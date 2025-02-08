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
       
       <!-- mapper 多个配置属性
            class 全限定类名地址
            url file:///d: 绝对路径方式
            resource: 类加载路径 resources 拼接
          ! Resource 与 Java 两个目录都是开发时独有的 Maven 自动移动内部文件至上级
        -->
    </mappers>
</configuration>
```

</details>

#### 设置选项

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
> mybatis 与spring一样支持配置文件导入语法,设置之前配置

<details>
<summary>查看详情</summary>

```xml
<!-- 替换符号 ${key} -->
<properties resource="path" url="file:///d:"><!-- 导入外部文件方式，起始目录 resource -->
    <!-- 配置内配置方式 key -> value -->
    <property name="" value="" />
    
</properties>
``` 

</details>

#### Mapper

<details>
<summary>查看详情</summary>

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

    //服务器只能存在的一个 sessionFactory
    private static SqlSessionFactory sqlSessionFactory;

    /* 类加载时执行 */
    static {
        /* SqlSessionFactory对象：一个工厂对应一个 environment ,按顺序拿取配置数据源 */
        try {
            sqlSessionFactory = new SqlSessionFactoryBuilder()
                    .build(Resources.getResourceAsStream("mybatis-config.xml"), "可指定配置数据连接环境id");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /*
     * Local 本质就是 线程的 Map 集合
     * key 就是 Thread.current()
     * 一个线程只能存储一个值，一个线程get出来的结果也只能是它
     * 一开始没给值,必须手动set提供，不然出来是null
     * 不直接使用 静态域的原因：线程对应单独的事务,全部共享一个不安全
     * */
    private static ThreadLocal<SqlSession> local = new ThreadLocal<>();

    /**
     * 获取会话对象
     * @return SqlSession
     * */
    public static SqlSession getSqlSession() {
        SqlSession sqlSession = local.get();
        if (SqlSession == null) {
            sqlSession = sqlSessionFactory.getSqlSession();
            //绑定到当前线程上
            local.set(sqlSession);
        }
        return sqlSession;
    }

    public static void close(SqlSession sqlSession) {
        if (sqlSession != null) {
            sqlSession.close();
            //移除对象和当前线程绑定
            local.remove();
        }
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

### 记录条数

```xml
<mapper xmlns="http://mybatis.org/schema/mybatis-mapper">
    <!-- 同样记得填写类型 -->
    <select id="userTotal" resultType="org.Naer.pojo.user">
        select count(*)
        from user
    </select>
</mapper>
```

### 自动生成

> [!TIP]
> Mybatis 通过接口来生成 CRUD 代码，实现了重复的书写 CRUD 代码
> 
> 学到这里很快进入注解开发模式，省略了代码演示直接说明原理

```java
public static void main(String[] args) {
   SqlSession sqlSession = SqlSessionUtil.openSession;
   //传递接口 获取自动实现 对象调用方法
   sqlSession.getMapper(Mapper.class);
}
```

</details>

原理：使用了 `javassist` **面向切片编程** 运行时生成类并 注入字节码

有字节码后再反射的方式拿取实例化对象，实现了运行时生成类并实例化

再规范你接口的定义，返回值 -> 类型 名称 -> id 找到 Mapper 配置项

根据配置项的标签 select del update ... 选择方法体模板 后枚举记录

实现了全部接口定义的方法 : 方法名 -> ID 找到`配置项` 选择方法体模板  

通过 javassist 初始化的类 实现接口 插入方法代码 生成字节码并注入内存

class 反射 -> 包路径 + 指定类名 调用无参构造拿取实例 强转为接口类型返回

实现了我们定义接口 它生成了实现类 通过接口来调用它实现类的方法。

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

## 动态SQL

> [!TIP]
> 动态SQL是用在 SQL 语句需要根据 传入的参数 来生成不同的条件
> 
> 比如：商城中的商品筛选，时间 类型 根据参数熟练来追加 where

### 配置文件

> 使用配置文件的方式来使用动态SQL

<details>
<summary>查看详情</summary>


```xml
<select  id="select" rusuleType="class">
   <!--
    根据 test 来 拼接 SQL
   !test 填写 @param 根据参数判断 未指定名称用默认名称 arg数字
   ?也可以使用 POJO 类 连接语句需要修改 & -> and | -> or
    pojo != null and arg != ''
   -->
   select * from table where 1 = 1
   <if test="true">
       and column = #{param}
   </if>
