# mybatis

> [!TIP]
> Mybatis 是用在帮助配置数据库连接后处的事情
> 他可以自动帮助我们将sql结果存储到 bean 中

<details>
<summary>依赖</summary>

```xml
<project>
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>8.0.33</version>
    </dependency>

    <dependency>
        <groupId>org.mybatis</groupId>
        <artifactId>mybatis</artifactId>
        <version>3.5.17</version>
    </dependency>

</project>
```

</details>

## 配置模式

springContext 一致，通过的是xml配置文件来注册对象

这样的方式非常不方便，后续学习注解模式开发便利。

### 配置文件

> [!TIP]
> 子配置文件尽量存放在配置文件下 mybatis 文件夹内
> 它会生成一堆子配置文件在目录下，查看起来非常混乱

<details>
<summary> 查看配置 </summary>

#### 主配置

主配置文件是配置数据库相关的，连接事务等等

存放在resource目录下就行，主配置不会产生其他文件

<details>
<summary>查看详情</summary>

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!-- XML引入的都是XML文档的限制规范,允许的标签顺序与嵌套关系. -->
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">

<configuration>
    <!-- 插件相关 -->
    <settings>
        <setting name="logImpl" value="LOG4J"/>
    </settings>
    
    <!-- default 表示默认使用的环境id -->
    <environments default="development">
        <!-- id 是区分的不同环境下配置的数据库连接 -->
        <environment id="development">
            <!--
                mybatis 事务管理分两种
                1. JDBC：默认关闭自动提交 开启事务模式，内部自己管理
                2. MANAGED：自己不负责管理了，交给其他人帮忙管理事务，spring
                如果没有人管理，开启MANAGED = 关闭了事务，自动提交语句
            -->
            <transactionManager type="JDBC" />
            <!-- 指定数据库连接池，默认用Java接口规范默认实现类.比如 c390 -->
            <dataSource type="POOLED"><!-- type:[UNPOOLED|POOLED|JUDI] -->
                <!-- UNP:不使用连接池，每次创建新的连接对象 -->
                <!-- POOLED:使用mybatis自带的连接池 -->
                <!-- JNDI:集成第三方的数据连接池 -->
                <property name="driver" value="com.mysql.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://localhost:3306/node"/>
                <property name="username" value="sa"/>
                <property name="password" value="123456"/>
                <!-- 配置不同的连接池，属性需要的不同，这里用的是默认所需的属性 -->
            </dataSource>
            <!-- 
                JNDI 是一个规范，Tomcat 实现了，它是命名目录的接口
                大部分连接池都实现了JNDI都规范，在实现了它规范的对象
                他们之间可以通过JNDI需要通过的连接字符，来找寻特点的对象
                比如c3p0你需要使用JNDI，并且在属性处提供
                datasource 这个属性就是它JNDI中查找字符了 连接池的实现类似线程池
                c3pn 可选的属性 https://mybatis.org/guice/datasources/c3p0.html
                配置方式：https://developer.aliyun.com/article/1138875
             -->
        </environment>
    </environments>
            
    <mappers>
        <!-- 一般设计是 一张表一个 mapper url:属性可以通过绝对路径 file:///d:/ -->
        <!-- <mapper resource="Mapper.xml"/> -->
        <!-- ! 多个mapper 调用指定方法 id* ： mapper < namespace + "." + id -->
    </mappers>
</configuration>
```

</details>

##### 设置选项

> [!TIP]
> mybatis 提供的一些配置信息，包括日志，懒加载，自定义配置工厂

[参考链接](https://mybatis.org/mybatis-3/configuration.html)

```xml
<settings>
    <!-- 选项设置必须在配置连接数据库之前 -->
    <setting name="logImpl" value="LOG4J"/>
    ...
</settings>
```

#### properties

> [!TIP]
> mybatis 与spring一样支持配置文件导入语法

```xml
<!-- 替换符号 ${key} -->
<properties resource="path" url="file:///d:"><!-- 导入外部文件方式，起始目录 resource -->
    <!-- 配置内配置方式 key -> value -->
    <property name="" value="" />
    
</properties>
``` 


#### Mapper

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- Mapper 工厂提供类 {interface} -->
<mapper namespace="org.Naer.map">
    <!--
         ?select 是查询方法
         id 唯一标识符，方法名需一致
         resultType 可指定返回值类型
         内部部分 就是 sql 语句
    -->
    <select id="userList" resultType="list">
        select * from user
    </select>
    <insert id="insert">
        insert into user(user, pwd) values ('123','123');
    </insert>
    <update id="">
        修改
    </update>
    <delete id="">
        删除
    </delete>
</mapper>
```

