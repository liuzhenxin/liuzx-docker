要测试基于GraalVM JDK 25.0.0构建的liuzx-nacos Docker镜像是否成功，可以按照以下步骤进行验证：

1. 检查镜像构建状态
首先确认镜像是否成功构建。在构建完成后，使用以下命令查看本地镜像列表：

```
docker images | grep liuzx-nacos
如果能看到包含liuzx-nacos标签的镜像，说明构建成功‌
```

2. 运行容器并验证服务
通过运行容器来测试镜像是否正常工作：
```
docker run -d -p 8848:8848 --name liuxx-nacos liuzx-nacos:latest
```
-d：后台运行容器
-p 8848:8848：将容器内的8848端口映射到主机
--name：为容器指定名称
3. 检查容器运行状态
使用以下命令查看容器是否正常运行：

```
docker ps
```
如果容器状态为Up，说明服务已启动‌

4. 查看容器日志
如果服务未正常启动，可以通过日志排查问题：

```
docker logs -f liuxx-nacos
```
查看日志中的错误信息，帮助定位问题‌


5. 测试服务连通性
通过curl或浏览器访问Nacos服务，验证功能是否正常：

```
curl http://localhost:8848/nacos
```
如果能够访问Nacos登录页面，说明服务运行正常‌

6. 清理测试环境
测试完成后，可以停止并删除测试容器：

```
docker stop liuxx-nacos
docker rm liuxx-nacos
```

通过以上步骤，您可以全面验证基于GraalVM JDK 25.0.0构建的liuzx-nacos Docker镜像是否成功构建并正常运行。


部署说明：‌
将docker-compose.yml文件与Dockerfile放在同一目录
运行 docker-compose up -d 启动服务
运行 docker-compose logs -f 查看实时日志
访问 http://localhost:8848/nacos 验证服务运行状态