</select>
```

</details>

#### 实用标签

> [!TIP]
> 使用 where 标签来管理条件语句,智能处理连接等问题 支持动态语句

##### 智能条件

<details>
<summary>查看详情</summary>

```xml
<select  id="select" rusuleType="class">
   select * from table <!-- 不要给 where 了 使用 where 连接性标签会自动追加 -->
   <!--? 可选使用 where 标签来管理条件语句,智能处理也支持动态语句 -->
   <where>
      <!-- 末尾 and 或者 or 智能移除 -->
      <if test="true">
         column = #{param} and
      </if>
   </where>
</select>
```

</details>

##### 智能修改

> [!TIP]
> 使用动态SQL来处理修改语句，自动删除末尾 `,` 防止语句异常

<details>
<summary>查看详情</summary>

```xml
<update id="name">
   update table
   <set>
      <!-- 如果有数据 SQL 必然会以 `,` 结尾 自动修复 测试不会异常   -->
      <if test="param != null">
         column = #{param},
      </if>
      <if test="param2 != null">
         column2 = #{param2},
      </if>
   </set>
   where id = #{id}
</update>
```

</details>

##### trim ：通用

> [!TIP]
> trim 格式化字符,同样是管理动态SQL字符串的处理好手 不能与其他 智能连接性标签 同时使用
>
> 需要搭配 IF 语句使用,不然是无法触发添加前缀 他需要有一个if 成立才使用

<details>
<summary>查看详情</summary>

```xml
<select id="name">
   <!--
        prefix: 前缀
        suffix: 后缀
        prefixOverrides: 删除前缀
        suffixOverrides: 删除后缀
   -->
   select * from table
   <trim prefix="where" suffixOverrides="and | or">
      <!-- 添加 where 拼接 删除最后的 and 或者 or 字符 -->
      <if test="true">
         and column = #{param}
      </if>
   </trim>
</select>
```

</details>

##### 智能判断

> [!TIP]
> 用来解决 if 标签的单一化，增加 if-else 的语法 

<details>
<summary>查看详情</summary>

```xml
<select>
   select * from table
   <where>
      <!-- 判断语句标签范围 两个标签都需要使用 强制 if 必须有 else -->
      <choose>
         <when test="1 = 1"><!-- if(1=1) -->
            age > 18 and
         </when>
         <when test="1 != 1"> <!-- if(1!=1) -->
            age != 18 and
         </when>
         <otherwise><!-- else -->
            1 = 1
         </otherwise>
      </choose>
   </where>
</select>
```

</details>

##### 智能循环

> [!TIP]
> Foreach 循环遍历传入数组 并生成语句 实现批量删除 批量增加同理

<details>
<summary>查看详情</summary>

```xml
<!--
    collection: 数组或者集合 -> 传入的数组 @param 名字 
    item: 元素 -> 指向当前次数对象
    separator: 循环分隔符 -> and | or | ,
    循环分隔符 -> 循环每次完成后追加的字符
    open: 自定义首字符 (
    close: 自定义结束符 )
-->
<delete id="name">
   delete from table where id in(
    <foreach collection="arg" item="id" separator=",">
       #{id}<!--? 手动加 `,` 会导致最后的字符是连接符 , separator 自动处理最后一个 -->
    </foreach>
   )
   
   批量插入演示语句
   
   insert into t_user(id,name,age) values(1,'zs',20),(2,'zs',20),(1,'zs',20)
</delete>
```

</details>

##### 语句模板

> [!TIP]
> 一条SQL多地方使用 提取为模板 方便复用 本质复制粘贴字符

<details>
<summary>查看详情</summary>

```xml
<!-- 转换别名 -->
<sql id="sql">
   id,
   name as user
