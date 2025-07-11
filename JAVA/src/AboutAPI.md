# Java 常用标准库

> ![TIP]
> Java 中常使用的 api，标准库使用不需要导包 [完整点我](./Class.md)

## System

| 方法名            | 说明                 | 参数                            | 说明                    |
| ----------------- | -------------------- | ------------------------------- | ----------------------- |
| exit              | 终止当前虚拟机       | status                          | 0:正常停止,其余异常     |
| currentTimeMillis | 返回系统时间〖毫秒〗 | 方法                            | long 类型               |
| arraycopy         | 数组复制             | srcPos \[arr2\] ,destPos,length | 数组 记录数组 索引 长度 |

### 说明

1. 记得在前面添加 `System` 它们是静态类方法
2. `currentTimeMillis` 从 `1970年1月1日 0:0:0` 开始计算毫秒时间,时差则在 **时分秒** 做加法
3. `arraycopy` 是 **可选数组** `arr2` 是将原数组的内容 放到数组 2 中,类型必须一致,Idea 无错误提示 <br> -遵循多态继承语法,同样可以用基类最为类型

## Runtime

| 方法名              | 说明                   |
| ------------------- | ---------------------- |
| getRuntime          | 当前系统的运行环境对象 |
| exit                | 停止虚拟机             |
| availableProcessors | 获得 CPU 的线程数      |
| MaxMemory           | Jvm 能获取最大内存大小 |
| totalMemory         | Jvm 已获得内存大小     |
| freeMemory          | Jvm 剩余内存大小       |
| exec                | 运行 cmd 命令          |

### 说明

1. Runtime 是单列模式，不能 new 出来，构造函数私有化。`Runtime.getRuntime()`通过方法区实现。
2. 这里的 `exit` 才是真实的，System 同样是调用这个， Runtime 是管理当前进程的类！
3. `MaxMemory` 内存相关获取默认是 Byte /1024 /104 就是 Kb MB 了
4. `exec` 是执行的 `cmd` 的命令 传入字符串 可尝试 `notepad` JDK18 废弃直接使用 Idea 解决方案 `try`

## Object

| 方法名   | 说明           |
| -------- | -------------- |
| toString | 转换字符串类型 |
| equals   | 对象比较       |
| clone    | 对象克隆       |

### 说明

1. `toString` Idea 可以生成覆写方法，使当前类对象的 toString 方法返回你写的字符串。<br>
2. `Object` 中的 `equals` 使用的是 `==` 对类进行判断，地址值自然不同，自行利用生成或手动重写
3. `Clone` 并不能直接调用，它是 `protected` 修饰符，因此我们必须方法重写〖IDea〗<br>
   规范：这个方法，它判断对象，是否实现了接口，我们需在使用类上面 实现 `implements Cloneable`

浅克隆：

是只将类中记录的数据，复制一份存储给变量，这样就会导致引用数据地址相同，一方修改了另一方同样也会被修改！

<details>
<summary>详细语法</summary>

```java
//注意要实现接口，被克隆的类重写 clone 方法！
User u1 = new Users();

Users u2 = (User) u1.clone();//!默认为浅克隆

//Idea 生成的方法，方法区块输入 clone 就行了，是被克隆对象声明和实现接口！
@Override
protected Object clone() throws CloneNotSupportedException {
    return super.clone();
}
```

</details>

深克隆：

深克隆就是浅克隆引用地址问题的解决方法，它将引用地址的数据给复制过来，再重新分配了新的地址。

<details>
<summary>详细语法</summary>

```java
//!手写深度克隆

import javax.xml.crypto.Data;

@Override
protected Object clone() throws CloneNotSupportedException {
    int[] list = this.data;

    int[] newList = new int[list.length];

    for (int i = 0; i < list.length; i++) {
        newList[i] = list[i];
    }
    //使用浅克隆存储基本数据类型
    User user = (Users) super.clone();
    //?将浅克隆数据替换为深克隆数据
    user.data = newList;

    return user;
    //!后续使用比较好的第三方算法类库的深克隆方法
}
```

</details>

## Objects

| 方法名  | 说明     |
| ------- | -------- |
| equals  | 比较     |
| isNull  | 判断     |
| nonNull | 判断取反 |

### 说明

1. `equals` 跟前者不同在它会在判断前判断对象是否为空，如果是它就直接返回 false，从而避免程序异常
2. `isNull` 判断对象是否为空，返回`boolean`类型。
3. `nonNull` 跟上面一样，只不过返回值取反了。

## BigInteger

| 方法名               | 说明               | 参数                   |
| -------------------- | ------------------ | ---------------------- |
| BigInteger           | 随机大整数         | int num Random r       |
| BigInteger           | 获取指定的大整数   | String val             |
| BigInteger           | 获取指定进制大整数 | sting val ,int radix   |
| -------------------- | 静态方法           | ---------------------- |
| valueOF              | 转换大整数类型     | long num               |
| -------------------- | 常见方法           | ---------------------- |
| add                  | 加法               |
| subtract             | 减法               |
| multiply             | 乘法               |
| divide               | 除法 获取 商       |
| divideAndRemainder   | 除法 获取 伤 余数  |
| equals               | 比较               |
| pow                  | 次幂               |
| max/min              | 返回较大值         |
| intValue             | 转为 int 类型整数  |
| double、long value   | 转换指定类型       |

### 说明

1. 随机大整数 第一个数是 (0~2^数字次方) -1 比如 4 \[0 ~ 15\] ，第二个实例化随机数类
2. 第二个就是单纯是字符串转换为大整数
3. 指定传入的数据是什么进制的，你写 (101010,2) 它返回的 10 进制中这个数量的大小。
4. 静态方法的有特殊优化，如果数子较小可直接使用。数字最后 `L` 表示 long
5. 额外内容 int 类型变量在内存 第一位 表示的正负数 0 表示数字 0 。

---

1. `a.add(b)`
2. `BigInteger[] arr = a.divideAndRemainder(b)`数组 0 商，1 余
3. `a.equal(b)` boolean 类型
4. `a.pow(2)` a 的 2 次幂
5. `a.max(b)` 返回最大值 返回的还是原对象，而不是新内存地址

## BigDecimal

| 方法名               | 说明               | 参数\|用法                 |
| -------------------- | ------------------ | -------------------------- |
| new BigDecimal       | 实例化             | int double string          |
| value of             | 获取对象           | String val                 |
| BigInteger           | 获取指定进制大整数 | sting val ,int radix       |
| add                  | 加法               | bd1.add(bd2)               |
| subtract             | 减法               | bd1.subtract(bd2)          |
| multiply             | 乘法               | bd1.multiply(bg2)          |
| divide               | 除法               | bd1.divide(bg2)            |
| divide               | 精确除法           | bd1.divide(bg2,scale,mode) |
| -------------------- | 静态方法           | ----------------------     |
| valueOf              | 静态获取对象       | long num flot              |
| -------------------- | 常见方法           | ----------------------     |
| add                  | 加法               |

### 说明

1. BigDecimal 是用来解决 Java 小数计算不精确的问题，实例化用 num 可能不精确，用字符串不会
2. valueOf 是静态方法，快速使用的方式，但是范围必须要在 double 内才行，有特殊优化 地址还一样
3. divide 精确除法 参数 传入参数可非 bg，`scale`是保留位数。参数预览中有提示 RoundingMode<br>
   `RoundingMode`是新版本舍弃模式，Down『向零』、Up『反零』、Half_UP『四舍五入』详见 api
4. 原理：通过将数字在内存中存储为 字符串码表 **char 数组** ，负号也是存进去的，使用时转换！

