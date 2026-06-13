#!/bin/sh
set -eu

MYSQL_CONTAINER="${MYSQL_CONTAINER:-liuzx-mysql}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-11111111}"
KMC_DB_NAME="${KMC_DB_NAME:-lcloud_kmc_4}"
INIT_DIR="${INIT_DIR:-/kmc-db-init}"

case "${KMC_DB_NAME}" in
  *[!A-Za-z0-9_]* | "")
    echo "Invalid KMC_DB_NAME: ${KMC_DB_NAME}" >&2
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
    -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${KMC_DB_NAME}';"
}

table_exists() {
  table_name="$1"
  count="$(mysql_exec --batch --skip-column-names \
    -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${KMC_DB_NAME}' AND table_name='${table_name}';")"
  [ "${count}" = "1" ]
}

base_data_count() {
  ca_count="$(mysql_exec --batch --skip-column-names "${KMC_DB_NAME}" \
    -e "SELECT COUNT(*) FROM kmc_ca WHERE tenant_id=3;")"
  strategy_count="$(mysql_exec --batch --skip-column-names "${KMC_DB_NAME}" \
    -e "SELECT COUNT(*) FROM kmc_pool_strategy WHERE tenant_id=3;")"
  echo "${ca_count}:${strategy_count}"
}

echo "Waiting for existing MySQL container ${MYSQL_CONTAINER}..."
for _ in $(seq 1 60); do
  if mysqladmin_ping >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

mysqladmin_ping >/dev/null

echo "Ensuring database ${KMC_DB_NAME} exists..."
mysql_exec < "${INIT_DIR}/00_create_database.sql"

kmc_table_count="$(table_count)"
if [ "${kmc_table_count}" = "0" ]; then
  echo "Importing ${KMC_DB_NAME} schema..."
  mysql_exec < "${INIT_DIR}/01_kmc_4_schema.sql"
else
  echo "Database ${KMC_DB_NAME} already has tables, skipping KMC schema import."
fi

if table_exists "kmc_ca" && table_exists "kmc_pool_strategy"; then
  counts="$(base_data_count)"
  case "${counts}" in
    0:* | *:0)
      echo "Importing ${KMC_DB_NAME} base data..."
      mysql_exec "${KMC_DB_NAME}" < "${INIT_DIR}/02_kmc_4_data.sql"
      ;;
    *)
      echo "KMC base data already exists in ${KMC_DB_NAME}, skipping seed data import."
      ;;
  esac
else
  echo "KMC base tables do not exist, skipping seed data import."
fi

echo "KMC database initialization completed."
