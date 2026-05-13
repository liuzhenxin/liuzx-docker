FROM nginx:stable-alpine

LABEL maintainer="Zhenxin Liu <liuzhenxin@ec.com.cn>"

# 复制 nginx 配置
COPY nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# 复制静态资源（由于是示例，您可以将打包后的 dist 文件夹放入此目录）
COPY dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
