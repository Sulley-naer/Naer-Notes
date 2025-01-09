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

## 注解集合

| 方法                               | 功能                            |
|----------------------------------|-------------------------------|
| ----Application----              | ----Application----           |
| SpringBootApplication            | 一键声明启动配置                      |
| ComponentScan("com")             | 指定扫描注解Bean路径                  |
| PropertySource("classpath:name") | 导入指定 Properties 配置            |
| MapperScan("com.mapper")         | 指定 Mybatis Mapper 扫描路径        |
| Configuration                    | 声明当前类是配置类                     |
| Import                           | 导入配置文件或配置类等                   |
| ConditionalOnProperty            | bean 注入检查 prefix name 不存在就不注入 |
| ConditionalOnMissingBean         | bean 检查 name 找不到指定对象 就自动注入    |
| ConditionalOnClass               | bean 检查 name 找不到指定对象 就不注入     |
| ----Bean----                     | ----Bean----                  |
| Data                             | 自动生成 Get;Set;                 |
| scope                            | 指定Bean使用范围                    |
| Component                        | 声明bean的基础注解                   |
| Service                          | 标注在控制器类上                      |
| RestController                   | API控制器类                       |
| Repository                       | 标注在数据访问类上(被mybatis优化了)        |
| ----methods----                  | ----methods----               |
| RequestMapping("name")           | 控制器指定路径                       |
| PostConstruct                    | 构造前方法 : 初始化方法                 |
| PreDestroy                       | 销毁后方法 : 销毁时方法                 |
| select                           | mybatis：mapper接口 字段填充数据       |
| ----params----                   | ----params----                |
| value                            | 形参指定注入的值 ${} 用于注册 Bean        |
| ----Fields----                   | ----Fields----                |
| Resource                         | 开启注入  name = "指定"             |
| Autowired                        | 旧版注入                          |
| Qualifier                        | 旧版注入 指定注入名称                   |
| Value                            | 指定内容,常用配置注入 ${key}            |
| Getter                           | 生成Get                         |
| Setter                           | 生成set                         |

## Lombok「推荐工具」

> 推荐的生成 Getter 与 Setter 工具

```java
//?方式一 直接生成类所有属性的
@Data
@Getter
@Setter
public class animal extends email {
    //?方式二 指定生成
    @Getter
    @Setter
    String name;
    String gender;
    int age;
}
```

## 发送邮件 Demo

