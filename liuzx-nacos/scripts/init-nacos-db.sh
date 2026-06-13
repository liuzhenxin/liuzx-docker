#!/bin/sh
set -eu

MYSQL_CONTAINER="${MYSQL_CONTAINER:-liuzx-mysql}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-11111111}"
NACOS_DB_NAME="${NACOS_DB_NAME:-lcloud_platform_nacos_3}"
INIT_DIR="${INIT_DIR:-/nacos-db-init}"

case "${NACOS_DB_NAME}" in
  *[!A-Za-z0-9_]* | "")
    echo "Invalid NACOS_DB_NAME: ${NACOS_DB_NAME}" >&2
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

echo "Waiting for existing MySQL container ${MYSQL_CONTAINER}..."
for _ in $(seq 1 60); do
  if mysqladmin_ping >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

mysqladmin_ping >/dev/null

echo "Ensuring database ${NACOS_DB_NAME} exists..."
mysql_exec < "${INIT_DIR}/00_create_database.sql"

table_count="$(mysql_exec --batch --skip-column-names -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${NACOS_DB_NAME}';")"

if [ "${table_count}" != "0" ]; then
  echo "Database ${NACOS_DB_NAME} already has tables, skipping Nacos SQL import."
  exit 0
fi

echo "Importing Nacos schema..."
mysql_exec < "${INIT_DIR}/01_nacos_3_schema.sql"

echo "Importing Nacos seed data..."
mysql_exec < "${INIT_DIR}/02_nacos_3_data.sql"

echo "Nacos database initialization completed."
