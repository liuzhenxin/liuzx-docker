# liuzx-nas 容器内密码机 SM4 CBC 加解密测试说明

本文说明如何在 `liuzx-nas` Docker 容器内执行密码机 SM4 CBC 加密和解密连通性测试。

## 1. 基本说明

`liuzx-nas` 不是宿主机 shell 命令，因此直接执行：

```bash
liuzx-nas
```

会得到：

```text
zsh:1: command not found: liuzx-nas
```

当前部署使用 Docker Compose 管理，容器名称是 `nas`，服务目录是：

```bash
~/aio/docker/liuzx-nas
```

所有容器内操作应通过 `docker exec nas ...` 执行。

## 2. 前置检查

进入部署目录：

```bash
cd ~/aio/docker/liuzx-nas
```

确认容器正在运行：

```bash
docker ps --filter name=nas
```

确认应用健康状态：

```bash
curl -fsS http://127.0.0.1:6443/api/actuator/health
```

确认容器内密码机配置文件存在：

```bash
docker exec nas sh -lc 'ls -l /app/sdhsm.ini && sed -n "1,40p" /app/sdhsm.ini'
```

确认测试执行类存在：

```bash
docker exec nas sh -lc 'ls -l /tmp/Sm4CbcRunner.class'
```

说明：宿主机上的 `Sm4CbcRunner.class` 会单独挂载到容器 `/tmp/Sm4CbcRunner.class`。

## 3. 执行测试脚本

脚本位置：

```bash
~/aio/docker/liuzx-nas/sm4-cbc-test.sh
```

该脚本在容器内路径是：

```bash
/tmp/sm4-cbc-test.sh
```

执行：

```bash
docker exec nas sh /tmp/sm4-cbc-test.sh
```

脚本实际使用 Spring Boot `PropertiesLauncher` 加载 `/app/app.jar` 内的 NAS 类和依赖，并把 `/tmp/Sm4CbcRunner.class` 作为入口类运行。

等价手工命令：

```bash
docker exec nas sh -lc 'cd /app && java -Dloader.main=Sm4CbcRunner -Dloader.path=/tmp -cp /app/app.jar org.springframework.boot.loader.launch.PropertiesLauncher'
```

## 4. 预期结果

测试成功时应看到类似结果：

```text
plain: ...
encrypted: ...
decrypted: ...
SM4 CBC encrypt/decrypt OK
```

具体输出取决于 `Sm4CbcRunner.class` 的实现。判断标准是：

- 能打开密码机会话。
- SM4 CBC 加密返回密文。
- SM4 CBC 解密后内容与原始明文一致。
- 进程退出码为 `0`。

检查退出码：

```bash
docker exec nas sh /tmp/sm4-cbc-test.sh
echo $?
```

## 5. 当前已知错误示例

如果输出包含：

```text
211.88.20.90 接收超时
连接设备 [ 211.88.20.90:1815 ] 失败
无有效设备连接
SDF_OpenDevice 设备打开失败
GfaSM4Exception: 无法连接到密码机
```

说明脚本已成功进入 NAS SM4 CBC 测试逻辑，但容器无法连接 `/app/sdhsm.ini` 中配置的密码机地址。

排查方向：

```bash
docker exec nas sh -lc 'grep -E "^(IP|PORT)[[:space:]]*=" /app/sdhsm.ini'
docker exec nas sh -lc 'ping -c 3 211.88.20.90 || true'
docker exec nas sh -lc 'telnet 211.88.20.90 1815'
```

如 `IP` 或 `PORT` 与实际密码机地址不一致，修改宿主机配置：

```bash
vi ~/aio/docker/liuzx-nas/hsm/sdhsm.ini
```

然后重建容器：

```bash
cd ~/aio/docker/liuzx-nas
docker compose up -d --build
```

## 6. 文件位置

宿主机部署目录：

```text
~/aio/docker/liuzx-nas
```

关键文件：

```text
docker-compose.yml       Docker Compose 配置
Dockerfile               NAS 镜像构建文件
liuzx-nas.jar            当前部署 JAR
hsm/sdhsm.ini            密码机配置
Sm4CbcRunner.class       SM4 CBC 测试入口类
sm4-cbc-test.sh          容器内测试脚本
```

容器内关键路径：

```text
/app/app.jar             NAS 应用 JAR
/app/sdhsm.ini           镜像内密码机配置
/app/lib/*.jar           厂商密码机 Java 依赖
/usr/lib64/*.so          厂商密码机 Native 依赖
/tmp/Sm4CbcRunner.class  SM4 CBC 测试入口类
/tmp/sm4-cbc-test.sh     测试脚本
```

## 7. 重新部署后注意事项

`logs/` 目录挂载到容器 `/tmp`；`Sm4CbcRunner.class` 和 `sm4-cbc-test.sh` 从部署目录分别单独挂载到容器 `/tmp/Sm4CbcRunner.class` 和 `/tmp/sm4-cbc-test.sh`。

但 `/app/app.jar`、`/app/sdhsm.ini`、`/app/lib` 和 native `.so` 来自镜像构建内容。修改 JAR、HSM 配置或 Dockerfile 后，需要执行：

```bash
cd ~/aio/docker/liuzx-nas
docker compose up -d --build
```

重建后再次运行：

```bash
docker exec nas sh /tmp/sm4-cbc-test.sh
```
