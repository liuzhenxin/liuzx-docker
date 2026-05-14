# 离线部署说明

这套脚本用于把当前 Docker 部署环境迁移到无法联网的服务器。

## 1. 在线机器打包

在当前目录执行：

```bash
scripts/offline-package.sh --build
```

如果镜像已经是最新的，可以不加 `--build`：

```bash
scripts/offline-package.sh
```

输出文件默认在：

```text
offline-packages/liuzx-docker-offline-YYYYmmddHHMMSS.tar.gz
```

离线包包含：

- 所有 compose 配置、Dockerfile、`.env`
- Java 服务 JAR、UI `dist`、nginx 配置
- NAS 所需 HSM 库和测试脚本
- MySQL 初始化 SQL
- 所有 compose 需要的 Docker 镜像 tar
- 离线安装和管理脚本

默认不包含：

- `data/`
- `logs/`
- `backups/`
- `.git/`

## 2. 传输到离线服务器

把生成的 tar.gz 复制到目标服务器，例如：

```bash
scp offline-packages/liuzx-docker-offline-*.tar.gz user@offline-server:/tmp/
```

## 3. 离线服务器安装

目标服务器需要提前安装好 Docker Engine 和 Docker Compose plugin。

```bash
cd /tmp
tar -xzf liuzx-docker-offline-*.tar.gz
cd liuzx-docker-offline-*
sudo ./install.sh --target /opt/liuzx-docker --start
```

如果解压旧离线包时看到 `Ignoring unknown extended header keyword 'LIBARCHIVE.xattr.*'`，这是 macOS 扩展属性元数据提示，不影响文件解压和安装。重新使用当前 `scripts/offline-package.sh` 生成的离线包会关闭这些扩展属性，不再出现该提示。

如果目标目录已存在：

```bash
sudo ./install.sh --target /opt/liuzx-docker --force --start
```

`--force` 会把旧目录移动成带时间戳的备份目录，不会直接删除。

## 4. 日常管理

进入安装目录：

```bash
cd /opt/liuzx-docker
```

查看状态：

```bash
./scripts/offline-manage.sh status
./scripts/offline-manage.sh health
```

启动、停止、重启：

```bash
./scripts/offline-manage.sh start
./scripts/offline-manage.sh stop
./scripts/offline-manage.sh restart
```

强制重建容器：

```bash
./scripts/offline-manage.sh recreate
```

单个镜像和容器升级：

```bash
# 查看可管理服务名
./scripts/offline-manage.sh services

# 导入镜像 tar 并只重建指定容器
./scripts/offline-manage.sh upgrade liuzx-gateway /tmp/liuzx-gateway.tar

# 镜像已经提前导入时，只重建指定容器
./scripts/offline-manage.sh upgrade-container liuzx-gateway
```

查看日志：

```bash
./scripts/offline-manage.sh logs liuzx-nacos
./scripts/offline-manage.sh logs liuzx-gateway 500
```

备份运行数据和环境文件：

```bash
./scripts/offline-manage.sh backup
./scripts/offline-manage.sh backup /backup/liuzx
```

## 5. 注意事项

- 安装脚本会自动创建 Docker 网络 `pki-network`。
- 安装脚本会创建各服务的 `data/` 和 `logs/` 目录。
- NAS compose 依赖宿主机路径 `/data/static/acim2/yjhx` 和 `/data/static/qcxfp/yjhx`，脚本会尝试创建。
- NAS 容器默认按宿主机 `dppc` 用户的 UID/GID 运行，用于保证迁移后写入 `/data/static/` 的文件归属为 `dppc`。如目标用户不是 `dppc`，安装时可指定 `NAS_HOST_USER=用户名`。
- 如果需要强制指定 NAS 写入文件的宿主机 UID/GID，例如 `/data/static/qcxfp/yjhx` 要生成 UID 为 `1002` 的文件，可在安装时指定 `NAS_RUN_UID=1002 NAS_RUN_GID=1002`。
- 如需迁移现有数据库数据，请单独导出 MySQL 数据或拷贝 `mysql8/data`，默认离线包只带初始化 SQL。

例如使用 `dppc` 作为 NAS 文件写入用户：

```bash
sudo NAS_HOST_USER=dppc ./install.sh --target /opt/liuzx-docker --start
```

强制使用 UID/GID `1002`：

```bash
sudo NAS_RUN_UID=1002 NAS_RUN_GID=1002 ./install.sh --target /opt/liuzx-docker --start
```

验证：

```bash
docker exec liuzx-nas id
ls -ld /data/static/acim2/yjhx /data/static/qcxfp/yjhx
ls -ln /data/static/qcxfp/yjhx
```