</sql>
```

```xml
<select id="name">
   select <include refid="sql"/>
   from table
</select>
```

</details>

### 注解模式

> [!TIP]
> 注解模式与配置文件方式没有变化 使用注解传入配置

<details>
<summary>查看详情</summary>

XML 模式
 
```xml
<delete id="deleteByIds">
   delete from table where id in(
    <foreach collection="ids" item="id" separator=",">
       #{id}
    </foreach>
   )
</delete>
```

注解模式

```java
@Mapper
public interface YourMapper {
    // <script> 必须包在标签内,不然无法访问到配置容器对象 id 等
    @Delete("<script>" +
            "delete from table where id in (" +
            "<foreach collection='ids' item='id' separator=','>" +
            "#{id}" +
            "</foreach>" +
            ")" +
            "</script>")
    int deleteByIds(@Param("ids") List<Integer> ids);
}
```

</details>

## 通用

### 数据库列别名

> [!TIP]
> 解决pojo类属性字段与数据库列字段名称不一致的问题
> 
> 方式一：数据库命令使用 as 语句来实现

#### 方式二 配置文件 自定义

<details>
<summary>查看详情</summary>

配置

```xml
<!-- id -> 数据库对应类型 id  type -> 绑定的 pojo 类  -->
<resultMap id="name" type="">
   <!-- 数据库唯一标识符 提高效率 -->
   <!-- property -> pojo 属性名称 column -> 数据库列名 -->
   <id property="id" column="id" />
   <!-- 普通的列配置对应关系 -->
   <result property="name" column="user"/>
   <result property="pwd" column="password"/>
</resultMap>
```

使用

```xml
<select id="id" resultType="自定义别名类型的 id">
 sql * from pojo
</select>
```

</details>

### 方式三 自动命名规范转换

Java 属性字段 -> 小驼峰 : 首字母小写 单词大写隔开 userName

SQL 列名规范 -> 全字母小写 单词间用 `_` 隔开 user_name

```xml
<settings>
   <setting name="mapUnderscoreToCameCase" value="true" />
</settings>
```

### 占位符

> [!TIP]
> mybatis 有两种占位符方式 `${}` `#{}`

- `${}` 部分的填充内容是直接进行 sql 拼接,会出现 sql 注入的风险! **日期分表时验证后使用**
- `#{}` 部分的填充内容预处理强制包裹在引号里面 : 'text'; sql 非引号语句 无法使用

### 别名

> [!TIP]
> 别名用于简化配置返回值类型等 需要写全限定类名地址的 : 不区分大小写

#### 配置

<details>
<summary>查看详情</summary>

```xml
<!-- properties 之后 -->
<typeAliaes>
   <!-- alias 可省略 默认最后一节的名称 -->
    <typeAlias type="com.name.pojo.user" alias="name" />
   <!-- 自动别名 此目录下的类全部用类名当作别名 -->
   <package name="org.Naer.mapper"/> <!--! Mapper 配置文件的XML -->
</typeAliaes>
```

</details>

#### 注解

> [!NOTE]
> 注解模式别名需要配置类似 mapScan 注解扫描目录,需要使用的都必须都在一个包下面
> 
> 注解模式的别名没有自动配置的注解，只能通过扫描路径 + Alias 注解声明

<details>
<summary>查看详情</summary>

##### 扫描配置

1. 方式一 Properties 文件指定 「推荐」

    ```properties
    mybatis.type-aliases-package=com.name.pojo
    ```

2. 方式二 工厂初始化时候指定

    ```java
    @Configuration
    public class MyBatisConfig {
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        sessionFactory.setTypeAliasesPackage("com.name.pojo"); // 指定别名扫描包
        return sessionFactory.getObject();
        }
    }
    ```

#### 实体类注解

```java
/* 必须在扫描路径下的才会正确设置别名 */
package com.name.pojo;

@Alias("name") // 定义别名
public class User {
    // 类的字段和方法
}
```

</details>

## 高级映射

