# 服务中心

> [!TIP]
> Spring-cloud 中的是注册服务，发现服务，服务调用，带有缓存,负载均衡等功能

## 注解

application 主类

| 注解                  | 说明                 |
| --------------------- | -------------------- |
| EnableDiscoveryClient | 当前服务挂载注册中心 |

> [!NOTE]
> 发现服务相关

| 注入字段              | 说明                   |
| --------------------- | ---------------------- |
| DiscoveryClient       | 注册中心拿取服务       |
| NacosServiceDiscovery | 注册中心拿取服务       |
| RestTemplate          | 发送请求工具           |
| 方法                  | 方法                   |
| getServices           | 查看当前微服务名称集合 |
| getInstances          | 传入服务名称查看地址集 |
| RestTemplate          | 方法参数 url data 数据 |

> [!TIP]
> 负载均衡

| 类注解       | 说明             |
| ------------ | ---------------- |
| LoadBalanced | 注解自动地址替换 |

```java

```

| 注入字段           | 说明                 |
| ------------------ | -------------------- |
| LoadBalancerClient | 负载均衡发现提供服务 |

| 方法    | 参数        | 说明              |
| ------- | ----------- | ----------------- |
| choose  | string name | 服务名称 拿取服务 |
| getPort | void        | 拿取端口          |
| getHost | void        | 拿取地址          |
| getUrl  | void        | 拿取网址          |

## 测试服务

> [!NOTE]
> spring-cloud-nacos 服务注册中心

| Bean                  | 说明           | 参数     |
| --------------------- | -------------- | -------- |
| DiscoveryClient       | 发现服务工具类 |          |
| NacosServiceDiscovery | 服务工具类一致 |          |
| DiscoveryClient       | 方法集         |          |
| getServices           | 已注册服务     |          |
| getInstances          | 服务信息参数   | str name |

```java
/* 测试环境 */
// 依赖: spring-boot-starter-test
@SpringBootTest
public class DiscoveryTest {

    @Resource
    DiscoveryClient discovery;

    @Test
    public void FinderTest() {
        List<String> services = discovery.getServices();
        services.forEach(i -> discovery.getInstances(i).forEach(instance -> log.info(instance.getHost() + ":" + instance.getPort())));
      // 固定拿取同一个服务的第一个，没有负载均衡的功能，只能是第一个服务顶着
    }
}
```

## 负载均衡

> [!TIP]
> spring-cloud 自动拿取实例，支持负载均衡,会被后续注解调用优化，跳过

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-loadbalancer</artifactId>
</dependency>
```

```md
<!-- 通过网络请求拿取测试 -->
## path: Get `localhost:8848/nacos/v1/ns/instance/list?serviceName=order_service&namespaceId=dev`

header:`Username` `Password`
Query:`serviceName` `namespaceId`

## apipost

curl --request GET \
  --url 'http://localhost:8848/nacos/v1/ns/instance/list?serviceName=order_service&namespaceId=dev' \
  --header 'Accept: */*' \
  --header 'Accept-Encoding: gzip, deflate, br' \
  --header 'Connection: keep-alive' \
  --header 'Password: nacos' \
  --header 'User-Agent: PostmanRuntime-ApipostRuntime/1.1.0' \
  --header 'Username: nacos'
```

## 配置文件

> [!NOTE]
> spring-cloud-nacos 配置文件，让服务自动注册和拿取配置中心

```yaml
spring:
  application:
    name: order-service
  profiles:
    active: dev # 激活的环境

  cloud:
    nacos:
      config:
        # 配置中心
        server-addr: 127.0.0.1:8848
        namespace: dev
        username: nacos
        password: nacos
        file-extension: properties
      discovery:
        # 注册中心
        server-addr: 127.0.0.1:8848
        namespace: dev
        username: nacos
        password: nacos

  config:
    # 导入配置中心 对应文件
    import: nacos:common.properties?group=order
```
