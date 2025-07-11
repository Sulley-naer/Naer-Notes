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
| AutoConfiguration                | 一键自动注入配置                      |
| ComponentScan("com")             | 指定扫描注解Bean路径                  |
| PropertySource("classpath:name") | 导入指定 Properties 配置            |
| MapperScan("com.mapper")         | 指定 Mybatis Mapper 扫描路径        |
| Configuration                    | 声明当前类是配置类                     |
| Import                           | 导入配置文件或配置类等                   |
| ConditionalOnProperty            | bean 注入检查 prefix name 不存在就不注入 |
| ConditionalOnMissingBean         | bean 检查 name 找不到指定对象 就自动注入    |
| ConditionalOnClass               | bean 检查 name 找不到指定对象 就不注入     |
| CrossOrigin                      | 注解跨域                          |
| ----Bean----                     | ----Bean----                  |
| Data                             | 自动生成 Get;Set;                 |
| scope                            | 指定Bean使用范围                    |
| Component                        | 声明bean的基础注解                   |
| Controller                       | 标注在控制器类上                      |
| Service                          | 标注服务层类上                       |
| Mapper                           | 标注代理层类上                       |
| RestController                   | API控制器类                       |
| Repository                       | 标注在数据访问类上(被mybatis优化了)        |
| ----methods----                  | ----methods----               |
| Transactional                    | Service 数据库自动同步根据异常状态         |
| RequestMapping("name")           | 控制器指定路径                       |
| PostConstruct                    | 构造前方法 : 初始化方法                 |
| PreDestroy                       | 销毁后方法 : 销毁时方法                 |
| selectOne                        | mybatis：mapper接口              |
| select                           | mybatis：mapper接口              |
| Insert                           | mybatis：mapper接口              |
| delete                           | mybatis：mapper接口              |
| update                           | mybatis：mapper接口              |
| ----params----                   | ----params----                |
| value                            | 形参指定注入的值 ${} 用于注册 Bean        |
| valid                            | 控制器参数中使用，请求参数自动检测  Pojo注解配置   |
| ----Fields----                   | ----Fields----                |
| Resource                         | 开启注入  name = "指定"             |
| Autowired                        | 旧版注入                          |
| Qualifier                        | 旧版注入 指定注入名称                   |
| Value                            | 指定内容,常用配置注入 ${key}            |
| Getter                           | 生成Get                         |
| Setter                           | 生成set                         |
| ----Pojo----                     | 控制器 @valid 开启参数校验             |
| NotNull                          | 属性非空                          |
| NotBlank                         | 属性非空白字符串                      |
| min                              | int类型最小值                      |
| max                              | int类型最大值                      |

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

实现方法抽象类 [优化版](./Utils.md#email)

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

    @RequestMapping("/login")
    @PreAuthorize("permitAll()")
    public ResponseEntity<?> test(String user, String pwd) {
        users select = getUser.select(user, pwd);

        if (select != null) {
            String token = JwtTokenUtil.generateToken(user);

            // 使用匿名内部类 自定义返回体结构
            return ResponseEntity.ok(new Object() {
                public final String status = "success";  // 状态
                public final Object data = token;        // 数据：token
            });
        }

        return ResponseEntity.notFound().build();
    }

}
```

</details>

### ... : WEB

> [!TIP]
> 此目录用在标准的 JavaWeb 项目使用，视图表单发送至 servlet 处理「Res Req」
>
> 对 response 解析添加中间层之类，request 返回流自定义操作等等

### ... : exception

> [!TIP]
> 可选：目录在标准的项目结构中，会需要自定义异常的需求，此目录用于存放类

### ... : Anno

> [!TIP]
> 可选：项目可能出现需要自定义注解的需求，此目录同样是用于存放实现类

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

<details>
<summary>注册条件语法</summary>

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
public test Provider() {
    return new test();
}
```

</details>

## Import

> [!TIP]
> 导入语法常用与导入配置文件，或者导入配置工厂模式类

1. @import("name.class")
2. @Import({"1.class,2.class"})

<details>
<summary>详细语法</summary>

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

</details>

## 自定义注解

> [!TIP]
> 自定义注解可以让多个注解变成你指定的一个注解，在特定场景有用

<details>
<summary>详细语法</summary>

```java
/*? com.name.anno */

@Target(ElementType.TYPE) //类上面声明，还有其他位置，翻译文档
@Retention(RetentionPolicy.RUNTIME) // 运行时保留的注解
@Bean //假设需要调用其他的注解，这里可以声明
public @interface sums {
}
```

</details>

## 自动配置原理

<details>
<summary>原理说明</summary>

`spring-boot` 附带依赖 `autoConfiguration`

而 `spring-boot` 的入口声明自定义注解合并了 `autoconfig` 的启动注解

`autoconfig` 也是个配置类，它使用了注解 `Import` 工厂模式

工厂模式实现了 `ImportSelector` 它这个不可能是写死的导入配置

它将它所支持的包名全部存放在 `autoconfig` 内部的一个 `.imports` 文件中

