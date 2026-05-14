#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/offline-common.sh
source "$SCRIPT_DIR/lib/offline-common.sh"

ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

usage() {
  cat <<'EOF'
Usage: scripts/offline-manage.sh COMMAND [args]

Commands:
  start                 Create/start all containers in dependency order
  stop                  Stop all containers without removing them
  down                  Stop and remove all compose-managed containers
  restart               Down then start all containers
  recreate              Force recreate all containers
  upgrade SERVICE [TAR] Load optional image TAR and recreate one container
  upgrade-image TAR     Load docker image archive
  upgrade-container SERVICE
                        Force recreate one compose service/container
  status                Show container status
  health                Show health status for all containers
  logs SERVICE [N]      Follow logs for SERVICE, with optional tail count
  config                Validate all compose files
  images                List images required by compose files
  services              List manageable compose services
  backup [DIR]          Archive env files and data directories

Examples:
  scripts/offline-manage.sh start
  scripts/offline-manage.sh upgrade liuzx-gateway /tmp/liuzx-gateway.tar
  scripts/offline-manage.sh upgrade-container liuzx-gateway
  scripts/offline-manage.sh logs liuzx-nacos 200
  scripts/offline-manage.sh backup /backup/liuzx
EOF
}

reverse_services() {
  local i
  for ((i=${#SERVICE_DIRS[@]}-1; i>=0; i--)); do
    printf '%s\n' "${SERVICE_DIRS[$i]}"
  done
}

container_names() {
  docker ps -a --format '{{.Names}}' | awk '/^liuzx-/ {print}' | sort
}

list_services() {
  local dir service
  for dir in "${SERVICE_DIRS[@]}"; do
    while read -r service; do
      [[ -n "$service" ]] || continue
      printf '%s\t%s\n' "$dir" "$service"
    done < <(compose_cmd "$ROOT_DIR" "$dir" config --services)
  done
}

service_count() {
  local dir="$1"
  compose_cmd "$ROOT_DIR" "$dir" config --services | awk 'NF {count++} END {print count + 0}'
}

first_service() {
  local dir="$1"
  compose_cmd "$ROOT_DIR" "$dir" config --services | awk 'NF {print; exit}'
}

resolve_service() {
  local target="$1"
  local dir service normalized container

  normalized="${target#liuzx-}"
  while read -r dir service; do
    container="liuzx-$service"
    if [[ "$target" == "$service" || "$target" == "$container" || "$normalized" == "$service" ]]; then
      printf '%s\t%s\n' "$dir" "$service"
      return 0
    fi
  done < <(list_services)

  for dir in "${SERVICE_DIRS[@]}"; do
    if [[ "$target" == "$dir" ]]; then
      if [[ "$(service_count "$dir")" -eq 1 ]]; then
        printf '%s\t%s\n' "$dir" "$(first_service "$dir")"
        return 0
      fi
      die "service directory '$dir' has multiple services. Use one of: $(compose_cmd "$ROOT_DIR" "$dir" config --services | xargs)"
    fi
  done

  die "unknown service/container: $target. Run 'scripts/offline-manage.sh services' to list valid names."
}

start_all() {
  require_docker
  ensure_network
  ensure_runtime_dirs "$ROOT_DIR"
  local dir
  for dir in "${SERVICE_DIRS[@]}"; do
    log "starting $dir"
    compose_cmd "$ROOT_DIR" "$dir" up -d
  done
}

stop_all() {
  require_docker
  local dir
  while read -r dir; do
    log "stopping $dir"
    compose_cmd "$ROOT_DIR" "$dir" stop || true
  done < <(reverse_services)
}

down_all() {
  require_docker
  local dir
  while read -r dir; do
    log "down $dir"
    compose_cmd "$ROOT_DIR" "$dir" down || true
  done < <(reverse_services)
}

recreate_all() {
  require_docker
  ensure_network
  ensure_runtime_dirs "$ROOT_DIR"
  local dir
  for dir in "${SERVICE_DIRS[@]}"; do
    log "recreating $dir"
    compose_cmd "$ROOT_DIR" "$dir" up -d --force-recreate
  done
}

load_image_archive() {
  require_docker
  local image_tar="${1:-}"
  [[ -n "$image_tar" ]] || die "image TAR is required"
  [[ "$#" -eq 1 ]] || die "usage: scripts/offline-manage.sh upgrade-image TAR"
  [[ -f "$image_tar" ]] || die "image TAR not found: $image_tar"
  log "loading docker image archive: $image_tar"
  docker load -i "$image_tar"
}

upgrade_container() {
  require_docker
  local target="${1:-}"
  local dir service resolved
  [[ -n "$target" ]] || die "SERVICE is required"
  [[ "$#" -eq 1 ]] || die "usage: scripts/offline-manage.sh upgrade-container SERVICE"
  ensure_network
  ensure_runtime_dirs "$ROOT_DIR"
  resolved="$(resolve_service "$target")"
  dir="${resolved%%$'\t'*}"
  service="${resolved#*$'\t'}"
  log "recreating $service from $dir/docker-compose.yml"
  compose_cmd "$ROOT_DIR" "$dir" up -d --no-deps --force-recreate "$service"
}

upgrade_one() {
  local target="${1:-}"
  local image_tar="${2:-}"
  [[ -n "$target" ]] || die "SERVICE is required"
  [[ "$#" -le 2 ]] || die "usage: scripts/offline-manage.sh upgrade SERVICE [TAR]"
  if [[ -n "$image_tar" ]]; then
    load_image_archive "$image_tar"
  else
    require_docker
  fi
  upgrade_container "$target"
}

status_all() {
  require_docker
  docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' | awk 'NR==1 || $1 ~ /^liuzx-/'
}

health_all() {
  require_docker
  local name health status
  printf '%-18s %-12s %s\n' NAME HEALTH STATUS
  while read -r name; do
    health="$(docker inspect --format '{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "$name" 2>/dev/null || true)"
    status="$(docker inspect --format '{{.State.Status}}' "$name" 2>/dev/null || true)"
    printf '%-18s %-12s %s\n' "$name" "$health" "$status"
  done < <(container_names)
}

logs_one() {
  require_docker
  local service="${1:-}"
  local tail_count="${2:-200}"
  [[ -n "$service" ]] || die "SERVICE is required"
  docker logs -f --tail "$tail_count" "$service"
}

backup_all() {
  local backup_root="${1:-$ROOT_DIR/backups}"
  local ts archive
  ts="$(date '+%Y%m%d%H%M%S')"
  mkdir -p "$backup_root"
  archive="$backup_root/liuzx-runtime-backup-$ts.tar.gz"
  log "creating backup: $archive"
  tar -C "$ROOT_DIR" -czf "$archive" \
    --ignore-failed-read \
    */.env \
    */data \
    liuzx-*/logs 2>/dev/null || true
  [[ -f "$archive" ]] || die "backup failed"
  du -h "$archive"
}

cmd="${1:-}"
case "$cmd" in
  start)
    start_all
    ;;
  stop)
    stop_all
    ;;
  down)
    down_all
    ;;
  restart)
    down_all
    start_all
    ;;
  recreate)
    recreate_all
    ;;
  upgrade)
    shift
    upgrade_one "$@"
    ;;
  upgrade-image)
    shift
    load_image_archive "$@"
    ;;
  upgrade-container)
    shift
    upgrade_container "$@"
    ;;
  status)
    status_all
    ;;
  health)
    health_all
    ;;
  logs)
    shift
    logs_one "$@"
    ;;
  config)
    require_docker
    compose_config_check "$ROOT_DIR"
    ;;
  images)
    require_docker
    compose_images "$ROOT_DIR"
    ;;
  services)
    require_docker
    list_services | awk 'BEGIN {printf "%-18s %s\n", "DIR", "SERVICE"} {printf "%-18s %s\n", $1, $2}'
    ;;
  backup)
    shift
    backup_all "$@"
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    usage
    [[ -z "$cmd" ]] || die "unknown command: $cmd"
    exit 1
    ;;
esac
