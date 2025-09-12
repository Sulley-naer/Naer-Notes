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
// 远程服务的名称 nacos 服务 id 字段 配置文件可定义的 spring-application-name 无法解析下划线
@FeignClient(name = "service-name")
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
