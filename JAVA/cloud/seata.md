# Seata

> [!TIP]
> Seata 是用于管理分布式系统中数据库事务不同步的问题，传统事务是可以同时处理多个表格
>
> 分布式系统中每个服务只负责自己的部分，这样的情况下无法无法确保其他表格数据的一致性

## seata 基础

### 分布式数据库

> [!NOTE]
> 在分布式系统中，负责操作数据库的功能需要单独开服务，这样的方式增加了维护成本，但这也极大提高了可维护性
>
> seata 必须这样管理，seata 全局事务 是通过操作数据库的类方法添加注解追踪，考虑这些结合业务导致事务太乱
>
> 业务到处定义 mybatis 进行本地管理，就违背了分布式系统服务远程调用的模式，又变回传统模式，一定不要这样做

完整流程：业务 -> 多业务服务 -> 其他单表服务；

拆分后分布式架构的问题均已解决，引入全局事务管理即可

目录结构推荐

```properties
+---seata
|   +---business # 多业务事务控制 用来管理事务和统一业务调用服务
|   |   \---src
|   |       \---main
|   |           \---java
|   |               \---org
|   |                   \---Naer
|   |                       \---business
|   |                           +---controller
|   |                           +---exception
|   |                           +---feign
|   |                           +---services
|   +---order # 单表 crud 服务
|   |   \---src
|   |       \---main
|   |           \---java
|   |               \---com
|   |                   \---Near
|   |                       \---order
|   |                           +---controller
|   |                           +---mapper
|   |                           +---services
|   +---product # 单表 crud 服务
|   |   \---src
|   |       \---main
|   |           \---java
|   |               \---com
|   |                   \---near
|   |                       \---product
|   |                           +---controller
|   |                           +---mapper
|   |                           +---services
```

### 本地式事务

> [!TIP]
> 在使用全局事务前，需要配置好本地式事务

将所有 seata-service 操作数据库服务 入口开启`@EnableTransactionManagement`

再将所有操作数据库的方法体加上 `@Transactional` 一般是 mvc 中的 services 层

### seata 服务

> [!NOTE]
> 远程 seata 服务中心，它用于管理所有事务，推荐使用 docker 管理

seata 官网下载 jar 包运行即可，Docker 版本 [前往](./docker.md)