## Regex 正则

<details>
  <summary style="font-size:17px;font-weight:bold;">正则语法</summary>

1. | 类型            | 作用                                                                             |
   | --------------- | -------------------------------------------------------------------------------- |
   | （^）           | 匹配字符串的开始位置，如“^a”表示以字母 a 开头的字符串。                          |
   | （$）           | 匹配字符串的结束位置，如“X^”表示以字母 X 结尾的字符串。                          |
   | （.）           | 这个字符就是英文下的点，它匹配**任何一个字符**，包括回车、换行等。 通配符 \_     |
   | （\*）          | 星号匹配 0 个或多个字符，在它之前必须有内容。通配符 % 后续字符等于之前的字符     |
   | （+）           | 加号匹配 1 个或多个字符，星号允许出现 0 次，加号必须出现一次。a+ 后面至少一个 a  |
   | {n}             | 匹配指定 n 个 ab{3} abbb 有 3 个 (ab){3} ababab .{3} 任意字符出现三次            |
   | {n,}            | 匹配不少于 n 个 字面意思，跟上面语法相同                                         |
   | {n,m}           | 匹配 n-m 个 字面意思，语法相同                                                   |
   | a?              | ?为断言匹配，自动填充，结果可为 `[字符]`或者 a`[字符]` 它可存在，可不存在 量子态 |
   | (ab)?a          | 断言匹配，结果可为 aba 或者 c 和上面的用法称为**量词**                           |
   | .\*?b           | .是如何字符，\*让第二字符必须和.的相同，?让\*的匹配可有可无，最后一位强制 b      |
   | a+?             | a+ 特性为后面字符**必须有一个** a，要么单 a 要么 至少有 2 个 a。 非贪婪量词      |
   | （?!）          | a(?!b) 匹配到 a，只要 a **后面非紧**跟着 b 零宽度负向前瞻                        |
   | （?=）          | a(?=b) 结果可为 a 或者 a **后面**紧跟着 b 的字符 零宽度正向前瞻                  |
   | （?<!）         | b(?<!a) 与(?!)相同，只不过是**前面**不能有字符 a 零宽度负向回顾                  |
   | （?<=）         | b(?<!a) 与(?=)相同，只不过是**前面**有 字符 a 零宽度正向回顾                     |
   | (?i)            | a(?i)bc bc 两个字符将忽视大小写 多用括号限制范围 Java 测试                       |
   | \[a-z\]         | 表示当前位置的字符，**是** Ascii 码表 a-z 范围内                                 |
   | \[^a-z\]        | 表示当前位置的字符，**非** Ascii 码表 a-z 范围内                                 |
   | \[a-zA-Z\]      | 表示当前位置的字符 a-z**或**A-Z 之间，不用空格 给范围符号提高阅读性              |
   | \[a-z[0-9]\]    | 表示当前位置的字符，a-z **或者** 0-9                                             |
   | \[a-z&[def]\]   | 表示当前位置的字符，a-z 之间 也可以是 **&** 符号 **或者** 是 def                 |
   | \[a-z&&[def]\]  | 表示当前位置的字符，a-z 和 def 的**交集**: 先必须在 a-z 然后再看 是不是 def      |
   | \[a-z&&[^bc]\]  | 表示当前位置的字符，a-z **非** bc 的**交集** 排除 bc                             |
   | \[a-z&&[^m-p]\] | 表示当前位置的字符，a-z **非** m-p 的**交集** 排除 m-p 之间                      |
   | 成果            | `select * from student where sname regexp '^张.*?$'`                             |

2. `'字符'` ：没有意思，就是判断它是不是 字符两个字
3. `|`：表示或 匹配多数据
4. `.+`：**当前字段** `.` 匹配任意字符 `+` 包括空格、换行符等。
5. `[]`：**当前字段** 匹配指定范围内的字符。`[a-z]` `[1-9]` `[a-zA-Z0-9]` 高版本不区分大小写。
6. `[^]`：匹配不在指定范围内的字符。 无法使用 可在表达式前添加 `NOT`
   1. `[5|6|7|8|9]` : 不代表或 它识别为 | 为字符了。`^[5|6|7]` 才能表达 或
   2. `[5|6|7]$` 匹配以 5、6、7 结尾的字符串。
7. 字节匹配
   1. `^.{10}$` 匹配 10 个字节的字符串。 `[a-z{10}$]` 英文 10 字节
      1. UTF8 编码下，一个中文字符占 3 个字节。 GBK 2 个字节。
      2. 英文字符占 1 个字节。 GBK 1 个字节。
      3. 数字占 1 个字节。 GBK 1 个字节。
   2. `BINARY ^'[A-Z]{10}$'` 匹配大写字母 10 个字节的字符串。
   3. `^.{10}|` 匹配 10 个字节的字符串或以 | 结尾的字符串。
8. `^[0-9.]{6}$` 匹配 6 位数字或小数点的字符串。| 版本号
   1. `^1[0-9.]{5}$` 以 1 开头 数字 或者 . 是 5 字节的 字符串。
   2. `^1[0-9.]{4}7$` 首为 1 末为 7 ……
   3. `{4,6}$` 匹配 4-6 字节的字符串。
   4. `^(.{1}|.{7})$` 匹配 为 1 或 7 字节的单个字符
9. `^[^ -~]` 首字中文。`[^]` 为非字符。`-~` 从空格到~ ASCII 所有字符。
10. `^([a-z]|[0-9]|[A-Z])+$` 匹配不包含空格、换行符、中文的字符串。
11. `\\d+` 匹配数字。第一个 \ 是 转意符，`\d` 是原值 `+` 表示 至少出现一次
12. `\\D+` 匹配非数字。
13. `\\w+` 匹配单词字符。 键盘上所有字符 ASCii 码表
14. `\\W+` 匹配非单词字符。 也就是仅匹配非 ASCII 码表 中文等等
15. `\\s+` 匹配空白字符。
16. `\\S+` 匹配非空白字符。
17. `\\b` 匹配单词边界。
18. `\\B` 匹配非单词边界。
19. `^` 表示行的开始
20. `.`匹配任何单个字符(除了换行符)
21. `$` 表示行的结束
22. `[]` 表示范围！一个字符为你的表达式内
23. `\\.` 特殊符号须转义！`[,]` 范围内可不用转义
24. `()` 正则表达式结果分组
25. JDK 1.6 api 查找 Pattern 查看文档

</details>

Java 中使用匹配邮箱

<details>
<summary>详细语法</summary>

```java
public static void main(String[] args) {
    String email1 = "1444736434@qq.com";
    String email2 = "gsne@gmail.cn";
    String email3 = "naer@qq.com.cn";

    /*
     * 第一部分 可以为数字 英文 下划线 @ - 可自行添加
     * 正则请注意 \ 出现一次的意思会被识别为 符号 所以必须用双 不在正则正常是用一次
     * [\w+]+
     * 第二部分 地址 无下划线 可为数字 英文 . 语法必须是[a-z&&[]]双层！
     * [\w&&[^_]]+
     * 最后一部分 域名 必须点+英文 并设置最大长度5
     * (\.[a-zA-Z]{2,5}){1,3}
     * 额外设置了分组，应对多地址的情况，因为分组所以小数点必须在组内，.com.cn……
     * */

    //!别用Idea修复&&处的简化，语法不能简化！
    String regex = "([\\w+]+)@([\\w&&[^_]]+)(\\.[a-zA-Z]{2,5}){1,3}";

    System.out.println(email1.matches(regex));
    System.out.println(email2.matches(regex));
    System.out.println(email3.matches(regex));
}
```

