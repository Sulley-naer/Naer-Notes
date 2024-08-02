# Java String

> [!TIP]
> 字符串处理，常用方法等
>
> 字符串对象其实是 `bytes` 数组进行记录使用的

创建方式

```java
final String text = "ABC";

char[] cars = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};
String test = new String(cars);

byte[] bytes = {97, 98, 99}; // A,B,C Ascll码表
final String str = new String(bytes);
```

## 方法 「methods」

1. 比较

   > [!TIP]
   > 字符串比较的是 `堆` 中的内存地址是否相同，引号写不通过 `new` 它是存储在栈帧中，所以能直接比较

   ```java
     import java.util.Objects;

     public static void main(String[] args){
       String b = 0;
        String c = 1;

        String a = new String(1);

        boolean result = b == c; //true
        boolean result = b == a; //false
        boolean result = Objects.equals(b, a); //true equals 方法判断对象值，而不是地址

        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();

        System.out.println(input=="value"); //false

        //它返回的字符串是 New String 对象，所以我们直接使用 "value" 判断无法通过 它返回的是堆中的地址

        // 所以我们需要使用 equals 方法来判断字符串是否相等

        // 或者使用 Objects.equals 方法来判断字符串是否相等

        System.out.println(input.equals("value")); //true
     }
   ```

   - 方法返回值查看

   1. 一直 Ctrl + 左键 去看 return 对象 基本上是套娃方法 继续转到方法声明处
   2. 右键>转到>实现！选择最符合的方法类型 再次重复上面 返回方法跳转查看
   3. `return new String(Arrays.copyOfRange(val, index, index + len), LATIN1);`
   4. 最后应该能看到熟悉的没有方法的代码了，它使用了 new string 就能知道了
   5. 它返回的字符串是 New String 对象，所以我们直接使用 "value" 判断无法通过 它返回的是堆中的地址

2. 索引

   > [!TIP]
   > 字符串索引同样是数组的方式, 也是从零计数

   ```java
   public static void main(String[] args){
     Scanner scanner = new Scanner(System.in);

     String str = scanner.nextLine();//? 获取输入字符串

     char c = str.charAt(0); // 取第一个字符

     for (int i = 0; i < str.length(); i++) {
            System.out.println(d.charAt(i));
          }
     }
   ```

3. 字符串截取

   > 获取字符串中特点位置的值，用于字符串处理

   ```java
   public static void main(String[] args) {
      String num = "12345678901";
      
      String stat = num.substring(0,3);
      
      String end = num.substring(7); //获取后面四位，参数为开始位置
   }
   ```

4. 大小写转换

   ```java
   public static void main(String[] args) {
      String num = "123456789";
      for (int i = 0; i < num.length(); i++) {
         System.out.println(uppercase(num.charAt(i)));
      }
   }
   
   public static String uppercase(char num){
      String[] list = {"零","壹","贰","叁","肆","伍","陆","柒","捌","玖"};
   
      return list[Integer.parseInt(num+"")];
   }
   ```

5. StringBuild

   > [!TIP]
   > `StringBuild` 是字符串容器的方法，里面包含了很多存储字符串，操作字符串等等方法。

   ```java
   
   public static void main(String[] args) {
      StringBuilder Box = new StringBuilder("default");
      //添加新的内容
      Box.append("1");
      //移除第一位字符
      Box.delete(0,1);
      //移除单字符，参数为序号
      Box.deleteCharAt(2);
      //似乎是排序？
      Box.indexOf("1",20);
      //反转
      Box.reverse();
      //获取长度
      Box.length();
      //转换字符类型，直接打印对象是内存地址
      Box.toString();
      //链式编程是指方法在一行内写完,面试会用到吧
      Box.append("1").append("2").append("3");
   }
   ```

6. StringJoiner

> [!TIP]
> `StringJoiner` 是用于帮助添加字符串中的连接字符 `char1--char2`

```java
import java.util.StringJoiner;

public static void main(String[] args) {
   StringJoiner Box = new StringJoiner("-", "[", "]");//三个参数：连接词，预加词，追加词
   // 添加了A和B 输出：[a-b]
   StringJoiner Box = new StringJoiner("=");
   Box.add(A).add("1");
   System.out.println(Box);
}
```

## [正则](../Mysql/Get%20started.md#模糊查询正则查询)

> [!TIP]
> Java 正则需要引入标准库中的正则相应类库

| 类型     | 作用                                                     |
|--------|--------------------------------------------------------|
| （^）    | 匹配字符串的开始位置，如“^a”表示以字母 a 开头的字符串。                        |
| （$）    | 匹配字符串的结束位置，如“X^”表示以字母 X 结尾的字符串。                        |
| （.）    | 这个字符就是英文下的点，它匹配**任何一个字符**，包括回车、换行等。 通配符 \_             |
| （\*）   | 星号匹配 0 个或多个字符，在它之前必须有内容。通配符 % 后续字符等于之前的字符              |
| （+）    | 加号匹配 1 个或多个字符，星号允许出现 0 次，加号必须出现一次。a+ 后面至少一个 a          |
| {n}    | 匹配指定 n 个 ab{3} abbb 有 3 个 (ab){3} ababab .{3} 任意字符出现三次 |
| {n,}   | 匹配不少于 n 个 字面意思，跟上面语法相同                                 |
| {n,m}  | 匹配 n-m 个 字面意思，语法相同                                     |
| a?     | ?为断言匹配，自动填充，结果可为 `[字符]`或者 a`[字符]` 它可存在，可不存在 量子态        |
| (ab)?a | 断言匹配，结果可为 aba 或者 c 和上面的用法称为**量词**                      |
| .\*?b  | .是如何字符，\*让第二字符必须和.的相同，?让\*的匹配可有可无，最后一位强制 b             |
| a+?    | a+ 特性为后面字符必须有一个 a，要么单 a 要么出至少有 2 个 a。 非贪婪量词            |
| （?!）   | a(?!b) 匹配到 a，只要 a 后面不紧跟着 b 零宽度负向前瞻                     |
| （?=）   | a(?=b) 结果可为 a 或者 a 后面紧跟着 b 的字符 零宽度正向前瞻                 |
| （?<!）  | b(?<!a) 与(?!)相同，只不过是前面不能有字符 a 零宽度负向回顾                  |
| （?<=）  | b(?<!a) 与(?=)相同，只不过是前面有 字符 a 零宽度正向回顾                   |
| 考验成果   | `select * from student where sname regexp '^张.*?$'`    |