> [!TIP]
> 高级映射：把数据库的表直接的映射关系 Java 通过映射对象 可以访问被映射对象的数据

### 选项

#### 全局懒加载

```xml
<settings>
   <setting name="lazyLoadingEnabled" value="true" />
</settings>
```

### 多对一

> [!NOTE]
> 多对一指代 数量多的表去映射单一的表 比如: 学生表与班级表的关系 学生绑定其一班级

<details>
<summary>查看详情</summary>

#### 常规方式

```xml
<!-- 定义查询关系 -->
<resultMap id="stu" type="student">
   <!-- 方式一：属性存储 -->
   
   <!-- 主键 索引效率 -->
   <id property="id" column="id" />
   <!-- 指定查询结果的列存储属性 -->
   <result property="name" column="name" />
   <result property="class" column="class" />
   <!-- 利用连接查询实现存储老师 -->
   <result property="teacher" column="teacher" />
   
   <!-- 方式二：对象存储 -->
   <!--
        association: 关联标签
        property: 指定存储的属性名称
        javaType: 指定存储属性的类型
        !这个方式存储是对象 不是属性
   -->
   <association property="class" javaType="class">
      <!-- 这里面写存储属性 查询关系 -->
      <id property="cid" column="cid" />
      <result property="teacher" column="teacher" />
   </association>
</resultMap>
```

```xml
<!-- 使用指定关系,存储绑定对象 -->
<select id="name" rusultMap="stu">
   select 
        <!--! 连接查询记录所需数据 -->
        s.id,s.name,s.class,b.teacher,b.cid
   from 
        <!--? 班级外键关系找到映射 -->
        student s left join class b on s.class = b.class
   where
        s.id = #{id}
</select>
```

#### 推荐方式

> [!TIP]
> 分步查询、可复用、支持懒加载
> 
> 隐形式 懒加载 实用舒适 
 
步骤:

1.   查询学生
2. 存储学生信息
3. 发现关联查询
4. 调用实现方法
5. 结果返回关联
6. 关联进行映射
7. 赋值指定属性

映射关系：

```xml
<resultMap id="Step" type="student">
   <id property="id" column="id" />
   <result propertype="name" column="name" />
   <!--? 指定第二条SQL语句 id 来获取数据存储 column 提供参数 --> 
   <!--? fetchType: Lazy|eager 懒加载 推荐全局 **动态代理** 实现 -->
   <association property="class" select="Select2" column="cid" fetchType="lazy" >
      <id property="cid" column="cid" />
      <result propertype="teacher" column="teacher" />
   </association>
</resultMap>
```

查询语句

```xml
<!-- 调用测试 -->
<select id="Select1" rusultMap="Step">
   select id,name from student where id = #{id}
</select>
```

```xml
<!--! 记得接口实现 没有实现不能执行 -->
<select id="Select2" resultType="class" >
   select cid,teacher from class where cid = #{cid}
</select>
```

</details>

### 一对多

> [!TIP]
> 一对多 数量少的关联绑定多的 比如 班级表与学生表的关系 班级被学生关联

<details>
<summary>查看详情</summary>

#### 常规方式

collection:

```xml
<resultMap id="stu" type="student">
   <!-- 主键 索引效率 -->
   <id property="cid" column="cid" />
   <result property="class" column="class" />
   <result property="teacher" column="teacher" />
   <!-- collection -> 集合存储对象 -->
   <collection property="studentList" ofType="student">
      <id property="id" column="id" />
      <result property="name" column="name"/>
   </collection>
</resultMap>
```

```xml
<!-- 使用指定关系,存储绑定对象 -->
<select id="name" rusultMap="stu">
   select 
        <!--! 连接查询记录所需数据 -->
        c.cid,c.class,c.teacher,b.name,b.id
   from 
        <!--? 班级外键关系找到映射 -->
        class c left join student b on c.class = b.class
   where
        c.cid = #{cid}
</select>
```

#### 推荐分步

> [!TIP]
> 步骤与多对一是一致的，查询步骤都需要有 Mapper 引用

