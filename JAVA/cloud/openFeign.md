# 声明式远程调用

> [!TIP]
> Spring-cloud 解决服务调用之间的复杂性，简化远程调用流程工具
>
> openFiegn 远程调用，默认集成了 Ribbon 负载均衡器，可以通过配置文件设置负载均衡策略

使用类似 mybatis 注解模式，通过接口声明，自动生成注入代理类，完成远程调用

## 引入依赖

```xml
<dependency>
   <groupId>org.springframework.cloud</groupId>
   <artifactId>spring-cloud-starter-openfeign</artifactId>
   <version>5.0.0-M1</version>
</dependency>
```

## 注解

| 注解               | 说明                      | 参数                  | 区域        |
| ------------------ | ------------------------- | --------------------- | ----------- |
| EnableFeignClients | 开启远程调用              | basePackages 扫描路径 | application |
| FeignClient        | 声明远程调用接口          | null                  | InterFace   |
| GetMapping         | 接受的参数类似            | null                  | class       |
| GetMapping         | 标注请求类型              | 地址                  | method      |
| RequestHeader      | 参数存放至请求头          | 键值                  | method      |
| RequestParam       | 参数存放请求参数字段      | 键值                  | method      |
| RequestParam       | 参数存放至RequestBody请求 | obj                   | method      |

## 声明

> [!IMPORTANT]
> 声明式远程调用，简化远程调用的复杂性，接口的定义就是配置

- 在主类上添加 `@EnableFeignClients` 注解，开启 Feign 功能。
- 创建一个接口，并使用 `@FeignClient` 注解来指定要调用的服务名称。

```java
// 目录控制器同级 feign 目录>默认自动扫描路径

@GetMapping
// 远程服务的名称 nacos 服务 id 字段 配置文件可定义的 spring-application-name 禁用下划线 path 对应控制器路径前缀注解
@FeignClient(name = "service-name", path = "/api/product")
public interface RemoteServiceClient {
    @GetMapping("/Product/{productId}")// 远程服务的具体接口
    void getProduct(@PathVariable String productId, @RequestHeader("Authorization") String token);
}
```

## 使用

> [!TIP]
> 在需要调用远程服务的地方，注入 Feign 接口并调用方法

```java
@RestController
@RequestMapping("/order")
public class OrderController {

    @Resource
    private RemoteServiceClient remoteServiceClient; // 注入 Feign 接口

    @GetMapping("/{orderId}")
    public String getOrder(@PathVariable String orderId) {
        // 调用远程服务
        remoteServiceClient.getProduct("12345", "Bearer token_value");
        return "Order details for " + orderId;
    }
}
```

## 测试

> [!TIP]
> 与普通 spirng 测试类似，等待 spring 容器启动后，注入 Feign 接口进行测试

```java

```java
@SpringBootTest
public class feignTest {

    @Resource
    orderFeignClient orderFeignClient;

    @Test
    public void orderTest() {
        System.out.printf(orderFeignClient.getOrder(String.valueOf(2)));
    }
}
```

## 配置

>[!TIP]
> Feign 默认集成了 Ribbon 负载均衡器，可以通过配置文件设置负载均衡策略，还有配置请求的日志等级

快速配置：

```yaml
# feign 日志等级
logging:
  level:
    com.Near.order.feign: DEBUG
    feign.Logger: DEBUG
    feign.Request: DEBUG
    feign.Response: DEBUG

spring:
  cloud:
    openfeign:
      # 全局拦截器配置
      httpclient:
        connection-timeout: 2000
        ok-http:
          read-timeout: 60s
      client:
        # 这个是服务请求配置，而不是别人连此服务的配置
        config:
          # 默认配置 对所有的请求的配置 axios的默认配置
          default:
            logger-level: basic
            # 10s没连接就异常
            connect-timeout: 10000
            # 5s没返回就异常
            read-timeout: 5000

          # 服务单独配置 判断请求地址
          product-service:
            logger-level: full
            # 重试机制
            retryer:
              period: 100 # 初始间隔时间
              max-period: 1000 # 最大间隔时间
              max-attempts: 5 # 最大重试次数
```

### 日志配置

1. 配置文件: `logging.level.com.example.feign=DEBUG` 包名改为自己的包名

2. 代码配置:

```java
@Bean
Logger.Level feignLoggerLevel() {
    return Logger.Level.FULL;
}
```

### 请求配置

> [!TIP]
> 普通的请求工具配置，类似axios一样的请求头设置等等，只是发起请求的配置，响应体只能是 spring 控制

```yml
spring:
  cloud:
    openfeign:
      # 全局拦截器配置
      httpclient:
        connection-timeout: 2000
        ok-http:
          read-timeout: 60s
      client:
        # 这个是服务请求配置，而不是别人连此服务的配置
        config:
          # 默认配置 对所有的请求的配置 axios的默认配置
          default:
            logger-level: basic
          # 服务单独配置 判断请求地址
          product-service:
            logger-level: full
            # 10s没连接就异常
            connect-timeout: 10000
            # 5s没返回就异常
            read-timeout: 5000
            # 重试器 默认重试类 自定义重新配置 Bean 覆盖默认
            retryer: feign.Retryer.Default

```

### 重试机制

> [!NOTE]
> feign 取消的默认的重试机制，开启需要配置 retryer: feign.Retryer.Default

```java
// com.example.service.config
@Configuration
public class FeignConfig {
    @Bean
    Retryer feignRetryer() {
        // 默认重试5次，间隔100ms，最大间隔1s，每次重试 上次的请求时间的2倍
        return new Retryer.Default();
    }
}

// 服务单独配置版： retryer: feign.Retryer.Default
```

### 拦截器配置

```java
// com.example.service.config

// 请求拦截器
@Configuration
public class FeignConfig {
    @Bean
    public RequestInterceptor requestInterceptor() {
        return requestTemplate -> {
            // 添加自定义请求头，例如添加认证信息
            requestTemplate.header("Authorization", "Bearer your_token_here");
            // 可以添加其他公共请求头
            requestTemplate.header("X-Custom-Header", "custom_value");
        };
    }
}

// 响应拦截器 Feign 没有提供响应拦截器，可以通过自定义 ErrorDecoder 来处理响应错误
class MyErrorDecoder implements ErrorDecoder {
    @Override
    public Exception decode(String methodKey, Response response) {
        if (response.status() == 400) {
            // 处理 400 错误
            return new CustomBadRequestException("Bad Request");
        }
        if (response.status() == 500) {
            // 处理 500 错误
            return new CustomInternalServerErrorException("Internal Server Error");
        }
        return defaultErrorDecoder.decode(methodKey, response);
    }
}
```

## Fallback 断路器

> [!TIP]
> 兜底返回机制，当远程服务不可用时，返回一个默认的响应，避免服务调用失败，重试机制完成后才触发，测试就关闭重试
>
> 需要使用 `spring-cloud-starter-alibaba-sentinel` 配置： `sentinel feign.sentinel.enabled=true`

```java
// 接口处定义兜底类 关闭重试机制不关需要等待重试后才触发时间较长 properties 配置注释即可
@FeignClient(name = "service-name", fallback = RemoteServiceClientFallback.class)
public interface RemoteServiceClient {
    @GetMapping("/Product/{productId}")
    String getProduct(@PathVariable String productId);
}

// feign>fallback 包路径 ，自己实现一遍 feign 的接口然后 fallback 引用就行了
@Component
class RemoteServiceClientFallback implements RemoteServiceClient {
    @Override
    public String getProduct(String productId) {
        return "Default Product"; // 兜底返回值
    }
}
```