</details>

### 启动服务

SqlSessionFactoryBuilder --> SqlSessionFactory --> SqlSession

<details>
<summary>查看代码</summary>

```java
public static void main(String[] args) {
    //获取配置文件流
    InputStream inputStream = Resources.getResourceAsStream("mybatis-config.xml");
    //方式二获取
//?  ClassLoader.getSystemClassLoader().getResourceAsStream("name.xml");
    
    SqlSessionFactory sqlSessionFactory = 
            new SqlSessionFactoryBuilder().build(inputStream,"可指定配置连接的环境id");
    
    SqlSession sqlSession = sqlSessionFactory.openSession(/* True 关闭事务，DML操作自动提交修改 */);
    //增加方法，需要对应你Mapper设置的id
    System.out.println(sqlSession.insert("insert"));
    //提交修改
    sqlSession.commit();
}
```

</details>

### 工具类

> [!TIP]
> 通过工具类获取数据源

<details>
<summary> 查看代码 </summary>

#### 手写方式

```java
public class sqlSessionUtil {

    private sqlSessionUtil() throws IOException {
    }

    private static SqlSessionFactory sqlSessionFactory;

    /* 类加载时执行 */
    static {
        /* SqlSessionFactory对象：一个工厂对应一个 environment ,按顺序拿取配置数据源 */
        try {
            sqlSessionFactory = new SqlSessionFactoryBuilder()
                    .build(Resources.getResourceAsStream("mybatis-config.xml"),"可指定配置数据连接环境id");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
    * 获取会话对象
    * @return SqlSession
    * */
    public static SqlSession getSqlSession(){
        return sqlSessionFactory.openSession();
    }
}
```

</details>

### CRUD 「增删改查」

> [!TIP]
> 使用 mybatis 来进行数据库操作

<details>
<summary>查看详情</summary>

#### 增加「动态参数」

配置

```xml
<mapper namespace="org.Naer.map">
    <insert id="insert" >
        <!-- #{}是占位符，用于替换字符的,Map 集合的 key -->
        insert into user(user, pwd) values (#{user},#{pwd});
    </insert>
</mapper>
```

调用

```java
public static void main(String[] args) {
    SqlSession sqlSession = sqlSessionUtil.getSqlSession();
    
    // 方式一通过 Map 集合传入
    Map<String,String> map = new HashMap<>();
    //? key值必须对照你配置文件填写的字符
    map.put("user","zs");
    map.put("pwd","zs");
    //!如果配置了多个mapper 第一个参数 id 需要填写 Mapper 的 namespace + id
    System.out.println(sqlSession.insert("insert",map));
    
    // 方式二：可通过 poJo 对照层传递
    sqlSession.insert("insert",new pojo("ls","ls"));
    //!多mapper  id : Mapper<namespace + "." + id
    
    sqlSession.commit();
    sqlSession.close();
}

@Data /* Lombok 生成Get Set */
class pojo{
    /* 它底层是通过Invoke方法 "Get" + name 来拿取属性值的,Get一定要对应上 */
    private String user;
    private String pwd;
    
    public pojo(String user,String pwd){
        this.user=user;
        this.pwd=pwd;
    }
}
```

#### 删除「动态」

配置

```xml
<mapper>
    <delete id="del">
        delete
        from user
        where id = #{id};
    </delete>
</mapper>
```

调用

```java
public static void main(String[] args) {
    SqlSession sqlSession = sqlSessionUtil.getSqlSession();
    //参数类型是 Obj 它会自动转换的，占位符只有一个时不会对照检查
    System.out.println(sqlSession.delete("del",1));
    //!多mapper  id : Mapper<namespace + "." + id
    sqlSession.commit();
    sqlSession.close();
}
```

#### 修改「动态」

配置

```xml
<mapper xmlns="http://mybatis.org/schema/mybatis-mapper">
    <update id="update">
        update user set user = #{user},pwd = #{pwd} where id = #{id};
    </update>
</mapper>
```

调用

```java
public static void main(String[] args) {
    SqlSession sqlSession = sqlSessionUtil.getSqlSession();
    //参数类型是 Obj 它会自动转换的，占位符只有一个时不会对照检查
    SqlSession sqlSession = sqlSessionUtil.getSqlSession();
    //Map集合方式 , 同样可以使用 pojo 方式,提供 Get
    Map<String,String> map = new HashMap<>();
    map.put("id","52");
    map.put("user","zs1");
    map.put("pwd","zs1");
    sqlSession.delete("del",1);
    //!多mapper  id : Mapper<namespace + "." + id
    System.out.println(sqlSession.update("update",map));
    //提交修改
    sqlSession.commit();
    sqlSession.close();
}
```