这里面记录的包名就是它生态链所适配的，在配置工厂返回的包名集合,随后拿去注册 `Bean`

它使用了 `Bean` 注册条件 `ConditionalOnClass` 验证是否存在该字节再去注入

这样如果你构建完成后能找到它适配的字节码，它就能过检查走 `Bean` 注册初始化了

`autoconfig` 注入的有个规范，适配的包里面都有 `名字` + `AutoConfiguration` 的类

这个就是适配自动注入的实现类，这个类有自定义注解，注解同样是配置类

它用它是配置类权限又去 注册它内部的 `Bean` 这就是自动配置的完整逻辑了。

### 第三方实现

`autoConfiguration` 内部的 `Imports` 文件它是在 `resource` < `META-INF` 目录

这个目录也说过它是配置文件的说明文件的目录，似乎是有特殊的特性一样。

好像这个 `META-INF` 下的说明文件同名的是自动追加合并，而不是覆盖和根据父级路径隔开。

就由此特性，让官方写的手动适配的白名单可以被注入进去，你也写它的全称，把自己包名写进入。

全名称: `org.springframework.boot.autoconfigure.AutoConfiguration.imports`

1. 在你的项目的程序位置 `resources` < `META-INF` < `spring` 创建上面的白名单
2. 填写能访问到你的提供自动配置的实现类 关键注解 `@AutoConfiguration`
3. 然后使用 `Import` 工厂模式导入,你项目负责 注册 `Bean` 的配置类来启动你的服务。
4. 工厂模式导入的 `Bean` 是配置类;工厂模式在 `Config` 目录;

面试回答

第一步：

在主启动类上添加了 `SpringBootApplication` 注解  
这个注解组合了 `EnableAutoConfiguration` 注解

第二步：

`EnableAutoConfiguration` 注解 又组合了 `Import` 注解  
导入了`AutoConfigurationImportSelector`类

第三步：

实现 `selectImports` 方法,这个方法经过层层调用,  
最终会 读取META-INF 目录下的 后缀名为 `Imports` 的文件  
当然了 "boot2.7" 以前的版本 读取的是 `spring.factories` 文件

第四步:

读取到全类名了之后,会解析注册条件 也就是 `@Conditional`   
及其行生注解 把满足注册条件的 `Bean` 对象 自动注入到 `I0C` 容器中

</details>

## 自定义 Starter

> [!TIP]
> 独立出去的模块，需要添加很多依赖，它就是用来帮忙注册模块依赖的
>
> starter 也是个 Maven 工程，使用添加 Maven 依赖来启动 starter
>
> starter 里面只需要 pom 文件来添加别的模块，别的依赖通过自动配置来注入

需求：需要能实现 mybatis 功能

需要两个模块 autoconfigure 、 starter

1. 创建新的 maven 模块
2. 再添加格子所需的依赖
3. 实现对应功能整合项目

### autoconfigure 「模块依赖」

<details>
<summary>查看详情</summary>

安装依赖

```text
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter</artifactId>
    <version>3.4.1</version>
</dependency>

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jdbc</artifactId>
    <version>3.4.1</version>
</dependency>

<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.5.17</version>
</dependency>

<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis-spring</artifactId>
    <version>3.0.4</version>
</dependency>
```

配置工厂 注册 Bean 测试一定先确保能使用 「泛型设计」控制器的所有功能

```java
//?这里只是重写了 mybatis-spring-boot-starter 这个依赖，来做演示功能。
@AutoConfiguration
//!它用来帮 mybatis 拿取配置连接属性，还有把他注册成为 Bean
public class mybatisAutoConfig {
    @Bean
    public SqlSessionFactoryBean sqlSessionFactoryBean(DataSource dataSource) {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();

        //?拿取配置文件的数据源，在使用它实例化数据源并注入进容器。
        sqlSessionFactoryBean.setDataSource(dataSource);

        return sqlSessionFactoryBean;
    }

    @Bean
    public MapperScannerConfigurer mapperScannerConfigurer(BeanFactory beanFactory) {
        //?代码方式注入注解 声明开启扫描 Mapper 的地址
        MapperScannerConfigurer mapperScannerConfigurer = new MapperScannerConfigurer();
        //获取Spring提供的配置工厂，拿取里面的第一个Bean，也就是启动配置，并设置它是扫描的地址
        List<String> pages = AutoConfigurationPackages.get(beanFactory);
        String s = pages.get(0);
        mapperScannerConfigurer.setBasePackage(s);

        mapperScannerConfigurer.setAnnotationClass(Mapper.class);
        return mapperScannerConfigurer;
    }
}
```

开启自动配置

1. resources < META-INF < Spring
2. 复制自动注入 Imports 名称，创建文件
3. Idea 外部库 Spring-boot-autoconfigure
4. 找到右键复制，返回目录创建文件。
5. 文件内写入你所配置的工厂路径
6. 防止手写问题，Idea 编辑下右键类名，复制引用

```text
config.mybatisAutoConfig
```

