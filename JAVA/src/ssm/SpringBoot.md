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
   <summary>手写项目结构</summary>

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
@RestController /* 这个是 API 控制器，返回的就是指定数据了 */
public class defaultController {
    /* ~=Router() localhost:8080/Home */
    @RequestMapping("/Home")
    public String Home() {
        return "Home";
    }
}
```

Resources:

1. static:静态资源文件夹
2. templates:模板文件夹
3. application.properties : 配置文件

</details>

## Spring-Boot 配置

> [!TIP]
> SpringBoot 的配置是 Resources < application.properties

在里面就是配置启动后的参数类的，必须占用的端口号

properties 没有注释，记得删除，配置文件也支持 yml 与 yaml 都无注释 推荐就这个阅读性高

注意 Spring-boot 的端口占用是不分网卡的，就是只要是 ipconfig 查看的 ipv4 地址都可以进入

```properties
# 端口号
server.port=25505
# 虚拟目录 也就是可定义第一级进入目录
server.servlet.context-path=/api
# Idea 会有提示的，自行查看翻译旁边的文档
```

## 发送邮件 Demo

> 使用 Spring-Boot web 添加了 官方 Mail 依赖实现的 api 义发送邮件 

<details>
    <summary> 全部代码 </summary>

### 完整依赖

> Spring-boot web 相关的自行加上去，这里这是额外添加内容

```xml
<dependencies>
    <!-- 邮箱发送类 -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-mail</artifactId>
        <version>3.4.1</version>
    </dependency>

</dependencies>
```

### 入口配置

```java
/*! com.name.config */
@SpringBootApplication
@ComponentScan("com")
@PropertySource("classpath:Mail.properties")
public class springConfiguration {
    public static void main(String[] args) {
        SpringApplication.run(springConfiguration.class, args);

    }
}
```

### 配置文件

> resources 目录下！
> 
> 1. META-INF ：对配置键 alt + a 定义配置键，声明类型等
> 2. static : 静态文件
> 3. templates : 模板文件

```properties
# application
server.port=25505
server.servlet.context-path=/api

# Mail | Code : 授权码
User=sulley-naer@qq.com
code=fobuedxbkrbnhjfb
step=smtp.qq.com
port=465
```

### API 控制器

```java
/* ! com.name.controller < */
@RestController
public class defaultController {
    
    //发送邮箱工具类
    private final Mail mail;

    public defaultController(Mail mail) {
        this.mail = mail;
    }
    
    //测试连接使用 /api/hello
    @RequestMapping("/hello")
    public String hello() {
        return "hello world";
    }
    
    // api/sendMail
    @RequestMapping("/sendMail")
    public String mail(String to, String title, String content) {
        return mail.send(to, title, content)?"已发送":"发送异常";
    }
}
```

### 邮箱工具类

实现方法抽象类

```java
/*! com.name.utils */

public abstract class email {

    public boolean send(String to, String title, String context, String user, String code, String step, int port) {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

        //邮箱的地址：step 特殊IP地址
        mailSender.setHost(step);
        mailSender.setPort(port);
        //登录密钥等
        mailSender.setUsername(user);
        mailSender.setPassword(code);
        mailSender.setDefaultEncoding("UTF-8");

        //特殊选项 QQ 邮箱启用了 SMTP 与 POP3 | SMTP = 认证 + SSL
        Properties props = mailSender.getJavaMailProperties();

        // 启用认证
        props.put("mail.smtp.auth", "true");
        // 启用 SSL
        props.put("mail.smtp.ssl.enable", "true");
        // 打开调试日志（可选）
        props.put("mail.debug", "false");
        //开启 SMTP
        props.put("mail.transport.protocol", "smtp");

        try {
            mailSender.testConnection();
        } catch (MessagingException e) {
            return false;
        }

        //?有兴趣自行开多线程
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(user);
        message.setTo(to);
        message.setSubject(title);
        message.setText(context);
        mailSender.send(message);
        return true;
    }
}
```

> [!TIP]
> 基层实现类 Spring 这样写，我们需要配置文件来解耦，通过配置文件引入值。

```java
/*! con.name.utils.Impl */
@Component
public class Mail extends email {
    /*
     * 官方有 Properties 邮箱提示
     * 反正都需要开一个bean来获取
     * 我单开配置文件来使用自定义
     * 它的不能导入配置时自动注入
     * 即使 Spring 也要拿取设置
     */
    @Value("${User}")
    String user;
    @Value("${code}")
    String code;
    @Value("${step}")
    String step;
    @Value("${port}")
    int port;

    public boolean send(String to,String title,String msg) {
        //?这里实现类只负责拿取配置的值，调用父类开启发送事件
        return super.send(to,title, msg, user, code, step, port);
    }
}
```

</details>
