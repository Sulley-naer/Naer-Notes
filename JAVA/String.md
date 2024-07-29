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

1.比较

> [!TIP]
> 字符串比较的是 `堆` 中的内存地址是否相同，直接写不通过 `new` 同值地址是分配相同地址

```java
import java.util.Objects;

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

```

方法返回值查看

1. 一直 Ctrl + 左键 去看 return 对象 基本上是套娃方法 继续转到方法声明处
2. 右键>转到>实现！选择最符合的方法类型 再次重复上面 返回方法跳转查看
3. `return new String(Arrays.copyOfRange(val, index, index + len), LATIN1);`
4. 最后应该能看到熟悉的没有方法的代码了，它使用了 new string 就能知道了
5. 它返回的字符串是 New String 对象，所以我们直接使用 "value" 判断无法通过 它返回的是堆中的地址

[//]: # "2."
