# Java 基础语法

- [Java 基础语法](#java-基础语法)
  - [入口函数](#入口函数)
  - [项目构建](#项目构建)
    - [Java 语言的构建工具有两种：Maven 和 Gradle](#java-语言的构建工具有两种maven-和-gradle)
    - [Project](#project)
    - [Package「项目结构」](#package项目结构)
  - [目录结构规范](#目录结构规范)
  - [高级语法相关 类库 |](#高级语法相关-类库-)
  - [Class](#class)
    - [语法](#语法)
  - [1. 变量](#1-变量)
  - [2. 数据类型 | Model](#2-数据类型--model)
  - [3. 运算符](#3-运算符)
  - [4. 控制语句](#4-控制语句)
  - [5. 数组](#5-数组)
  - [6. 类与对象](#6-类与对象)
  - [7. 接口与抽象类](#7-接口与抽象类)
  - [8. 多态](#8-多态)
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

## 项目构建

> [!TIP]
> 创建项目的基础，Java 编辑器请选择 Idea
>
> IDea 菜单栏>文件>项目结构>模块中勾选想要的项目预设

### Java 语言的构建工具有两种：Maven 和 Gradle

- Maven：Apache Maven 是 Java 项目管理工具，它可以自动化构建、依赖管理、项目信息管理等。
- Gradle：Gradle 是基于 Groovy 的项目自动化构建工具，它可以简化构建过程，提升构建效率。

### Project

> [!TIP]
> Idea 会自动打开上次的项目，可去菜单栏点击关闭项目，打开项目目录
>
> 管理你的项目或者添加项目，它自带一些模板快速构建项目录 插件可添加，也可以创建空目录自己创建项目。
>
> IDea 可以在注释首字母输入 **TIP** 再通过左测行位置点击即可切换 具有 UI 的注释
>
> ![comment](./images/UICommont.png)

### Package「项目结构」

> [!TIP]
> 包是 Java 语言的组织结构，它是 Java 项目的基本单元、通常存放于 src 目录下。
>
> 项目结构：
>
> IDea 中直接右键你所需要创建的目录下，新建>新建软件包，注意包的命名通过 `.` 分割 每一个 `.` 代表一个层级，它会不同层级生成不同的目录。三层就有三个文件夹

包的命名规则：

1. 包名只能包含字母、数字、下划线（\_）、美元符号（$）
2. 包名不能以数字开头
3. 包名不能是关键字

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
      1. com/example/: 包目录，对应包名 `com.example` 命名通常是域名反写
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

## 高级语法相关 [类库](./Class.md) |

## Class

> [!TIP]
> 类是 Java 语言的基本单位，它包含成员变量、方法、构造器、访问控制符、继承、多态等。

类（Class）：模板，用来创建对象的蓝图。

类是 Java 语言的基本单位，它包含成员变量、方法、构造器、访问控制符、继承、多态等。

类可以包含以下元素：

- 成员变量：类中定义的变量，用于存储数据。
- 方法：类中定义的函数，用于实现功能。
- 构造器：类中用于创建对象的函数。
- 访问控制符：public、private、protected。
- 继承：一个类可以从另一个类继承所有其成员变量和方法。
- 多态：同一个方法可以作用于不同的对象，根据对象的实际类型调用不同的方法。
- 封装：将数据和方法包装在一起，隐藏内部实现细节。

### 语法

<details>
<summary>类语法</summary>

1. 构造器（Constructor）

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
   }
   ```

2. 方法（Method）

   ```java
   public class Person {
       private String name;
       private int age;
       private String gender;

       public void sayHello() {
           System.out.println("Hello, my name is " + name + " and I am " + age + " years old.");
       }
   }
   ```

3. 成员变量（Field）

   ```java
   public class Person {
       private String name;
       private int age;
       private String gender;
   }
   ```

4. 访问控制符（Access Modifier）

   ```java
   public class Person {
       public String name;    // public 修饰的变量可以被任何地方访问
       private int age;       // private 修饰的变量只能在本类中访问
       protected String gender;   // protected 修饰的变量可以被本类和子类访问
   }
   ```

5. 继承（Inheritance）

   ```java
   public class Animal {
       public void eat() {
           System.out.println("Animal is eating.");
       }
   }

   public class Dog extends Animal {
       public void bark() {
           System.out.println("Dog is barking.");
       }
   }

   public class Cat extends Animal {
       public void meow() {
           System.out.println("Cat is meowing.");
       }
   }
   ```

6. 多态（Polymorphism）

   ```java
   public class Animal {
       public void eat() {
           System.out.println("Animal is eating.");
       }
   }

   public class Dog extends Animal {
       public void bark() {
           System.out.println("Dog is barking.");
       }
   }

   public class Cat extends Animal {
       public void meow() {
           System.out.println("Cat is meowing.");
       }
   }

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

</details>

## 1. 变量

<details>
<summary>变量语法</summary>

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

特殊类型

- 静态类型 `static` ：静态类型是存储在方法区中的，它在程序运行时创建，并在程序结束时销毁。
- 动态类型 `dynamic` <sup>默认</sup>：动态类型是存储在堆内存中的，它在类加载时创建，并在程序结束时销毁。
- 常量 `final`：常量是一种特殊的变量 拥有静态类型特性，但它的值定义后不能被修改。JS：`const`

## 3. 运算符

Java 语言支持以下运算符：

- 算术运算符：+、-、\*、/、%、++、--
- 赋值运算符：=、+=、-=、\*=、/=、%=
- 关系运算符：==、!=、>、<、>=、<=
- 逻辑运算符：&&、||、!
- 位运算符：&、|、^、~、<<、>>、>>>
- 条件运算符：?:

</details>

<details>
<summary>更多运算符</summary>

- Java 进行小数运算结果不是精确的，而是近似值任意出现偏差，尽量不要使用浮点型进行精确运算。

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

<details>
<summary>控制语句语法</summary>

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

</details>

## 5. 数组

<details>
<summary>数组语法</summary>

Java 语言支持以下数组：

1. 静态数组

   > 直接打印多层数组是内存地址 **`Arrays.deepToString(arr)`**
   >
   > 访问修改指定位置就需要 **`arr[i][j]`**
   >
   > 下表`-1`就是设置空值，Java 逻辑处理无法直接使用 null;

   ```java
   int[] arr = new int[10];     // 声明一个长度为 10 的 int 数组
   int[] arr = new int[5-1];     // 声明一个长度为 5-1 = 4 的 int 数组
   ```

   ```java
   int[] arr = {10, 20, 30};    // 声明一个包含 3 个元素的 int 数组
   ```

   ```java
   String[] arr = {"Hello", "World"};    // 声明一个包含 2 个字符串的 String 数组
   ```

   ```java
   int[][] arr = new int[2][3];    // 声明一个二维数组，第一维长度为 2，第二维长度为 唯就是数组的层数
   // 不好理解你就 int[row][column] = {{1, 2, 3}, {4, 5, 6}}; 第一个括号是行数，第二个括号是列数
   [
    [1],[2],[3]
   ],
   [
    [4],[5],[6]
   ]
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

2. 动态数组

   ```java
    import java.util.ArrayList;
    ArrayList<Integer> list = new ArrayList<Integer>();
    list.add(10);
    int[] arr = new int[list.size()];
    for (int i = 0; i < arr.length; i++) {
        arr[i] = list.get(i);
    }
    //不能在创建时候直接添加内容
   list.add(); // 向 ArrayList 中添加元素
   list.get(0); // 访问 ArrayList 中的元素
   list.remove(0); // 从 ArrayList 中删除元素
   list.size(); // 获取 ArrayList 中元素的个数
   list.isEmpty(); // 判断 ArrayList 是否为空
   list.clear(); // 清空 ArrayList
   list.contains(obj); // 判断 ArrayList 中是否包含某个元素
   list.set(0, obj); // 修改 ArrayList 中某个元素的值
   list.subList(0, 2); // 获取 ArrayList 的子列表
   list.toArray(); // 将 ArrayList 转换为数组
   list.toArray(new Integer[0]); // 将 ArrayList 转换为指定类型的数组
   list.iterator(); // 获取 ArrayList 的迭代器
   list.listIterator(); // 获取 ArrayList 的列表迭代器
   list.forEach(System.out::println); // 遍历 ArrayList 的元素
   ```

   -二维动态数组

   ```java
    ArrayList<ArrayList<Integer>> list = new ArrayList<>();
    ArrayList<Integer> list1 = new ArrayList<>();
    list1.add(1);
    ArrayList<Integer> list2 = new ArrayList<>();
    list2.add(2);
    list.add(list1);
    list.add(list2);
    System.out.println(list);
   ```

</details>

## 6. 类与对象

- 类（Class）：模板，用来创建对象的蓝图。
- 对象（Object）：类的实例，根据类创建的实例称为对象。
- 成员变量（Field）：类中定义的变量，用于存储数据。
- 方法（Method）：类中定义的函数，用于实现功能。
- 构造器（Constructor）：类中用于创建对象的函数。
- 访问控制符（Access Modifier）：public、private、protected。
- 继承（Inheritance）：一个类可以从另一个类继承所有其成员变量和方法。
  - Java 所有类都继承 Object 类使其作为基类
  - Java 不能**多继承**，但是可以**多层继承**，变相解决继承问题。
  - Java 对继承做了优化，非 `static`、`final`、`private` 属性|方法 <br>
    均在虚方法中允许并**被继承**，继承了 `Getter` 方法，但静态属性**未继承**，`Getter`发现未继承属性，抛错！
  - **第二层**继承了**第一层**，**第三层**继承**第二层**，**第二层**中继承的**第一层**，所以**第三层**继承了**一二层**
  - Java 类中只能存在**一个**公开的类，所以继承的类必须**分离**文件出来 <br>
    类中写类无法调用 `super` 因 `this` 无法指向父类而是自己的堆值
  - 还需注意 继承类的 **堆** 中是拥有 父类的属性，`super` 是调用父类 **构造函数** <br>
    尽管没调用它也继承了 **父类的属性**，它实例化后就记录在了**方法区**中。
- 多态（Polymorphism）：同一个方法可以作用于不同的对象，根据对象的实际类型调用不同的方法。
- 封装（Encapsulation）：将数据和方法包装在一起，隐藏内部实现细节。

<details>
<summary>类与对象语法</summary>

> [!TIP]
> 注意！Java 语言是强类型语言，参数类型与返回值类型必须一致。
>
> 并且 Java 只允许一个文件中只有一个 public 类，并且这个类必须与文件名相同。还有 Java 不能多继承，只能单继承。
>
> 方法重载和方法重写的区别：方法重载是指在一个类中，有多个方法名相同，但是参数列表不同。方法重写是指子类重写父类的方法。<br>
> Java 语言不支持方法重载，只能通过方法重写来实现多态。
>
> 方法中使用 `this()` 方法来实现调用构造器。

1. 属性

   > [!CAUTION]
   > 请务必遵守「属性尽量不要用 public」的原则，因为 public 属性会被其他类访问，可能导致被修改数据，后续 debug 很难排查问题。就按照 pinia 状态管理思想。

   ```java
   public class Person {
       private String name;
       private int age;
       private String gender;
      // 属性不能像C# 一样 {get;set;}

      //idea可直接右键生成[alt+insert]构造器和get/set方法都能自动生成

       public Person(String name, int age, String gender) {
           //this. 是获取当前对象的引用地址，也是就是 在堆中的地址。默认拿去栈帧中的数据
           this.name = name;
           this.age = age;
           this.gender = gender;
       }
       //static 静态方法 不用实例化存在方法区
       public void sayHello() {
        /* public 公共方法 private 私有方法 protected 保护方法 */
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

4. 方法重载

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
        //调用构造方法
        this(name, age, gender)
        System.out.println("Hello, my name is " + name + " and I am " + age + " years old.");
    }
    // 方法重载
    public void sayHello(String name) {
        System.out.println("Hello, my name is " + name + " and I am " + age + " years old.");
    }
   }
   ```

5. 访问成员变量

   ```java
   System.out.println(person.name);
   ```

6. 继承

   ```java
   public class Student extends Person {
       private String major;

       public Student(String name, int age, String gender, String major) {
           super(name, age, gender);
           this.major = major;
           //访问父类属性
           String name = super.name;
       }

       public void study() {
           System.out.println(name + " is studying in " + major + ".");
       }
   }
   ```

7. 多态

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

</details>

## 7. 接口与抽象类

> [!TIP]
> 接口（Interface）：一种抽象的类型，它定义了某一类事物的行为，但是不提供具体的实现。
>
> 抽象类（Abstract Class）：一种类，它不能实例化，只能作为父类被继承，可以包含抽象方法和具体方法。
>
> `Super`关键字指向父类「内存地址」，`this`关键字指向当前类。

<details>
<summary>接口与抽象类语法</summary>

> [!CAUTION]
> Java 8 开始支持接口的默认方法和静态方法。 Java 不能多继承，只能单继承！。Java 9 开始支持**模块化**和**注解**<sup>`告诉方法参数类型…`</sup>。

1. 接口

   ```java
   public interface Animal {
       void eat();
   }
   ```

2. 抽象类

   ```java
   public abstract class Person {
       private String name;
       private int age;
       private String gender;

       public Person(String name, int age, String gender) {
           this.name = name;
           this.age = age;
           this.gender = gender;
       }

       public abstract void sayHello();
   }
   ```

3. 实现接口

   ```java
   public class Dog implements Animal {
       public void eat() {
           System.out.println("Dog is eating.");
       }
   }
   ```

4. 继承抽象类

   - super() 方法调用父类的构造器，并初始化父类的成员变量。super 调用继承抽象类

   ```java
      public class Student extends Person {
         private String major;

         public Student(String name, int age, String gender, String major) {
             super(name, age, gender);
             this.major = major;
             //直接拿取父类属性
             System.out.println(super.name);
         }

         public void study() {
             System.out.println(name + " is studying in " + major + ".");
         }

         public void sayHello() {
             System.out.println("Hello, my name is " + name + " and I am " + age + " years old.");
         }
      }
   ```

</details>

## 8. 多态

> [!TIP]
> 多态（Polymorphism）：同一个方法可以作用于不同的对象，根据对象的实际类型调用不同的方法。
>
> **多态**：对象的多种形态，即一个对象可以有多种形态，具有不同的功能。

- 向上转型（Upcasting）：将子类的引用赋给父类的引用。
- 向下转型（Downcasting）：将父类的引用赋给子类的引用。
- instanceof 运算符：判断对象是否属于某个类。
- 多态的好处：
  - 代码重用：父类引用可以指向子类的对象，可以调用子类的方法。
  - 接口和抽象类：接口和抽象类可以定义方法，子类可以实现接口或继承抽象类，可以调用父类和子类的共同方法。
  - 灵活性：程序可以根据需要调用不同的对象，灵活地处理对象。

<details>
<summary>多态语法</summary>

多态类型：

> [!CAUTION]
>
> `Object` 类是所有类的基类，所有类的父类。`person a = new student();`
>
> 看左边类型，如果有属性冲突，则采用左边类型，也就是基类中的写的值。方法也同理
>
> 说简单点就是，父类型，实例化子类，优先去找父类方法或者属性。找不到就直接报错！
>
> 因为类型是引用的父类，编译时候会去看父类方法，只有通过了检查才能运行。
>
> 运行的时候因为类继承了父类，他会将父类的所有方法都复制到子类实例中，所以子类实例可以调用父类的方法。
>
> `student s = new student();`
>
> 左边类型自己，看到有继承类，调用方法先看自己 methods，再看父类 methods，再看 Object methods。
>
> 其实也不是真正去实例了父类，在方法区加载的时候 | 编译，Java 记录了所有类能继承的方法 非 `static` 、`final` 、`private`
>
> 将其称之为 `虚方法表` ，在栈实例化类的时候，就将从父类 **虚方法表** 中的方法复制到子类实例中，没有实例化父类。

````java
public class person {
    String name;
    int age;

    public void sayHello() {
        System.out.println(STR."默认：\{name},\{age}");
    }
}

public class student extends person {
    @Override
    public void sayHello() {
        System.out.println(STR."学生：\{name},\{age}");
    }
}

public class admin {
    @Override
    public void sayHello() {
        System.out.println(STR."管理：\{name},\{age}");
    }
}

public class Main {
    public static void main(String[] args) {
        //看左边类型，如果有属性冲突，则采用左边类型，也就是基类中的写的值。方法也同理
        //说简单点就是，父类型，实例化子类，优先去找父类方法或者属性。找不到就直接报错！
        //因为类型是引用的父类，编译时候会去看父类方法，只有通过了检查才能运行。
        //运行的时候因为类继承了父类，他会将父类的所有方法都复制到子类实例中，所以子类实例可以调用父类的方法。
        person p = new person();
        p.name = "Alice";
        p.age = 25;
        sayHello(p);

        student s = new student();
        s.name = "Bob";
        s.age = 20;
        sayHello(s);

        admin a = new admin();
        a.name = "Tom";
        a.age = 30;
        sayHello(a);
    }

  //他们都是person类型，只要是被继承的类，都可以属于person类型。
  //父级的类型不一定是person，只需要它是基类即可。
  public static void sayHello(person p) {
        p.sayHello();
  }
}
```

转型语法：

> [!TIP]
> 转型语法就是用于专门解决，父类引用指向子类对象，或者子类对象指向父类引用。类型检查无法调用方法，需要使用转型。
>
> 向上转型：将子类的引用赋给父类的引用。
>
> 向下转型：将父类的引用赋给子类的引用。


```java
//基类
public class Animal {
    public void eat() {
        System.out.println("Animal is eating.");
    }
}

public class Dog extends Animal {
    public void bark() {
        System.out.println("Dog is barking.");
    }
}

public class Cat extends Animal {
    public void meow() {
        System.out.println("Cat is meowing.");
    }
}

public class Main {
    public static void main(String[] args) {
        //向上转型 animal 引用指向子类对象
        Animal animal = new Dog();
        animal.eat();
        ((Dog) animal).bark();
        //向下转型 子类对象指向父类引用
        Animal cat = new Cat();
        cat.eat();
        ((Cat) cat).meow();

       //判断类型再转换
        if (animal instanceof Dog) {
            ((Dog) animal).bark();
            //括号内是父类，括号外是子类
            animal = (Animal) cat;
        }
        else if (animal instanceof Cat) {
            ((Cat) animal).meow();
        }
        //JDK11语法，判断对象是不是指定类型，是就直接转换。再使用命名接受转换后的对象
        //如果 a 变量是 Dog 就调用 bark 方法，如果是猫就调用 meow 方法
        if (animal instanceof Dog dog) {
            //在判断成功后，已经转换了，接受的转换类型变量去调用方法
            dog.bark();
        }
        else if (animal instanceof Cat cat) {
            cat.meow();
        }
    }
}
````

</details>

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

```

```
