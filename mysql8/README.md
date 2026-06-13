## 用途

该目录只构建 MySQL 8 容器运行环境，不在容器初始化时自动创建业务数据库、业务表或初始化数据。

## 目录结构

```text
mysql8/
├── docker-compose.yml
├── mysql/
│   └── conf.d/
│       └── my.cnf
└── README.md
```

## 启动命令

```bash
docker compose up -d
```

## 关键配置说明

1. `./data` 挂载到 `/var/lib/mysql`，用于保存 MySQL 数据文件。
2. `./mysql/conf.d/my.cnf` 只读挂载到 `/etc/mysql/conf.d/my.cnf`，用于统一字符集、连接数和网络配置。
3. 本目录不维护业务数据库脚本，容器启动时不会自动创建业务数据库、业务表或导入业务数据。

## 验证步骤

```bash
docker exec -it liuzx-mysql mysql -uroot -p11111111 -e "SHOW VARIABLES LIKE 'character%';"
docker exec -it liuzx-mysql mysql -uroot -p11111111 -e "SHOW DATABASES;"
```

## 删除容器

```bash
docker compose down
```
