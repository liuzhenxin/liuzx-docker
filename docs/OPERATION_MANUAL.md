# Docker 离线部署操作手册

## 1. 文档目标

本文档用于指导运维人员将当前 Docker 部署环境打包，并部署到无法联网的服务器上。

适用范围：

- 在线机器生成离线部署包
- 离线服务器安装部署包
- 日常启动、停止、重启、状态检查和日志查看
- 数据备份、升级、回滚和常见故障处理

## 2. 部署组成

业务服务：

- `liuzx-admin`
- `liuzx-auth`
- `liuzx-ca`
- `liuzx-gateway`
- `liuzx-kmc`
- `liuzx-nacos`
- `liuzx-nas`
- `liuzx-ra`
- `liuzx-ui`

基础设施服务：

- `liuzx-mysql`
- `liuzx-redis`
- `liuzx-kafka`
- `liuzx-kafka-ui`

默认 Docker 网络：

```text
pki-network
```

默认离线安装目录：

```text
/opt/liuzx-docker
```

## 3. 前置条件

在线打包机器需要：

- 已安装 Docker Engine
- 已安装 Docker Compose plugin
- 当前 Docker 镜像已构建完成，或允许打包脚本执行构建
- 当前目录包含各服务 `.env`、JAR、UI `dist`、MySQL 初始化 SQL 等部署文件

离线服务器需要：

- Linux 服务器
- 已安装 Docker Engine
- 已安装 Docker Compose plugin
- 操作用户可执行 Docker 命令，或使用 `sudo`
- 目标端口未被其它进程占用

常用端口：

```text
80      liuzx-ui
1111    liuzx-auth
3443    liuzx-kmc
4443    liuzx-ca
5443    liuzx-ra
5555    liuzx-gateway
6443    liuzx-nas
8048    liuzx-nacos
8848    liuzx-nacos
9848    liuzx-nacos
3306    liuzx-mysql
6379    liuzx-redis
8080    liuzx-kafka-ui
19092   liuzx-kafka
```

## 4. 在线打包

进入 Docker 部署目录：

```bash
cd /Users/liuzhenxin/aio/docker
```

构建镜像并生成离线包：

```bash
scripts/offline-package.sh --build
```

如果确认镜像已经是最新版本，可以跳过构建：

```bash
scripts/offline-package.sh
```

指定输出目录和包名：

```bash
scripts/offline-package.sh \
  --output /tmp/liuzx-offline \
  --name liuzx-docker-offline-4.1.2
```

打包完成后会生成：

```text
offline-packages/liuzx-docker-offline-YYYYmmddHHMMSS.tar.gz
```

离线包包含：

- 部署目录文件
- Docker Compose 配置
- `.env` 环境文件
- JAR 包
- UI `dist`
- MySQL 初始化 SQL
- NAS 依赖库
- Docker 镜像 tar
- 安装和管理脚本

离线包默认不包含：

- 运行数据目录 `data/`
- 日志目录 `logs/`
- 备份目录 `backups/`
- Git 仓库目录 `.git/`

## 5. 离线包传输

将离线包复制到目标服务器：

```bash
scp offline-packages/liuzx-docker-offline-*.tar.gz user@offline-server:/tmp/
```

也可以使用 U 盘、堡垒机文件传输或其它内网传输方式。

传输完成后，建议在目标服务器确认文件大小：

```bash
ls -lh /tmp/liuzx-docker-offline-*.tar.gz
```

## 6. 离线安装

登录离线服务器：

```bash
ssh user@offline-server
```

解压离线包：

```bash
cd /tmp
tar -xzf liuzx-docker-offline-*.tar.gz
cd liuzx-docker-offline-*
```

如果解压旧离线包时看到 `Ignoring unknown extended header keyword 'LIBARCHIVE.xattr.*'`，这是 macOS 扩展属性元数据提示，不影响文件解压和安装。重新使用当前 `scripts/offline-package.sh` 生成的离线包会关闭这些扩展属性，不再出现该提示。

安装并启动：

```bash
sudo ./install.sh --target /opt/liuzx-docker --start
```

如果 `/opt/liuzx-docker` 已存在，使用 `--force`：

```bash
sudo ./install.sh --target /opt/liuzx-docker --force --start
```

说明：

- `--target` 指定安装目录。
- `--start` 安装完成后自动启动所有容器。
- `--force` 会把旧目录移动为时间戳备份目录，不会直接删除。

