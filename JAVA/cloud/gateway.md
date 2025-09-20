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

拥有更多的可配置项:

| 断言项     | 说明             | 参数                |
| ---------- | ---------------- | ------------------- |
| After      | 指定时间之后     | 1/datetime          |
| Before     | 指定时间之前     | 1/datetime          |
| Between    | 指定时间之内     | 2/datetime          |
| Cookie     | cookie校验       | 2/string,regexp     |
| Header     | 请求头校验       | 2/string,regexp     |
| Host       | 请求头host校验   | N/String            |
| Method     | 请求方式校验     | N/String            |
| Path       | 路径尾/判断      | 2/List<String>,bool |
| Query      | 请求参数校验     | 2/String,regexp     |
| RemoteAddr | 请求网络域 CIDR  | 1/List<String>      |
| Weight     | 指定权重负载均衡 | 2/String,Int        |

XForwardedRemoteaddr : 从x-Forwarded-For请求头中解析请求来源，并判断是否来源于指定网络域 : `1/List<String>`

<details>
<summary>查看详情</summary>

```yml
# 匹配规则长写法模式了解即可 matchTrailingSlash 最后一个尾/是否匹配，默认开启
predicates:
  # 断言项
  - name: Path
    args:
      patterns:
        # 参数
        - /search
      query:
        param: q
        regexp: h
      # 结果，必须访问 /search 然后参数带有 q 值必须是 h
      matchTrailingSlash: true
```

</details>

### 源码查看参数

> idea没有参数提示时，查看源码方式查看字段

1. 搜索自己当前配置的项 Query + Route + Predicate
2. 查看构造函数 参数是 Config.class 右键转到实现
3. 变量区域就是支持的字段了，有注解说明是否强制参数

## 过滤器

> [!TIP]
> 过滤器是用于后处理掉符合特定条件的选项，地址重写、请求头处理等
> [文档](https://docs.spring.io/spring-cloud-gateway/reference/spring-cloud-gateway-server-webmvc/filters/rewritepath.html)

```yml
# 短写法
filters:
  - RewritePath=/api/product/?(?<segment>.*), /$\{segment}
# 完整写法
filters:
  - name: RewritePath
    args:
      regexp: /api/product/(?<segment>.*)
      replacement: /${segment}
# 类似全局过滤器
spring:
  cloud:
    gateway:
      # 默认过滤器，没有手动重写会自动继承默认的规则，默认重写 /api 比较好
      default-filters:
        - RewritePath=/api/?(?<segment>.*), /$\{segment}
```

全局拦截器 -> 无法配置只能重现

```java
// filter.RtGlobalFilter

@Slf4j
@Component
public class RtGlobalFilter implements GlobalFilter, Ordered {

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        // =============== 前置 =============== \\
        ServerHttpRequest request = exchange.getRequest();
        ServerHttpResponse response = exchange.getResponse();

        String uri = request.getURI().getPath();
        long start = System.currentTimeMillis();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

        log.info("请求：{} 开始时间：{}", uri, dateFormat.format(new java.util.Date(start)));

        Mono<Void> filter = chain.filter(exchange).doFinally(Result -> {
            // =============== 后置 =============== \\
            long end = System.currentTimeMillis();
            log.info("请求: {} 结束时间: {},耗时: {}ms", uri, dateFormat.format(new java.util.Date(end)), end - start);
        });
        return filter;
    }

    @Override
    public int getOrder() {
        return 0;
    }
}
```

## CORS 跨域

> [!TIP]
> 在前后端分离模式中，经常出现的跨域请求配置
> 以前使用 corsOrigin 注解 现网关统一配置

```yml
spring:
  cloud:
    gateway:
      globalcors:
        cors-configurations:
          # 可自定义接口
          '[/**]':
            # 自定义数组写法 换行 - get - post 不用引号
            allowed-origin-patterns: '*'
            allowed-headers: '*'
            allowed-methods: '*'
            allowed-origins: '*'
```
