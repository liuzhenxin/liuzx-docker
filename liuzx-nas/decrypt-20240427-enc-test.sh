#!/bin/sh
set -eu

APP_JAR="${APP_JAR:-/app/app.jar}"
LOADER_MAIN="${LOADER_MAIN:-BatchSm4CbcDecryptRunner}"
LOADER_PATH="${LOADER_PATH:-/opt/liuzx-nas/tools}"
INPUT_DIR="${1:-${INPUT_DIR:-/Users/liuzhenxin/20240427-enc}}"
OUTPUT_DIR="${2:-${OUTPUT_DIR:-/Users/liuzhenxin/20240427-dec-test}}"
IV="${3:-${SM4_CBC_IV:-LCloud-NAS-IV123}}"
JAVA_OPTS_EXTRA="${JAVA_OPTS_EXTRA:-}"

if [ ! -f "$APP_JAR" ]; then
  echo "ERROR: application jar not found: $APP_JAR" >&2
  exit 1
fi

if [ ! -f "/opt/liuzx-nas/tools/BatchSm4CbcDecryptRunner.class" ]; then
  echo "ERROR: decrypt runner class not found: /opt/liuzx-nas/tools/BatchSm4CbcDecryptRunner.class" >&2
  exit 1
fi

echo "Running NAS HSM SM4 CBC batch decrypt test"
echo "INPUT_DIR=$INPUT_DIR"
echo "OUTPUT_DIR=$OUTPUT_DIR"
echo "LOADER_MAIN=$LOADER_MAIN"

cd /app
exec java \
  $JAVA_OPTS_EXTRA \
  -Dloader.main="$LOADER_MAIN" \
  -Dloader.path="$LOADER_PATH" \
  -cp "$APP_JAR" \
  org.springframework.boot.loader.launch.PropertiesLauncher \
  "$INPUT_DIR" "$OUTPUT_DIR" "$IV"
