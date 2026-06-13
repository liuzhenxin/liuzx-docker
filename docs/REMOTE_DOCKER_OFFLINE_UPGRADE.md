# 远程 Docker 离线升级文档

## 1. 适用场景

本文档用于升级已经部署好的远程 Docker 环境。

目标服务器：

```text
211.88.41.215
```

服务端 Docker 目录：

```text
/opt/liuzx-docker
```

适用情况：

- 服务器无法直接联网，不能执行 `docker pull`。
- 当前机器无法直接 SSH 登录服务器，需要通过堡垒机、远程桌面、U 盘、内网文件传输或现场人员执行命令。
- 需要升级全部容器、业务镜像、前端镜像和相关 SQL。

本文档不保存服务器账号密码。账号密码只在实际登录时由运维人员输入。

## 2. 升级原则

远程服务器不能联网时，服务器上不要执行：

```bash
docker pull
docker compose build
docker compose up -d --build
```

正确方式是：

1. 在本机或可联网构建机生成离线升级包。
2. 离线升级包中包含 compose 文件、JAR、前端文件、SQL、Docker 镜像 tar。
3. 将升级包传到服务器。
4. 服务器执行 `docker load` 导入镜像。
5. 服务器使用 `docker compose up -d --no-build` 或离线管理脚本重建容器。

## 3. 升级范围

本次升级建议覆盖全部容器和镜像，避免远程环境版本不一致。

基础组件：

```text
liuzx-mysql
liuzx-redis
liuzx-kafka
liuzx-kafka-ui
liuzx-nacos
```

公共服务：

```text
liuzx-snowflake-id
liuzx-auth
liuzx-admin
liuzx-gateway
```

PKI 业务服务：

```text
liuzx-ca
liuzx-kmc
liuzx-ra
liuzx-nas
```

前端：

```text
liuzx-ui
```

注意：如果服务器没有 `liuzx-snowflake-id`，本次必须补充部署。NAS 迁移失败记录写入依赖雪花 ID 服务生成主键，否则会出现：

```text
B_Service_GenerateSnowflakeIdNotFound
调用生成雪花ID服务失败，请联系管理员
```

## 4. 本机生成离线升级包

在本机 Docker 部署目录执行：

```bash
cd /Users/liuzhenxin/aio/docker
```

如果需要重新构建所有业务镜像：

```bash
scripts/offline-package.sh --build
```

如果本机镜像已经是最新版本：

```bash
scripts/offline-package.sh
```

生成文件位置：

```text
/Users/liuzhenxin/aio/docker/offline-packages/liuzx-docker-offline-YYYYmmddHHMMSS.tar.gz
```

离线包包含：

- 所有服务 compose 配置。
- `.env` 环境配置。
- Java 服务 JAR。
- 前端 `dist`。
- MySQL 初始化 SQL。
- Docker 镜像归档 `images/docker-images.tar`。
- 离线安装脚本 `install.sh`。
- 运维管理脚本 `scripts/offline-manage.sh`。

## 5. 本次 SQL 升级文件

本次 NAS 迁移失败记录功能需要执行：

```text
liuzx-nas/doc/db/mysql/upgrade_20260522_migration_failure_record.sql
```

该脚本用于补建：

```text
lcloud_nas_4.nas_migration_failure_record
```

并补充页面菜单、权限和角色授权数据。

如果离线包中没有该 SQL，需要手动复制到升级包：

```bash
mkdir -p /tmp/liuzx-upgrade-sql
cp /Users/liuzhenxin/Office/Source/LiuZX/LCloud/PKI/liuzx-nas/doc/db/mysql/upgrade_20260522_migration_failure_record.sql \
  /tmp/liuzx-upgrade-sql/
```

## 6. 无法 SSH 时如何传输

如果当前机器无法 SSH 连接服务器，不能直接执行：

