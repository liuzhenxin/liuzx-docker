#!/bin/sh
set -eu

RUNNER_CLASS="${RUNNER_CLASS:-/tmp/Sm4CbcRunner.class}"
APP_JAR="${APP_JAR:-/app/app.jar}"
LOADER_MAIN="${LOADER_MAIN:-Sm4CbcRunner}"
LOADER_PATH="${LOADER_PATH:-/tmp}"

if [ ! -f "$APP_JAR" ]; then
  echo "ERROR: application jar not found: $APP_JAR" >&2
  exit 1
fi

if [ ! -f "$RUNNER_CLASS" ]; then
  echo "ERROR: runner class not found: $RUNNER_CLASS" >&2
  echo "Copy or compile Sm4CbcRunner.class to /tmp before running this script." >&2
  exit 1
fi

cd /app
exec java \
  -Dloader.main="$LOADER_MAIN" \
  -Dloader.path="$LOADER_PATH" \
  -cp "$APP_JAR" \
  org.springframework.boot.loader.launch.PropertiesLauncher