</details>

Java 正则爬虫

<details>
<summary>详细语法</summary>

```java
public static void main(String[] args) {
    Pattern p = Pattern.compile("Java\\d{0,2}");
    Matcher m = p.matcher("Java来自*****Java8和Java11是长期支持版本！");
    /*
     * m.find 方法就是爬虫，依次往后阅读，找到符合返回true，到最后返回true
     * 并且 m.find发现之后，它会将当前符合规则的记录 group方法
     * .并且将历史结果存储在内部数组中，可以在调用 group方法时 填写int
     * */
    while (m.find()) {
        System.out.println(m.group());//!1是指第一个组 0 位置整行所有内容了
    }
}
```

</details>

Matcher：正则匹配结果返回值 | String 字符串操作方法

| 功能        | 参数\|作用   |
| ----------- | ------------ |
| replace     | Regex string |
| replaceAll  | Regex string |
| toLowerCase | 转换小写     |
| toUpperCase | 转换大写     |
| split       | Regex        |

### 说明

1. 只能是字符串类型才能使用的方法，matcher 是字符串正则匹配是否成功！
2. Replace 依然是通过正则匹配，再讲匹配到的内容进行替换，将非英文 全部移除 `.("\W","")`
3. split 正则结果切割为数组，匹配非英文，就在英文结束的位置记录，再去找下一个再记录 似`m.group`

## Java 爬虫

- 基础使用

<details>
<summary>详细语法</summary>

```java
public static void main(String[] args) {
    //可选使用正则拿取内容 所有href链接地址
    Pattern p = Pattern.compile("(.*)href=\"([\\w :/.\"]*)\"(.*)");//!使用了分组，以左括号分组 1起始

    //?声明在线链接
    URL site = new URL("https://otp.landian.vip/zh-cn/");
    //?连接地址并声明类型
    URLConnection connection = site.openConnection();
    //?阅读获取的输出流
    BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
    String line;


    //?行读取循环,直到没有行
    while ((line = br.readLine()) != null) {
        System.out.println(line);
        //可选使用正则
        Matcher m = p.matcher(line);
        while (m.find()) {
            System.out.println(m.group(2));//!1是指第一个括号 0 位置留给整行所有内容了 2是匹配的链接内字符
        }
    }
}
```

</details>

## Time

JDK7

- 基础

<details>
<summary>详细语法</summary>

```java
import java.util.Date;

public static void main(String[] args) {
    Date d = new Date();//括号填写0表示从时区是从0开始的 中国是 8 L是 long类型
    System.out.println(d);

    //修改时间
    d.setTime(1000L); //1000毫秒
    System.out.println(d);

    //获取时间
    long time = d.getTime();
    System.out.println(time);

    //增加一年
    time add = time + 1000L * 60 * 60 * 24 * 365; //?第一个数给 L 防止输出超出 int 上线 用 long 类型
    System.out.println(d.setTime(add));//1971年

    //!时间判断,不能直接进行比较，2个对象通过get方式获取时间再进行判断。
}
```

</details>

- 转换

> [!TIP]
> 处理时间转换，时间修改

<details>
<summary>详细语法</summary>

```java
import java.text.SimpleDateFormat;
import java.util.Date;

public static void main(String[] args) {
    //实例化对象
    SimpleDateFormat sdf = new SimpleDateFormat();
    //指定格式 自行查看api文档 EE 表示星期
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
    Date d = new Date();

    String After = sdf.format(d);
    System.out.println(After);

    //!字符串转换时间 format 格式必须与输入格式一致 否则无法转换
    String time = "2023-11-11";
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    Date date = format.parse(time);
    System.out.println(date.getTime());
}
```

</details>

- 优化 日历

> [!TIP]
> 用于优化时间修改时的重复转换。

<details>
<summary>详细语法</summary>

```java
import java.util.Calendar;
import java.util.Date;

public static void main(String[] args) {
    //?源码中它会根据时区，获取不同日历对象，日本历和佛历……
    //!它是日历月范围是 0~11 从零计数的
    //!外国人 星期天 是一周的第一天！
    Calendar c = Calendar.getInstance();
    Date date = new Date(0L);
    c.set(date);
    /*
     * Get api
     * 0 : 纪元 : ERA
     * 1 : 年 : YEAR
     * 2 : 月 : MONTH
     * 3 : 年周数 : WEEK_OF_YEAR
     * 4 : 月周数 : WEEK_OF_MONTH
     * 5 : 月天数 : DATE
     * ... 自行查看 api 或者翻阅源码
     * 月记得加一,它从零计数 周起始是星期日,自行解决,可选用数组根据传入值,返回对于数据 : 查表法
     * */
    int year = c.get(Calendar.YEAR);

    //?修改 超出则进位
    c.set(Calendar.YEAR, 2024);
    //?增加 超出则进位
    c.add(Calendar.MONTH, -50);
}
```

</details>

JDK8

| 功能                      | 参数                     | 简述                        |
| ------------------------- | ------------------------ | --------------------------- |
| ---------------           | zoneID static            | ---------------             |
| getAvailableZoneIds       | method                   | 获取所有时区名称            |
| of                        | string                   | 指定时区                    |
| systemDefault             | method                   | 获取当前系统时区            |
| ---------------           | Instant static           | ---------------             |
| now                       | method                   | 获取当前时间 ins 对象       |
| ofEpoch\[Milli...\]       | long num                 | 根据时间(类型)获取 ins 对象 |
| atZone                    | ZoneID zone              | 指定时区                    |
| atZone                    | ZoneID zone              | 指定时区                    |
| ---------------           | Instant dynamic          | ---------------             |
| equals、is                | ...                      | 判断相关                    |
| minus                     | ...                      | 减少时间相关                |
| plus                      | ...                      | 增加时间相关                |
| ---------------           | ZonedDateTime static     | ---------------             |
| of                        | y/m/d/h/m/s/ns ZoneId    | 获取指定的时间对象需时区    |
| ofInstant                 | Instant                  | 根据 Ins 获得时间对象       |
| with\[YEAR...\]           | num                      | 修改时间系列方法            |
| minus\[YEAR...\]          | num                      | 减少时间系列方法            |
| plus\[YEAR...\]           | num                      | 增加时间系列方法            |
| ---------------           | DateTimeFormatter static | ---------------             |
| ofPattern                 | YYYY-MM-dd HH:mm:ss EE a | 时间格式化                  |
| ---------------           | Calendar static          | ---------------             |
| Local\[Date、Time、DT\]   | method                   | 日历对象系列                |
| now                       | method                   | 获取当前时间对象            |
| of...                     | method                   | 指定时间对象                |
| get...                    | method                   | 获取系列语法                |
| isBefore,after，equals    | method                   | 比较时间系列                |
| with...                   | method                   | 修改时间系列                |
| minus...                  | method                   | 减少时间系列                |
| plus...                   | method                   | 增加时间相关                |
| ------------------        | Tools                    | ------------------          |
| ---------------           | Duration static          | ---------------             |
| ---------------           | 计算时间差 (秒，纳秒)    | ---------------             |
| between                   | LocalTime、INS \* 2      | 计算差                      |
| get...                    | method                   | 获取系列                    |
| to...                     | method                   | 换算差总                    |
| isLeapYear                | method                   | 闰年判断                    |
| ---------------           | Period static            | ---------------             |
| ---------------           | 计算日期间隔 (年,月,日)  | ---------------             |
| between                   | LocalDate \* 2           | 计算差                      |
| get...                    | method                   | 获取系列                    |
| toTotal...                | method                   | 换算差总                    |
| ---------------           | ChronoUnit static        | ---------------             |
| ---------------           | 计算日期间隔             | ---------------             |
| Unit.\[YEARS...\].between | LocalDateTime \* 2       | 计算差,前缀为单位           |