```xml
<select id="selectByStep" rusultMap="SelectStep">
   select cid,name from class where cid=#{cid}
</select>
```

```xml
<!--! 一定有 Mapper 引用 让它生成方法 -->
<select id="selectByStep2" rusultMap="SelectStep">
   select * from student where cid=#{cid}
</select>
```

```xml
<rusultMap id="SelectStep" type="class">
   <id property="cid" column="cid"/>
   <rusult property="name" column="name" />
   <!-- 存储字段 查询id 传递参数 集合存储对象 -->
   <collection property="studentList" select="selectByStep2" column="cid"/>
</rusultMap>
```

</details>

## 缓存

> [!TIP]
> Mybatis使用缓存保存数据 提高性能效率 自动处理过期 默认开启

一级缓存：sqlSession -> sql语句(select)
二级缓存：sqlSessionFactory -> 数据库 

### 一级缓存

> [!NOTE]
> 一级缓存会记录所有的查询 sql 语句 记录返回值

同一条语句 执行两次可以通过 日志看到没有发送

失效条件 数据库表格更新 增删改 系列缓存失效

手动失效 `sqlSession.clearCache()`

### 二级缓存

> [!NOTE]
> 二级缓存是将数据库缓存 pojo 类需要可序列化
>
> 二级无法与一级同时使用 二级须关闭 SqlSession
> 
> 关闭一级缓存 `sqlSession.close()`

可序列化 -> 实现接口 `Serializable`

<details>
<summary>开启方式</summary>

```xml
<!-- 全局开启 -->
<settings>
   <setting name="cacheEnabled" value="true" />
</settings>
```

```xml
<!-- 开启 -->
<cache/>
```

存储方式：一级缓存关闭后 将内部的缓存移植到二级中

没有关闭一级缓存时 优先使用一级缓存来获取数据

</details>

#### 配置

| 属性            | 值                  | 说明        |
|---------------|--------------------|-----------|
| flushInterval | ms:time int        | 过期时间      |
| size          | int                | 缓存大小      |
| eviction      | LRU、FIFO、SOFT、WEAK | 淘汰算法      |
| readOnly      | boolean            | 关闭:返回对象克隆 |

### 三方缓存

> [!TIP]
> Mybatis 支持使用第三方的缓存工具 一级缓存是无法取代 可以优化二级缓存

<details>
<summary>查看演示</summary>

#### Ehcache

一.依赖

```xml
<dependency>
   <groupId>org.mybatis.caches</groupId>
   <artifactId>mybatis-ehcache</artifactId>
   <version>1.3.0</version>
</dependency>
```

二.配置文件

```xml
<!-- ehcache.xml -->
<diskStore path="e:/ehcache" /> <!-- 磁盘存储 -->
```

</details>

## 注解模式

> [!TIP]
> 如果使用的是 Spring-Boot 使用 @Resource 注入提供，不用额外调用初始化方法

### Mapper「接口」

| 注解              | 说明              |
|-----------------|-----------------|
| ---Interface--- | ---Interface--- |
| Mapper          | 自动实现            |
| ---method---    | ---method---    |
| select          | 查询方法            |
| Insert          | 增加方法            |
| Update          | 修改方法            |
| Delete          | 删除方法            |
| ResultType      | 返回类型            |
| results         | 字段映射            |
| ---params---    | ---params---    |
| param           | 占位对象            |

> [!TIP]
> 注解模式直接使用的接口生成代码，但是需要注解声明是生成的类型

<details>
<summary>查看详情</summary>

```java
/* 注解模式 声明Map类 spring 需配置扫描软件包路径 */
@Mapper
// ? 自定义别名映射
@Result({
        @Result(property = "id",column = "id"),
        @Result(property = "user",column = "student_name")
})
public interface usermap {
    /* 简单的语句可以不用在 xml 书写,script标签允许使用访问配置文件变量 */
    @Select("<script> select * from user where user = #{user} && pwd = #{pwd}</script>")
    user getUsers(@Param("user") String user, @Param("pwd") String pwd);
}
```

</details>