## 7. 安装后检查

进入安装目录：

```bash
cd /opt/liuzx-docker
```

查看容器状态：

```bash
./scripts/offline-manage.sh status
```

查看健康状态：

```bash
./scripts/offline-manage.sh health
```

正常情况下应看到大部分服务为：

```text
healthy running
```

`liuzx-kafka-ui` 没有配置健康检查，显示 `none running` 属于正常。

检查 Docker 网络：

```bash
docker network inspect pki-network
```

检查对外端口：

```bash
docker ps --format 'table {{.Names}}\t{{.Ports}}'
```

## 8. 日常管理

进入安装目录：

```bash
cd /opt/liuzx-docker
```

启动全部服务：

```bash
./scripts/offline-manage.sh start
```

停止全部服务：

```bash
./scripts/offline-manage.sh stop
```

停止并移除容器：

```bash
./scripts/offline-manage.sh down
```

重启全部服务：

```bash
./scripts/offline-manage.sh restart
```

强制重建全部容器：

```bash
./scripts/offline-manage.sh recreate
```

校验 Compose 配置：

```bash
./scripts/offline-manage.sh config
```

查看当前需要的镜像：

```bash
./scripts/offline-manage.sh images
```

查看可单独管理的服务：

```bash
./scripts/offline-manage.sh services
```

## 9. 日志查看

查看 Nacos 日志：

```bash
./scripts/offline-manage.sh logs liuzx-nacos
```

查看 Gateway 最近 500 行日志并持续跟踪：

```bash
./scripts/offline-manage.sh logs liuzx-gateway 500
```

直接使用 Docker 查看日志：

```bash
docker logs --tail 200 liuzx-admin
docker logs -f --tail 200 liuzx-auth
```

## 10. 数据备份

执行运行数据和环境文件备份：

```bash
cd /opt/liuzx-docker
./scripts/offline-manage.sh backup
```

指定备份目录：

```bash
./scripts/offline-manage.sh backup /backup/liuzx
```

备份内容包括：

- 各服务 `.env`
- 各服务 `data/`
- 业务服务 `logs/`

重要说明：

- 该备份适合保留部署现场配置和运行目录。
- 生产 MySQL 建议额外使用 `mysqldump` 做逻辑备份。

MySQL 逻辑备份示例：

```bash
docker exec liuzx-mysql sh -c 'mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" --all-databases' > mysql-all.sql
```

Redis 数据备份示例：

```bash
docker exec liuzx-redis redis-cli -a "$REDIS_PASSWORD" save
tar -czf redis-data.tar.gz redis8/data
```

## 11. 升级流程

### 11.1 全量升级

在线机器生成新的离线包：

```bash
scripts/offline-package.sh --build --name liuzx-docker-offline-new
```

传输到离线服务器后，先备份旧环境：

```bash
cd /opt/liuzx-docker
./scripts/offline-manage.sh backup /backup/liuzx
```

停止旧环境：

```bash
./scripts/offline-manage.sh stop
```

安装新包：

```bash
cd /tmp
tar -xzf liuzx-docker-offline-new.tar.gz
cd liuzx-docker-offline-new
sudo ./install.sh --target /opt/liuzx-docker --force --start
```

升级后检查：

```bash
cd /opt/liuzx-docker
./scripts/offline-manage.sh health
./scripts/offline-manage.sh status
```

### 11.2 单个镜像和容器升级

适用于只更新一个服务镜像，不替换整套离线部署目录的场景。

在线机器导出单个新镜像：

```bash
docker save -o liuzx-gateway.tar liuzx-gateway:新版本号
```

把镜像 tar 传输到离线服务器后执行：

```bash
cd /opt/liuzx-docker
./scripts/offline-manage.sh backup /backup/liuzx
./scripts/offline-manage.sh upgrade liuzx-gateway /tmp/liuzx-gateway.tar
```

如果镜像已经通过其他方式导入，也可以只重建指定容器：

```bash
./scripts/offline-manage.sh upgrade-container liuzx-gateway
```

可用服务名通过以下命令查看：

```bash
./scripts/offline-manage.sh services
```

`upgrade` 和 `upgrade-container` 只对目标 compose service 执行 `up -d --no-deps --force-recreate`，不会主动重启依赖服务。

## 12. 回滚流程

