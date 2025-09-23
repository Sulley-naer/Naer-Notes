# 使用 Docker 管理服务

> [!TIP]
> 在分布式系统中，使用 Docker 来管理和部署各个微服务，可以大大简化环境配置和依赖管理。

它能够确保每个服务在隔离的环境中运行，避免了环境冲突问题，并且可以轻松地进行服务的扩展和迁移。

## 目录结构

```text
cloud/
├── compose/                        # 存放 compose 相关文件（可选）添加需要调整路径
│   └── docker-compose.yml          # docker-compose 文件（或直接放在根目录）
├── inits/
│   ├── db/
│   │   ├── nacos-mysql.sql         # Nacos 初始化 SQL（可选，脚本会自动下载）
│   │   └── seata-mysql.sql         # Seata 初始化 SQL（可选，脚本会自动下载）
│   └── script/
│       └── init-db.sh              # 数据库初始化脚本
├── nacos/
│   └── conf/
│       └── application.properties  # Nacos 配置文件
├── seata/
│   └── config/
│       ├── file.conf               # Seata file 配置
│       └── registry.conf           # Seata 注册中心配置
├── Sentinel/
│   └── Dockerfile                  # Sentinel Dashboard 的 Dockerfile
├── ...                             # 你的其他服务或项目代码
```

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
    # 使用 init 脚本初始化数据库,而不是默认文件夹方式
    # - ./inits/db:/docker-entrypoint-initdb.d
    networks:
      - cloud-network
    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

  db-init:
    image: mysql:9.4   # 还是用 MySQL 镜像跑初始化脚本
    environment:
      MYSQL_ROOT_PASSWORD: root123
      NACOS_VERSION: master   # 默认 master 对应 github 分支的名称
      SEATA_VERSION: 2.x      # 默认 2.x 分支 对应 github 分支的名称
    volumes:
      - ./inits/script/init-db.sh:/init-db.sh      # 改脚本名更通用
      - ./inits/db:/project-init-scripts           # 里面可以放 nacos-mysql.sql / seata-mysql.sql
    command: /bin/bash /init-db.sh
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
      MYSQL_SERVICE_USER: nacos
      MYSQL_SERVICE_PASSWORD: nacos
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
      - ./nacos/conf/application.properties:/home/nacos/conf/application.properties
    depends_on:
      - db-init
      - mysql
    restart: always
    networks:
      - cloud-network

  sentinel:
    build: ./Sentinel
    container_name: sentinel-dashboard
    ports:
      - "8888:8080"
    networks:
      - cloud-network
    depends_on:
      - nacos
    restart: always

  seata:
    image: seataio/seata-server:2.0.0
    container_name: seata-server
    ports:
      - "8091:8091"  # 映射到容器内的 8091 端口
      - "7091:7091"
    volumes:
      - ./seata/config/file.conf:/seata-server/resources/file.conf
      - ./seata/config/registry.conf:/seata-server/resources/registry.conf
    networks:
      - cloud-network
    depends_on:
      - mysql
      - db-init
#    restart: always

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

init>script>init-db.sh

可选：

本地版服务初始化脚本，下载地址脚本中有

init>db>nacos-mysql.sql | seata-mysql.sql

