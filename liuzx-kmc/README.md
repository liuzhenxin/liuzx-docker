# liuzx-kmc Docker

This directory contains the Docker deployment files for the KMC service.

## Files

- `liuzx-kmc.jar`: Spring Boot executable JAR copied from `liuzx-kmc-start/target/liuzx-kmc-start.jar`.
- `Dockerfile`: Runtime image based on Eclipse Temurin 25 JRE.
- `docker-compose.yml`: Compose service definition for container `kmc`.
- `.env`: Non-secret runtime defaults.
- `logs/`: Mounted to `/tmp` for application logs and temporary files.
- `data/`: Mounted to `/home/kmc/data` for service data.

## Commands

```bash
cd ~/aio/docker/liuzx-kmc
docker compose build
docker compose up -d
docker compose logs -f
```

The service listens on host port `3443` by default and joins the external Docker network `pki-network`.

Do not store production database passwords, keystore passwords, KMC master keys, private keys, or PIN values in this directory.
