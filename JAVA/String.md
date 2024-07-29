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
```

[//]: # (2.)