```bash
#!/bin/bash

# 等待MySQL服务启动完成
until mysql -h mysql -u root -proot123 -e "SELECT 1" &> /dev/null; do
  echo "MySQL is unavailable - sleeping"
  sleep 5
done

echo "nacos 版本: ${NACOS_VERSION}"
echo "seata 版本: ${SEATA_VERSION}"

############################################
# 初始化 Nacos 数据库
############################################
if mysql -h mysql -u root -proot123 -e "USE nacos_config; SELECT COUNT(*) FROM users WHERE username='nacos';" | grep -q "1"; then
  echo "Nacos database already initialized, skipping initialization..."
else
  echo "Creating nacos_config database..."
  mysql -h mysql -u root -proot123 -e "CREATE DATABASE IF NOT EXISTS nacos_config DEFAULT CHARACTER SET utf8mb4 COLLATE=utf8mb4_unicode_ci;"

  echo "Initializing Nacos database..."
  if mysql -h mysql -u root -proot123 -e "USE nacos_config; SHOW TABLES LIKE 'users';" | grep -q "users"; then
    echo "Nacos database already initialized, skipping initialization..."
  else
    echo "Downloading Nacos MySQL schema..."
    NACOS_VERSION=${NACOS_VERSION:-master}
    SQL_FILE_URL="https://proxy.pipers.cn/https://raw.githubusercontent.com/alibaba/nacos/${NACOS_VERSION}/distribution/conf/mysql-schema.sql"

    curl -o /tmp/nacos-mysql.sql "$SQL_FILE_URL"
    if [ $? -ne 0 ]; then
      echo "Failed to download Nacos SQL file, using local file instead..."
      LOCAL_SQL_FILE="/project-init-scripts/nacos-mysql.sql"
      [ -f "$LOCAL_SQL_FILE" ] && cp "$LOCAL_SQL_FILE" /tmp/nacos-mysql.sql || { echo "Local Nacos SQL file not found, exiting..."; exit 1; }
    fi

    mysql -h mysql -u root -proot123 nacos_config < /tmp/nacos-mysql.sql
    [ $? -ne 0 ] && { echo "Error executing Nacos SQL file, exiting..."; exit 1; }
    echo "Nacos SQL file executed successfully"
  fi
fi

############################################
# 初始化 Seata 数据库
############################################
echo "Creating seata database..."
mysql -h mysql -u root -proot123 -e "CREATE DATABASE IF NOT EXISTS seata DEFAULT CHARACTER SET utf8mb4 COLLATE=utf8mb4_unicode_ci;"

if mysql -h mysql -u root -proot123 -e "USE seata; SHOW TABLES LIKE 'global_table';" | grep -q "global_table"; then
  echo "Seata database already initialized, skipping initialization..."
else
  echo "Initializing Seata database..."
  SEATA_VERSION=${SEATA_VERSION:-2.x}

  # 首先尝试从本地文件初始化
  LOCAL_SQL_FILE="/project-init-scripts/seata-mysql.sql"
  if [ -f "$LOCAL_SQL_FILE" ]; then
    echo "Using local Seata SQL file..."
    mysql -h mysql -u root -proot123 seata < "$LOCAL_SQL_FILE"
    [ $? -eq 0 ] && echo "Local Seata SQL file executed successfully" || { echo "Error executing local Seata SQL file, exiting..."; exit 1; }
  else
    echo "Local Seata SQL file not found, trying to download..."
    SEATA_SQL_URL="https://proxy.pipers.cn/https://raw.githubusercontent.com/apache/incubator-seata/${SEATA_VERSION}/script/server/db/mysql.sql"
    curl -o /tmp/seata-mysql.sql "$SEATA_SQL_URL"
    if [ $? -ne 0 ]; then
      echo "Failed to download Seata SQL file, exiting..."
      exit 1
    fi
    mysql -h mysql -u root -proot123 seata < /tmp/seata-mysql.sql
    [ $? -ne 0 ] && { echo "Error executing Seata SQL file, exiting..."; exit 1; }
    echo "Seata SQL file executed successfully"
  fi
fi

############################################
# 初始化项目自带脚本
############################################
echo "Executing project initialization scripts..."
for file in /project-init-scripts/*.sql; do
  echo "当前文件路径: $file"
  if [ -f "$file" ]; then
    if [[ "$file" == "/project-init-scripts/nacos-mysql.sql" ]] || [[ "$file" == "/project-init-scripts/seata-mysql.sql" ]]; then
      echo "Skipping $file to avoid re-execution..."
      continue
    fi
    mysql -h mysql -u root -proot123 nacos_config < "$file"
    [ $? -eq 0 ] && echo "$file executed successfully" || echo "Error executing $file"
  fi
done

############################################
# 创建数据库用户并授权
############################################
echo "Creating user 'nacos' and granting privileges..."
mysql -h mysql -u root -proot123 -e "CREATE USER IF NOT EXISTS 'nacos'@'%' IDENTIFIED BY 'nacos';"
mysql -h mysql -u root -proot123 -e "GRANT ALL PRIVILEGES ON nacos_config.* TO 'nacos'@'%';"
mysql -h mysql -u root -proot123 -e "FLUSH PRIVILEGES;"

echo "Creating user 'seata' and granting privileges..."
mysql -h mysql -u root -proot123 -e "CREATE USER IF NOT EXISTS 'seata'@'%' IDENTIFIED BY 'seata';"
mysql -h mysql -u root -proot123 -e "GRANT ALL PRIVILEGES ON seata.* TO 'seata'@'%';"
mysql -h mysql -u root -proot123 -e "FLUSH PRIVILEGES;"

echo "Granting cloud_user access to seata database..."
mysql -h mysql -u root -proot123 -e "GRANT SELECT, INSERT, UPDATE, DELETE ON seata.* TO 'cloud_user'@'%';"
mysql -h mysql -u root -proot123 -e "FLUSH PRIVILEGES;"

echo "Database initialization completed!"
```

