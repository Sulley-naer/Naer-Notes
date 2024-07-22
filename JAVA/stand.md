# Java 基础语法

- [Java 基础语法](#java-基础语法)
  - [入口函数](#入口函数)
  - [目录结构规范](#目录结构规范)
    - [构建工具](#构建工具)
  - [高级语法相关 类库 |](#高级语法相关-类库-)
  - [1. 变量](#1-变量)
  - [2. 数据类型 | Model](#2-数据类型--model)
  - [3. 运算符](#3-运算符)
  - [4. 控制语句](#4-控制语句)
  - [5. 数组](#5-数组)
  - [6. 类与对象](#6-类与对象)
  - [7. 接口与抽象类](#7-接口与抽象类)
  - [8. 异常处理](#8-异常处理)
  - [9. 多线程](#9-多线程)
  - [10. 反射](#10-反射)
  - [11. 注解](#11-注解)
  - [12. 泛型](#12-泛型)
  - [13. 枚举](#13-枚举)
  - [14. 输入/输出](#14-输入输出)
  - [15. 语法糖](#15-语法糖)
  - [16. 包](#16-包)
  - [17. 反编译](#17-反编译)
  - [18. 编译](#18-编译)
  - [19. 调试](#19-调试)
  - [20. 单元测试](#20-单元测试)
  - [21. 代码风格](#21-代码风格)
  - [22. 注释](#22-注释)
  - [23. 编码规范](#23-编码规范)
  - [24. 版本控制](#24-版本控制)
  - [25. 设计模式](#25-设计模式)
  - [26. 数据库](#26-数据库)
  - [27. 设计原则](#27-设计原则)
  - [28. 设计模式](#28-设计模式)

## 入口函数

> [!TIP]
> 入口函数是 Java 程序的入口，所有的 Java 程序都必须有一个入口函数。
>
> 并且 java 格式文件名必须与类名相同，并且最外层必须是一个类，**类名必须与文件名相同**。强制`ESmodule`这样理解

Java 程序的入口函数一般是 `main` 方法，它是所有 Java 程序的入口。

```java
public class Main {
    public static void main(String[] args) {
        system.out.println("Hello, world!");
        // your code here
    }
}
```

> 使用 javac 命令编译 Java 源文件，并使用 java 命令运行 Java 程序。

## 目录结构规范

> [!TIP]
> Java 语言的目录结构，必须遵循规范，不使用会导致在 JVM 上无法找到类库。

Java 语言的目录结构：

```text
my-java-project/
├── src/
│   └── main/
│       └── java/
│           └── com/
│               └── example/
│                   ├── App.java
│                   └── utils/
│                       └── Utils.java
│   └── test/
│       └── java/
│           └── com/
│               └── example/
│                   └── AppTest.java
├── lib/
├── bin/
├── build/
├── docs/
└── pom.xml or build.gradle
```

1. main/: 主源代码
   1. java/: Java 源代码
      1. com/example/: 包目录，对应包名 `com.example`
         1. App.java: 主应用程序类
         2. utils/: 工具类包，对应包名 `com.example.utils`
            1. Utils.java: 工具类
2. test/: 测试代码
   1. java/: Java 测试代码
      1. com/example/: 测试类包目录，对应包名 `com.example`
         1. AppTest.java: 测试类
3. lib/: 存放外部库的目录。
4. bin/: 编译输出目录，存放编译后的 `.class` 文件。
5. build/: 构建输出目录。
6. docs/: 文档目录
7. pom.xml 或 build.gradle: 项目构建工具配置文件（分别用于 Maven 或 Gradle）。

### 构建工具

Java 语言的构建工具有两种：Maven 和 Gradle。

- Maven：Apache Maven 是 Java 项目管理工具，它可以自动化构建、依赖管理、项目信息管理等。
- Gradle：Gradle 是基于 Groovy 的项目自动化构建工具，它可以简化构建过程，提升构建效率。

## 高级语法相关 [类库](./Class.md) |

## 1. 变量

变量是程序中用于存储数据的占位符，它可以用来保存各种数据类型的值。

变量的命名规则：

1. 变量名只能包含字母、数字、下划线（\_）、美元符号（$）
2. 变量名不能以数字开头
3. 变量名不能是关键字

## 2. 数据类型 | [Model](./Model.md)

Java 语言支持以下数据类型：

- 整型：byte、short、int、long
- 浮点型：float、double
- 字符型：char
- 布尔型：boolean
- 字符串型：String

## 3. 运算符

Java 语言支持以下运算符：

- 算术运算符：+、-、\*、/、%、++、--
- 赋值运算符：=、+=、-=、\*=、/=、%=
- 关系运算符：==、!=、>、<、>=、<=
- 逻辑运算符：&&、||、!
- 位运算符：&、|、^、~、<<、>>、>>>
- 条件运算符：?:

<details>
<summary>更多运算符</summary>

```java
// 三元运算符
int a = 10 > 5? 10 : 5;

// instanceof 运算符
if (obj instanceof String) {
    // do something
}

// 数组访问运算符
int[] arr = {1, 2, 3};
int num = arr[0];

// 字符串连接运算符
String str = "Hello" + "World";

// 字符串拼接运算符
String str = "Hello" + " " + "World";

// 字符串重复运算符
String str = "Hello" * 3;

```

</details>

## 4. 控制语句

Java 语言支持以下控制语句：

1. if-else 语句

   ```java
   if (condition) {
       // do something
   } else {
       // do something else
   }
   ```

2. switch-case 语句

   ```java
   switch (expression) {
      case value1:
          // do something
          break;
      case value2:
          // do something else
          break;
      default:
          // default action
          break;
   }
   ```

3. for 循环

   ```java
   for (initialization; condition; iteration) {
       // do something
   }
   ```

4. for-each 循环

   ```java
   for (element : array) {
       // do something
   }
   ```

5. while 循环

   ```java
   while (condition) {
       // do something
   }
   ```

6. do-while 循环

   ```java
   do {
       // do something
   } while (condition);
   ```

7. break 语句

   ```java
   for (int i = 0; i < 10; i++) {
       if (i == 5) {
           break;
       }
       System.out.println(i);
   }
   ```

8. continue 语句

   ```java
   for (int i = 0; i < 10; i++) {
       if (i == 5) {
           continue;
       }
       System.out.println(i);
   }
   ```

9. return 语句

   ```java
   public int add(int a, int b) {
       return a + b;
   }
   ```

## 5. 数组

Java 语言支持以下数组：

1. 静态数组

   ```java
   int[] arr = new int[10];     // 声明一个长度为 10 的 int 数组
   ```

2. 动态数组

   ```java
   int[] arr = new int[10];     // 声明一个长度为 10 的 int 数组
   arr[0] = 10;                 // 给数组的第一个元素赋值
   arr[9] = 20;                 // 给数组的最后一个元素赋值
   ```

   ```java
   int[] arr = {10, 20, 30};    // 声明一个包含 3 个元素的 int 数组
   ```

   ```java
   String[] arr = {"Hello", "World"};    // 声明一个包含 2 个字符串的 String 数组
   ```

   ```java
   int[][] arr = new int[2][3];    // 声明一个 2 行 3 列的 int 数组
   ```

   ```java
   int[][] arr = {{1, 2, 3}, {4, 5, 6}};    // 声明一个 2 行 3 列的 int 数组
   ```

   ```java
   int[][][] arr = new int[2][3][4];    // 声明一个 2 行 3 列 4 层的 int 数组
   ```

   ```java
   int[] arr = new int[10];     // 声明一个长度为 10 的 int 数组
   for (int i = 0; i < arr.length; i++) {
       arr[i] = i * 2;           // 给数组的每个元素赋值
   }
   ```

## 6. 类与对象

- 类（Class）：模板，用来创建对象的蓝图。
- 对象（Object）：类的实例，根据类创建的实例称为对象。
- 成员变量（Field）：类中定义的变量，用于存储数据。
- 方法（Method）：类中定义的函数，用于实现功能。
- 构造器（Constructor）：类中用于创建对象的函数。
- 访问控制符（Access Modifier）：public、private、protected。
- 继承（Inheritance）：一个类可以从另一个类继承所有其成员变量和方法。
- 多态（Polymorphism）：同一个方法可以作用于不同的对象，根据对象的实际类型调用不同的方法。
- 封装（Encapsulation）：将数据和方法包装在一起，隐藏内部实现细节。

1. 创建类

   ```java
   public class Person {
       private String name;
       private int age;
       private String gender;

       public Person(String name, int age, String gender) {
           this.name = name;
           this.age = age;
           this.gender = gender;
       }

       public void sayHello() {
           System.out.println("Hello, my name is " + name + " and I am " + age + " years old.");
       }
   }
   ```

2. 创建对象

   ```java
   Person person = new Person("Alice", 25, "Female");
   ```

3. 调用方法

   ```java
   person.sayHello();
   ```

4. 访问成员变量

   ```java
   System.out.println(person.name);
   ```

5. 继承

   ```java
   public class Student extends Person {
       private String major;

       public Student(String name, int age, String gender, String major) {
           super(name, age, gender);
           this.major = major;
       }

       public void study() {
           System.out.println(name + " is studying in " + major + ".");
       }
   }
   ```

6. 多态

   ```java
   public class Animal {
       public void eat() {
           System.out.println("Animal is eating.");
       }
   }
    //Dog 和 Cat 继承 Animal
   public class Dog extends Animal {
       public void bark() {
           System.out.println("Dog is barking.");
       }
   }
    //Cat 继承 Animal
   public class Cat extends Animal {
       public void meow() {
           System.out.println("Cat is meowing.");
       }
   }
   //Main 类
   public class Main {
       public static void main(String[] args) {
           Animal animal = new Dog();
           animal.eat();
           ((Dog) animal).bark();

           Animal cat = new Cat();
           cat.eat();
           ((Cat) cat).meow();
       }
   }
   ```

## 7. 接口与抽象类

## 8. 异常处理

## 9. 多线程

## 10. 反射

## 11. 注解

## 12. 泛型

## 13. 枚举

## 14. 输入/输出

## 15. 语法糖

## 16. 包

## 17. 反编译

## 18. 编译

## 19. 调试

## 20. 单元测试

## 21. 代码风格

## 22. 注释

## 23. 编码规范

## 24. 版本控制

## 25. 设计模式

## 26. 数据库

## 27. 设计原则

## 28. 设计模式
