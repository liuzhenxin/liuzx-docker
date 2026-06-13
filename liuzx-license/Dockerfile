FROM eclipse-temurin:25-jre-jammy

LABEL maintainer="Zhenxin Liu <liuzhenxin@ec.com.cn>" \
      description="License Service"

WORKDIR /app

COPY liuzx-license.jar app.jar

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    JAVA_OPTS="-Xms512m -Xmx512m -Xmn256m"

EXPOSE 1443

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dloader.main=org.liuzx.license.LicenseApp -cp app.jar org.springframework.boot.loader.launch.PropertiesLauncher"]