</details>

## 配置文件

### Nacos

nacos>conf>application.properties

```properties
spring.datasource.platform=mysql
db.num=1
db.url.0=jdbc:mysql://mysql:3306/nacos_config?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true
db.user=nacos
db.password=nacos

# 认证相关配置
nacos.core.auth.system.type=nacos
nacos.core.auth.enabled=true
nacos.core.auth.server.identity.key=nacos
nacos.core.auth.server.identity.value=nacos
nacos.core.auth.plugin.nacos.token.secret.key=SecretKey012345678901234567890123456789012345678901234567890123456789
```

### seata

seata>config>file.conf

```conf
transport {
  # tcp udt unix-domain-socket
  type = "TCP"
  #NIO AIO
  server = "NIO"
  #enable heartbeat
  heartbeat = true
  #thread factory for netty
  thread-factory {
    boss-thread-prefix = "NettyBoss"
    worker-thread-prefix = "NettyServerNIOWorker"
    server-executor-thread-prefix = "NettyServerBizHandler"
    share-boss-worker = false
    client-selector-thread-prefix = "NettyClientSelector"
    client-selector-thread-size = 1
    client-worker-thread-prefix = "NettyClientWorkerThread"
    # netty boss thread size,will not be used for UDT
    boss-thread-size = 1
    #auto default pin or 8
    worker-thread-size = "default"
  }
  shutdown {
    # when destroy server, wait seconds
    wait = 3
  }
  serialization = "seata"
  compressor = "none"
}

service {
  #vgroup->rgroup
  vgroupMapping.my_tx_group = "default"
  #only support single node
  default.grouplist = "seata-server:8091"
  #degrade current not support
  enableDegrade = false
  #disable
  disable = false
  #unit ms,s,m,h,d represents milliseconds, seconds, minutes, hours, days, default permanent
  max.commit.retry.timeout = "-1"
  max.rollback.retry.timeout = "-1"
  disableGlobalTransaction = false
}

store {
  # support: file, db, redis
  mode = "db"
  db {
    driverClassName = "com.mysql.cj.jdbc.Driver"
    url = "jdbc:mysql://mysql:3306/seata?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Shanghai"
    user = "seata"
    password = "seata"
    minConn = 5
    maxConn = 100
    globalTable = "global_table"
    branchTable = "branch_table"
    lockTable = "lock_table"
    queryLimit = 100
    maxWait = 5000
  }
}

server {
  service-port = 8091
}

# metrics configuration
metrics {
  enabled = false
  registry-type = "compact"
  # multi exporters use comma divided
  exporter-list = "prometheus"
  exporter-prometheus-port = 9898
}
```

seata>config>registry.conf

```conf
registry {
  type = "nacos"
  nacos {
    serverAddr = "nacos:8848"      # 注意用 Docker 服务名
    namespace = "dev"           # 可自定义
    cluster = "default"            # 可选
    username = "nacos"             # 对应 Nacos 用户
    password = "nacos"
  }
}

config {
  type = "nacos"
  nacos {
    serverAddr = "nacos:8848"
    namespace = "dev"
    username = "nacos"
    password = "nacos"
    # file.conf 中的配置都会放到这个 Data ID 下
    dataId = "file.conf"
    group = "SEATA_GROUP"
  }
}
```