1. [Mail](https://www.baeldung.com/spring-email)
2. [Config](https://docs.spring.io/spring-boot/reference/io/email.html)

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
email.User=sulley-naer@qq.com
email.code=fobuedxbkrbnhjfb
email.step=smtp.qq.com
email.port=465
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
        return mail.send(to, title, content) ? "已发送" : "发送异常";
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
/*
 * 此注解可简写Value里面都有的前缀 email
 * 使用该方法需要删除 @value 它自动注入
 * 并且提供 Get;Set; Idea 成功了 Idea 方法旁提示
 * 如果想使用不要真的去写 Get;Set 依赖 Lombok
 * @Data : Lombok 自动生成类所有成员 Get;set;
 * */
@ConfigurationProperties(prefix = "email")

public class Mail extends email {
    /*
     * 官方有 Properties 邮箱提示
     * 反正都需要开一个bean来获取
     * 我单开配置文件来使用自定义
     * 它的不能导入配置时自动注入
     * 即使 Spring 也要拿取设置
     */
    @Value("${email.User}")
    String user;
    //@Getter @Setter Lombok 自动生成该属性的
    @Value("${email.code}")
    String code;
    @Value("${email.step}")
    String step;
    @Value("${email.port}")
    int port;

    public boolean send(String to, String title, String msg) {
        //?这里实现类只负责拿取配置的值，调用父类开启发送事件
        return super.send(to, title, msg, user, code, step, port);
    }
}
```

</details>

## MVC Mybatis-spring 「泛型设计」

> [!TIP]
> 将 Mybatis 集成进 spring-boot 内使用并配置连接数据库
>
> Mybatis 同样也是注解开发
> 使用它所提供的方法，传递SQL语句，返回注入 Bean 的对象
>
> 使用需要配置连接数据库，才能使用它的注解方法。

<details>
<summary>MVC</summary>

### 依赖&配置

Spring-boot-web 依赖省略

```xml

<dependencys>
    <!-- 可选生成 Get Set -->
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
        <version>1.18.36</version>
    </dependency>

    <dependency>
        <groupId>org.mybatis.spring.boot</groupId>
        <artifactId>mybatis-spring-boot-starter</artifactId>
        <version>3.0.4</version>
    </dependency>
    <!-- 数据库对应类型，需要有 jdbc.Driver -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>8.0.33</version>
    </dependency>
</dependencys>
```

```properties
server.port=25505
server.servlet.context-path=/api
#? 这里开始指定数据库连接 这里指定的，通过 spring 注入拿取，会自动赋值进入。
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/node
spring.datasource.username=sa
spring.datasource.password=123456
```

### 主配置

```java
/* com.name.config */
@SpringBootApplication
@ComponentScan("com")
@PropertySource("classpath:Mail.properties")
//! Spring 指定 Mybatis 实现重写接口的 Bean 软件包
@MapperScan("com.naer.mapper")
public class springConfiguration {
    public static void main(String[] args) {
        SpringApplication.run(springConfiguration.class, args);
    }
}
```

### Mapper&pojo

> [!TIP]
> Mapper 就是声明让 mybatis 填充 Bean 数据的层，数据层就是 pojo 了

Mapper:数据填充层

```java
/* com.name.Mapper */
@Mapper //!必须是「接口」 它帮忙重写方法，根据你的注解来
public interface userMapper {
    /*
     * 接口是无法实例化，这里的注解被 Mybatis 去生成数据了。
     * 根据接口里面你写的 Mybatis 相关注解生成方法
     * 返回对象是按着你接口限制来的，
     * Bean里面数据需要你写注解 查询相关 它注入生成 bean
     */
    @Select("select * from user;")
    user findUserById(Integer id);
}
```

pojo:数据库对照层。

```java
/* com.name.pojo */
@Data
public class user {
    private int id;
    private String user;
    private String pwd;
}
```

### Services

> [!TIP]
> 服务层，调用 mapper 获取数据，返回进行操作

接口

```java
/*! 接口是放 Services下 实现放 Services.Impl 下 */
public interface userService {
    user findById(int id);
}
```

实现

```java
/*! 接口是放 Services下 实现放 Services.Impl 下 */
@Service
public class userServiceImpl implements userService {
    //! 拿取 Mybatis 重写mapper的类，接口无法实例化，它实现重写后返回你。
    @Resource //?Spring 建议的新注入注解 ,Autowired 会警告这个不会
    private userMapper userMapper;

    @Override
    public user findById(int id) {
        return userMapper.findUserById(id);
    }
}
```

### Controller

```java
/* com.name.controller */
@RestController
public class defaultController {

    @Resource //?新注入注解 Autowired 会警告。
    private userServiceImpl userServiceImpl;

    @RequestMapping("/hello")
    public String hello() {
        return "hello world";
    }

    @RequestMapping("FindUser")
    public user findUser(int id) {
        return userServiceImpl.findById(id);
    }

}
```

</details>

## Bean 注册

> [!TIP]
> 在Jar包中的类无法修改，我们需要让它也能挂载 Bean，后续挂载实现

<details>
<summary>代码演示</summary>

推荐写法

```java
//配置一个扫描包路径，把配置文件添加进去
@SpringBootApplication
public class springConfiguration {
    public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(springConfiguration.class, args);
        //?通过声明的Bean Id 拿取
        System.out.println(context.GetBean("t1"));
        System.out.println(context.GetBean("t2"));
    }
}
```

```java

@Configuration //声明为配置类
public class configs {

    @Bean //? 可选指定名称 @Bean("test") 默认是方法名称
    public test t1() {
        test item = new test();
        //item.set() 这样实现注入初始化值,推荐用配置文件注入值，外面预留 @value
        return new test();
    }

    //!spring 声明 Bean 的时候发现有参数，Spring 内部有 Bean 类型字节码,就会走自动传递
    @Bean("t2")
    public test t2(test t1) {
        System.out.println("test:" + t1);
        test item = new test();
        //test.set() 注册的bing你可以自行初始化，通过@value 在形参或者属性字段
        return item;
    }
}

@Data
@EqualsAndHashCode
class test {
    private String t1;
    private String t2;
}
```

不推荐 bean 注入写入口配置里面

```java

@SpringBootApplication
public class springConfiguration {
    public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(springConfiguration.class, args);
        //GetBean 语法就行了 ，传入字节码就能获取到了
        System.out.println(context.getBean(test.class));
    }

    //!实际不推荐这样写
    @Bean
    public test t1() {
        return new test();
    }
}

@Data
@EqualsAndHashCode
class test {
    private String t1;
    private String t2;
}
```

</details>

## Bean 注册条件

> [!TIP]
> Bean 注册条件 就是在声明注册Beam 的启动条件，注册操作记得在配置类环境！

```java

