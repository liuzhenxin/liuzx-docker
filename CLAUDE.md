# CLAUDE.md

本文件为 Claude Code (claude.ai/code) 在本仓库中工作时提供指导。

## 项目概述

LiuZX Cloud PKI (LCloud-Platform-PKI) Docker 部署项目。将完整的 PKI/证书管理平台部署为一组 Docker 容器，专为**离线（气隙）部署**到生产服务器而设计。

**服务器目标安装路径：** `/opt/liuzx-docker`

## 架构

所有服务共享一个外部 Docker 桥接网络：`pki-network`。内部 DNS 解析服务名（如 `nacos`、`kafka`、`mysql`）。

### 服务启动顺序（按依赖关系）

```
第一层 - 基础设施：
  mysql8 (MySQL 8.0, :3306)
  redis8 (Redis 8.2, :6379)
  kafka (KRaft 模式, :19092 + kafka-ui :8080)

第二层 - 服务发现：
  liuzx-nacos (:8848/8048/9848) — 依赖 mysql8

第三层 - 平台服务：
  liuzx-auth (:1111)           — Nacos
  liuzx-kmc (:3443)            — MySQL、Nacos、Kafka
  liuzx-ca (:4443)             — MySQL、Nacos、Kafka
  liuzx-license (:1443)        — Nacos、Redis、Kafka
  liuzx-ocsp (:10444)          — MySQL、Nacos
  liuzx-ra (:5443)             — MySQL、Redis、Nacos、Kafka
  liuzx-admin (:9990)          — MySQL、Nacos
  liuzx-gateway (:5555)        — Nacos、Redis、Kafka

第四层 - 业务服务：
  liuzx-nas (:6443)            — MySQL、Nacos、Kafka、HSM 硬件
  liuzx-snowflake-id (:9094 HTTP + :19094 gRPC) — Nacos、Kafka

第五层 - 前端：
  liuzx-ui (:80)               — nginx 反向代理 → gateway + license
```

- **Nacos** 是中心服务注册中心：所有服务使用命名空间 `0dac1a68-2f01-40df-bd26-bf0cb199057a`，分组 `LIUZX_GROUP`。
- **MySQL** 每个服务使用独立数据库：`lcloud_platform_4`、`lcloud_ca_4`、`lcloud_kmc_4`、`lcloud_ra_4`、`lcloud_nas_4`、`lcloud_ocsp`、`lcloud_license_4`、`lcloud_platform_nacos_3`。
- **NAS** 连接物理 HSM 硬件 `211.88.20.90:1815` 进行 SM4 CBC 加密操作（Sansec/SurePass SDK）。

### 服务目录结构

每个 Java 服务（`liuzx-*`）遵循以下结构：
```
liuzx-<名称>/
  .env                     # 版本号、数据库凭证、Nacos/Kafka/Redis 配置
  docker-compose.yml       # 主服务 + 可选的 db-init 一次性容器
  Dockerfile               # 基于 eclipse-temurin:25-jre-jammy
  liuzx-<名称>.jar         # Spring Boot 可执行文件（gitignore，从 Maven 构建复制过来）
  data/                    # 挂载为 /home/<名称>/data
  logs/                    # 挂载为 /tmp 或 /home/<名称>/data/logs
  scripts/                 # 数据库初始化脚本（仅限有数据库的服务）
  mysql/init/              # SQL 文件：00_create_database.sql、01_*_schema.sql、02_*_data.sql
```

**例外情况：**
- `liuzx-ra` 和 `liuzx-ocsp` 使用外部 `application.yml` 进行 Spring 配置
- `liuzx-license` 有 `docker-compose.override.yml`，包含 RSA 签名密钥
- `liuzx-gateway`、`liuzx-auth`、`liuzx-snowflake-id`、`liuzx-license` 没有 `mysql/`（无直接数据库依赖）
- `liuzx-nas` 有 HSM SDK jar/库文件在 `lib/` 中、`hsm/sdhsm.ini`、原生 `.so` 文件、`log4j2-off.xml`
- `liuzx-auth` 有 `fonts/NotoSansCJK-Regular.ttc` 中文字体支持

## 常用命令

### 开发环境（macOS — 本地机器）

