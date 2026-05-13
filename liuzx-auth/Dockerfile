
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
      description="Auth Service"

# 安装字体库依赖 (freetype, fontconfig)
# Temurin 镜像是基于 Ubuntu 的，所以使用 apt-get
RUN apt-get update -y && \
    apt-get install -y fontconfig libfreetype6 && \
    apt-get clean

# 工作目录
WORKDIR /app

# 复制 Spring Boot 可执行 JAR
COPY liuzx-auth.jar app.jar

# 设置 UTF-8 环境
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# 复制中文字体（Noto Sans CJK SC）到系统字体目录
COPY fonts/NotoSansCJK-Regular.ttc /usr/share/fonts/truetype/NotoSansCJK-Regular.ttc

# 暴露端口
EXPOSE 1111

# JVM 参数
ENV JAVA_OPTS="-Xms256m -Xmx512m"

# 启动 Spring Boot 应用
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