1. `'字符'` ：相当于 '%字符%'
2. `|`：表示或 匹配多数据
3. `.+`：**当前字段** `.` 匹配任意字符 `+` 包括空格、换行符等。
4. `[]`：**当前字段** 匹配指定范围内的字符。`[a-z]` `[1-9]` `[a-zA-Z0-9]` 高版本不区分大小写。
5. `[^]`：匹配不在指定范围内的字符。 无法使用 可在表达式前添加 `NOT`
6. `[5|6|7|8|9]` : 不代表或 它识别为 | 为字符了。`^[5|6|7]` 才能表达 或
7. `[5|6|7]$` 匹配以 5、6、7 结尾的字符串。
8. 字节匹配
9. `^.{10}$` 匹配 10 个字节的字符串。 `[a-z{10}$]` 英文 10 字节
10. UTF8 编码下，一个中文字符占 3 个字节。 GBK 2 个字节。
11. 英文字符占 1 个字节。 GBK 1 个字节。
12. 数字占 1 个字节。 GBK 1 个字节。
13. `BINARY ^'[A-Z]{10}$'` 匹配大写字母 10 个字节的字符串。
14. `^.{10}|` 匹配 10 个字节的字符串或以 | 结尾的字符串。
15. `^[0-9.]{6}$` 匹配 6 位数字或小数点的字符串。| 版本号
16. `^1[0-9.]{5}$` 以 1 开头 数字 或者 . 是 5 字节的 字符串。
17. `^1[0-9.]{4}7$` 首为 1 末为 7 ……
18. `{4,6}$` 匹配 4-6 字节的字符串。
19. `^(.{1}|.{7})$` 匹配 为 1 或 7 字节的单个字符
20. `^[^ -~]` 首字中文。`[^]` 为非字符。`-~` 从空格到~ ASCII 所有字符。
21. `^([a-z]|[0-9]|[A-Z])+$` 匹配不包含空格、换行符、中文的字符串。
22. `\\d+` 匹配数字。
23. `\\D+` 匹配非数字。
24. `\\w+` 匹配单词字符。
25. `\\W+` 匹配非单词字符。
26. `\\s+` 匹配空白字符。
27. `\\S+` 匹配非空白字符。
28. `\\b` 匹配单词边界。
29. `\\B` 匹配非单词边界。
30. `^` 表示行的开始
31. `.`匹配任何单个字符(除了换行符)
32. `$` 表示行的结束
33. `[]` 表示范围！一个字符为你的表达式内
34. `\\.` 特殊符号须转义！`[,]` 范围内可不用转义
35. `()` 正则表达式结果分组

> 简易利用正则匹配字符串 利用了括号分组 [文档](https://www.runoob.com/java/java-regular-expressions.html)

```java
import java.util.regex; //Pattern 正则表达式 //matcher 匹配对象
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public static void main(String[] args) {
   String number;
   number = "15023389356";

   Pattern r = Pattern.compile("^(.{3})(.{5})(.{3})");
   Matcher m = r.matcher(number);

   while (m.find()) {
      System.out.println(m.group(0)); // 全部结果，没打组的返回对象
      System.out.println(m.group(1));
      System.out.println(m.group(2));
      System.out.println(m.group(3));
   }
}
```

## 原理

1. 编译Class时候，Java变量存储

```java
//编译时栈帧会查看，与否有变量参与计算，无则直接合并存储结果
public static void main(String[] args) {
   //1. 字符串连接，直接计算
   String st1 = "1+1+1+1";
   //2. 变量连接，栈帧调用堆
   String st2 = st1 + "1";
}
```

1. 字符串连接
   1. 栈帧发现有变量参与计算，就会去调用 stringBuilder类
   2. 实例化SB类，再调用addend方法添加内存，再存储它的计算结果。
   3. 可去string》toString》newString 源码中查看，返回的结果
   4. JDK8 之后 性能优化，会在调用方法前，获取栈帧的值，判断长度，小则直接连接，省去循环
2. 变量连接
   1. 结论：JDK8前无论长度都会创建 "+" 个sb对象,造成性能资源浪费
   2. 而在JDK8时，它加入了字符长度判断，还会连接时先获取变量判断，大于则创建SB
   3. 所以：JDK8需连接直接用SB，JDK8 连接的字符不要太多，造成判断的性能浪费，还可能创建多个SB
3. StringBuild
   1. Sb在添加的内容实际是一个数组，数组中有长度，默认为16字节
   2. 在添加新内容，发现数组长度不够了，它会尝试扩容 默认增长 `*2+2`
   3. 如果增长之后长度还是不够，如果长度依然不够它就会以 增长**内容的长度**为准