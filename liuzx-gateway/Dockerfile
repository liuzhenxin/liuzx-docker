# /**
#  * Copyright (c) 2022-2025 LCloud-Platform-PKI Author or Authors. All Rights Reserved.
#  * <p>
#  * Licensed under the Apache License, Version 2.0 (the "License");
#  * you may not use this file except in compliance with the License.
#  * You may obtain a copy of the License at
#  * <p>
#  *   http://www.apache.org/licenses/LICENSE-2.0
#  * <p>
#  * Unless required by applicable law or agreed to in writing, software
#  * distributed under the License is distributed on an "AS IS" BASIS,
#  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.ev
#  * See the License for the specific language governing permissions and
#  * limitations under the License.
#  */
# ---------- Runtime ----------
FROM eclipse-temurin:25-jre-jammy

LABEL maintainer="Zhenxin Liu <liuzhenxin@ec.com.cn>" \
      description="GateWay Service based on Spring Boot"

# 设置容器内工作目录
WORKDIR /app

# 将 jar 包复制到容器中
COPY liuzx-gateway.jar app.jar

# 设置 UTF-8 编码环境
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# 暴露端口
EXPOSE 5555

# 环境变量（可覆盖 JVM 启动参数）
ENV JAVA_OPTS="-Xms256m -Xmx512m"

# ENTRYPOINT 用于固定命令；CMD 用于可覆盖参数
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