@Bean("t3") /*! 如果没配置这个名称，就会直接异常 */
/*
 * 注入前检查是否有这属性，否则不注入
 * Prefix属性前缀 对应 name.name name.name2
 * 这样能防止起服务的阶段，不会异常，后续GetBean还是会出找不到异常
 * */
@Bean
@ConditionalOnProperty(prefix = "name", name = {"name", "name2"}) 
public test t1(@value("${n1}") String p1) {
    test item = new test();
    //?item.set(p1) 这样实现注入初始化值,推荐用配置文件注入值，形参预留 @value
    return item;
}
```

防止上面未注入找不到bean

```java
@Bean //如果是为了解决上面未定义的异常，记得指定Id是同一个
/*? spring 容器没有找到指定的Bean 就自动调用方法注入一个。 */
@ConditionalOnMissingBean(test.class)
@ConditionalOnClass(name = "") //!这个注解是上面相反，是找得到就注入相反同理
public test Provider(){
    return new test();
}
```

## Import

> [!TIP]
> 导入语法常用与导入配置文件，或者导入配置工厂模式类

1. @import("name.class")
2. @Import({"1.class,2.class"})

```java
//@Import(CommonImportSelector.class)

public class CommonImportSelector implements ImportSelector {
    @Override
    public String[] selectImports(AnnotationMetadata importingClassMetadata) {
        //!这样就可以一次导入多个类了 字符串必须是全类名
        return new String[]{"com.name.class1", "2", "3"};
        //?一般不是写死导入那些类，而是根据配置文件去动态调整，导入的配置。
        InputStream is = CommonImportSelector.class
                .getClassLoader().getResourceAsStream("name.imports");//获取Resources目录下文件
        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        String Line;
        while ((Line = br.readLine()) != null) {
            //?自己添加进字符串数组里面
        }
    }
}
```

## 自定义注解

> [!TIP]
> 自定义注解可以让多个注解变成你指定的一个注解，在特定场景有用

```java
/*? com.name.anno */

@Target(ElementType.TYPE) //类上面声明，还有其他位置，翻译文档
@Retention(RetentionPolicy.RUNTIME) // 运行时保留的注解
@Bean //假设需要调用其他的注解，这里可以声明
public @interface sums {
}
```

## 自动配置原理

<details>
<summary>原理说明</summary>

spring-boot 附带依赖 autoConfiguration

而spring-boot的入口声明自定义注解合并了 autoconfig的启动注解

autoconfig也是个配置类，它使用了注解 Import 工厂模式

工厂模式实现了 ImportSelector 它这个不可能是写死的导入配置

它将它所支持的包名全部存放在 autoconfig 内部的一个 .imports 文件中

这里面记录的包名就是它生态链所适配的，在配置工厂返回的包名集合,随后拿去注册 Bean

它使用了 Bean 注册条件 ConditionalOnClass 验证是否存在该字节再去注入

这样如果你构建完成后能找到它适配的字节码，它就能过检查走 Bean 注册初始化了

autoconfig 注入的有个规范，适配的包里面都有 名字 + AutoConfiguration 的类

这个就是适配自动注入的实现类，这个类有自定义注解，注解同样是配置类

它用它是配置类权限又去 注册它内部的 Bean 这就是自动配置的完整逻辑了。

### 第三方实现

autoConfiguration 内部的 Imports 文件它是在 resource < META-INF 目录

这个目录也说过它是配置文件的说明文件的目录，似乎是有特殊的特性一样。

好像这个 META-INF 下的说明文件同名的是自动追加合并，而不是覆盖和根据父级路径隔开。

就由此特性，让官方写的手动适配的白名单可以被注入进去，你也写它的全称，把自己包名写进入。

全名称: org.springframework.boot.autoconfigure.AutoConfiguration.imports

1. 在你的项目的程序位置 resources < META-INF < spring 创建上面的白名单
2. 填写能访问到你的提供自动配置的实现类 关键注解 @AutoConfiguration 
3. 然后使用 Import 工厂模式导入,你项目负责 注册 Bean 的配置类来启动你的服务。
4. 工厂模式导入的 Bean 是配置类;工厂模式在 Config 目录;

面试回答

第一步：

在主启动类上添加了
SpringBootApplication注解
这个注解组合了
EnableAutoConfiguration注
解

第二步：

EnableAutoConfiguration注解
又组合了Import注解,导入了
AutoConfigurationImportSelector类

第三步：

实现selectImports方法,这个
方法经过层层调用,最终会
读取META-INF 目录下的 后
缀名 为Imports的文件,当然
了,boot2.7以前的版本,读取
的是spring.factories文件

第四步:

读取到全类名了之后,会解析
注册条件,也就是
@Conditional及其行生注解
把满足注册条件的Bean对象
自动注入到I0C容器中

</details>
