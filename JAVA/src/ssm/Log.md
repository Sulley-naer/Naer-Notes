# Log

> [!TIP]
> 日志对于每个编程语言都非常重要，在Java用日志框架非常多，现代化推荐Slf4j的规范

## 依赖

> [!TIP]
> Spring-boot 中自带的Log 就是最优的，可以不用添加

```xml
<dependencys>
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-api</artifactId>
        <version>2.1.0-alpha1</version>
    </dependency>
    <!-- SLF4J 是抽象类，这个是SLF4J的提出者的官方实现类 -->
    <dependency>
        <groupId>ch.qos.logback</groupId>
        <artifactId>logback-classic</artifactId>
        <version>1.5.18</version>
    </dependency>
</dependencies>
```

## 使用

> [!TIP]
> Log 的使用方式都是通用的，其他没有任何不同，不同的实现也有自己的配置，可以自定义显示log信息 线程也支持显示

```java
class demo (){
    // 在所需要输出的类中注册 Log 到类加载器中
    private static final Logger logger = LoggerFactory.getLogger(YourClassName.class);
    
    //在方法中使用即可，因为是静态字段，构建函数当然也可以使用
    private method1(){
        logger.debug("Debug message");  // 用于开发调试时的详细信息
        logger.info("Informational message");  // 正常的信息，通常用来记录程序流
        logger.warn("Warning message");  // 表示潜在的风险
        logger.error("Error message", exception);  // 记录错误信息，通常会带上异常信息
    }
}
```