如果安装新包时使用了 `--force`，旧目录会被移动成类似：

```text
/opt/liuzx-docker.backup.YYYYmmddHHMMSS
```

停止当前环境：

```bash
cd /opt/liuzx-docker
./scripts/offline-manage.sh down
```

恢复旧目录：

```bash
sudo mv /opt/liuzx-docker /opt/liuzx-docker.failed.$(date +%Y%m%d%H%M%S)
sudo mv /opt/liuzx-docker.backup.YYYYmmddHHMMSS /opt/liuzx-docker
```

启动旧环境：

```bash
cd /opt/liuzx-docker
sudo ./scripts/offline-manage.sh start
```

## 13. 常见故障处理

### 13.1 Docker 未安装或未启动

现象：

```text
docker daemon is not available
```

处理：

```bash
systemctl status docker
sudo systemctl start docker
sudo systemctl enable docker
```

### 13.2 Docker Compose 不可用

现象：

```text
docker compose plugin is not available
```

处理：

- 确认已安装 Docker Compose plugin。
- 执行 `docker compose version` 验证。

### 13.3 端口被占用

现象：

```text
Bind for 0.0.0.0:PORT failed: port is already allocated
```

处理：

```bash
sudo lsof -i :PORT
docker ps --format 'table {{.Names}}\t{{.Ports}}'
```

停止占用端口的进程或容器后重新启动：

```bash
./scripts/offline-manage.sh start
```

### 13.4 容器 unhealthy

查看健康状态：

```bash
./scripts/offline-manage.sh health
```

查看日志：

```bash
./scripts/offline-manage.sh logs liuzx-nacos 300
```

常见处理顺序：

```bash
./scripts/offline-manage.sh restart
./scripts/offline-manage.sh health
```

如果业务服务连接 Nacos 失败，先确认 `liuzx-nacos` 是否 healthy：

```bash
docker ps --filter name=liuzx-nacos
docker logs --tail 200 liuzx-nacos
```

### 13.5 镜像不存在

现象：

```text
image not found locally
```

处理：

- 在线机器重新执行打包。
- 确认离线包内存在 `images/docker-images.tar`。
- 离线服务器重新安装或手动加载：

```bash
docker load -i images/docker-images.tar
```

### 13.6 外部网络不存在

安装脚本会自动创建 `pki-network`。如果需要手动创建：

```bash
docker network create pki-network
```

### 13.7 NAS 宿主机目录不存在

NAS 依赖以下宿主机路径：

```text
/data/static/acim2/yjhx
/data/static/qcxfp/yjhx
```

手动创建：

```bash
sudo mkdir -p /data/static/acim2/yjhx /data/static/qcxfp/yjhx
```

NAS 容器默认按宿主机 `dppc` 用户的 UID/GID 运行，确保迁移后写入 `/data/static/` 的文件在宿主机上归属为 `dppc`。如果目标服务器的写入用户不是 `dppc`，安装时指定：

```bash
sudo NAS_HOST_USER=用户名 ./install.sh --target /opt/liuzx-docker --start
```

如果 `/data/static/qcxfp/yjhx` 目录下新生成文件必须归属 UID `1002`，安装时强制指定：

```bash
sudo NAS_RUN_UID=1002 NAS_RUN_GID=1002 ./install.sh --target /opt/liuzx-docker --start
```

如果手动准备目录，需要同时设置目录归属：

```bash
sudo chown -R 1002:1002 /data/static/acim2/yjhx /data/static/qcxfp/yjhx
```

验证 NAS 容器运行用户和宿主机文件归属：

```bash
docker exec liuzx-nas id
ls -ld /data/static/acim2/yjhx /data/static/qcxfp/yjhx
ls -ln /data/static/qcxfp/yjhx
```

## 14. 验收清单

部署完成后逐项确认：

- Docker 服务运行正常
- `pki-network` 已存在
- 13 个容器均已启动
- 除 `liuzx-kafka-ui` 外，其它带健康检查的容器均为 `healthy`
- UI 端口 `80` 可访问
- Nacos 端口 `8048/8848/9848` 可访问
- MySQL、Redis、Kafka 容器状态正常
- 业务服务日志无持续启动失败异常
- 已完成首次备份

推荐验收命令：

```bash
cd /opt/liuzx-docker
./scripts/offline-manage.sh status
./scripts/offline-manage.sh health
docker ps
```
