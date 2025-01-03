# Spring

预学习阶段，我们需掌握的配置与结构，开发理念。

![Spring 体系图](./images/Idea/pre-Study-1735895529137.png)

我们先学习 Spring 容器部分

## GetStand

> Spring 快速入门

Spring 开发步骤

1. 导入 Spring 开发的依赖包坐标
2. 编写 Dao 接口与实现类
3. 创建 spring 核心配置文件
4. 在 Spring 配置文件中获得 UserDaoImpl
5. 使用 Spring 的 API 获得 Bean 实例{反射实现}

依赖资源

```xml

<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>6.2.1</version>
</dependency>
```

定义接口

```java
package com.Naer;

public interface UserDao {
    void run();
}
```

主程序 `resources` 配置路径下 右键新建 < xml < spring 配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- 推荐约定俗成命名 applicationContext  -->

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
    <!-- 添加你的主程序所需 Bean -->
    <bean id="UserDao" class="com.Naer.Demo"/>
</beans>
```

主程序 | bean

```java
public class Demo implements UserDao {
    public static void main(String[] args) {
        //主程序调用 Spring 读取配置文件
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        //根据配置文件，反射拿取到 Bean
        UserDao userDao = app.getBean(UserDao.class);
        //调用方法,入口函数是静态的，调用的是动态实例化的方法。
        userDao.run();
        //运行直接当前文件，或者Idea main 方法有个按钮点击
    }

    public String say(String name) {
        return "hello " + name;
    }

    @Override
    public void run() {
        System.out.println("Running");
    }
}
```

## Spring Config

### Bean

> 配置项目所需的 Java Bean 对象，可由 Spring 进行管理的形式

```xml

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="UserDao" class="com.Naer.Demo" scope=""/>
</beans>
``` 

spring 挂载 Bean 实现类不是接口
id是Bean的标识符, Get 获取需要根据Id同名的 class 对象。  
默认实例化 Class 方式调用 Instance 方法，只能通过无参构造。

init-method： 指定 Bean 初始化的调用的方法

destroy-method : 指定 Bean 被销毁时调用方法

测试直接关闭实例化出来的配置文件 close 方法。

#### 指定获取 Bean 方式

class: 反射方式获取Bean对象 

指定对象字节码地址，通过此地址访问并反射调用 无参构造，返回此 Bean

factory-method : 静态工厂「静态工厂 获取对象」

拥有此属性，反射获取到指定对象后，再去调用对象中指定静态方法去获取Bean。

factory-bean : 动态工厂「动态工厂 获取对象」

自动实例化一个配置的工厂，返回这个工厂对象，使用时调用工厂方法获取 Bean

factory-method「动态工厂 获取对象」

绑定动态工厂，在动态工厂被实例化后，直接调用工厂内部的指定方法来获取 Bean

#### 范围限制

scope 可选范围：

1. singleton : 默认 单列模式
2. prototype : 多例的
3. request : WEB 项目中，Spring创建一个Bean 的对象，将对象存入到 request 域中
4. session : WEB项目中，Spring创建一个Bean的对象，将对象存入到 session 域中
5. global session : WEB项目中，应用在Portlet环境
   如果没有 Portlet 环境那么 globalSession 相当于session


