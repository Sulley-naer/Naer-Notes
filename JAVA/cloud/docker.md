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
      - ./inits/db:/docker-entrypoint-initdb.d
    networks:
      - cloud-network
    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

  nacos-db-init:
    image: mysql:9.4
    environment:
      MYSQL_ROOT_PASSWORD: root123
      NACOS_VERSION: latest
    volumes:
      - ./inits/script/init-nacos-db.sh:/init-nacos-db.sh
      - ./inits/db:/project-init-scripts
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
    image: nacos/nacos-server:latest
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
      NACOS_CONFIG_GRAY_MIGRATE: "false"
      NACOS_CORE_API_COMPATIBILITY_CONSOLE_ENABLED: "true"
    ports:
      - "8848:8848"
      - "9848:9848"
      - "9849:9849"
      - "8080:8080"
    volumes:
      - nacos_data:/home/nacos/data
      - nacos_logs:/home/nacos/logs
    depends_on:
      - nacos-db-init
      - mysql
    restart: always
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

# 等待MySQL服务启动完成
until mysql -h mysql -u root -proot123 -e "SELECT 1"; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 5
done

echo "nacos 版本: ${NACOS_VERSION}"

# 检查是否已经初始化过
if mysql -h mysql -u root -proot123 -e "USE nacos_config; SELECT COUNT(*) FROM users WHERE username='nacos';" | grep -q "1"; then
  echo "Nacos database already initialized, skipping initialization..."
  exit 0
fi

>&2 echo "MySQL is up - executing command"

# 创建nacos_config数据库
echo "Creating nacos_config database..."
mysql -h mysql -u root -proot123 -e "CREATE DATABASE IF NOT EXISTS nacos_config DEFAULT CHARACTER SET utf8mb4 COLLATE=utf8mb4_unicode_ci;"

# 初始化Nacos数据库
echo "Initializing Nacos database..."

# 检查是否已经初始化过（检查nacos_config数据库中是否存在users表）
if mysql -h mysql -u root -proot123 -e "USE nacos_config; SHOW TABLES LIKE 'users';" | grep -q "users"; then
  echo "Nacos database already initialized, skipping initialization..."
else
  # 尝试下载Nacos数据库SQL文件
  echo "Downloading Nacos MySQL schema..."
  NACOS_VERSION=${NACOS_VERSION:-latest}
  if [ "$NACOS_VERSION" = "latest" ]; then
    SQL_FILE_URL="https://proxy.pipers.cn/https://raw.githubusercontent.com/alibaba/nacos/master/distribution/conf/mysql-schema.sql"
  else
    SQL_FILE_URL="https://proxy.pipers.cn/https://raw.githubusercontent.com/alibaba/nacos/${NACOS_VERSION}/distribution/conf/mysql-schema.sql"
  fi

  # 使用curl下载Nacos SQL文件，如果失败则使用本地文件
  curl -o /tmp/nacos-mysql.sql "$SQL_FILE_URL"

  # 如果下载失败，使用本地的SQL文件
  if [ $? -ne 0 ]; then
    echo "Failed to download Nacos SQL file, using local file instead..."

    # 确保本地路径正确
    LOCAL_SQL_FILE="/project-init-scripts/nacos-mysql.sql"
    if [ -f "$LOCAL_SQL_FILE" ]; then
      cp "$LOCAL_SQL_FILE" /tmp/nacos-mysql.sql
    else
      echo "Local SQL file not found, exiting..."
      exit 1
    fi
  fi

  # 检查SQL文件是否存在
  if [ -f "/tmp/nacos-mysql.sql" ]; then
    echo "Executing Nacos SQL file..."
    mysql -h mysql -u root -proot123 nacos_config < /tmp/nacos-mysql.sql
    if [ $? -ne 0 ]; then
      echo "Error executing Nacos SQL file, exiting..."
      exit 1
    else
      echo "Nacos SQL file executed successfully"
    fi
  else
    echo "No SQL file found, exiting..."
    exit 1
  fi
fi

# 如果Nacos数据库初始化成功，再继续初始化项目数据库
echo "Executing project initialization scripts..."

# 执行项目中的初始化脚本（如果存在），跳过nacos-mysql.sql
for file in /project-init-scripts/*.sql; do
  echo "当前文件路径: $file"  # 打印文件路径，调试用
  # 进行路径比较，避免路径不匹配

  if [ -f "$file" ]; then
    echo "Executing $file"
    # 使用IF NOT EXISTS来避免表已存在的错误
      if [[ "$file" == "/project-init-scripts/nacos-mysql.sql" ]]; then
        echo "Skipping $file to avoid re-execution..."
        continue
      else
        mysql -h mysql -u root -proot123 nacos_config < "$file"
      fi
    if [ $? -eq 0 ]; then
      echo "$file executed successfully"
    else
      echo "Error executing $file"
    fi
  else
    echo "No SQL file found in /project-init-scripts"
  fi
done

# 创建数据库用户并授权
echo "Creating user 'nacos' and granting privileges..."
mysql -h mysql -u root -proot123 -e "CREATE USER IF NOT EXISTS 'nacos'@'%' IDENTIFIED BY 'nacos';"
mysql -h mysql -u root -proot123 -e "GRANT ALL PRIVILEGES ON nacos_config.* TO 'nacos'@'%';"
mysql -h mysql -u root -proot123 -e "FLUSH PRIVILEGES;"

echo "Nacos database initialization completed!"
```

</details>