### 说明

1. zoneID 为时间时区相关类
2. Instant 时间戳相关
3. ZonedDateTime 是真正的时间对象
4. Calendar 为日历 JDK8 使用需使用 LocalDateTime 系列类
5. 真正使用实例化 LocalDateTime.of 直接填写值 ，需要时区再去使用 Zone ,精准时间用 INS,格式化 ofPattern

<details>
<summary>详细语法</summary>

```java
public static void main(String[] args) {
//!JDK7
    //规则:只要对时间进行计算或者判断，都需要先获取当前时间的毫秒值
    //1.计算出生年月日的亳秒值
    String birthday = "2000年1月1日";
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd");
    Date date = sdf.parse(birthday);
    long birthdayTime = date.getTime();
    //2.获取当前时间的毫秒值
    long todayTime = System.currentTimeMillis();
    //3.计算间隔多少天
    long time = todayTime - birthdayTime;
    System.out.println(time / 1000 / 60 / 60 / 24);

//!JDK8
    LocalDate ld1 = LocalDate.of(2000, 1, 1);
    LocalDate ld2 = LocalDate.now();
    long days = chronoUnit.DArs.between(ld1, ld2);
    System.out.println(days);
}
```

</details>

## 包装类

> [!TIP]
> 包装类是 Java 数据类型的对象，int->Integer char->Character string->String boolean->Boolean ……

| 方法 静态           | 功能             |
| ------------------- | ---------------- |
| ParseInt            | 类型转换         |
| ValueOf             | 填写数据         |
| new                 | 实例化，可选构造 |
| toBinaryString(int) | 得到二进制       |
| toOctalString(int)  | 得到八进制       |
| toHexString(int)    | 得到十六进制     |

说明

1. `Integer` 0~127 有优化，方法区已实例化了，可正常直接判断
2. arrayList 类似需要填写类型时候，写包装类而不是简写的 int
3. int 这些简写是 JDK5 之后 Java 特性 自动包装 拆箱。省实例。

## Arrays 算法 API

| 方法 静态    | 功能     | 说明       |
| ------------ | -------- | ---------- |
| asList       | 转换数组 | 参数无上限 |
| toString     | 数组转换 | 转为字符串 |
| binarySearch | 二分查找 | 找不到 -1  |
| copeOf       | 拷贝数组 | 自动扩容   |
| copeOfRange  | 范围拷贝 | 左包右不包 |
| fill         | 数组填充 | 字意       |
| sort         | 排序     | ArrayList  |

<details>
<summary>详细语法</summary>

```java
import java.util.Arrays;

public static void main(String[] args) {
    int[] list = {1, 3, 9, 6, 5, 6, 8};

    Arrays.sort(list, new Comparator<Integer>() {
        @Override
        public int compare(Integer o1, Integer o2) {
            return o2 - o1;//o2-o1 倒序，o1-o2 正序
            //o1是有序列表，o2是无序列表
            //负数往前排，正数为正序。
        }
    });
}
```

</details>

## lambda

> Java 中的箭头函数，函数式编程思维，作用在匿名内部类中，并且接口必须为函数式接口。
>
> 函数式接口：只有一个抽象方法的接口，需头顶添加 @FunctionalInterface 注释

<details>
<summary>详细语法</summary>

```java
public static void main(String[] args) {
    //实习接口需要 new 出来，而 lambda可以直接
    lam gf = () -> {
    };
    //?省略写法，就别写大括号 箭头后面直接写返回值,单参数括号可省 () -> ()
}

@FunctionalInterface
interface lam {
    public abstract void doSomething();
}
```

</details>

## For & Foreach

> Java 增强 for 和 Foreach 使用和原理

For

> 增强 for 的变量是临时变量，对他进行操作不会对原数据产生影响。

<details>
<summary>详细语法</summary>

```java
public static void main(String[] args) {
    int[] list = {1, 2, 6, 8, 7, 3, 1, 4, 8};
    //语法：类型 变量 : 对象。不用死记 Idea 变量.for 或者普通 for 解决方法有提示
    for (String item : list) {
        System.out.println(item);
    }
}
```

</details>

Foreach

> 底层代码就是普通的 For 循环，只不过用起来更方便了。

<details>
<summary>详细语法</summary>

```java
import java.util.ArrayList;
import java.util.Collection;
import java.util.function.Consumer;

public static void main(String[] args) {
    Collection<String> cl = new ArrayList<String>();
    cl.add("test1");
    cl.add("test2");
    cl.add("test3");
    //普通写法，内部类实现接口，并执行操作
    cl.forEach(new Consumer<String>() {
        @Override
        public void accept(String s) {
            System.out.println(s);
        }
    });
    //? 于Lambda联动
    cl.forEach(s -> System.out.println(s));
}
```

</details>

## Stream 流 [API](./stand.md#stream-流)

一个 Steam 只能完整使用一次,可链式编程多个操作,与 iterator 类似。

| 集合     | 实现            |
| -------- | --------------- |
| 单列集合 | stream()        |
| 双列集合 | 无直接实现      |
| 零散数据 | Arrays.stream() |
| 数组     | Stream<T>       |

![PixPin_2024-12-03_13-46-18.png](./images/Idea/AboutAPI-1733204791453.png)

### Stream API

| 方法 静态           | 功能       | 参数                 | 说明                   |
| ------------------- | ---------- | -------------------- | ---------------------- |
| of                  | 数组流     | T...                 | 数组                   |
| sort                | 排序       | Comparator:Interface | 默认升序               |
| forEach             | 遍历       | void                 | Lambda                 |
| concat              | 合并       | Stream \* 2          | 记得去重               |
| distinct            | 去重       | void                 | hashCode eq            |
| filter              | 过滤       | Predicate<T>         | 过滤条件               |
| limit               | 截取       | Integer              | 截取元素               |
| skip                | 跳过       | Integer              | 跳过元素               |
| map                 | 映射       | Function<T, R>       | 数据转换 JS            |
| reduce              | 归约       | BinaryOperator<T>    | 聚合操作               |
| count               | 计数       | Integer              | 元素数量               |
| min                 | 最小值     | Optional<T>          | 最小值                 |
| sum                 | 求和       | Integer              | 元素求和               |
| max                 | 最大值     | Optional<T>          | 最大值                 |
| parallel            | 并行       | void                 | 并行流                 |
| ----------          | 流数据处理 | Collect、toArray     | ----------             |
| Collectors.toSet()  | set 集合   | void                 | Int 类型方法用 toArray |
| Collectors.toList() | List 集合  | void                 |                        |
| Collectors.toMap()  | Map 集合   | fn \* 2              | fn1->key fn2->value    |

终结方法 无法再次链式调用

返回 Stream<T> 就是中间操作，可以继续调用其他方法

返回值 void Object[] ... 就是终结流

| 方法    |
| ------- |
| forEach |
| count   |
| min     |
| max     |
| sum     |

<details>
<summary>Stream 流 API</summary>

1. 单列集合

   <details>
   <summary>详细语法</summary>

   ```java
   import java.util.stream.Stream;
   public static void main(String[] args) {
       //1. 数组
       int[] arr = {1, 2, 3, 4, 5};
       Stream<Integer> stream = Arrays.stream(arr);
       //2. 集合
       List<Integer> list = Arrays.asList("a", "b", "c", "d", "e");
       Stream<String> stream1 = list.stream();
       //3. 字符串
       String str = "hello world";
       Stream<String> stream2 = Arrays.stream(str.split(" "));
   }
   ```

   </details>

