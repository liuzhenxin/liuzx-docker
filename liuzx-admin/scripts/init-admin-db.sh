#!/bin/sh
set -eu

MYSQL_CONTAINER="${MYSQL_CONTAINER:-liuzx-mysql}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-11111111}"
DOCKER_BIN="${DOCKER_BIN:-docker}"
PLATFORM_DB_NAME="${PLATFORM_DB_NAME:-lcloud_platform_4}"
PLATFORM_DOMAIN_DB_NAME="${PLATFORM_DOMAIN_DB_NAME:-lcloud_platform_domain_4}"
INIT_DIR="${INIT_DIR:-/admin-db-init}"

for db_name in "${PLATFORM_DB_NAME}" "${PLATFORM_DOMAIN_DB_NAME}"; do
  case "${db_name}" in
    *[!A-Za-z0-9_]* | "")
      echo "Invalid database name: ${db_name}" >&2
      exit 1
      ;;
  esac
done

mysql_exec() {
  "${DOCKER_BIN}" exec -i \
    -e MYSQL_PWD="${MYSQL_PASSWORD}" \
    "${MYSQL_CONTAINER}" \
    mysql -u"${MYSQL_USER}" --default-character-set=utf8mb4 "$@"
}

mysqladmin_ping() {
  "${DOCKER_BIN}" exec \
    -e MYSQL_PWD="${MYSQL_PASSWORD}" \
    "${MYSQL_CONTAINER}" \
    mysqladmin -u"${MYSQL_USER}" ping --silent
}

table_count() {
  db_name="$1"
  mysql_exec --batch --skip-column-names \
    -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${db_name}';"
}

column_count() {
  db_name="$1"
  table_name="$2"
  column_name="$3"
  mysql_exec --batch --skip-column-names \
    -e "SELECT COUNT(*) FROM information_schema.columns WHERE table_schema='${db_name}' AND table_name='${table_name}' AND column_name='${column_name}';"
}

ensure_operate_log_dept_id() {
  dept_column_count="$(column_count "${PLATFORM_DOMAIN_DB_NAME}" "sys_operate_log" "dept_id")"
  if [ "${dept_column_count}" = "0" ]; then
    echo "Adding missing ${PLATFORM_DOMAIN_DB_NAME}.sys_operate_log.dept_id column..."
    mysql_exec "${PLATFORM_DOMAIN_DB_NAME}" \
      -e "ALTER TABLE sys_operate_log ADD COLUMN dept_id bigint DEFAULT NULL COMMENT '部门ID' AFTER tenant_id;"
  fi
}

echo "Waiting for existing MySQL container ${MYSQL_CONTAINER}..."
for _ in $(seq 1 60); do
  if mysqladmin_ping >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

mysqladmin_ping >/dev/null

echo "Ensuring platform databases exist..."
mysql_exec < "${INIT_DIR}/00_create_database.sql"

platform_table_count="$(table_count "${PLATFORM_DB_NAME}")"
if [ "${platform_table_count}" = "0" ]; then
  echo "Importing ${PLATFORM_DB_NAME} schema..."
  mysql_exec < "${INIT_DIR}/01_platform_4_schema.sql"

  echo "Importing ${PLATFORM_DB_NAME} seed data..."
  mysql_exec < "${INIT_DIR}/02_platform_4_data.sql"
else
  echo "Database ${PLATFORM_DB_NAME} already has tables, skipping platform SQL import."
fi

domain_table_count="$(table_count "${PLATFORM_DOMAIN_DB_NAME}")"
if [ "${domain_table_count}" = "0" ]; then
  echo "Importing ${PLATFORM_DOMAIN_DB_NAME} schema..."
  mysql_exec < "${INIT_DIR}/01_platform_domain_4_schema.sql"
else
  echo "Database ${PLATFORM_DOMAIN_DB_NAME} already has tables, skipping domain SQL import."
fi

ensure_operate_log_dept_id

echo "Admin database initialization completed."
