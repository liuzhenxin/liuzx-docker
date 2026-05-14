# liuzx-nas 密码机 SM4 CBC 加密与解密测试脚本使用说明

本文说明 `liuzx-nas` 容器内密码机 SM4 CBC 加密自测脚本和批量解密测试脚本的使用方法。

## 1. 脚本用途

当前镜像内提供两个脚本：

```text
/usr/local/bin/sm4-cbc-test
/usr/local/bin/decrypt-20240427-enc-test
```

用途如下：

| 脚本 | 用途 | 默认入口类 |
| --- | --- | --- |
| `sm4-cbc-test` | 执行 SM4 CBC 字节加解密和文件加解密闭环测试 | `Sm4CbcRunner` |
| `decrypt-20240427-enc-test` | 对指定目录内的已加密文件做批量解密测试 | `BatchSm4CbcDecryptRunner` |

说明：

- `sm4-cbc-test` 会在容器内生成临时明文文件，调用密码机加密，再调用密码机解密，并校验解密结果是否等于原始明文。
- `decrypt-20240427-enc-test` 只做批量解密测试，输入目录必须已经存在加密文件。
- 两个脚本都通过 Spring Boot `PropertiesLauncher` 加载 `/app/app.jar` 内的 NAS 代码和密码机依赖。

## 2. 前置条件

进入部署目录：

```bash
cd ~/aio/docker/liuzx-nas
```

确认容器运行：

```bash
docker ps --filter name=liuzx-nas
```

确认健康状态：

```bash
curl -fsS http://127.0.0.1:6443/api/actuator/health
```

确认密码机配置存在：

```bash
docker exec liuzx-nas sh -lc 'ls -l /app/sdhsm.ini && grep -E "^(IP|PORT|CONNTIMEOUT|RWTIMEOUT)" /app/sdhsm.ini'
```

确认测试入口类存在：

```bash
docker exec liuzx-nas sh -lc 'ls -l /opt/liuzx-nas/tools/Sm4CbcRunner.class /opt/liuzx-nas/tools/BatchSm4CbcDecryptRunner.class'
```

如果脚本或入口类不存在，需要重新构建镜像：

```bash
docker compose up -d --build
```

## 3. 加密自测脚本

执行：

```bash
docker exec liuzx-nas sm4-cbc-test
```

等价完整命令：

```bash
docker exec liuzx-nas sh -lc 'cd /app && java -Dloader.main=Sm4CbcRunner -Dloader.path=/opt/liuzx-nas/tools -cp /app/app.jar org.springframework.boot.loader.launch.PropertiesLauncher'
```

脚本默认参数：

| 参数 | 默认值 | 说明 |
| --- | --- | --- |
| `APP_JAR` | `/app/app.jar` | NAS 应用 JAR |
| `LOADER_MAIN` | `Sm4CbcRunner` | 测试入口类 |
| `LOADER_PATH` | `/opt/liuzx-nas/tools` | 测试入口类所在目录 |
| `JAVA_OPTS_EXTRA` | 空 | 额外 Java 参数 |

如需追加 Java 参数：

```bash
docker exec -e JAVA_OPTS_EXTRA='-Djava.security.egd=file:/dev/./urandom' liuzx-nas sm4-cbc-test
```

成功时输出包含：

```text
SM4 CBC byte round trip OK
SM4 CBC file round trip OK
```

判断标准：

- 可以读取 `/app/sdhsm.ini`。
- 可以连接密码机。
- 字节数组加密后不等于原文。
- 字节数组解密后等于原文。
- 文件加密后不等于原文件内容。
- 文件解密后等于原文件内容。
- 命令退出码为 `0`。

检查退出码：

```bash
docker exec liuzx-nas sm4-cbc-test
echo $?
```

## 4. 批量解密测试脚本

默认执行：

```bash
docker exec liuzx-nas decrypt-20240427-enc-test
```

默认输入输出目录：

| 目录 | 默认值 | 说明 |
| --- | --- | --- |
| 输入目录 | `/Users/liuzhenxin/20240427-enc` | 已加密文件目录 |
| 输出目录 | `/Users/liuzhenxin/20240427-dec-test` | 解密结果目录 |
| IV | `LCloud-NAS-IV123` | SM4 CBC IV，必须是 16 字节 |

