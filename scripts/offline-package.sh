#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/offline-common.sh
source "$SCRIPT_DIR/lib/offline-common.sh"

ROOT_DIR="$(repo_root)"
OUTPUT_DIR="$ROOT_DIR/offline-packages"
PACKAGE_NAME="liuzx-docker-offline-$(date '+%Y%m%d%H%M%S')"
BUILD_IMAGES=0
CLEAN_IMAGES=0
INCLUDE_SERVICES=""
EXCLUDE_SERVICES=""

# Infrastructure services that are always included (unless explicitly excluded)
INFRA_SERVICES=(mysql8 redis8 kafka)

usage() {
  cat <<'EOF'
Usage: scripts/offline-package.sh [options]

Create a self-contained offline deployment package.

Options:
  --output DIR        Output directory. Default: ./offline-packages
  --name NAME         Package base name. Default: liuzx-docker-offline-YYYYmmddHHMMSS
  --build             Rebuild images from local Dockerfiles before saving them
  --clean-images      Remove all local Docker images and exit
  --services LIST     Comma-separated list of services to include. Use "all" for
                      every service (default). Examples: "liuzx-ca,liuzx-nas"
  --exclude LIST      Comma-separated list of services to exclude from the
                      default set. Applied after --services. Example: "liuzx-ui"
  -h, --help          Show help

The package includes:
  - app/              Compose files, env files, jars, UI dist, SQL init files, scripts
  - images/*.tar      Docker images required by selected compose files
  - install.sh        Offline installer entrypoint
EOF
}

# Compute the final list of services to package.
# Modifies the global SERVICE_DIRS / APP_SERVICE_DIRS arrays.
compute_service_list() {
  local included excluded new_service new_app s e skip

  # Determine initial list
  if [[ -z "$INCLUDE_SERVICES" || "$INCLUDE_SERVICES" == "all" ]]; then
    new_service=("${SERVICE_DIRS[@]}")
    new_app=("${APP_SERVICE_DIRS[@]}")
  else
    IFS=',' read -ra included <<< "$INCLUDE_SERVICES"
    # Build new lists: infrastructure + specified services
    new_service=()
    for s in "${INFRA_SERVICES[@]}"; do
      skip=0
      for e in "${included[@]}"; do
        [[ "$s" == "$e" ]] && { skip=1; break; }
      done
      [[ $skip -eq 0 ]] && new_service+=("$s")
    done
    for e in "${included[@]}"; do
      new_service+=("$e")
    done
    new_app=("${included[@]}")
  fi

  # Apply exclusions
  if [[ -n "$EXCLUDE_SERVICES" ]]; then
    IFS=',' read -ra excluded <<< "$EXCLUDE_SERVICES"
    local tmp_service=("${new_service[@]}")
    new_service=()
    for s in "${tmp_service[@]}"; do
      skip=0
      for e in "${excluded[@]}"; do
        [[ "$s" == "$e" ]] && { skip=1; break; }
      done
      [[ $skip -eq 0 ]] && new_service+=("$s")
    done
    local tmp_app=("${new_app[@]}")
    new_app=()
    for s in "${tmp_app[@]}"; do
      skip=0
      for e in "${excluded[@]}"; do
        [[ "$s" == "$e" ]] && { skip=1; break; }
      done
      [[ $skip -eq 0 ]] && new_app+=("$s")
    done
  fi

  SERVICE_DIRS=("${new_service[@]}")
  APP_SERVICE_DIRS=("${new_app[@]}")

  log "services to package: ${SERVICE_DIRS[*]}"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --output)
      OUTPUT_DIR="$2"
      shift 2
      ;;
    --name)
      PACKAGE_NAME="$2"
      shift 2
      ;;
    --build)
      BUILD_IMAGES=1
      shift
      ;;
    --clean-images)
      CLEAN_IMAGES=1
      shift
      ;;
    --services)
      INCLUDE_SERVICES="$2"
      shift 2
      ;;
    --exclude)
      EXCLUDE_SERVICES="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown option: $1"
      ;;
  esac
done

require_docker

# Apply service filtering before any operations
compute_service_list

if [[ "$CLEAN_IMAGES" -eq 1 ]]; then
  mapfile -t IMAGE_IDS < <(docker image ls -aq | sort -u)
  if [[ "${#IMAGE_IDS[@]}" -eq 0 ]]; then
    log "no docker images to remove"
    exit 0
  fi

  log "removing all local docker images: ${#IMAGE_IDS[@]}"
  docker image rm -f "${IMAGE_IDS[@]}"
  log "docker image cleanup complete"
  exit 0
fi

compose_config_check "$ROOT_DIR"

# macOS bsdtar stores Finder metadata and extended attributes as LIBARCHIVE
# pax headers by default. GNU tar on Linux extracts the files correctly but
# prints noisy "Ignoring unknown extended header keyword" warnings. Disable
# copyfile metadata for all tar operations in this packaging script.
export COPYFILE_DISABLE=1

if [[ "$BUILD_IMAGES" -eq 1 ]]; then
  for dir in "${APP_SERVICE_DIRS[@]}"; do
    log "building image for $dir"
    compose_cmd "$ROOT_DIR" "$dir" build
  done
fi

IMAGES=()
while IFS= read -r image; do
  IMAGES+=("$image")
done < <(compose_images "$ROOT_DIR")
[[ "${#IMAGES[@]}" -gt 0 ]] || die "no images found from compose config"

for image in "${IMAGES[@]}"; do
  docker image inspect "$image" >/dev/null 2>&1 || die "image not found locally: $image. Run with --build or pull/build it before packaging."
done

mkdir -p "$OUTPUT_DIR"
WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/liuzx-offline.XXXXXX")"
trap 'rm -rf "$WORK_DIR"' EXIT

BUNDLE_DIR="$WORK_DIR/$PACKAGE_NAME"
mkdir -p "$BUNDLE_DIR/app" "$BUNDLE_DIR/images" "$BUNDLE_DIR/meta"

log "copying deployment files"

# Build the list of paths to include in the package
INCLUDE_PATHS=(scripts docs README.md .gitignore)
for dir in "${SERVICE_DIRS[@]}"; do
  INCLUDE_PATHS+=("$dir")
done

tar -C "$ROOT_DIR" \
  --exclude='*/data' \
  --exclude='*/logs' \
  --exclude='*/backups' \
  --exclude='.DS_Store' \
  --exclude='*/.DS_Store' \
  -cf - "${INCLUDE_PATHS[@]}" | tar -C "$BUNDLE_DIR/app" -xf -

log "saving docker images"
printf '%s\n' "${IMAGES[@]}" > "$BUNDLE_DIR/meta/images.txt"
docker save -o "$BUNDLE_DIR/images/docker-images.tar" "${IMAGES[@]}"

cp "$ROOT_DIR/scripts/offline-install.sh" "$BUNDLE_DIR/install.sh"
chmod +x "$BUNDLE_DIR/install.sh"

cat > "$BUNDLE_DIR/README-OFFLINE.txt" <<'EOF'
Offline deployment package.

On the offline server:
  tar -xzf this-package.tar.gz
  cd extracted-directory
  sudo ./install.sh --target /opt/liuzx-docker --start

After installation:
  cd /opt/liuzx-docker
  ./scripts/offline-manage.sh status
  ./scripts/offline-manage.sh logs liuzx-nacos
EOF

ARCHIVE="$OUTPUT_DIR/$PACKAGE_NAME.tar.gz"
log "creating archive: $ARCHIVE"
tar -C "$WORK_DIR" -czf "$ARCHIVE" "$PACKAGE_NAME"

log "package created: $ARCHIVE"
du -h "$ARCHIVE"