```bash
# 创建共享网络（首次使用）
docker network create pki-network

# 构建所有镜像（从 Maven 构建复制 JAR 后执行）
scripts/offline-package.sh --build

# 生成离线部署包（不重新构建）
scripts/offline-package.sh

# 构建单个服务镜像
cd liuzx-nas && docker compose build
```

### 生产环境（Linux 服务器，路径 /opt/liuzx-docker）

```bash
# 按依赖顺序启动所有服务
./scripts/offline-manage.sh start

# 按反向顺序停止所有服务
./scripts/offline-manage.sh stop

# 查看状态概览
./scripts/offline-manage.sh status
./scripts/offline-manage.sh health

# 查看某个服务的日志
./scripts/offline-manage.sh logs liuzx-nas

# 升级单个服务镜像
./scripts/offline-manage.sh upgrade-image /path/to/liuzx-nas-image.tar
./scripts/offline-manage.sh upgrade-container liuzx-nas

# 完整备份
./scripts/offline-manage.sh backup /backup/path
```

### 离线部署流程

1. **打包**（在线机器）：`scripts/offline-package.sh --build`
2. **传输** 将 `offline-packages/` 中的 tar 包传输到离线服务器
3. **安装**（服务器上）：`tar -xzf liuzx-docker-offline-*.tar.gz && cd liuzx-docker-offline-* && sudo ./install.sh --target /opt/liuzx-docker --start`
4. **管理**（服务器上）：`cd /opt/liuzx-docker && ./scripts/offline-manage.sh <命令>`

### JAR 文件管理

JAR 文件被 **gitignore** 忽略，需要从外部构建。Maven 源码路径为 `/Users/liuzhenxin/Office/Source/Liuzx/LCloud/PKI/`。构建后：

```bash
# 复制 JAR 到对应目录（以 NAS 为例）
cp /Users/liuzhenxin/Office/Source/Liuzx/LCloud/PKI/pki-nas/target/liuzx-nas.jar liuzx-nas/

# 前端 dist
cp -r /Users/liuzhenxin/Office/Source/Liuzx/LCloud/PKI/pki-ui/dist liuzx-ui/dist
```

### 数据库操作

每个服务的数据库由一个一次性的 `*-db-init` 容器初始化，该容器使用 `docker:27-cli` 并通过 Docker socket 访问，在运行中的 MySQL 容器内执行 SQL：

```bash
# 手动初始化某个服务的数据库
docker compose -f liuzx-ca/docker-compose.yml run --rm liuzx-ca-db-init

# 直接访问 MySQL
docker exec -it liuzx-mysql mysql -uroot -p
```

## 关键文件

- `scripts/lib/offline-common.sh` — 核心库：`SERVICE_DIRS` 启动顺序、`ensure_network`、`ensure_runtime_dirs`、`compose_cmd`、`compose_images`。所有脚本都引用此文件。
- `scripts/offline-package.sh` — 构建离线 tar 包（docker save + tar）
- `scripts/offline-install.sh` — 服务器端从 tar 包安装
- `scripts/offline-manage.sh` — 日常运维（启动/停止/升级/备份/日志）
- `docs/OPERATION_MANUAL.md` — 完整运维手册（部署、升级、回滚、故障排查）

## 重要约定

- **`.env` 文件被 gitignore 忽略** — 每个服务有包含默认配置（版本号、凭证）的 `.env` 文件，运行时必须存在但不提交到版本控制。对 `.env` 的修改视为仅本地有效。
- **启动顺序很重要** — 脚本强制执行严格的依赖顺序。`offline-common.sh` 中的 `SERVICE_DIRS` 定义了标准顺序。
- **所有镜像使用 `restart: unless-stopped`**，日志采用 JSON 文件格式（最大 50MB，保留 3 个文件）。
- **NAS 需要特殊设置**：主机路径 `/data/static/acim2/yjhx` 和 `/data/static/qcxfp/yjhx` 必须存在，NAS 的 UID/GID 通过 `.env` 中的 `NAS_RUN_UID`/`NAS_RUN_GID` 设置。
- **打包时设置 `COPYFILE_DISABLE=1`**，避免 macOS 的 `._` 扩展属性文件污染 Linux 环境。
- **新服务**（`liuzx-license`、`liuzx-ocsp`、`liuzx-snowflake-id`）目录已存在但尚未提交到 git — 完成后需要 commit。
