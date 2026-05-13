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
