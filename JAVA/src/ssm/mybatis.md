# mybatis

> [!TIP]
> Mybatis 是用在帮助配置数据库连接后处的事情
> 他可以自动帮助我们将sql结果存储到 bean 中

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

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">

<configuration>
    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC" />
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://localhost:3306/node"/>
                <property name="username" value="sa"/>
                <property name="password" value="123456"/>
            </dataSource>
        </environment>
    </environments>
            
    <mappers>
        <!-- 一般设计是 一张表一个 mapper url:属性可以通过绝对路径 file:///d:/ -->
        <mapper resource="Mapper.xml"/>
    </mappers>
</configuration>
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
    //获取文件流
    InputStream inputStream = Resources.getResourceAsStream("mybatis-config.xml");
    //方式二获取
//?  ClassLoader.getSystemClassLoader().getResourceAsStream("name.xml");
    
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
    SqlSession sqlSession = sqlSessionFactory.openSession();
    //增加方法，需要对应你Mapper设置的id
    System.out.println(sqlSession.insert("insert"));
    //提交修改
    sqlSession.commit();
}
```

</details>

