FROM eclipse-temurin:25-jre-jammy

LABEL maintainer="Zhenxin Liu <liuzhenxin@ec.com.cn>" \
      description="Snowflake ID Service"

WORKDIR /app

COPY liuzx-snowflake-id.jar app.jar

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    JAVA_OPTS="-Xms256m -Xmx512m"

EXPOSE 9094 19094

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
