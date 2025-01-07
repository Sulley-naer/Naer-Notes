# Spring-Boot

> [!TIP]
> Spring 是 Spring 系列方法的一个集合，Spring有很多工具
> 
> SpringBoot 就是把所有常用的全部集合在一块使用的`框架`

在配置依赖时只需要一个坐标，就能集合传统过多的依赖项目。

它还附带其他特性

1. 内嵌Tomcat、Jetty(无需部署WAR文件)
2. 外部化配置(配置文件不需要重新编译部署)
3. 不需要XML配置，全注解模式开发

创建项目推荐 Idea 模块 > 新建项目 > Spring boot > Maven > web > spring web

<details>
   <summary>手动创建</summary>

> 依赖相关

```xml
<!-- 手动创建需要的依赖 -->
<project>
    <!-- 父级依赖，用于管理起步依赖的版本 -->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.4.1</version>
    </parent>
    
    <dependencies>
        <!--   依赖复制到这里     -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>5.11.4</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
        </dependency>

    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.opoo.maven</groupId>
                <artifactId>tomcat9-maven-plugin</artifactId>
                <version>3.0.0</version>
            </plugin>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

入口文件
 
```java
@SpringBootApplication
@ComponentScan("com")//指定扫描 Bean 路径 
// @SpringBootApplication(scanBasePackages = "") 这种也可以指定
public class springConfiguration {
    //这里就是整个程序的入口函数
    public static void main(String[] args) {
        //启动 Spring
        SpringApplication.run(springConfiguration.class, args);
    }
}

```

controller

```java

//@Controller /* Context的注解 这个是控制器的 返回的都是视图 */
@RestController /* 这个是 Api 控制器，返回的就是指定数据了 */
public class defaultController {
    /* 进入地址 Router() */
    @RequestMapping("/")
    public String index() {
        return "index";
    }
}
```

Resources:

1. static:静态资源文件夹
2. templates:模板文件夹
3. application.properties : 配置文件

</details>
