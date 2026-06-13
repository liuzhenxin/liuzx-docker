#!/bin/sh
set -eu

MYSQL_CONTAINER="${MYSQL_CONTAINER:-liuzx-mysql}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-11111111}"
LICENSE_DB_NAME="${LICENSE_DB_NAME:-lcloud_license_4}"
PLATFORM_DB_NAME="${PLATFORM_DB_NAME:-lcloud_platform_4}"
INIT_DIR="${INIT_DIR:-/license-db-init}"

for db_name in "${LICENSE_DB_NAME}" "${PLATFORM_DB_NAME}"; do
  case "${db_name}" in
    *[!A-Za-z0-9_]* | "")
      echo "Invalid database name: ${db_name}" >&2
      exit 1
      ;;
  esac
done

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
  db_name="$1"
  mysql_exec --batch --skip-column-names \
    -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${db_name}';"
}

table_exists() {
  db_name="$1"
  table_name="$2"
  count="$(mysql_exec --batch --skip-column-names \
    -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${db_name}' AND table_name='${table_name}';")"
  [ "${count}" = "1" ]
}

license_platform_menu_count() {
  mysql_exec --batch --skip-column-names "${PLATFORM_DB_NAME}" \
    -e "SELECT COUNT(*) FROM sys_menu WHERE tenant_id=2 AND id=2000;"
}

echo "Waiting for existing MySQL container ${MYSQL_CONTAINER}..."
for _ in $(seq 1 60); do
  if mysqladmin_ping >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

mysqladmin_ping >/dev/null

echo "Ensuring database ${LICENSE_DB_NAME} exists..."
mysql_exec < "${INIT_DIR}/00_create_database.sql"

license_table_count="$(table_count "${LICENSE_DB_NAME}")"
if [ "${license_table_count}" = "0" ]; then
  echo "Importing ${LICENSE_DB_NAME} schema..."
  mysql_exec < "${INIT_DIR}/01_license_4_schema.sql"
else
  echo "Database ${LICENSE_DB_NAME} already has tables, skipping License schema import."
fi

if table_exists "${PLATFORM_DB_NAME}" "sys_menu"; then
  platform_menu_count="$(license_platform_menu_count)"
  if [ "${platform_menu_count}" = "0" ]; then
    echo "Importing License platform menu, permission and base data into ${PLATFORM_DB_NAME}..."
    mysql_exec "${PLATFORM_DB_NAME}" < "${INIT_DIR}/02_license_4_platform_data.sql"
  else
    echo "License platform data already exists in ${PLATFORM_DB_NAME}, skipping platform data import."
  fi
else
  echo "Database ${PLATFORM_DB_NAME} is not initialized, skipping License platform data import."
fi

echo "License database initialization completed."
