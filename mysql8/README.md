## 项目结构
```
mysql-charset-fix/
├── docker-compose.yml
├── mysql/
│   └── conf.d/
│       └── my.cnf
├── init/
│   ├── init.sql
└── README.md
```

## 启动命令

# 启动服务
docker-compose up -d

# 验证字符集配置
docker exec -it mysql8 mysql -uroot -p11111111 -e "SHOW VARIABLES LIKE 'character%';"

# 检查数据库创建
docker exec -it mysql8 mysql -uroot -p11111111 -e "SHOW DATABASES;"
```

## 关键配置说明
1. **字符集统一**：服务端、客户端和连接都设置为utf8mb4
2. **环境变量**：设置LANG=C.UTF-8确保容器内部中文显示正常
3. **初始化脚本**：在容器启动时自动创建数据库并设置字符集
4. **配置文件挂载**：通过volumes将自定义配置应用到容器

## 验证步骤
启动后执行以下命令验证配置：
```bash
docker exec -it mysql8 locale
docker exec -it mysql8 mysql -uroot -p11111111 -e "SHOW VARIABLES LIKE 'char%';"
```

# 删除容器
docker-compose down
