#!/bin/sh
set -eu

MYSQL_CONTAINER="${MYSQL_CONTAINER:-liuzx-mysql}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-11111111}"
CA_DB_NAME="${CA_DB_NAME:-lcloud_ca_4}"
PLATFORM_DB_NAME="${PLATFORM_DB_NAME:-lcloud_platform_4}"
INIT_DIR="${INIT_DIR:-/ca-db-init}"

for db_name in "${CA_DB_NAME}" "${PLATFORM_DB_NAME}"; do
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

echo "Waiting for existing MySQL container ${MYSQL_CONTAINER}..."
for _ in $(seq 1 60); do
  if mysqladmin_ping >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

mysqladmin_ping >/dev/null

echo "Ensuring database ${CA_DB_NAME} exists..."
mysql_exec < "${INIT_DIR}/00_create_database.sql"

ca_table_count="$(table_count "${CA_DB_NAME}")"
if [ "${ca_table_count}" = "0" ]; then
  echo "Importing ${CA_DB_NAME} schema..."
  mysql_exec < "${INIT_DIR}/01_ca_4_schema.sql"
else
  echo "Database ${CA_DB_NAME} already has tables, skipping CA schema import."
fi

if table_exists "${PLATFORM_DB_NAME}" "sys_tenant"; then
  echo "Importing CA platform seed data into ${PLATFORM_DB_NAME}..."
  mysql_exec < "${INIT_DIR}/02_ca_4_data.sql"
else
  echo "Database ${PLATFORM_DB_NAME} is not initialized, skipping CA platform seed data."
fi

echo "CA database initialization completed."
