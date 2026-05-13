FROM eclipse-temurin:25-jre-jammy

LABEL maintainer="Zhenxin Liu <liuzhenxin@ec.com.cn>" \
      description="CA Service"

WORKDIR /app

COPY liuzx-ca.jar app.jar

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    JAVA_OPTS="-Xms512m -Xmx512m -Xmn256m"

EXPOSE 4443

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
