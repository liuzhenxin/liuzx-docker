#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLE_ROOT="$SCRIPT_DIR"
APP_DIR="$BUNDLE_ROOT/app"

TARGET_DIR="/opt/liuzx-docker"
START_AFTER_INSTALL=0
FORCE=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Install an offline Liuzx Docker deployment package.

Options:
  --target DIR      Install target. Default: /opt/liuzx-docker
  --start           Start all containers after install
  --force           If target exists, move it to a timestamped backup first
  -h, --help        Show help

Prerequisite on offline server:
  - Docker Engine
  - Docker Compose plugin
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET_DIR="$2"
      shift 2
      ;;
    --start)
      START_AFTER_INSTALL=1
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'ERROR: unknown option: %s\n' "$1" >&2
      exit 1
      ;;
  esac
done

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

[[ -d "$APP_DIR" ]] || die "app directory not found in package: $APP_DIR"
[[ -f "$BUNDLE_ROOT/images/docker-images.tar" ]] || die "docker image archive not found: images/docker-images.tar"
command -v docker >/dev/null 2>&1 || die "docker command not found"
docker info >/dev/null 2>&1 || die "docker daemon is not available"
docker compose version >/dev/null 2>&1 || die "docker compose plugin is not available"

set_env_value() {
  local file="$1"
  local key="$2"
  local value="$3"
  local tmp
  tmp="$(mktemp)"
  if [[ -f "$file" ]] && grep -q "^${key}=" "$file"; then
    sed "s|^${key}=.*|${key}=${value}|" "$file" > "$tmp"
    cat "$tmp" > "$file"
  else
    printf '%s=%s\n' "$key" "$value" >> "$file"
  fi
  rm -f "$tmp"
}

configure_nas_runtime_user() {
  local user="${NAS_HOST_USER:-dppc}"
  local env_file="$TARGET_DIR/liuzx-nas/.env"
  local uid gid

  [[ -f "$env_file" ]] || return 0
  if [[ -n "${NAS_RUN_UID:-}" && -n "${NAS_RUN_GID:-}" ]]; then
    uid="$NAS_RUN_UID"
    gid="$NAS_RUN_GID"
    log "configuring liuzx-nas runtime user from NAS_RUN_UID/NAS_RUN_GID: $uid:$gid"
  elif id "$user" >/dev/null 2>&1; then
    uid="$(id -u "$user")"
    gid="$(id -g "$user")"
    log "configuring liuzx-nas runtime user: $user ($uid:$gid)"
  else
    uid="$(id -u)"
    gid="$(id -g)"
    log "user '$user' not found; configuring liuzx-nas runtime user as current user ($uid:$gid)"
  fi

  set_env_value "$env_file" NAS_RUN_UID "$uid"
  set_env_value "$env_file" NAS_RUN_GID "$gid"
}

if [[ -e "$TARGET_DIR" ]]; then
  if [[ "$FORCE" -ne 1 ]]; then
    die "target exists: $TARGET_DIR. Re-run with --force to move it aside first."
  fi
  BACKUP_DIR="${TARGET_DIR}.backup.$(date '+%Y%m%d%H%M%S')"
  log "moving existing target to $BACKUP_DIR"
  mv "$TARGET_DIR" "$BACKUP_DIR"
fi

log "loading docker images"
docker load -i "$BUNDLE_ROOT/images/docker-images.tar"

log "installing files to $TARGET_DIR"
mkdir -p "$(dirname "$TARGET_DIR")"
cp -a "$APP_DIR" "$TARGET_DIR"
chmod +x "$TARGET_DIR"/scripts/*.sh
configure_nas_runtime_user

# shellcheck source=lib/offline-common.sh
source "$TARGET_DIR/scripts/lib/offline-common.sh"

ensure_network
ensure_runtime_dirs "$TARGET_DIR"
compose_config_check "$TARGET_DIR"

log "install complete: $TARGET_DIR"
if [[ "$START_AFTER_INSTALL" -eq 1 ]]; then
  log "starting containers"
  "$TARGET_DIR/scripts/offline-manage.sh" start
fi
