#!/usr/bin/env bash

set -euo pipefail

SERVICE_DIRS=(
  mysql8
  redis8
  kafka
  liuzx-nacos
  liuzx-snowflake-id
  liuzx-auth
  liuzx-kmc
  liuzx-ca
  liuzx-license
  liuzx-ocsp
  liuzx-ra
  liuzx-admin
  liuzx-gateway
  liuzx-nas
  liuzx-ui
)

APP_SERVICE_DIRS=(
  liuzx-nacos
  liuzx-snowflake-id
  liuzx-auth
  liuzx-kmc
  liuzx-ca
  liuzx-license
  liuzx-ocsp
  liuzx-ra
  liuzx-admin
  liuzx-gateway
  liuzx-nas
  liuzx-ui
)

NETWORK_NAME="${NETWORK_NAME:-pki-network}"

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

repo_root() {
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  cd "$script_dir/../.." && pwd
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"
}

require_docker() {
  require_cmd docker
  docker info >/dev/null 2>&1 || die "docker daemon is not available"
  docker compose version >/dev/null 2>&1 || die "docker compose plugin is not available"
}

compose_cmd() {
  local root_dir="$1"
  local service_dir="$2"
  shift 2
  docker compose \
    --project-directory "$root_dir/$service_dir" \
    -f "$root_dir/$service_dir/docker-compose.yml" \
    "$@"
}

ensure_network() {
  if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
    log "creating docker network: $NETWORK_NAME"
    docker network create "$NETWORK_NAME" >/dev/null
  fi
}

ensure_runtime_dirs() {
  local root_dir="$1"
  local dir nas_uid nas_gid nas_env
  for dir in "${SERVICE_DIRS[@]}"; do
    mkdir -p "$root_dir/$dir/data"
  done
  for dir in "${APP_SERVICE_DIRS[@]}"; do
    mkdir -p "$root_dir/$dir/logs"
  done

  # NAS compose binds these host paths directly.
  mkdir -p /data/static/acim2/yjhx /data/static/qcxfp/yjhx 2>/dev/null || true

  nas_env="$root_dir/liuzx-nas/.env"
  if [[ -f "$nas_env" ]]; then
    nas_uid="$(awk -F= '$1 == "NAS_RUN_UID" {print $2}' "$nas_env" | tail -1)"
    nas_gid="$(awk -F= '$1 == "NAS_RUN_GID" {print $2}' "$nas_env" | tail -1)"
  fi
  nas_uid="${nas_uid:-1000}"
  nas_gid="${nas_gid:-1000}"

  if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    log "setting liuzx-nas writable directory ownership to $nas_uid:$nas_gid"
    chown "$nas_uid:$nas_gid" "$root_dir/liuzx-nas/data" "$root_dir/liuzx-nas/logs" 2>/dev/null || true
    chown "$nas_uid:$nas_gid" /data/static/qcxfp/yjhx 2>/dev/null || true

    if [[ "${NAS_CHOWN_RECURSIVE:-0}" == "1" ]]; then
      log "recursively setting liuzx-nas target data ownership; this may take a long time"
      chown -R "$nas_uid:$nas_gid" "$root_dir/liuzx-nas/data" "$root_dir/liuzx-nas/logs" 2>/dev/null || true
      chown -R "$nas_uid:$nas_gid" /data/static/qcxfp/yjhx 2>/dev/null || true
    fi
  fi
}

compose_config_check() {
  local root_dir="$1"
  local dir
  for dir in "${SERVICE_DIRS[@]}"; do
    log "validating $dir/docker-compose.yml"
    compose_cmd "$root_dir" "$dir" config --quiet
  done
}

compose_images() {
  local root_dir="$1"
  local dir
  for dir in "${SERVICE_DIRS[@]}"; do
    compose_cmd "$root_dir" "$dir" config --images
  done | awk 'NF' | sort -u
}
