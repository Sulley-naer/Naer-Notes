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

## 使用服务

> [!TIP]
> 使用 seata 需要客户端配置连接与添加依赖
>
> 在调用了多个分布式服务事务的方法添加 `GlobalTransactional` 完成

### 依赖

```xml
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-seata</artifactId>
    <version>${nacos.version}</version> <!-- 2023.0.3.3 -->
</dependency>
```

### 自定义事务管理器

依赖没有自动注入，需要手写一次

```java
// config>TransactionConfig
@Configuration
@EnableTransactionManagement
public class TransactionConfig {

    @Primary
    @Bean("transactionManager")
    public PlatformTransactionManager transactionManager(DataSource dataSource) {
        return new org.springframework.jdbc.datasource.DataSourceTransactionManager(dataSource);
    }
}
```

### 回滚表

> [!TIP]
> seata 事务需要每一个 数据库结构|仓库 都有一个回滚的表

```sql
CREATE TABLE undo_log
(
    id            bigint(20)   NOT NULL AUTO_INCREMENT,
    branch_id     bigint(20)   NOT NULL,
    xid           varchar(100) NOT NULL,
    context       varchar(128) NOT NULL,
    rollback_info longblob     NOT NULL,
    log_status    int(11)      NOT NULL,
    log_created   datetime     NOT NULL,
    log_modified  datetime     NOT NULL,
    ext           varchar(100) DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY ux_undo_log (xid, branch_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8;
```

## 配置文件

### 推荐模式

> [!TIP]
> 利用 spring properties 特性去配置，而不是使用 seata 自己的文件，统一管理还能使用配置中心同步

application-seata 记得导入 spring:profiles:include: - seata

```yml
#logging:
#  level:
#    org.apache.seata: DEBUG

# 对应你 seata server 里面配置的连接和分组

seata:
  enabled: true
  application-id: ${spring.application.name}
  tx-service-group: my_tx_group
  enable-auto-data-source-proxy: true
  service:
    vgroup-mapping:
      my_tx_group: default
    grouplist:
      default: 127.0.0.1:8091,ip2:8091 # 集群模式 异常自动切换 通常 nacos 配置
  config:
    type: file
  registry:
    type: file

#logging:
#  level:
#    org.apache.seata: DEBUG
```

### 传统方式

> [!WARNING]
> 不推荐这样写，单独2个文件只为了一个服务，配置中心还需要重写一次，导入新的yml文件比这种方式好很多

resources>file.conf seata 客户端独立配置

```conf
# 连接心跳相关
transport {
  # tcp udt unix-domain-socket
  type = "TCP"
  #NIO NATIVE
  server = "NIO"
  #enable heartbeat
  heartbeat = true
  # the client batch send request enable
  enableClientBatchSendRequest = true
  # the thread pool config
  threadFactory {
    bossThreadPrefix = "NettyBoss"
    workerThreadPrefix = "NettyServerNIOWorker"
    serverExecutorThreadPrefix = "NettyServerBizHandler"
    shareBossWorker = false
    clientSelectorThreadPrefix = "NettyClientSelector"
    clientSelectorThreadSize = 1
    clientWorkerThreadPrefix = "NettyClientWorkerThread"
    # the worker thread size, two properties share the same thread pool
    bossThreadSize = 1
    workerThreadSize = 8
  }
  shutdown {
    # when destroy server, wait seconds
    wait = 3
  }
  serialization = "seata"
  compressor = "none"
}

# 配置服务端组 相关 对应nacos 命名空间 分组等关键分类配置
service {
  #vgroup->rgroup
  vgroupMapping.my_tx_group = "default"
  #only support single node
  default.grouplist = "127.0.0.1:8091"
  #degrade current not support
  enableDegrade = false
  #disable
  disable = false
  #unit ms,s,m,h,d represents milliseconds, seconds, minutes, hours, days, default permanent
  max.commit.retry.timeout = "-1"
  max.rollback.retry.timeout = "-1"
  disableGlobalTransaction = false
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

resources>registry.conf seata 独立配置集成配置中心

```conf
# 刚才的本地版
registry {
  # file 、nacos 、eureka、redis、zk、consul、etcd3、sofa
  type = "file"
  file {
    name = "file.conf"
  }
  nacos {
    serverAddr = "localhost:8848"
    namespace = ""
    cluster = "default"
    username = ""
    password = ""
  }
}

