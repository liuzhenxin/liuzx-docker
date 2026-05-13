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
      description="Nacos Authentication Service"

WORKDIR /app

COPY liuzx-nacos.jar app.jar

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

ENV JAVA_OPTS="\
-Xms512m \
-Xmx1024m \
-XX:+UseG1GC \
-XX:+UseContainerSupport \
-XX:MaxRAMPercentage=75 \
-XX:+IgnoreUnrecognizedVMOptions \
--add-opens=java.base/java.util=ALL-UNNAMED \
-Dfile.encoding=UTF-8 \
-Djava.security.egd=file:/dev/urandom"

EXPOSE 8048 8848 9848

ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar app.jar"]
