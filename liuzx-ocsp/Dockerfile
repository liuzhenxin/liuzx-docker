FROM eclipse-temurin:25-jre-jammy

LABEL maintainer="Zhenxin Liu <liuzhenxin@ec.com.cn>" \
      description="OCSP Service"

WORKDIR /app

COPY liuzx-ocsp.jar app.jar
COPY application.yml application.yml

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    JAVA_OPTS="-Xms512m -Xmx1024m -Xmn256m" \
    SPRING_CONFIG_LOCATION="file:/app/application.yml" \
    SPRING_CLOUD_BOOTSTRAP_ENABLED="false"

EXPOSE 6960

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
