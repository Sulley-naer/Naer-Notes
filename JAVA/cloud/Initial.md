# 搭建服务

> [!TIP]
> 创建springCloud项目，再最顶层的pom里面声明全局依赖

<details>
  <summary>查看依赖</summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <!-- Idea 创建spring-boot 模块时 勾选全部 spring-cloud 就行 -->
    <packaging>pom</packaging><!-- 声明当前为父包而不是构建服务 -->
    <dependencies>
      <!-- Nacos 所需依赖，注册中心 也能用 Consul -->
      <dependency>
        <groupId>com.alibaba.cloud</groupId>
        <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        <version>2023.0.3.3</version>
      </dependency>
    </dependencies>
</project>
```

</details>

## 目录结构

> [!TIP]
> 由分布式架构的服务模块化结构，每个服务都有自己的 pom 文件，

而 services 目录下的 pom 文件用于声明所有服务的通用依赖。
每个服务都可以独立部署，也可以一起部署。

```md
\---demo
  |   pom.xml
  |
  \---Model
  | |   name.java<!-- 通用 Pojo -->
  |
  \---services
    |   pom.xml <!-- 用于声明 services 通用依赖 -->
    |
    +---service-order
    |   |   pom.xml <!-- 普通的 pom 父级是 Services -->
    |   |
    |   \---src
    \---service-product
        |   pom.xml <!-- 记得引入 model 全局Pojo的依赖 -->
```

## 服务注册

> [!TIP]
> Spring-boot 启动配置，为它配置 服务名称，占用端口，服务独立性

<details>

<summary>查看配置</summary>

```yaml
# 注册中心显示的服务名称
nacos:
  server: 127.0.0.1:8848 # nacos 地址
  username: nacos
  password: nacos
  namespace: dev # 命名空间 ID

spring:
  application:
    name: order-service # 服务名称，注册中心显示的服务名称
  profiles:
    active: ${nacos.namespace} # 激活的环境
    include: feign #导入配置 映射:applicaton-feign

  cloud:
    nacos:
      config: # 配置中心
        server-addr: ${nacos.server}
        namespace: ${nacos.namespace}
        username: ${nacos.username}
        password: ${nacos.password}
        file-extension: properties
      discovery: # 注册中心
        server-addr: ${nacos.server}
        namespace: ${nacos.namespace}
        username: ${nacos.username}
        password: ${nacos.password}

  config:
    import:
      - nacos:common.properties?group=DEFAULT_GROUP # 公共配置
      - nacos:${spring.application.name}.properties?group=${spring.application.name} # 服务独有配置
```

</details>

<details>

<summary>查看代码</summary>

```java
//注解声明开启注册
@SpringBootApplication
@EnableDiscoveryClient
public class OrderApplication {
    public static void main(String[] args) {
        SpringApplication.run(OrderApplication.class, args);
    }
}
```

</details>

## 多服务模拟

> [!TIP]
> 服务中添加spring-boot vm参数选项右上角设置勾选，再写入 -Dserver.port=9002
>
> [查看服务状态](http://127.0.0.1:8080/index.html#/serviceManagement)

<details>

<summary>编辑器配置</summary>

```xml
<!-- Idea 配置服务文件 -->
<!-- .idea\runConfigurations\OrderApplication_9002.xml -->
<component name="ProjectRunConfigurationManager">
  <configuration default="false" name="OrderApplication_9001" type="SpringBootApplicationConfigurationType" factoryName="Spring Boot">
    <module name="service-order" />
    <option name="SPRING_BOOT_MAIN_CLASS" value="com.Near.order.OrderApplication" />
    <option name="VM_PARAMETERS" value="-Dserver.port=9001" />
    <extension name="net.ashald.envfile">
      <option name="IS_ENABLED" value="false" />
      <option name="IS_SUBST" value="false" />
      <option name="IS_PATH_MACRO_SUPPORTED" value="false" />
      <option name="IS_IGNORE_MISSING_FILES" value="false" />
      <option name="IS_ENABLE_EXPERIMENTAL_INTEGRATIONS" value="false" />
      <ENTRIES>
        <ENTRY IS_ENABLED="true" PARSER="runconfig" IS_EXECUTABLE="false" />
      </ENTRIES>
    </extension>
    <method v="2">
      <option name="Make" enabled="true" />
  </configuration>
</component>
```

</details>

## temp

| 功能                          |
| ----------------------------- |
| [架构描述](./Spring-Cloud.md) |
| [注解集合](./annotations.md)  |
| [服务容器](./Docker.md)       |
| [注册中心](./serverCenter.md) |
| [配置中心](./configCenter.md) |
| [远程调用](./openFeign.md)    |