#### 查询「单个」

配置

```xml
<mapper>
    <!-- 必须指定查询结果的类型 默认为Obj 推荐指定为pojo 记得复制引用地址！ -->
    <select id="userList" resultType="org.name.pojo.user">
        <!-- !查询结果的列名进行转换提供数据的 数据库列名需要与pojo的属性名一致！ -->
        <!-- 特别是数据库列名一般用下划线分单词，类用驼峰导致对不上，可以用as语句 -->
        select *
        from user where id = #{id}
    </select>
</mapper>
```

调用

```java
public static void main(String[] args) {
    SqlSession sqlSession = sqlSessionUtil.getSqlSession();
    // 查询结果默认Obj类型，可以用 pojo 强制类型转换,推荐额外配置单查询并且指定类型
    user o = sqlSession.selectOne("userList", 30);
    //!多mapper  id : Mapper<namespace + "." + id
    System.out.println(o);
    sqlSession.close();
    
}
```

#### 查询「多条」

```xml
<mapper xmlns="http://mybatis.org/schema/mybatis-mapper">
    <!-- 同样记得填写类型 -->
    <select id="userList" resultType="org.Naer.pojo.user">
        select *
        from user
    </select>
</mapper>
```

```java
public static void main(String[] args) {
    SqlSession sqlSession = sqlSessionUtil.getSqlSession();
    //集合填写泛型,就能自动强转了,map集合,很少使用,用也没意义
    List<user> o = sqlSession.selectList("userList");
    //!多mapper  id : Mapper<namespace + "." + id
    o.forEach(System.out::println);
    
    sqlSession.close();
}
```

</details>

## 日志集成

> [!TIP]
> `Logback`日志框架实现了`slf4j`的标准

```xml
<!-- Ctrl + Shift + M 搜索结果第一个 -->
<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>1.5.15</version>
</dependency>
```

### 配置文件

<details>
<summary>完整查看</summary>

存放于resource目录下自动查找

文件名：logback.xml logback-test.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>

<configuration debug="false">
    <!-- 调试输出 -->
    <appender name="STDOUT" class="ch.gos.logback.core.ConsoleAppender">
        <encoder class="ch.gos.logback.classic.encoder.PatternLayoutEncoder">
            <!--格式化输出:%d表示日期，%thread表示线程名，%-5evel:级别从左显示5个字符宽度%ms9:日志消息，%n是换行符-->
            <pattern>%d{yyyy-MM-dd HH:mm:ss.sss} [%thread]%-5level %logger{50}-%msg%n</pattern>
        </encoder>
    </appender>
    <!--按照每天生成日志文件 -->
    <appender name="FILE" class="ch.gos.logback.core.rolling.RollingFileAppender">
        <rollingPolicy class="ch.gos.logback.core.rolling.TimeBasedRollingPolicy">
            <!--日志文件输出的文件名-->
            <FileNamePattern>${L0G_HOME}/TestWeb.log.%d{yyyy-MM-dd}.log</FileNamePattern>
            <!--日志文件保留天数 -->
            <MaxHistory>30</MaxHistory>
        </rollingPolicy>
        <encoder class="ch.gos.logback.classic.encoder.PatternLayoutEncoder">
            <!--格式化输出:%d表示日期，%thread表示线程名，%-5level:级别从左显示5个字符宽度%ms9:日志消息，%n是换行符-->
            <pattern>%d{yyyy-MM-dd HH:mm:ss.sss} [%thread]%-5level %logger{50}- %msg%n</pattern>
        </encoder>
        <!--日志文件最大的大小-->
        <triggeringPolicy class="ch.gos.logback.core.rolling.SizeBasedTriggeringPolicy">
            <MaxFileSize>100MB</MaxFileSize>
        </triggeringPolicy>
    </appender>

    <!--mybatis log configure-->
    <logger name="com.apache.ibatis" level="TRACE"/>
    <logger name="java.sql.Connection" level="DEBUG"/>
    <logger name="java.sql.Statement" level="DEBUG"/>
    <logger name="java.sql.PreparedStatement" level="DEBUG"/>

    <!-- 日志输出级别,logback日志级别包括五个:TRACE<DEBUG<INFO< WARN< ERROR -->
    <root level="DEBUG">
        <appender-ref ref="STDOUT"/>
        <appender-ref ref="FILE"/>
    </root>

</configuration>
```

</details>