```bash
scp liuzx-docker-offline-*.tar.gz user@211.88.41.215:/tmp/
ssh user@211.88.41.215
```

需要选择一种可用通道：

- 堡垒机文件上传。
- 远程桌面上传。
- 运维平台文件分发。
- 内网共享目录。
- U 盘或现场人员拷贝。
- 临时 HTTP 文件服务，由服务器主动下载。

传输到服务器后的建议路径：

```text
/tmp/liuzx-docker-offline-YYYYmmddHHMMSS.tar.gz
```

服务器上确认文件：

```bash
ls -lh /tmp/liuzx-docker-offline-*.tar.gz
```

## 7. 服务器升级前检查

以下命令在服务器上执行。

确认 Docker：

```bash
docker version
docker compose version
```

确认部署目录：

```bash
ls -la /opt/liuzx-docker
```

确认当前容器：

```bash
docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}'
```

确认是否已有 snowflake-id：

```bash
docker ps -a | grep liuzx-snowflake-id || true
```

## 8. 服务器升级前备份

备份部署目录：

```bash
sudo tar -czf /tmp/liuzx-docker-backup-$(date +%Y%m%d%H%M%S).tar.gz /opt/liuzx-docker
```

备份数据库：

```bash
docker exec liuzx-mysql mysqldump -uroot -p --databases \
  lcloud_platform_4 \
  lcloud_platform_domain_4 \
  lcloud_ca_4 \
  lcloud_kmc_4 \
  lcloud_ra_4 \
  lcloud_nas_4 \
  > /tmp/liuzx-db-backup-$(date +%Y%m%d%H%M%S).sql
```

说明：`-p` 后不要在文档中写明文密码，执行时按提示输入。

## 9. 解压离线包

```bash
cd /tmp
tar -xzf liuzx-docker-offline-*.tar.gz
cd liuzx-docker-offline-*
```

查看包内容：

```bash
ls -la
ls -lh images/
ls -la app/
```

## 10. 导入全部镜像

如果离线包由 `scripts/offline-package.sh` 生成，镜像文件通常为：

```text
images/docker-images.tar
```

导入镜像：

```bash
docker load -i images/docker-images.tar
```

确认镜像：

```bash
docker images | grep -E 'liuzx-|mysql|redis|kafka|nacos'
```

## 11. 更新部署目录

如果要完整替换 `/opt/liuzx-docker` 的 compose 和部署文件，使用安装脚本：

```bash
sudo ./install.sh --target /opt/liuzx-docker --force
```

说明：

- `--force` 会把旧目录移动为带时间戳的备份目录。
- 不加 `--start`，是为了先执行 SQL，再按顺序启动容器。

如果只想保留现有目录，仅手动同步文件，可以参考：

```bash
sudo rsync -a --delete \
  --exclude '*/data/' \
  --exclude '*/logs/' \
  --exclude 'backups/' \
  app/ /opt/liuzx-docker/
```

## 12. 执行 SQL 升级

如果 SQL 已在部署目录中：

```bash
docker exec -i liuzx-mysql mysql -uroot -p < /opt/liuzx-docker/liuzx-nas/doc/db/mysql/upgrade_20260522_migration_failure_record.sql
```

如果 SQL 单独放在 `/tmp`：

```bash
docker exec -i liuzx-mysql mysql -uroot -p < /tmp/upgrade_20260522_migration_failure_record.sql
```

验证表是否存在：

```bash
docker exec -i liuzx-mysql mysql -uroot -p <<'SQL'
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'lcloud_nas_4'
  AND table_name = 'nas_migration_failure_record';
SQL
```

## 13. 启动或重建全部容器

进入部署目录：

```bash
cd /opt/liuzx-docker
```

优先使用离线管理脚本：

```bash
./scripts/offline-manage.sh recreate
```

如果需要按顺序手动启动，执行：

