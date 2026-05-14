创建共享网络
```
docker network create pki-network
```
查看共享网络

docker network ls



停止所有容器‌：
docker container stop $(docker ps -a -q)
移除所有容器‌：
docker container rm $(docker ps -a -q)
删除所有镜像‌：
docker image rm $(docker image ls -q)

## 离线部署

生成离线包：

```bash
scripts/offline-package.sh --build
```

离线服务器安装：

```bash
tar -xzf liuzx-docker-offline-*.tar.gz
cd liuzx-docker-offline-*
sudo ./install.sh --target /opt/liuzx-docker --start
```

安装后管理：

```bash
cd /opt/liuzx-docker
./scripts/offline-manage.sh status
./scripts/offline-manage.sh health
```

详细说明见：

- [docs/OFFLINE_DEPLOY.md](docs/OFFLINE_DEPLOY.md)
- [docs/OPERATION_MANUAL.md](docs/OPERATION_MANUAL.md)