2. 双列集合

   <details>
   <summary>详细语法</summary>

   ```java
   import java.util.stream.Stream;
   public static void main(String[] args) {
       //?Map等 双列集合本身不支持，拿取到健和值的集合后,转为单列集合
        //添加数据
        List<String> K = Arrays.asList("张三", "李四", "王五");
        List<Integer> V = Arrays.asList(18,16,80);

        Map<String,Integer> list = new HashMap<String, Integer>();

        K.stream().forEach(i->{
            list.put(i,V.get(K.indexOf(i)));
        });

        System.out.println("原数据："+list);

        Set<Map.Entry<String, Integer>> entries = list.entrySet();

        ArrayList res = new ArrayList<>();

        entries.stream().forEach(i->{
            res.add(i.getKey() + " : " + i.getValue());
        });

        System.out.println(res);
   }
   ```
   
   </details>

3. 零散数据

   <details>
   <summary>详细语法</summary>

   ```java
   import java.util.stream.Stream;
   public static void main(String[] args) {
    //通过of()方法创建流,参数只能为同类型,使用了可变参数
     Stream<Integer> stream = Stream.of(1, 2, 3, 4, 5);
     stream.forEach(System.out::println);/* 可选用lambda表达式 */

     String tips = "
        /*
          Stream.of 注意事项
          1. 参数为变量时候，注意变量类型问题
          2. 引用数据 存入内存地址
          3. 基本数据 数组单个元素   数组可直接使用.stream
          4. 它是可变参数,多数据记得隔开,单参就是单个元素
        */
      "
   }
   ```
   
   </details>

4. 数组

   <details>
   <summary>详细语法</summary>

   ```java
   import java.util.Arrays;
   import java.util.stream.IntStream;
   public static void main(String[] args) {
       int[] arr = {1, 2, 3, 4, 5};
       Arrays.stream(arr).forEach(System.out::println);
       // IntStream.of(arr).forEach(System.out::println);
   }
   ```
   
   </details>

5. 集合转换

   <details>
   <summary>详细语法</summary>

   ```java
   public static void main(String[] args){
        List<String> K = Arrays.asList("张三", "李四", "王五");

        Map<Object, Object> res;

        //将流数据合并和数组.
        res = K.stream().filter(g -> g.length() == 2)
                .collect(Collectors.toMap(i -> i.charAt(0), b -> b.substring(1)));

        //!异常就是触发了map集合异常，键不能重复!
        System.out.println(res);
   }
   ```

   </details>

6. More

    <details>
    <summary>进阶操作</summary>

   1. 过滤

      <details>
      <summary>详细语法</summary>

      ```java
      import java.util.stream.IntStream;
      public static void main(String[] args) {
          int[] arr = {1, 2, 3, 4, 5};
          IntStream intStream = IntStream.of(arr);
          //源码中使用了Predicate接口，返回 boolean
          intStream.filter(i -> i > 2).forEach(System.out::println);
      }
      ```
      
      </details>

   2. 映射

      <details>
      <summary>详细语法</summary>

      ```java
      import java.util.stream.IntStream;
      public static void main(String[] args) {
          int[] arr = {1, 2, 3, 4, 5};
          IntStream intStream = IntStream.of(arr);
          intStream.map(i -> i * 2).forEach(System.out::println);
      }
      ```
      
      </details>

   3. 归约

      <details>
      <summary>详细语法</summary>

      ```java
      import java.util.stream.IntStream;
      public static void main(String[] args) {
          int[] arr = {1, 2, 3, 4, 5};
          IntStream intStream = IntStream.of(arr);
          int sum = intStream.reduce(0, (a, b) -> a + b);
          System.out.println(sum);
      }
      ```
      
      </details>

   4. 排序

      <details>
      <summary>详细语法</summary>

      ```java
      import java.util.stream.IntStream;
      public static void main(String[] args) {
          int[] arr = {1, 2, 3, 4, 5};
          IntStream intStream = IntStream.of(arr);
          intStream.sorted().forEach(System.out::println);
      }
      ```
      
      </details>

   5. 并行流

      <details>
      <summary>详细语法</summary>

      ```java
      import java.util.stream.IntStream;
      public static void main(String[] args) {
          int[] arr = {1, 2, 3, 4, 5};
          IntStream intStream = IntStream.of(arr);
          intStream.parallel().forEach(System.out::println);
      }
      ```
      
      </details>

   6. 其他

      <details>
      <summary>详细语法</summary>

      ```java
      import java.util.stream.IntStream;
      public static void main(String[] args) {
          int[] arr = {1, 2, 3, 4, 5};
          IntStream intStream = IntStream.of(arr);
          // 跳过前两个元素
          intStream.skip(2).forEach(System.out::println);
          // 截取前两个元素
          intStream.limit(2).forEach(System.out::println);
          // 元素计数
          long count = intStream.count();
          System.out.println(count);
          // 元素求和
          int sum = intStream.sum();
          System.out.println(sum);
          // 元素最大值
          int max = intStream.max().getAsInt();
          System.out.println(max);
          // 元素最小值
          int min = intStream.min().getAsInt();
          System.out.println(min);
      }
      ```
      
      </details>

   </details>

</details>

## File

> [!TIP]
> File 类 用来操作文件和目录，可以对文件进行创建、删除、复制、移动、读写等操作。
>
> 字符串拼接交给 File 它可以根据系统来自动转换,file 两参数就是 `目录和文件` 。
>
> File 类用来读取整个文件 FileInput 字节读取文件,FileOutput 字节写入文件。

- File 类是 Java 中用于处理文件和目录的类。
- File 类可以创建、删除、复制、移动文件和目录。
- File 类可以获取文件或目录的属性，如：文件名、路径、大小、最后修改时间等。
- File 类可以对文件进行读写操作。
- File 类不能链式调用,file 获取父级路径，新获取的并不能使用操作方法，需 new 再使用

<details>
<summary>File 类方法</summary>

| 方法                                    | 参数                                     | 说明                                                     |
| --------------------------------------- | ---------------------------------------- | -------------------------------------------------------- |
| File(String pathname)                   | pathname：文件路径                       | 创建一个 File 对象，指定文件路径。                       |
| File(String parent, String child)       | parent：父目录路径 child：子目录或文件名 | 创建一个 File 对象，指定父目录路径和子目录或文件名。     |
| File(File parent, String child)         | parent：父目录对象 child：子目录或文件名 | 创建一个 File 对象，指定父目录对象和子目录或文件名。     |
| boolean exists()                        | void                                     | 判断文件或目录是否存在。                                 |
| boolean createNewFile()                 | void                                     | 创建文件，根据路径末尾名称                               |
| boolean mkdirs()                        | void                                     | 创建多级文件夹，多级创建，不存在的路径自动创建           |
| boolean mkdir()                         | void                                     | 创建文件夹,被 dirs 完全优化                              |
| boolean delete()                        | void                                     | 删除文件或目录 永久删除。文件夹中有文件无法删除 递归删除 |
| boolean renameTo(File dest)             | dest：目标文件或目录                     | 重命名文件或目录。                                       |
| long length()                           | void                                     | 获取文件大小 字节。                                      |
| String[] list()                         | void                                     | 列出目录中的文件和目录。                                 |
| String[] list(FilenameFilter filter)    | filter：文件名过滤器                     | 列出目录中的文件和目录，并过滤。                         |
| File[] listFiles()                      | void                                     | 列出目录中的文件。权限不够 返回 null                     |
| File[] listFiles(FilenameFilter filter) | filter：文件名过滤器                     | 列出目录中的文件，并过滤。                               |
| File[] listFiles(FileFilter filter)     | filter：文件过滤器                       | 列出目录中的文件，并过滤。                               |