</details>

### Stater

> [!TIP]
> 这个模块只是负责写依赖的，将整个项目所需要的依赖，写入 Pom 就行了

```xml
<!-- 添加你所写的，注入方法拆分成模块的项目 -->
<dependency>
    <groupId>org.Naer</groupId>
    <artifactId>my-spring-boot-starter</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
```

实际项目，导入 Starter pom,starter 负责 自动注入相关的依赖

## mybatis

> [!TIP]
> Mybatis mapper 相关的注解配置等说明

[完整详情](./mybatis.md)

注解集合

| 注解         | 说明     |
|------------|--------|
| Class      | Class  |
| Mapper     | 注入配置   |
| method     | method |
| select     | 查询方法   |
| Insert     | 增加方法   |
| Update     | 修改方法   |
| Delete     | 删除方法   |
| ResultType | 返回类型   |
| results    | 字段映射   |
| params     | params |
| param      | 指定替换   |

1. 方法注解相关括号内指定SQL语句
2. Param 可以省略，但是默认是按照顺序替换
3. `#{}` ：插入替换符 `${}` : 拼接替换符
4. 指定返回值类型，在注解模式默认返回值类型
5. 推荐网站查看语法：[了解详情](https://reurl.cc/mRAxv9)

### 替换符

> [!NOTE]
> 插入替换符会进行运处理，防止SQL注入的问题
>
> 使用$是直接字符串替换的，表名参数化才使用

<details>
<summary>查看代码</summary>

```java

@Select("select * from user where user = #{user} && pwd = #{pwd}")
user getUsers(@Param("user") String user, @Param("pwd") String pwd);
```

</details>

### 字段映射

> [!NOTE]
> 当数据库的列名与pojo名称不一致时，无法正确的转换数据时使用
>
> 推荐使用 Sql 语句的别名 来实现这个功能，原此注解太长

<details>
<summary>查看详情</summary>

```java

@Results({
        @Result(property = "sex", column = "sex", javaType = UserSexEnum.class),
        @Result(property = "userName", column = "user_name")
})
List<User> getUserList();
```

</details>

## api控制器

> [!TIP]
> Api 控制器对参数解析，不同类型请求体的均可注解说明
>
> ModelAttribute 最特殊，他参数只能有一个对象 用 dto 来拿取数据 Getter Setter

| 注解                    | 适用场景             | 支持的Content-Type                                           | 数据绑定方式     | 示例代码片段                                                                   |
|-----------------------|------------------|-----------------------------------------------------------|------------|--------------------------------------------------------------------------|
| **`@RequestParam`**   | 获取URL参数或表单字段     | `application/x-www-form-urlencoded` `multipart/form-data` | 键值对绑定      | `@RequestParam("name") String username`                                  |
| **`@PathVariable`**   | 从URL路径中获取变量      | 无（URL路径部分）                                                | 路径模板匹配     | `@GetMapping("/users/{id}")`<br>`public User get(@PathVariable Long id)` |
| **`@RequestBody`**    | 接收JSON/XML等复杂请求体 | `application/json` `application/xml`                      | 反序列化为对象    | `@RequestBody UserDTO user`                                              |
| **`@ModelAttribute`** | 绑定表单数据到对象（非JSON） | `multipart/form-data` `application/x-www-form-urlencoded` | 字段反射绑定     | `@ModelAttribute UserForm form`                                          |
| **`@RequestHeader`**  | 获取HTTP请求头        | 任意                                                        | 按头名字符串匹配   | `@RequestHeader("User-Agent") String agent`                              |
| **`@CookieValue`**    | 获取Cookie值        | 任意                                                        | 按Cookie名匹配 | `@CookieValue("JSESSIONID") String sessionId`                            |
| **`@RequestPart`**    | 文件上传+表单混合数据      | `multipart/form-data`                                     | 文件与字段分离处理  | `@RequestPart("file") MultipartFile file`                                |
| **`@MatrixVariable`** | 获取URL矩阵参数（特殊格式）  | 无（URL路径中`;`分隔）                                            | 路径参数解析     | `/cars;color=red`<br>`@MatrixVariable String color`                      |

### 特性对比表

| 特性               | `@RequestParam`       | `@RequestBody` | `@ModelAttribute` | `@RequestPart` |
|------------------|-----------------------|----------------|-------------------|----------------|
| **简单类型支持**       | ✔️                    | ❌              | ✔️                | ✔️ (文件+字段)     |
| **复杂对象支持**       | ❌                     | ✔️             | ✔️                | ❌              |
| **文件上传**         | ❌                     | ❌              | ❌                 | ✔️             |
| **JSON/XML反序列化** | ❌                     | ✔️             | ❌                 | ❌              |
| **表单字段绑定**       | ✔️                    | ❌              | ✔️                | ✔️             |
| **默认必填**         | ✔️                    | ✔️             | ✔️                | ✔️             |
| **可选的required**  | ✔️ (`required=false`) | ✔️             | ✔️                | ✔️             |
