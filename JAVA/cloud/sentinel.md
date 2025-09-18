# sentinel

> [!TIP]
> Sentinel 是一个流量控制组件，提供了丰富的流量控制和熔断降级功能，可以与 Feign 熔断结合使用，实现对远程调用的保护。
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
@SentinelResource(value = "CreateOrder", blockHandler = "CreateOrderFallback")/* 可以 fallback 只不过优先是走被流控传的方法 */
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

### 流控相关

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

### 熔断降级

> [!TIP]
> 熔断降级是指在系统出现异常或高负载时，自动切断对某些服务的调用，以防止故障蔓延，保护系统的整体稳定性
>
> 断路器：当某个服务的错误率或响应时间超过设定的阈值时，断路器会打开，阻止对该服务的调用，直接返回预设的降级响应 <br/>
> 半开状态：经过一段时间后，断路器会进入半开状态，允许少量请求通过，如果这些请求成功，断路器会关闭，恢复正常调用

熔断策略：

1. 慢调用比例
   1. 最大RT：最大请求响应时间
   2. 比例阈值：未通过率超过这个阈值就触发熔断
   3. 熔断时长：字意触发后这段时间请求不会该服务
   4. 最小请求数：样本量 当请求总次数超过才计数
   5. 统计时长：统计间隔 3s 同级一次
2. 异常比例：
   1. 比例阈值 熔断时长 最小请求数 统计时长 一致
3. 异常数量：
   1. 异常数量：当请求的异常数超过这个数量时触发熔断

### 热点规则

> [!TIP]
> 热点规则是指针对某些特定的资源或服务，设置更为严格的流量控制和熔断降级规则，以保护这些资源不被过度使用

请求参数带某些参数的请求进行流量控制，比如搜索xxx等，配置最大请求数等，或者用于禁止某些参数的请求

限制用户 ID 访问频率，防止单个用户过度使用资源 比如自动下单爬取等脚本，限制某个用户访问频率，防止恶意请求

1. 参数索引：控制器方法参数的位置，从 0 开始
2. 单机阈值：该参数的每秒最大请求数
3. 统计窗口时长：统计间隔，单位为秒
4. 是否集群：是否在集群模式下生效

高级选项：新增后编辑

1. 参数类型：string/int/long/boolean/other
2. 参数值：指定参数值进行流量控制
3. 限流阈值：此类型并且值相同的请求的最大请求数

### 授权规则

> [!TIP]
> 授权规则是指对特定的资源或服务，设置访问权限和控制，以确保只有授权的资源能够访问这些资源
>
> 用的少，会被网关配置顶掉

1. 授权应用：指定哪些应用有权限访问该资源
2. 授权类型：白名单/黑名单

### 系统规则

> [!TIP]
> 对系统性能相关的限制，确保服务不会让系统高压，这些设置精度太弱，几乎不用

1. load： 限制磁盘加载相关的资源数量
2. RT： 最大请求响应时间限制
3. 线程数： 服务创建的线程数量
4. 入口QPS：每秒并发数量
5. cpu使用率：服务器性能限制

## 持久化

> [!NOTE]
> 将 sentinel 中心配置相关由原来的内存存储，改为由配置中心统一管理，实现自动初始化配置
