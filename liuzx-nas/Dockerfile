FROM eclipse-temurin:25-jre-jammy

LABEL maintainer="Zhenxin Liu <liuzhenxin@ec.com.cn>" \
      description="NAS Service"

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends iputils-ping telnet \
    && rm -rf /var/lib/apt/lists/*

COPY liuzx-nas.jar app.jar
COPY lib/sdhsm-1.5.1.jar /app/lib/sdhsm-1.5.1.jar
COPY lib/sdjce-1.5.1.jar /app/lib/sdjce-1.5.1.jar
COPY hsm/sdhsm.ini /app/sdhsm.ini
COPY doc/文件加密/Linux64/libsdcrypto4j.so /usr/lib64/libsdcrypto4j.so
COPY doc/文件加密/Linux64/libsdhsmcrypto.so /usr/lib64/libsdhsmcrypto.so
COPY doc/文件加密/Linux64/libsdcrypto4j.so /usr/lib/libsdcrypto4j.so
COPY doc/文件加密/Linux64/libsdhsmcrypto.so /usr/lib/libsdhsmcrypto.so

RUN ldconfig

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LD_LIBRARY_PATH=/usr/lib64:/usr/lib \
    JAVA_TOOL_OPTIONS="--enable-native-access=ALL-UNNAMED" \
    JAVA_OPTS="-Xms512m -Xmx512m -Xmn256m -Djava.library.path=/usr/lib64:/usr/lib"

EXPOSE 6443

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
