# sentinel

> [!TIP]
> Sentinel 是一个流量控制组件，提供了丰富的流量控制和熔断降级功能，可以与 Feign 结合使用，实现对远程调用的保护。
>
> 它用于对资源的管理，对请求实现规则控制，保护特定的资源不被过度使用，从而提高系统的稳定性和可靠性

## 引入依赖

```xml
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
    <version>2023.0.3.3</version>
</dependency>
```

## Docker

启动服务:下载 jar 存放目录 [sentinel](https://github.com/alibaba/Sentinel)

dockerFile 制作服务镜像

```dockerfile
# Use an OpenJDK runtime as the base image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file into the container
COPY sentinel-dashboard-1.8.8.jar /app/sentinel-dashboard.jar

# Expose the port that Sentinel dashboard uses
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "sentinel-dashboard.jar"]
```

```yaml
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
```

## 配置使用

> [!TIP]
> 在配置文件中配置连接地址，并设置初始化周期即可自动开启资源注册
>
> 在资源注册后，先在 Sentinel 控制台中对资源进行流量控制和熔断降级规则的配置

```yml
spring:
  cloud:
    sentinel:
      transport:
        dashboard: localhost:8888
      eager: true # 项目重启时连接而非首次请求

feign:
  sentinel:
    enabled: true
```

## 注解

Sentinel 提供的注解

| 注解              | 说明                           | 参数               | 区域    |
| ----------------- | ------------------------------ | ------------------ | ------- |
| @SentinelResource | 配置定义受 Sentinel 保护的资源 | value,blockHandler | 方法/类 |

## 兜底数据

> [!NOTE]
> 当配置规范触发后，比如流控规则达到上限，sentinel 会在内部抛出异常，然如果没有配置回返回字符串
>
> 实际项目不能只是放回写死的字符串，通常需要给对应的接口返回，无用或者空数据，让前端正确处理的结构

```java
@SentinelResource(value = "CreateOrder", blockHandler = "CreateOrderFallback")
@GetMapping("/order/{id}")
public ResponseEntity<Object> CreateOrder(@PathVariable int id) {
    return ResponseEntity.ok(new Success(true));
}

//兜底回调
public ResponseEntity<Object> CreateOrderFallback(@PathVariable int id, BlockException blockException) {
    //通常 new 一个 数据返回
    return ResponseEntity.ok(new Success(blockException));
}
```

## 异常拦截

> [!TIP]
> 在实际情况中，无法预估所有的异常，此时项目需要引入 全局异常拦截，进行统一的控制器异常管理

```java
// 在 exception 包下
package com.near.order.exception;

@RestControllerAdvice
public class GlobalExceptionHandle {
    //拦截范围注解，基本上所有的控制器类型都能拦截
    @ExceptionHandler(Throwable.class)
    public String handleException(Throwable throwable) {
        return throwable.getMessage();
    }
}
```

## 配置说明

流控规则：

1. QPS（Queries Per Second）：基于请求的每秒查询数进行流量控制
2. 并发线程数（Concurrent Threads）：基于请求的并发线程数

流控模式：

1. 直接模式：直接拒绝超过阈值的请求
2. 关联模式：根据其他资源的状态来决定是否拒绝请求
  1 数据读多限写 读取接口配置流控 关联写入 读取接口自身无限制
  2 当写入接口达到流控阈值时 读取接口受限 关联需要互相关联
  3 写入接口没有配置关联读取 读取接口再多 写入接口不受影响
3. 链路模式：基于调用链路来进行流量控制
  1 其他接口 调用本接口 限制其他接口调用此接口的流量 入口资源填写其他接口名称
  2 自己无限制 比如秒杀创建订单限制数量 而不限制普通业务创建订单数量

流控效果:

1. 快速失败：直接执行 Block 异常处理步骤
2. warmUp：预热期，逐步增加流量，避免瞬时大流量冲击
3. 排队等待：当请求超过阈值时，进入排队等待状态，等待处理
