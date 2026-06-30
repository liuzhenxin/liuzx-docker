# liuzx-kmc Docker

This directory contains the local Docker deployment files for the KMC service.

## Files

- `liuzx-kmc.jar`: Spring Boot executable JAR copied from `liuzx-kmc-start/target/liuzx-kmc-start.jar`.
- `Dockerfile`: Runtime image based on Eclipse Temurin 25 JRE.
- `docker-compose.yml`: Default KMC service definition.
- `.env`: Local runtime settings.
- `mysql/init/`: One-shot database initialization SQL.
- `scripts/init-kmc-db.sh`: Optional database initialization helper.
- `logs/`: Mounted to `/tmp` for application logs and temporary files.
- `data/`: Mounted to `/home/kmc/data` for service data.

## Commands

```bash
cd /Users/liuzhenxin/aio/docker/liuzx-kmc
docker compose up -d --build
docker compose ps
docker compose logs -f liuzx-kmc
```

The default compose startup only starts `liuzx-kmc`. This keeps redeployments from being blocked by the one-shot database initializer. After startup, KMC must register itself in Nacos as `liuzx-kmc`; otherwise gateway requests to `/api-gateway/kmc/**` will return `Unable to find instance for liuzx-kmc`.

## Database Initialization

The compose file includes a one-shot `liuzx-kmc-db-init` container behind the `init` profile. Run it explicitly only when the local MySQL data needs initialization or additive platform data needs to be checked:

```bash
cd /Users/liuzhenxin/aio/docker/liuzx-kmc
docker compose --profile init up liuzx-kmc-db-init
```

Initialization order:

- `mysql/init/00_create_database.sql`: creates `lcloud_kmc_4` when needed.
- `mysql/init/01_kmc_4_schema.sql`: imports the KMC business schema only when `lcloud_kmc_4` has no tables.
- `mysql/init/02_kmc_4_platform_data.sql`: imports tenant, menu, role, user, and permission data only when KMC platform menus do not exist.

Do not store production database passwords, keystore passwords, KMC master keys, private keys, or PIN values in this directory.

## Verification

```bash
curl -sS http://127.0.0.1/api-gateway/kmc/v1/init/status
```

Expected result after KMC is registered: the response should not contain `Unable to find instance for liuzx-kmc`. If unauthenticated, `Unauthorized` is normal.