# 远程配置中心
config {
  # file、nacos 、apollo、zk、consul、etcd3
  type = "file"
  file {
    name = "file.conf"
  }
  nacos {
    serverAddr = "localhost:8848"
    namespace = "dev"
    group = "SEATA_GROUP"
    username = "nacos"
    password = "nacos"
  }
}
```

## 演示项目

> [!NOTE]
> 必须由传统的事务模式才能使用，调用分布式事务只需要一个注解即可

### spring-boot 事务模式

1. 主服务开启事务 application `@EnableTransactionManagement`
2. 注入事务管理器 [Bean](#自定义事务管理器)
3. services的接口或者实现类标注 `@Transactional` 方法或者类体上
4. 控制器层开放api允许调用

<details>
<summary>演示</summary>

service

```java
@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Resource
    private OrdersMapper ordersMapper;

    @Override
    public Orders findById(Long id) {
        return ordersMapper.findById(id);
    }

    @Override
    public List<Orders> findAll() {
        return ordersMapper.findAll();
    }

    @Override
    public Orders save(Orders order) {
        ordersMapper.insert(order);
        return order;
    }

    @Override
    public Orders update(Orders order) {
        ordersMapper.update(order);
        return order;
    }

    @Override
    public void deleteById(Long id) {
        ordersMapper.deleteById(id);
    }
}
```

controller

```java
@RestController
@RequestMapping("/orders")
public class SeataOrderController {

    @Resource
    private OrderService orderService;

    @GetMapping("/{id}")
    public Orders getOrder(@PathVariable Long id) {
        return orderService.findById(id);
    }

    @GetMapping
    public List<Orders> getAllOrders() {
        return orderService.findAll();
    }

    @PostMapping
    public Orders createOrder(@RequestBody Orders order) {
        return orderService.save(order);
    }

    @PutMapping("/{id}")
    public Orders updateOrder(@PathVariable Long id, @RequestBody Orders order) {
        order.setId(id);
        return orderService.update(order);
    }

    @DeleteMapping("/{id}")
    public void deleteOrder(@PathVariable Long id) {
        orderService.deleteById(id);
    }
}
```

mybatis

```java
@Mapper
public interface OrdersMapper {

    @Select("SELECT * FROM orders WHERE id = #{id}")
    Orders findById(Long id);

    @Select("SELECT * FROM orders")
    List<Orders> findAll();

    @Insert("INSERT INTO orders(user_id, product_name, quantity, price) VALUES(#{userId}, #{productName}, #{quantity}, #{price})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Orders order);

    @Update("UPDATE orders SET user_id = #{userId}, product_name = #{productName}, quantity = #{quantity}, price = #{price} WHERE id = #{id}")
    int update(Orders order);

    @Delete("DELETE FROM orders WHERE id = #{id}")
    int deleteById(Long id);
}
```

</details>

### 分布式调用

<details>
<summary>演示</summary>

openfeign

```java
@FeignClient(name = "seata-product-service", path = "/products")
public interface ProductFeignClient {

    @GetMapping("/{id}")
    Product getProductById(@PathVariable("id") Long id);

    @PostMapping
    Product createProduct(@RequestBody Product product);

    @PutMapping("/{id}")
    Product updateProduct(@PathVariable("id") Long id, @RequestBody Product product);
}

// 需要两个服务，不让无法演示全局事务，自己再根据上面的再写一个服务出来
@FeignClient(name = "seata-order-service", path = "/orders", fallback = OrderFallback.class)
public interface OrderFeignClient {
    /* 复制粘贴 控制器方法签名 快速声明 */
    @PostMapping
    public Orders createOrder(@RequestBody Orders order);
}
```

service

```java
@Service
public class BusinessService {

    @Resource
    private ProductFeignClient productService;

    @Resource
    private OrderFeignClient orderService;

    @Transactional
    @GlobalTransactional
    //关键注解，使用了分布式事务 由他开启 seata 全局事务
    public Orders createOrder(@NotNull Orders order) {
        // 1. 先根据商品ID获取商品信息，检查库存
        Product product = productService.getProductById(order.getProductId());

        // 2. 检查库存是否足够
        if (product.getStock() <= 0) {
            throw new RuntimeException("商品库存不足");
        }

        // 3. 减少商品库存
        Product updatedProduct = new Product();
        updatedProduct.setId(product.getId());
        updatedProduct.setName(product.getName());
        updatedProduct.setPrice(product.getPrice());
        updatedProduct.setDescription(product.getDescription());
        updatedProduct.setStock(product.getStock() - 1);
        productService.updateProduct(product.getId(), updatedProduct);

        // 4. 创建订单
        Orders newOrder = new Orders();
        newOrder.setUserId(order.getUserId());
        newOrder.setProductId(order.getProductId());
        newOrder.setProductName(product.getName());
        newOrder.setQuantity(1);
        newOrder.setPrice(product.getPrice());

        // 模拟异常 触发回滚
        int i = 10 / 0;

        return orderService.createOrder(newOrder);
    }
}
```

controller

```java
@RestController
@RequestMapping("/business")
public class OrderController {

    @Resource
    BusinessService businessService;

    @PostMapping("/order")
    public ResponseEntity<Object> createOrder(@RequestBody Orders order) {
        try {
            Orders createdOrder = businessService.createOrder(order);
            return ResponseEntity.ok(new Success(createdOrder));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new Success(500, "下单失败: " + e.getMessage(), null));
        }
    }
}
```

</details>

## 原理
