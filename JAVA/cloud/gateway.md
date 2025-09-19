# 网关

> [!TIP]
> 分布式系统中的网关服务，用于管理请求路由，身份认证，流量控制，负载均衡等
>
> 它在分布式系统中能处理的事情最多，也是最重要的部分之一

## 初始化模块

> [!NOTE]
> 单独模块继承顶层 cloud，它是项目中的模块式，而非服务式网关

<details>
<summary>查看依赖</summary>

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-gateway</artifactId>
    <version>4.3.1</version>
</dependency>
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter</artifactId>
    <exclusions>
        <exclusion>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </exclusion>
    </exclusions>
</dependency>
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
    <version>${nacos.version}</version>
</dependency>
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
    <version>${nacos.version}</version>
</dependency>
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>9.3.0</version>
</dependency>
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>3.8.1</version>
    <scope>test</scope>
</dependency>
```

</details>

配置 `spring.main.web-application-type:reactive` 与web服务冲突时解决，springboot数据库等自行解决

入口函数：

```java
@SpringBootApplication
@EnableDiscoveryClient
public class GatewayMainApplication {
    public static void main(String[] args) {
        SpringApplication.run(GatewayMainApplication.class, args);
    }
}
```

## 配置路由

> [!TIP]
> 最重要的部分，网关配置路径导航，是springboot项目，因此基本上是在配置文件中进行配置管理，配置中心也可以

```yml
# application-gateway 导入 spring:profiles:include : - gateway
spring:
  cloud:
    gateway:
      routes:
        - id: order-route
          # 服务地址 lb 是负载均衡写法 需安装 loadbalancer
          uri: lb://order-service
          # 匹配器 Path P 大写不然异常
          predicates:
            - Path=/api/order/**
          # 过滤器 排除某个路由等
          filters:
            - args:
            - name:
          # Map集合 路由元数据
          metadata:
            hello: world
          # 优先级
          order: 0
        - id: product-route
          uri: lb://product-service
          predicates:
          #/api/product 没有路径重写 product 控制器那边也会是原封不动的地址
            - Path=/api/product/**
        - id: 404-route
          uri: https://www.bing.com/404
          predicates:
            - Path=/**
          # 最低优先级防止拦截正常路径
          order: 999
```

## 长匹配规则

> 了解即可，一般短写法映射多

<details>
<summary>查看详情</summary>

```yml
# 匹配规则长写法模式了解即可 matchTrailingSlash 最后一个尾/是否匹配，默认开启
spring:
  cloud:
    gateway:
      routes:
        - id: product-route
          uri: lb://product-service
          predicates:
            - name: Path
              args:
                patterns:
                  - /api/product/**
                matchTrailingSlash: true
        - id: search-route
          uri: https://www.bing.com
          # 匹配器 Path P 大写不然异常
          predicates:
            - name: Path
              args:
                patterns:
                  - /search
                query:
                  param: q
                  regexp: h
                # 结果，必须访问 /search 然后参数带有 q 值必须是 h
                matchTrailingSlash: true
```

</details>
