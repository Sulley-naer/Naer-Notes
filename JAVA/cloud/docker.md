# 使用 Docker 管理服务

> [!TIP]
> 在分布式系统中，使用 Docker 来管理和部署各个微服务，可以大大简化环境配置和依赖管理。

它能够确保每个服务在隔离的环境中运行，避免了环境冲突问题，并且可以轻松地进行服务的扩展和迁移。

## compose 快速启动

> [!TIP]
> 当前的项目通用的服务，使用单独的 docker-compose 文件进行编排。
>
> 如果是自己项目的服务，单独编写新的 compose 文件，出问题容易排查。

<details>
<summary>查看 compose 文件</summary>

> [!NOTE]
> 我们的项目使用了 MySQL 作为数据库，Redis 作为缓存，Nacos 作为配置和服务注册中心。
>
> Nacos 是单独的服务，我使用了通过远程仓库拉取对应 nacos 版本初始化sql，避免服务无法启动

```yaml
version: '3.9'

services:
  mysql:
    image: mysql:9.4
    container_name: mysql-db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: cloud_db
      MYSQL_USER: cloud_user
      MYSQL_PASSWORD: cloud_pass
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - cloud-network
    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
  # Nacos 远程脚本初始化服务
  nacos-db-init:
    image: mysql:9.4
    environment:
      MYSQL_ROOT_PASSWORD: root123
      NACOS_VERSION: v3.0.3
    volumes:
      - ./mysql/init/init-nacos-db.sh:/init-nacos-db.sh
      - ./mysql/init:/project-init-scripts
    command: /bin/bash /init-nacos-db.sh
    networks:
      - cloud-network
    depends_on:
      - mysql

  redis:
    image: redis:7-alpine
    container_name: redis-cache
    restart: always
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    command: redis-server --appendonly yes --requirepass redis123
    networks:
      - cloud-network

  nacos:
    image: nacos/nacos-server:v3.0.3
    container_name: nacos-server
    environment:
      MODE: standalone
      SPRING_DATASOURCE_PLATFORM: mysql
      MYSQL_SERVICE_HOST: mysql
      MYSQL_SERVICE_PORT: 3306
      MYSQL_SERVICE_DB_NAME: nacos_config
      MYSQL_SERVICE_USER: root
      MYSQL_SERVICE_PASSWORD: root123
      NACOS_AUTH_ENABLE: true
      NACOS_AUTH_TOKEN: SecretKey012345678901234567890123456789012345678901234567890123456789
      NACOS_AUTH_IDENTITY_KEY: nacos
      NACOS_AUTH_IDENTITY_VALUE: nacos
    ports:
      - "8848:8848"
      - "8080:8080"
      - "9848:9848"
      - "9849:9849"
    volumes:
      - nacos_data:/home/nacos/data
      - nacos_logs:/home/nacos/logs
    depends_on:
      - nacos-db-init
    networks:
      - cloud-network

volumes:
  mysql_data:
    driver: local
  redis_data:
    driver: local
  nacos_data:
    driver: local
  nacos_logs:
    driver: local

networks:
  cloud-network:
    driver: bridge
```

自动初始化脚本

```bash
#!/bin/bash
# 路径：mysql>init>init-nacos-db.sh

# 等待MySQL服务启动完成
until mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT 1"; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 5
done

>&2 echo "MySQL is up - executing command"

# 检查是否已经初始化过
if mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "USE nacos_config; SELECT COUNT(*) FROM users WHERE username='nacos';" | grep -q "1"; then
  echo "Nacos database already initialized, skipping initialization..."
  exit 0
fi

# 创建数据库
mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS nacos_config DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# 执行项目中的初始化脚本（如果存在）
echo "Executing project initialization scripts..."
for file in /project-init-scripts/*.sql; do
  if [ -f "$file" ]; then
    echo "Executing $file"
    # 使用 < 操作符执行SQL文件
    mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}" nacos_config < "$file"
  fi
done

# 根据Nacos版本下载对应的数据库初始化脚本
NACOS_VERSION=${NACOS_VERSION:-latest}
if [ "$NACOS_VERSION" = "latest" ]; then
  SQL_FILE_URL="https://raw.githubusercontent.com/alibaba/nacos/master/distribution/conf/nacos-mysql.sql"
else
  SQL_FILE_URL="https://raw.githubusercontent.com/alibaba/nacos/${NACOS_VERSION}/distribution/conf/nacos-mysql.sql"
fi

# 下载SQL文件
wget -O /tmp/nacos-mysql.sql "$SQL_FILE_URL"

# 检查SQL文件是否下载成功
if [ -f "/tmp/nacos-mysql.sql" ]; then
  echo "Executing Nacos SQL file..."
  # 使用 < 操作符执行SQL文件
  mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}" nacos_config < /tmp/nacos-mysql.sql
else
  echo "Failed to download Nacos SQL file"
fi

# 创建用户并授权
mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS 'nacos'@'%' IDENTIFIED BY 'nacos';"
mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON nacos_config.* TO 'nacos'@'%';"
mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

echo "Nacos database initialization completed!"
```

</details>