```java
public static void main(String[] args) {
    //创建 File 对象
    File file = new File("D:\\test.txt");

    //判断文件是否存在
    if (file.exists()) {
        //删除文件
        file.delete();
    }

    //创建目录
    File dir = new File("D:\\test");
    if (!dir.exists()) {
        dir.mkdir();
    }

    //创建文件
    try {
        if (!file.exists()) {
            file.createNewFile();
        }
    } catch (IOException e) {
        e.printStackTrace();
    }

    //列出目录中的文件 一定要确保地址是文件夹,file 对象只能调用一次方法，新地址用新对象存储
    String[] list = dir.list();
    for (String s : list) {
        System.out.println(s);
    }

    //文件路径获取父级
    String path = "test.txt";

    File f1 = new File(path);

    System.out.println(f1.exists());
    //!相对路径无法获取到上级目录，必须先转换为绝对路径。
    f1 = new File(f1.getAbsolutePath());
    System.out.println(f1.getParent());

    //?根据目录来创建文件 file2 确保它是文件夹就行了
    File f2 = new File(file1.getAbsolutePath(), "addTest.text");
    System.out.println(f2.createNewFile());

    /*
     *  列出文件系列方法，filter接口语法。
     *  过滤器 dir 文件夹，name是当前文件路径。
     *  f2.list((dir, name) -> !".idea".equals(name)))
     * */
}
```

<details>
<summary>更多语法</summary>

| 方法                                      | 参数                   | 说明                        |
| ----------------------------------------- | ---------------------- | --------------------------- |
| boolean setReadOnly()                     | void                   | 设置文件为只读。            |
| boolean isDirectory()                     | void                   | 判断是否是目录。            |
| boolean isFile()                          | void                   | 判断是否是文件。            |
| boolean canRead()                         | void                   | 判断是否可读。              |
| boolean canWrite()                        | void                   | 判断是否可写。              |
| boolean isHidden()                        | void                   | 判断是否隐藏。              |
| boolean setWritable(boolean writable)     | writable：是否可写     | 设置文件是否可写。          |
| boolean setReadable(boolean readable)     | readable：是否可读     | 设置文件是否可读。          |
| boolean setExecutable(boolean executable) | executable：是否可执行 | 设置文件是否可执行。        |
| boolean setLastModified(long time)        | time：最后修改时间     | 设置文件最后修改时间 毫秒。 |
| boolean compareTo(File pathname)          | pathname：文件路径     | 比较两个文件路径。          |
| boolean equals(Object obj)                | obj：对象              | 判断两个对象是否相等。      |
| int hashCode()                            | void                   | 获取对象的哈希值。          |
| String getPath()                          | void                   | 获取文件路径。              |
| String getName()                          | void                   | 获取文件名。                |
| String getParent()                        | void                   | 获取父目录路径。            |
| String getAbsolutePath()                  | void                   | 获取绝对路径。              |
| String getCanonicalPath()                 | void                   | 获取规范路径。              |
| File getAbsoluteFile()                    | void                   | 获取绝对文件。              |
| File getCanonicalFile()                   | void                   | 获取规范文件。              |
| URL toURL()                               | void                   | 获取文件 URL。              |
| boolean isAbsolute()                      | void                   | 判断是否是绝对路径。        |

```java
public static void main(String[] args) {
    //列出目录中的文件，并过滤
    FilenameFilter filter = new FilenameFilter() {
        @Override
        public boolean accept(File dir, String name) {
            return name.endsWith(".txt");
        }
    };
    String[] list1 = dir.list(filter);
    for (String s : list1) {
        System.out.println(s);
    }

    //列出目录中的文件，并过滤
    FileFilter filter1 = new FileFilter() {
        @Override
        public boolean accept(File pathname) {
            return pathname.isFile();
        }
    };
    File[] listFiles = dir.listFiles(filter1);
    for (File file1 : listFiles) {
        System.out.println(file1.getName());
    }

    //获取文件大小
    long length = file.length();
    System.out.println(length);

    //设置文件为只读
    file.setReadOnly();

    //设置文件是否可写
    file.setWritable(false);

    //设置文件是否可读
    file.setReadable(false);

    //设置文件是否可执行
    file.setExecutable(false);

    //设置文件最后修改时间
    long time = System.currentTimeMillis();
    file.setLastModified(time);

    //比较两个文件路径
    File file1 = new File("D:\\test.txt");
    int compareTo = file.compareTo(file1);
    System.out.println(compareTo);

    //获取文件路径
    String path = file.getPath();
    System.out.println(path);

    //获取文件名
    String name = file.getName();
    System.out.println(name);

    //获取父目录路径
    String parent = file.getParent();
    System.out.println(parent);

    //获取绝对路径
    String absolutePath = file.getAbsolutePath();
    System.out.println(absolutePath);

    //获取规范路径
    String canonicalPath = file.getCanonicalPath();
    System.out.println(canonicalPath);

    //获取绝对文件
    File absoluteFile = file.getAbsoluteFile();
    System.out.println(absoluteFile);

    //获取规范文件
    File canonicalFile = file.getCanonicalFile();
    System.out.println(canonicalFile);

    //获取文件 URL
    URL url = file.toURL();
    System.out.println(url);

    //获取文件 URI
    URI uri = file.toURI();
    System.out.println(uri);

    //判断是否是绝对路径
    boolean isAbsolute = file.isAbsolute();
    System.out.println(isAbsolute);
}
```

</details>

</details>

## UUID

> [!TIP]
> 生成唯一标识符

| 方法         | 功能           |
| ------------ | -------------- |
| 静态方法     | ---            |
| randomUUID() | 获得随机 UUID  |
| fromString() | 根据字符串生成 |

<details>
<summary>详细语法</summary>

```java
import java.util.UUID;

public static void main(String[] args) {
    //?用处在文件夹等，需要唯一标识符的地方。
   System.out.println(UUID.randomUUID());
}
```

</details>

## Commons-io