这些目录已在 `docker-compose.yml` 中挂载到容器内：

```yaml
- /Users/liuzhenxin/20240427-enc:/Users/liuzhenxin/20240427-enc:rw
- /Users/liuzhenxin/20240427-dec-test:/Users/liuzhenxin/20240427-dec-test:rw
```

指定输入目录、输出目录和 IV：

```bash
docker exec liuzx-nas decrypt-20240427-enc-test \
  /Users/liuzhenxin/20240427-enc \
  /Users/liuzhenxin/20240427-dec-test \
  LCloud-NAS-IV123
```

也可以通过环境变量指定默认值：

```bash
docker exec \
  -e INPUT_DIR=/Users/liuzhenxin/20240427-enc \
  -e OUTPUT_DIR=/Users/liuzhenxin/20240427-dec-test \
  -e SM4_CBC_IV=LCloud-NAS-IV123 \
  liuzx-nas decrypt-20240427-enc-test
```

成功时输出类似：

```text
NAS SM4 CBC decrypt test
inputDir=/Users/liuzhenxin/20240427-enc
outputDir=/Users/liuzhenxin/20240427-dec-test
files=38
OK  xxx.jpg -> /Users/liuzhenxin/20240427-dec-test/xxx.jpg
decrypt summary: success=38, failed=0
```

判断标准：

- 输入目录存在。
- 输出目录可以创建或写入。
- IV 长度为 16 字节。
- 所有输入文件均能解密成功。
- `decrypt summary` 中 `failed=0`。
- 命令退出码为 `0`。

## 5. 常见问题

### 5.1 无法连接密码机

错误示例：

```text
连接设备失败
无有效设备连接
SDF_OpenDevice 设备打开失败
GfaSM4Exception: 无法连接到密码机
```

检查配置：

```bash
docker exec liuzx-nas sh -lc 'grep -E "^(IP|PORT|CONNTIMEOUT|RWTIMEOUT)" /app/sdhsm.ini'
```

检查网络：

```bash
docker exec liuzx-nas sh -lc 'ping -c 3 <密码机IP> || true'
docker exec liuzx-nas sh -lc 'telnet <密码机IP> <端口>'
```

如果修改了 `hsm/sdhsm.ini`，需要重新构建镜像：

```bash
docker compose up -d --build
```

### 5.2 IV 长度错误

错误示例：

```text
IV must be 16 bytes
```

SM4 CBC 的 IV 必须是 16 字节。当前默认值：

```text
LCloud-NAS-IV123
```

该字符串长度为 16 字节。

### 5.3 输入目录不存在

错误示例：

```text
Input directory does not exist
```

检查目录是否已挂载进容器：

```bash
docker exec liuzx-nas sh -lc 'ls -ld /Users/liuzhenxin/20240427-enc'
```

如需使用其它宿主机目录，需要先在 `docker-compose.yml` 的 `volumes` 中增加挂载，然后重建或重启容器。

### 5.4 找不到入口类

错误示例：

```text
ERROR: decrypt runner class not found
ERROR: runner class not found
```

检查镜像内文件：

```bash
docker exec liuzx-nas sh -lc 'find /opt/liuzx-nas/tools -maxdepth 1 -type f -print'
```

如果缺失，重新构建镜像：

```bash
docker compose up -d --build
```

## 6. 相关文件

宿主机路径：

```text
~/aio/docker/liuzx-nas/sm4-cbc-test.sh
~/aio/docker/liuzx-nas/decrypt-20240427-enc-test.sh
~/aio/docker/liuzx-nas/Sm4CbcRunner.java
~/aio/docker/liuzx-nas/BatchSm4CbcDecryptRunner.java
~/aio/docker/liuzx-nas/hsm/sdhsm.ini
~/aio/docker/liuzx-nas/docker-compose.yml
~/aio/docker/liuzx-nas/Dockerfile
```

容器路径：

```text
/app/app.jar
/app/sdhsm.ini
/app/lib/sdhsm-1.5.1.jar
/app/lib/sdjce-1.5.1.jar
/opt/liuzx-nas/tools/Sm4CbcRunner.class
/opt/liuzx-nas/tools/BatchSm4CbcDecryptRunner.class
/usr/local/bin/sm4-cbc-test
/usr/local/bin/decrypt-20240427-enc-test
```