```bash
cd /opt/liuzx-docker/mysql8
docker compose up -d --no-build

cd /opt/liuzx-docker/redis8
docker compose up -d --no-build

cd /opt/liuzx-docker/kafka
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-nacos
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-snowflake-id
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-auth
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-admin
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-gateway
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-ca
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-kmc
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-ra
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-nas
docker compose up -d --no-build

cd /opt/liuzx-docker/liuzx-ui
docker compose up -d --no-build
```

## 14. 升级后验证

查看容器状态：

```bash
cd /opt/liuzx-docker
./scripts/offline-manage.sh status
./scripts/offline-manage.sh health
```

查看关键日志：

```bash
docker logs --tail 200 liuzx-nacos
docker logs --tail 200 liuzx-snowflake-id
docker logs --tail 200 liuzx-gateway
docker logs --tail 200 liuzx-nas
docker logs --tail 200 liuzx-ui
```

验证首页：

```bash
curl -I http://127.0.0.1/
```

验证 NAS 迁移任务接口。未登录返回 `Unauthorized` 是正常的，说明路由和服务已通：

```bash
curl -i -X POST http://127.0.0.1/prod-api/nas/v1/migration-tasks/page \
  -H 'Content-Type: application/json' \
  -d '{}'
```

验证 NAS 迁移失败记录接口：

```bash
curl -i -X POST http://127.0.0.1/prod-api/nas/v1/migration-failure-records/page \
  -H 'Content-Type: application/json' \
  -d '{"pageIndex":1,"pageSize":10}'
```

验证 NAS 到 snowflake-id 的网络：

```bash
docker exec liuzx-nas bash -lc '(echo >/dev/tcp/liuzx-snowflake-id/19094) >/dev/null 2>&1 && echo snowflake_grpc_ok || echo snowflake_grpc_fail'
```

期望：

```text
snowflake_grpc_ok
```

## 15. Nacos 路由配置检查

确认 `router.json` 使用 `dev` 命名空间，不使用 `public` 命名空间。

NAS 路由重写应为：

```json
{
  "_genkey_0": "/api-gateway/nas/(?<path>.*)",
  "_genkey_1": "/api/${path}"
}
```

不要配置为：

```json
{
  "_genkey_1": "/api/nas/${path}"
}
```

否则前端请求：

```text
/prod-api/nas/v1/migration-tasks/page
```

会被错误转发成：

```text
/api/nas/v1/migration-tasks/page
```

NAS 服务真实接口是：

```text
/api/v1/migration-tasks/page
```

## 16. 回滚

如果升级失败，优先回滚部署目录：

```bash
sudo rm -rf /opt/liuzx-docker
sudo tar -xzf /tmp/liuzx-docker-backup-YYYYmmddHHMMSS.tar.gz -C /
```

重新启动：

```bash
cd /opt/liuzx-docker
./scripts/offline-manage.sh recreate
```

如果需要回滚数据库：

```bash
docker exec -i liuzx-mysql mysql -uroot -p < /tmp/liuzx-db-backup-YYYYmmddHHMMSS.sql
```

说明：本次新增表 `lcloud_nas_4.nas_migration_failure_record` 通常可以保留，旧版本服务不会访问该表。只有在明确要求完全恢复数据库时，才恢复数据库备份。

## 17. SSH 无法连接时的处理建议

如果连接服务器出现：

```text
Connection timed out during banner exchange
```

说明客户端已经连到 TCP 端口，但 SSH 服务没有返回协议 banner，通常不是密码错误。

需要服务器侧或网络侧检查：

```bash
systemctl status sshd
ss -lntp | grep ssh
firewall-cmd --list-all
iptables -L -n
```

同时确认：

- 是否必须通过堡垒机登录。
- SSH 端口是否不是 `22`。
- 安全设备是否限制来源 IP。
- 服务器 sshd 是否异常。
- 云防火墙或机房防火墙是否放通。

在 SSH 恢复前，只能由现场人员或其它运维通道执行本文档中的服务器命令。
