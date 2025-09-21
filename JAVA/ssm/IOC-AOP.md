# IOC-AOP

> [!TIP]
> Spring 核心实现原理的两个模块，IOC 注入模块，aop 动态代理

## 一、IoC（控制反转）与 DI（依赖注入）

1. IoC 是什么？
   核心思想：将对象的创建、依赖管理和生命周期交给框架（容器）控制，而不是由开发者手动管理（如 new 关键字）。

   传统方式：对象直接依赖其他对象时，需要自己创建和管理依赖，导致代码耦合度高。

   ```java
   // 传统方式：直接依赖具体实现
   public class UserService {
       private UserRepository userRepository = new UserRepository();
   }
   ```

   IoC 方式：对象的依赖由容器注入，开发者只需定义依赖关系。

   ```java
   
   public class UserService {
       // 依赖由容器注入
       private UserRepository userRepository;
   
       // 通过构造函数或Setter注入
       public UserService(UserRepository userRepository) {
           this.userRepository = userRepository;
       }
   }
   ```

2. DI（依赖注入）
   DI 是 IoC 的实现方式：容器通过构造函数、Setter 方法或字段注入依赖。

   Spring 中的实现：
   
   使用 @Autowired 注解自动注入依赖。
   
   通过 XML 配置或 Java Config（@Configuration）定义 Bean 的依赖关系。

3. IoC 容器的核心作用
   管理 Bean：创建、初始化、销毁对象。

   解决耦合：对象只关注接口，不依赖具体实现。
   
   生命周期管理：支持单例、原型等作用域，管理 Bean 的完整生命周期。

4. 代码示例
   ```java

   // 定义接口和实现类
   public interface UserRepository { /* ... */ }
   @Component
   public class JdbcUserRepository implements UserRepository { /* ... */ }

   // 服务类依赖注入
   @Service
   public class UserService {
   private final UserRepository userRepository;
   @Autowired
   public UserService(UserRepository userRepository) {
   this.userRepository = userRepository;
    }
   }
   ```

## 二、AOP（面向切面编程）

1. AOP 是什么？

   核心思想：将横切关注点（如日志、事务、安全）与业务逻辑分离，通过“切面”模块化这些功能。
   
   解决的问题：避免代码重复（如每个方法都写日志代码），提高可维护性。

2. 关键概念

   切面（Aspect）：封装横切功能的模块（如日志切面）。
   
   连接点（Join Point）：程序执行的点（如方法调用、异常抛出）。
   
   通知（Advice）：切面在连接点执行的动作（如方法执行前、后）。
   
   切点（Pointcut）：定义哪些连接点会触发通知（通过表达式匹配）。
   
   织入（Weaving）：将切面代码插入目标对象的过程（编译期、类加载期、运行期）。

3. Spring AOP 的实现

   基于动态代理：

   如果目标对象实现了接口，使用 JDK 动态代理。
   
   如果未实现接口，使用 CGLIB 生成子类代理。
   
   注解驱动：通过 @Aspect, @Before, @After 等注解定义切面。

4. 代码实例
   ```java
   // 定义一个日志切面
   @Aspect
   @Component
   public class LoggingAspect {
   // 定义切点：匹配所有Service层方法
   @Pointcut("execution(* com.example.service.*.*(..))")
   public void serviceLayer() {}
   
       // 前置通知：方法执行前记录日志
       @Before("serviceLayer()")
       public void logBefore(JoinPoint joinPoint) {
           System.out.println("调用方法: " + joinPoint.getSignature().getName());
       }
   }
   ```
   
## 三、IoC 与 AOP 的区别与联系

| 特性   | IoC              | AOP           |
|------|------------------|---------------|
| 关注点  | 	对象创建与依赖管理       | 横切关注点的模块化     |
| 实现方式 | 	容器管理 Bean 的生命周期 | 动态代理或字节码增强    |
| 典型应用 | 	依赖注入、Bean 配置    | 日志、事务、安全、性能监控 |
| 设计目标 | 	降低耦合，提高灵活性      | 代码复用，分离关注点    |

## 为什么需要 IoC 和 AOP？

1. IoC 的优势：

   松耦合：对象依赖接口而非具体实现。
   
   易于测试：依赖可替换为 Mock 对象（如单元测试）。
   
   集中管理：统一配置 Bean 的作用域、初始化逻辑等。

2. AOP 的优势：

   代码复用：避免重复代码（如每个方法都写事务代码）。
   
   业务逻辑纯净：核心代码只关注业务，不被横切逻辑污染。
   
   灵活扩展：通过切面动态添加功能，无需修改原有代码。

## 五、总结

IoC 是 Spring 的基石，通过容器管理对象依赖，实现解耦。

AOP 解决横切关注点的问题，提升代码模块化。

两者协同：IoC 管理对象，AOP 增强对象功能，共同构建灵活、可维护的应用。

如果你有具体场景或更深入的问题，欢迎进一步讨论！ 😊
