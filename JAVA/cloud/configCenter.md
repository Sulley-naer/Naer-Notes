# 配置中心

> [!TIP]
> 配置中心是一个集中式的配置管理系统，用于管理应用程序的配置信息。

springCloud 中配置中心的服务通常是 nacos 提供的

## 依赖

```xml
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
    <version>2023.0.3.3</version>
</dependency>
```

## 注解

| 注解                | 说明                 |
| ------------------- | -------------------- |
| RefreshScope        | 配置中心数据自动更新 |
| NacosPropertySource | 声明配置中心地址     |

## 创建配置

> [!NOTE]
> [加入后台，创建配置](http://127.0.0.1:8080/index.html#/configurationManagement)

## 使用配置

> [!TIP]
> **数据中心中出现同名配置 数据中心的值会覆盖本地的值 实现配置的动态更新**

- 声明配置中心地址 后才能使用 **注册的名称要带有后缀.properties**

  ```xml
  spring.cloud.nacos.config.server-addr=127.0.0.1:8848
  spring.cloud.nacos.config.username=nacos
  spring.cloud.nacos.config.password=nacos
  spring.cloud.nacos.config.file-extension=properties
  ```

- properties 导入配置，nacos需要先配置地址

  `spring.config.import=nacos:配置中心内名称.properties,nacos:n2.yml`

- 在 Spring Boot 应用中，使用 `@NacosPropertySource` 注解来声明配置源。

> [!CAUTION]
> 配置了 spring.config.import 后启动会检查你是否使用，可能会导致无法启动

加入 `spring.cloud.nacos.config.import-check.enabled=false` 关闭检查就行

## 无感注入

> [!TIP]
> spring 配置中心工厂类，把所有的配置定义在一个类中使用

<details>

<summary>查看代码</summary>

```java
@Data
@Component
// 自动刷新无需配置注解
@ConfigurationProperties(prefix = "order")
public class orderProperties {
    //对应配置文件中 order.name
    String name;
}
```

```java
@Resource
orderProperties orderProperties;
```

</details>

## 配置监听器

> [!IMPORTANT]
> Nacos提供的配置变化拦截事件，可以通过它实现监听更新

- ApplicationRunner : Spring 完成加载事件，带有自动装配Bean，拿取 NacosConfigManager
- ConfigService : 通过 NacosConfigManager 拿到配置对象，配置接口实现监听器方法注入

<details>

<summary>查看代码</summary>

```java
/* services.listener */
@Configuration
public class listener {
    @Bean
    ApplicationRunner applicationRunner(NacosConfigManager nacosConfigManager) {
        return args -> {
            ConfigService configuration = nacosConfigManager.getConfigService();
            // 参数一 配置中心 配置文件名，配置文件组 监听器方法。
            configuration.addListener("demo", "DEFAULT_GROUP", new Listener() {
                @Override
                public Executor getExecutor() {
                    //线程池
                    return Executors.newFixedThreadPool(4);
                }

                @Override
                public void receiveConfigInfo(String configInfo) {
                    System.out.printf("配置更新:" + configInfo);
                }
            });
        };
    }
}
```

</details>

## 环境隔离

>[!TIP]
> 类似 vite 中的 .env.Development .env.Productions 来根据环境切换配置

环境 -> 命名空间 微服务 -> 分组 多配置 -> 配置名称 spring -> 激活

命名空间需要去管理页面，侧边栏命名空间，新疆命名空间

比如 配置id:common.properties,group:order,namespace:dev

导入测试

```properties
spring.cloud.nacos.config.namespace=dev
spring.cloud.nacos.discovery.namespace=dev
# 一定要带后缀，不然可能无法导入
spring.config.import=nacos:common.properties?group=order
```

根据环境导入

```properties
# 当前运行环境
spring.profiles.active=dev

spring.cloud.nacos.config.namespace=${spring.profiles.active:public}
spring.cloud.nacos.discovery.namespace=${spring.profiles.active:public}
spring.config.import=nacos:common.properties?group=order
```

环境追加导入

<details>

<summary>查看配置</summary>

```yml
# 斜杆分割符 只支持yml配置，自动根据环境追加导入 ，用的少 可以通过分文件实现
---
spring:
  config:
    import:
      - nacos:common.properties?group=order
      - nacos:database.properties?group=order
      - nacos:common.properties?group=order
  profiles:
    active: test
---
```

</details>

## 配置文件

> [!TIP]
> Nacos 官方强调的独立配置，不应该放在程序配置里，让程序只负责自己的功能

```yml
# application.yml 放主程序 resouces 下
nacos:
  server: 127.0.0.1:8848
  username: nacos
  password: nacos
  namespace: dev #环境 -> 命名空间

spring:
  application:
    name: product-service # 服务名称
  profiles:
    active: ${nacos.namespace} # 激活的环境

  cloud:
    nacos:
      config:
        server-addr: ${nacos.server}
        namespace: ${nacos.namespace}
        username: ${nacos.username}
        password: ${nacos.password}
        file-extension: properties
      discovery:
        server-addr: ${nacos.server}
        namespace: ${nacos.namespace}
        username: ${nacos.username}
        password: ${nacos.password}

  config:
    import:
      - nacos:common.properties?group=DEFAULT_GROUP # 公共配置
      - nacos:${spring.application.name}.properties?group=${spring.application.name} # 服务独立配置
```

## 测试环境问题

> [!CAUTION]
> 测试环境会遇到不加载等问题，首先导入的名称一定要带后缀名，测试环境单独配置

测试环境规范类注解 `@ActiveProfiles("test")`

```properties
# 测试环境单独配置 namespace 就行了 他会在原配置下覆盖添加
spring.cloud.nacos.config.namespace=test
spring.cloud.nacos.discovery.namespace=test
spring.config.import=nacos:common.properties?group=order&
# test 目录的下的 resources 别放主程序去了
```