### 使用

| 注解               | 说明           |
|------------------|--------------|
| ---Mapper---     | ---Mapper--- |
| selectOne        | 查询单个结果       |
| select           | 查询多个结果       |
| Insert           |              |
| Update           | 修改方法         |
| Delete           | 删除方法         |
| ResultType       | 返回类型         |
| results          | 字段映射         |

<details>
<summary>查看详情</summary>


```java
@Resource /* Spring 注入实现的 Mapper 不然使用 session.getMapper(map.class) 获取 */
private usermap map;

@Override
public boolean getUser(String user, String pwd) {

    user res = map.getUsers(user, pwd);

    return res != null;
}
```

</details>

## 自动生成

> [!TIP]
> 利用 Mybatis 数据库生成的插件来省略写 mapper 系列的繁琐部分

Idea > 插件 > MyBatisCodeHelperPro

Idea > 数据库 > 表格 > 右键 > Mybatis multiple table generate

## 分页查询

> [!TIP]
> 通过 LIMIT 偏移实现分页 (page - 1) * pageSize -> 0
> TAKE 拿取的条数 pageSize -> 10
> 
> SQL ： select * from table limit 0,10

### 分页插件

> [!TIP]
> 分页插件可以让我们无视分页的步骤，直负责提供查询的方法就行了

<details>
<summary>代码演示</summary>

pom.xml

```xml
<!-- mybatis 单独使用版 -->
<dependency>
   <groupId>com.github.pagehelper</groupId>
   <artifactId>pagehelper</artifactId>
   <version>6.1.0</version>
</dependency>
```

```xml
<!-- spring-Boot -->
<dependency>
   <groupId>com.github.pagehelper</groupId>
   <artifactId>pagehelper-spring-boot-starter</artifactId>
   <version>2.1.0</version>
</dependency>
```

Mybatis-config

```xml
<!-- spring 无视 -->
<plugins>
   <plugin interceptor="com.github.pagehelper" />
</plugins>
```

```java
//? 调用 mapper 查询前设置好就行了
@Test
public void SessionTest() {
   SqlSession sqlSession = sqlSessionUtil.getSqlSession();
   PageHelper.startPage(0, 2);
   /* ? 自己调用测试 */ 
}
```

springBoot

```java
/* !排除 mybatis 自动注入 用 pagehelper 的注入 */
@SpringBootApplication(exclude = mybatisAutoConfig.class)
@MapperScan("org.Naer.mapper")
public class application {
    public static void main(String[] args) throws IOException {
        SpringApplication.run(application.class, args);
    }
}

/*
 异常显示 两个 bean 不要排除 pagehelper 的 不然无法拦截查询请求分页功能失效
 file [D:\小米云盘\桌面\JAVA\study\target\classes\org\Naer\mapper\UserMapper.class] required a single bean, but 2 were found:
	- sqlSessionFactory: defined by method 'sqlSessionFactory' in class path resource [org/mybatis/spring/boot/autoconfigure/MybatisAutoConfiguration.class]
	- sqlSessionFactoryBean: defined by method 'sqlSessionFactoryBean' in class path resource [config/mybatisAutoConfig.class] 
  
 */
```

```properties
pagehelper.helperDialect=mysql
pagehelper.reasonable=true
pagehelper.supportMethodsArguments=true
pagehelper.params=count=countSql
```

```java
@Override
public List<User> findAll(int page, int size) {
    /* 在使用查询前修改即可 */
   PageHelper.startPage(0, 2);
   List<User> users = userMapper.selectAll();
   return new PageInfo<>(users); /* 还可以再给一个 int 参数 获取自定义页数的详情信息 */
   /*? pageInfo 可以查看pageHelper的其他参数 最重要 count 总数量 是否最后一页等等  */
}
```

</details>

## 原理

### Param

> [!NOTE]
> 底层里面 Param 本质都是一个 Map 集合
> 
> 占位符 -> map.put("arg0","user") map.put("param0","name")
> 
> 自动生成的实现类会把参数存储后填充 map.put("param0",text)
