# 注解集合

> [!TIP]
> spring-cloud 项目中的常用性注解

## 主要配置类

| 注解                    | 说明                      | 参数                  | 位置\|说明  |
| ----------------------- | ------------------------- | --------------------- | ----------- |
| Class                   | 类注解                    |                       |             |
| EnableDiscoveryClient   | 开启注册中心              |                       | application |
| ConfigurationProperties | 注册配置中心,配置包类使用 | prefix 自定义前缀     | Component   |
| EnableFeignClients      | 开启远程调用              | basePackages 接口地址 | interface   |

## 目录结构

```text
demo
demo
├── pom.xml                         <!-- 项目依赖 cloud 版本和 boot 版本 -->
│
├── Model
│   └── ServiceName                 <!-- 服务名称包 -->
│       └── name                    <!-- 服务所需 pojo -->
├── mysql
│    └── init
│        ├── 01-init-database.sql         <!-- 初始化数据库的 SQL 脚本 -->
│        └── init-nacos-db.sh             <!-- Nacos 数据库初始化的 shell 脚本 -->
├── services
│   ├── pom.xml                     <!-- 声明 services 通用依赖 -->
│   │
│   ├── service-order
│   │   ├── pom.xml                 <!-- 服务自己的依赖，业务工具类 -->
│   │   │
│   │   ├── src
│   │   │   ├── main
│   │   │   │   ├── java
│   │   │   │   │   └── com
│   │   │   │   │       └── naer
│   │   │   │   │           └── name
│   │   │   │   │               ├── controller
│   │   │   │   │               │   └── main <!-- 控制器层 -->
│   │   │   │   │               ├── feign
│   │   │   │   │               │   └── ServiceFeignClient <!-- 远程调用接口 -->
│   │   │   │   │               ├── Properties
│   │   │   │   │               │   └── ServiceProperties <!-- 注册配置中心注解 -->
│   │   │   │   │               └── services
│   │   │   │   │                   ├── Impl
│   │   │   │   │                   │   └── main <!-- 实现类 -->
│   │   │   │   │                   └── main <!-- 接口类型，不能是 class -->
│   │   │   │   └── resources
│   │   │   │       ├── application.properties <!-- 必要配置用 mysql 等 服务名称 -->
│   │   │   │       └── application.yml        <!-- 配置中心专用 -->
│   │   │   └── application.java             <!-- 主函数 开启配置与注册中心还有远程调用 -->
│   │   │
│   │   └── test
│   │       └── java
│   │           └── com
│   │               └── naer
│   │                   └── name
│   │                       └── ExampleTest.java  <!-- 测试类 -->
│   │       └── resources
│   │           └── application-test.properties  <!-- 测试环境配置 -->
│   │
│   └── service-product
        └── pom.xml                      <!-- 另一个服务的 pom 配置 -->
```

TODO 其他注解

## 主类

```java
// com.Near.order; 主类包下
@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
public class OrderApplication {
    public static void main(String[] args) {
        SpringApplication.run(OrderApplication.class, args);
    }
}
```

## 配置中心

```java
// com.Near.order.Properties; Properties 包下
@Data
@Component
// 自动刷新无需配置注解
@ConfigurationProperties(prefix = "")
public class orderProperties {
    //对应配置文件中 order.name
    String name;
    String kfz;
}
```

## Feign 远程调用

```java
// com.Near.order.feign; feign 包下
@FeignClient(name = "product-service")
public interface orderFeignClient {
    /* 复制粘贴 控制器方法签名 快速声明 */
    @GetMapping("/Product/{productId}")
    String getProduct(@PathVariable int productId);
}
```