> [!TIP]
> Commons-io 是 **apache** 开源基金组织提供的一组有关 `lO`
> 操作的开源工具包。 [下载](https://mvnrepository.com/artifact/commons-io/commons-io/2.11.0)
>
> lib 文件夹规范，里面存放项目所需的包，推荐创建并添加，<kbd> ctrl+alt+shift+s </kbd> 库 > 添加 > java,或者对 lib 目录右键>添加为库

### FileUtils 数据

| 类                                                               | 说明                         | tips               |
| ---------------------------------------------------------------- | ---------------------------- | ------------------ |
| static void copyFile(File srcFile, File destFile)                | 复制文件                     | ------             |
| static void copyDirectory(File srcDir, File destDir)             | 复制文件夹                   | 输出是文件集合     |
| static void copyDirectoryToDirectory(File srcDir, File destDir)  | 复制文件夹                   | 输出根路径是文件夹 |
| static void deleteDirectory(File directory)                      | 删除文件夹                   | 不保留文件夹       |
| static void cleanDirectory(File directory)                       | 清空文件夹                   | 保留文件夹         |
| static String readFileToString(File file, Charset encoding)      | 读取文件中的数据变成成字符串 | ------             |
| static void write(File file, CharSequence data, String encoding) | 写出数据                     | ------             |

<details>
<summary>更多语法</summary>

#### 复制文件夹

| 类                                                                    | 说明                                         |
| --------------------------------------------------------------------- | -------------------------------------------- |
| FileUtils.copyDirectory(File srcDir, File destDir)                    | 复制文件夹(文件夹里面的文件内容也会复制)     |
| FileUtils.copyDirectory(File srcDir, File destDir, FileFilter filter) | 复制文件夹，带有文件过滤功能                 |
| FileUtils.copyDirectoryToDirectory(File srcDir,File destDir)          | 以子目录的形式将文件夹复制到到另一个文件夹下 |

#### 复制文件

| 类                                                                                            | 说明                                    |
| --------------------------------------------------------------------------------------------- | --------------------------------------- |
| FileUtils.copyFile(File srcFile, File destFile)                                               | 复制文件                                |
| FileUtils.copyFile(File input, OutputStream output)                                           | 复制文件到输出流                        |
| FileUtils.copyFileToDirectory(File srcFile, File destDir)                                     | 复制文件到一个指定的目录                |
| FileUtils.copyInputStreamToFile(InputStream source,File destination)                          | 把输入流里面的内容复制到指定文件        |
| FileUtils.copyURLToFile(URL source, File destination)                                         | 把 URL 里面内容复制到文件(可以下载文件) |
| FileUtils.copyURLToFile(URL source, File destination, int connectionTimeout, int readTimeout) |                                         |

#### 把字符串写入文件

| 类                                                                                   |
| ------------------------------------------------------------------------------------ |
| FileUtils.writeStringToFile(File file, String data, String encoding)                 |
| FileUtils.writeStringToFile(File file, String data, String encoding, boolean append) |
| FileUtils.writeLines(File file, collection<?> lines, String lineEnding)              |

#### 把字节数组写入文件

| 类                                                                                      |
| --------------------------------------------------------------------------------------- |
| FileUtils.writeByteArrayToFile(File file, byte[] data)                                  |
| FileUtils.writeByteArrayToFile(File file, byte[] data, boolean append)                  |
| FileUtils.writeByteArrayToFile(file file,byte[] data, int off, int len)                 |
| FileUtils.writeByteArrayToFile(file file,byte[] data, int off, int len, boolean append) |

#### 把集合里面的内容写入文件

> encoding:文件编码，lineEnding:每行以什么结尾

| 类                                                                                                       |
| -------------------------------------------------------------------------------------------------------- |
| FileUtils.writeLines(File file, Collection<?> lines)                                                     |
| FileUtils.writeLines(File file, Collection<?> lines, boolean append)                                     |
| FileUtils.writeLines(File file, collection<?> lines, String lineEnding)                                  |
| FileUtils.writeLines(File file, Collection<?> lines, String lineEnding, boolean append)                  |
| FileUtils.writeLines(File file, String encoding, Collection<?> lines)                                    |
| FileUtils.writeLines(File file, String encoding, Collection<?> lines, boolean append)                    |
| FileUtils.writeLines(File file, String encoding, Collection<?> lines, String lineEnding)                 |
| FileUtils.writeLines(file file, String encoding, Collection<?> lines, String lineEnding, boolean append) |

#### 往文件里面写内容

| 类                                                                              |
| ------------------------------------------------------------------------------- |
| FileUtils.write(File file, CharSequence data, Charset encoding)                 |
| FileUtils.write(File file, CharSequence data, Charset encoding, boolean append) |
| FileUtils.write(File file, CharSequence data, String encoding)                  |
| FileUtils.write(File file, CharSequence data, String encoding, boolean append)  |

#### 文件移动

| 类                                                                                | 说明                                 |
| --------------------------------------------------------------------------------- | ------------------------------------ |
| FileUtils.moveDirectory(File srcDir, File destDir)                                | 文件夹在内的所有文件都将移动         |
| FileUtils.moveDirectoryToDirectory(File src, File destDir, boolean createDestDir) | 以子文件夹的形式移动到另外一个文件下 |
| FileUtils.moveFile(File srcFile, File destFile)                                   | 移动文件                             |
| FileUtils.moveFileToDirectory(File srcFile, File destDir, boolean createDestDir)  | 以子文件的形式移动到另外一个文件夹下 |
| FileUtils.moveToDirectory(File src, file destDir,boolean createDestDir)           | 移动文件或者目录到指定的文件夹内     |

#### 清空和删除文件夹

| 类                                        | 说明                                         |
| ----------------------------------------- | -------------------------------------------- |
| FileUtils.deleteDirectory(File directory) | 删除文件夹，包括文件夹和文件夹里面所有的文件 |
| FileUtils.cleanDirectory(File directory)  | 清空文件夹里面的所有的内容                   |
| FileUtils.forceDelete(File file)          | 删除，会抛出异常                             |
| FileUtils.deleteQuietly(File file)        | 删除，不会抛出异常                           |

#### 创建文件夹

| 类                                    | 说明                   |
| ------------------------------------- | ---------------------- |
| FileUtils.forceMkdir(File directory)  | 创建文件夹(可创建多级) |
| FileUtils.forceMkdirParent(File file) | 创建文件的父级目录     |

#### 获取文件输入/输出流

| 类                                    |
| ------------------------------------- |
| FileUtils.openInputStream(File file)  |
| FileUtils.openOutputStream(File file) |

#### 读取文件

| 类                                                      | 说明                   |
| ------------------------------------------------------- | ---------------------- |
| FileUtils.readFileToByteArray(File file)                | 把文件读取到字节数组   |
| FileUtils.readFileToString(File file, Charset encoding) | 把文件读取成字符串     |
| FileUtils.readFileToString(File file, String encoding)  |                        |
| FileUtils.readLines(File fie,Charset encoding)          | 把文件读取成字符串集合 |
| FileUtils.readLines(File file, String encoding)         |                        |

#### 测试两个文件的修改时间

| 类                                                |
| ------------------------------------------------- |
| FileUtils.isFileNewer(File file, Date date)       |
| FileUtils.isFileNewer(File file, File reference)  |
| FileUtils.isFileNewer(File file, long timeMillis) |
| FileUtils.isFileOlder(File file, Date date)       |
| FileUtils.isFileOlder(File file, File reference)  |
| FileUtils.isFileOlder(File file, long timeMillis) |

#### 文件/文件夹的送代

| 类                                                      | 说明                                   |
| ------------------------------------------------------- | -------------------------------------- |
| FileUtils.isSymlink(File file)                          | 判断是否是符号链接                     |
| FileUtils.directoryContains(File directory, File child) | 判断文件夹内是否包含某个文件或者文件夹 |
| FileUtils.sizeOf(File file)                             | 获取文件或者文件夹的大小               |
| FileUtils.getTempDirectory()                            | 获取临时目录文件                       |
| FileUtils.getTempDirectoryPath()                        | 获取临时目录路径                       |
| FileUtils.getUserDirectory()                            | 获取用户目录文件                       |
| FileUtils.getUserDirectoryPath()                        | 获取用户目录路径                       |

#### 其他

| 类                                                                                             |
| ---------------------------------------------------------------------------------------------- |
| FileUtils.iterateFiles(File directory, lOFileFilter fileFilter, lOFileFilter dirFilter)        |
| FileUtils.iterateFiles(File directory, String! extensions, boolean recursive)                  |
| FileUtils.iterateFilesAndDirs(File directory, lOFileFilter fileFilter, lOFileFilter dirFilter) |
| FileUtils.lineIterator(File file)                                                              |
| FileUtils.lineIterator(File file, String encoding)                                             |
| FileUtils.listFiles(File directory, lOFileFilter fileFilter, lOFileFilter dirFilter)           |
| FileUtils.listFiles(File directory, String! extensions, boolean recursive)                     |
| FileUtils.listFilesAndDirs(File directory, lOFileFilter fileFilter, lOFileFilter dirFilter)    |

</details>

### IOUtils 文件夹

| 类                                                             | 说明       |
| -------------------------------------------------------------- | ---------- |
| public static int copy(InputStream input, OutputStream output) | 复制文件   |
| public static int copyLarge(Reader input, Writer output)       | 复制大文件 |
| public static String readLines(Reader input)                   | 读取数据   |
| public static void write(String data, OutputStream output)     | 读取数据   |

<details>
<summary>更多语法</summary>

#### 拷贝方法

> copy 方法有多个重载方法，满足不同的输入输出流

| 类                                                                     | 说明                 |
| ---------------------------------------------------------------------- | -------------------- |
| IOUtils.copy(inputStream input, OutputStream output)                   |                      |
| IOUtils.copy(InputStream input, OutputStream output, int bufferSize)   | 可指定缓冲区大小     |
| IOUtils.copy(InputStream input, Writer output, String inputEncoding)   | 可指定输入流的编码表 |
| IOUtils.copy(Reader input, Writer output)                              |                      |
| I0Utils.copy(Reader input, OutputStream output, String outputEncoding) | 可指定输出流的编码表 |

#### 拷贝大文件的方法

> 这个方法适合拷贝较大的数据流，比如 2G 以上

| 类                                                            | 说明                              |
| ------------------------------------------------------------- | --------------------------------- |
| I0Utils.copyLarge(Reader input, Writer output)                | 默认会用 1024\*4 的 buffer 来读取 |
| I0Utils.copyLarge(Reader input, Writer output, char[] buffer) | 可指定缓冲区大小                  |

#### 将输入流转换成字符串

| 类                                                    |
| ----------------------------------------------------- |
| IOUtils.toString(Reader input)                        |
| IOUtils.toString(byte[] input, String encoding)       |
| IOUtils.toString(InputStream input, Charset encoding) |
| IOUtils.toString(inputStream input, String encoding)  |
| IOUtils.toString(URl uri, String encoding)            |
| IOUtils.toString(URL url, String encoding)            |

#### 将输入流转换成字符数组

| 类                                                 |
| -------------------------------------------------- |
| IOUtils.toByteArray(InputStream input)             |
| IOUtils.toByteArray(inputStream input, int size)   |
| IOUtils.toByteArray(URl uri)                       |
| IOUtils.toByteArray(URL url)                       |
| IOUtils.toByteArray(URLConnection urlConn)         |
| IOUtils.toByteArray(Reader input, String encoding) |

#### 字符串读写

| 类                                                                                                |
| ------------------------------------------------------------------------------------------------- |
| IOUtils.readLines(Reader input)                                                                   |
| IOUtils.readLines(inputStream input, Charset encoding)                                            |
| IOUtils.readLines(inputStream input, String encoding)                                             |
| IOUtils.writeLines(Collection<?> lines, String lineEnding, Writer writer)                         |
| IOUtils.writeLines(Collection<?> lines, String lineEnding, OutputStream output, Charset encoding) |
| IOUtils.writeLines(Collection<?> lines, String lineEnding, OutputStream output, String encoding)  |

#### 从一个流中读取内容

| 类                                                                     |
| ---------------------------------------------------------------------- |
| IOUtils.read(inputStream input, byte[] buffer)                         |
| IOUtils.read(inputStream input, byte[] buffer, int offset, int length) |
| IOUtils.read(Reader input, char[] buffer)                              |
| IOUtils.read(Reader input, char[] buffer, int offset, int length)      |

#### 从一个流中读取内容，如果读取的长度不够，就会抛出异常

| 类                                                                          |
| --------------------------------------------------------------------------- |
| IOUtils.readFully(inputStream input, int length)                            |
| IOUtils.readFully(inputStream input, byte[] buffer)                         |
| IOUtils.readFully(InputStream input, byte[] buffer, int offset, int length) |
| IOUtils.readFully(Reader input,char[] buffer)                               |
| IOUtils.readFully(Reader input, char[] buffer, int offset, int length)      |

#### 比较

| 类                                                           | 说明                   |
| ------------------------------------------------------------ | ---------------------- |
| IOUtils.contentEquals(InputStream input1,InputStream input2) | 比较两个流是否相等     |
| IOUtils.contentEquals(Reader input1, Reader input2)          |                        |
| IOUtils.contentEqualsIgnoreEOL(Reader input1,Reader input2)  | 比较两个流，忽略换行符 |

#### 其他方法

| 类                                                | 说明                                       |
| ------------------------------------------------- | ------------------------------------------ |
| IOUtils.skip(InputStream input, long toSkip)      | 跳过指定长度的流                           |
| IOUtils.skip(Reader input, long toSkip)           |                                            |
| IOUtils.skipFully(InputStream input, long toSkip) | 如果忽略的长度大于现有的长度，就会抛出异常 |
| IOUtils.skipFully(Reader input, long toSkip)      |                                            |

</details>

### FilenameUtils 文件名

| 类                                                                             | 说明                               |
| ------------------------------------------------------------------------------ | ---------------------------------- |
| FilenameUtils.concat(String basePath, String fullFilenameToAdd)                | 合并目录和文件名为文件全路径       |
| FilenameUtils.getBaseName(String filename)                                     | 去除目录和后缀后的文件名           |
| FilenameUtils.getExtension(String filename)                                    | 获取文件的后缀                     |
| FilenameUtils.getFullPath(String filename)                                     | 获取文件的目录                     |
| FilenameUtils.getName(String filename)                                         | 获取文件名                         |
| FilenameUtils.getPath(String filename)                                         | 去除盘符后的路径                   |
| FilenameUtils.getPrefix(String filename)                                       | 盘符                               |
| FilenameUtils.indexOfExtension(String filename)                                | 获取最后一个.的位置                |
| FilenameUtils.indexOfLastSeparator(String filename)                            | 获取最后一个/的位置                |
| FilenameUtils.normalize(String filename)                                       | 获取当前系统格式化路径             |
| FilenameUtils.removeExtension(String filename)                                 | 移除文件的扩展名                   |
| FilenameUtils.separatorsToSystem(String path)                                  | 转换分隔符为当前系统分隔符         |
| FilenameUtils.separatorsToUnix(String path)                                    | 转换分隔符为 linux 系统分隔符      |
| FilenameUtils.separatorsToWindows(String path)                                 | 转换分隔符为 windows 系统分隔符    |
| FilenameUtils.equals(String filename1,String filename2)                        | 判断文件路径是否相同，非格式化     |
| FilenameUtils.equalsNormalized(String filename1,String filename2)              | 判断文件路径是否相同，格式化       |
| FilenameUtils.directoryContains(String canonicalParent, String canonicalChild) | 判断目录下是否包含指定文件或目录   |
| FilenameUtils.isExtension(String filename, String extension)                   | 判断文件扩展名是否包含在指定集合中 |

## [Hutool](https://hutool.cn/)

> [!TIP]
> Hutool 是一个 Java 的第三方库 是比较常用和简易的库，优化标准库的使用体验，并且是在线[文档](https://plus.hutool.cn/apidocs/)
>
> 使用的比如创建文件，标准库中的如果传入路径中，不存在则返回异常，而它优化体验，自动创建文件夹，方法命名也几乎与标准库一致，导入时注意区分。
