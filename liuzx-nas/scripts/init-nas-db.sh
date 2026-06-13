#!/bin/sh
set -eu

MYSQL_CONTAINER="${MYSQL_CONTAINER:-liuzx-mysql}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-11111111}"
NAS_DB_NAME="${NAS_DB_NAME:-lcloud_nas_4}"
INIT_DIR="${INIT_DIR:-/nas-db-init}"

case "${NAS_DB_NAME}" in
  *[!A-Za-z0-9_]* | "")
    echo "Invalid NAS_DB_NAME: ${NAS_DB_NAME}" >&2
    exit 1
    ;;
esac

mysql_exec() {
  docker exec -i \
    -e MYSQL_PWD="${MYSQL_PASSWORD}" \
    "${MYSQL_CONTAINER}" \
    mysql -u"${MYSQL_USER}" --default-character-set=utf8mb4 "$@"
}

mysqladmin_ping() {
  docker exec \
    -e MYSQL_PWD="${MYSQL_PASSWORD}" \
    "${MYSQL_CONTAINER}" \
    mysqladmin -u"${MYSQL_USER}" ping --silent
}

table_count() {
  mysql_exec --batch --skip-column-names \
    -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${NAS_DB_NAME}';"
}

echo "Waiting for existing MySQL container ${MYSQL_CONTAINER}..."
for _ in $(seq 1 60); do
  if mysqladmin_ping >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

mysqladmin_ping >/dev/null

echo "Ensuring database ${NAS_DB_NAME} exists..."
mysql_exec < "${INIT_DIR}/00_create_database.sql"

nas_table_count="$(table_count)"
if [ "${nas_table_count}" = "0" ]; then
  echo "Importing ${NAS_DB_NAME} schema..."
  mysql_exec < "${INIT_DIR}/01_nas_4_schema.sql"
else
  echo "Database ${NAS_DB_NAME} already has tables, skipping NAS schema import."
fi

echo "NAS database initialization completed."
