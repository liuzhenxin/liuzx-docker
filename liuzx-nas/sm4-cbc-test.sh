#!/bin/sh
set -eu

RUNNER_CLASS="${RUNNER_CLASS:-/opt/liuzx-nas/tools/Sm4CbcRunner.class}"
APP_JAR="${APP_JAR:-/app/app.jar}"
LOADER_MAIN="${LOADER_MAIN:-Sm4CbcRunner}"
LOADER_PATH="${LOADER_PATH:-/opt/liuzx-nas/tools}"
JAVA_OPTS_EXTRA="${JAVA_OPTS_EXTRA:-}"

if [ ! -f "$APP_JAR" ]; then
  echo "ERROR: application jar not found: $APP_JAR" >&2
  exit 1
fi

if [ ! -f "$RUNNER_CLASS" ]; then
  echo "ERROR: runner class not found: $RUNNER_CLASS" >&2
  echo "Copy or compile Sm4CbcRunner.class to /tmp before running this script." >&2
  exit 1
fi

echo "Running NAS HSM SM4 CBC self-test"
echo "APP_JAR=$APP_JAR"
echo "RUNNER_CLASS=$RUNNER_CLASS"
echo "LOADER_MAIN=$LOADER_MAIN"

cd /app
exec java \
  $JAVA_OPTS_EXTRA \
  -Dloader.main="$LOADER_MAIN" \
  -Dloader.path="$LOADER_PATH" \
  -cp "$APP_JAR" \
  org.springframework.boot.loader.launch.PropertiesLauncher
