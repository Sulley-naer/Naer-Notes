# Java 标准库

- [Java 标准库](#java-标准库)
  - [定义类](#定义类)
  - [导入类 | Java 类库包](#导入类--java-类库包)
  - [官方类库语法](#官方类库语法)
  - [1. java.lang](#1-javalang)
    - [1. Object：所有类的基类](#1-object所有类的基类)
    - [2. Class：类对象，用于描述类的属性和方法](#2-class类对象用于描述类的属性和方法)
    - [3. System：系统类，用于获取系统相关信息](#3-system系统类用于获取系统相关信息)
    - [4. String：字符串类，用于处理字符串](#4-string字符串类用于处理字符串)
    - [5. StringBuilder：字符串构建器，用于构建字符串](#5-stringbuilder字符串构建器用于构建字符串)
    - [6. Math：数学运算类](#6-math数学运算类)
    - [7. Thread：线程类，用于创建和控制线程](#7-thread线程类用于创建和控制线程)
    - [8. Exception：异常类 \&\& RuntimeException 继承异常](#8-exception异常类--runtimeexception-继承异常)
    - [9. Throwable：所有异常类的父类，它包含了异常的基本信息和方法](#9-throwable所有异常类的父类它包含了异常的基本信息和方法)
    - [10. Integer：整数类，用于处理整数](#10-integer整数类用于处理整数)
    - [11. Double：浮点类](#11-double浮点类)
    - [12. Boolean：布尔类型](#12-boolean布尔类型)
    - [13. Character：字符类型](#13-character字符类型)
  - [2. java.util](#2-javautil)
    - [1. ArrayList：动态数组](#1-arraylist动态数组)
    - [2. LinkedList：双向链表](#2-linkedlist双向链表)
    - [3. HashMap：哈希表](#3-hashmap哈希表)
    - [4. HashSet：哈希集](#4-hashset哈希集)
    - [5. Date：日期类](#5-date日期类)
    - [6. TreeMap：有序哈希表](#6-treemap有序哈希表)
    - [7. Collections：集合工具类](#7-collections集合工具类)
    - [8. Calendar：日历类](#8-calendar日历类)
    - [9. Random：随机数生成器](#9-random随机数生成器)
    - [10. UUID：通用唯一标识符](#10-uuid通用唯一标识符)
    - [11. Scanner：扫描器](#11-scanner扫描器)
    - [12. PriorityQueue：优先级队列](#12-priorityqueue优先级队列)
    - [13. Stack：栈](#13-stack栈)
  - [3. java.io](#3-javaio)
    - [1. File：文件类，用于处理文件](#1-file文件类用于处理文件)
    - [2. FileInputStream：文件输入流](#2-fileinputstream文件输入流)
    - [3. FileOutputStream 输出文件流](#3-fileoutputstream-输出文件流)
    - [4. BufferedReader：传输输入流](#4-bufferedreader传输输入流)
    - [5. BufferedWriter：传输写入流](#5-bufferedwriter传输写入流)
    - [6. InputStreamReader：字符输入流](#6-inputstreamreader字符输入流)
    - [7. OutputStreamWriter：字符输出流](#7-outputstreamwriter字符输出流)
    - [8. PrintWriter：输出写入](#8-printwriter输出写入)
    - [9. DataInputStream：日期输入流](#9-datainputstream日期输入流)
    - [10. DataOutputStream：日期输出流](#10-dataoutputstream日期输出流)
    - [11. ObjectInputStream：对象输入流](#11-objectinputstream对象输入流)
    - [12. ObjectOutputStream：对象输出流](#12-objectoutputstream对象输出流)
  - [4. java.net](#4-javanet)
    - [1. URL：统一资源定位符，用于表示网络资源的位置](#1-url统一资源定位符用于表示网络资源的位置)
    - [2. URLConnection：网络连接类，用于处理网络连接](#2-urlconnection网络连接类用于处理网络连接)
    - [3. HttpURLConnection：HTTP 连接类，用于处理 HTTP 连接](#3-httpurlconnectionhttp-连接类用于处理-http-连接)
    - [4. Socket：套接字类，用于处理网络连接](#4-socket套接字类用于处理网络连接)
    - [5. ServerSocket：服务器套接字类，用于处理服务器端套接字](#5-serversocket服务器套接字类用于处理服务器端套接字)
    - [6. InetAddress：网络地址类，用于表示 IP 地址](#6-inetaddress网络地址类用于表示-ip-地址)
  - [5. java.sql](#5-javasql)
    - [1. Connection：数据库连接类，用于处理数据库连接](#1-connection数据库连接类用于处理数据库连接)
    - [2. Statement：SQL 语句对象，用于执行 SQL 语句](#2-statementsql-语句对象用于执行-sql-语句)
    - [3. PreparedStatement：预编译 SQL 语句对象，用于执行预编译 SQL 语句](#3-preparedstatement预编译-sql-语句对象用于执行预编译-sql-语句)
    - [4. ResultSet：结果集对象，用于处理查询结果](#4-resultset结果集对象用于处理查询结果)
    - [5. DatabaseMetaData：数据库元数据类，用于获取数据库元数据](#5-databasemetadata数据库元数据类用于获取数据库元数据)
    - [6. CallableStatement：存储过程调用对象，用于执行存储过程](#6-callablestatement存储过程调用对象用于执行存储过程)
  - [6. javax.swing](#6-javaxswing)
    - [1. JFrame：窗体组件](#1-jframe窗体组件)
    - [2. JDialog：对话框组件](#2-jdialog对话框组件)
    - [1. JComboBox：下拉列表框组件](#1-jcombobox下拉列表框组件)
    - [2. JTable：表格组件](#2-jtable表格组件)
    - [3. JCheckBox：复选框组件](#3-jcheckbox复选框组件)
    - [4. JRadioButton：单选按钮组件](#4-jradiobutton单选按钮组件)
    - [5. JTextArea：多行文本框组件](#5-jtextarea多行文本框组件)
    - [6. JTextField：单行文本框组件](#6-jtextfield单行文本框组件)
    - [7. JPasswordField：密码文本框组件](#7-jpasswordfield密码文本框组件)
    - [8. JMenu：菜单组件](#8-jmenu菜单组件)
    - [9. JMenuBar：菜单栏组件](#9-jmenubar菜单栏组件)
    - [10. JMenuItem：子菜单项组件](#10-jmenuitem子菜单项组件)
    - [11. JTabbedPane：选项卡组件](#11-jtabbedpane选项卡组件)
    - [12. JScrollPane：滚动面板组件](#12-jscrollpane滚动面板组件)
    - [13. JList：列表组件](#13-jlist列表组件)
    - [14. JFileChooser：文件选择器组件](#14-jfilechooser文件选择器组件)
    - [15.JButton：按钮组件](#15jbutton按钮组件)

## 定义类

```java
public class MyClass {
    // 成员变量
    private int myInt;
    private String myString;

    // 构造方法
    public MyClass(int myInt, String myString) {
        this.myInt = myInt;
        this.myString = myString;
    }

    // 成员方法
    public void print() {
        System.out.println("myInt: " + myInt);
        System.out.println("myString: " + myString);
    }
}
```

## 导入类 | Java 类库包

> [!TIP]
> Java 需要导入类库包才能使用类库中的类。Java 类库包分为标准类库包和第三方类库包。
>
> 标准库包：Java 运行环境自带的类库包，它的用处是 Java 可选依赖可以剩下一些不必要的类，符合模块化开发，减少程序体积。
>
> 第三方库包：由第三方开发者开发的类库包，使用别人的类库，可以帮助我们在开发时，减少一些重复性的工作。也可以省下自身的开发时间

导入类库包：

```java
import java.util.ArrayList;

public class MyClass {
    // 成员变量
    private int myInt;
    private String myString;
    private ArrayList<String> myList;

    // 构造方法
    public MyClass(int myInt, String myString) {
        this.myInt = myInt;
        this.myString = myString;
        this.myList = new ArrayList<>();
    }

    // 成员方法
    public void print() {
        System.out.println("myInt: " + myInt);
        System.out.println("myString: " + myString);
        System.out.println("myList: " + myList);
    }
}
```

## 官方类库语法

- `java.lang`：Java 语言核心类库，包含了 Java 语言的基本类和接口。
- `java.util`：Java 集合类库，包含了 Java 集合框架的类和接口。
- `java.io`：Java 输入输出类库，包含了 Java 输入输出流的类和接口。
- `java.net`：Java 网络类库，包含了 Java 网络编程的类和接口。
- `java.sql`：Java 数据库类库，包含了 Java 数据库编程的类和接口。
- `javax.swing`：Java 图形用户界面类库，包含了 Java 图形用户界面开发的类和接口。

## 1. java.lang

<details>
  <summary>展开</summary>

### 1. Object：所有类的基类

```java
Object() // 构造方法
String toString() // 转换为字符串
Class<?> getClass() // 获取类对象
int hashCode() // 获取哈希码
boolean equals(Object obj) // 比较两个对象是否相等
void notify() // 唤醒一个线程
void notifyAll() // 唤醒所有线程
void wait() // 等待通知
```

### 2. Class：类对象，用于描述类的属性和方法

```java
Class<?> forName(String className) // 根据类名获取类对象
String getName() // 获取类名
Class<?> getSuperclass() // 获取父类
Class<?>[] getInterfaces() // 获取接口
boolean isInterface() // 判断是否是接口
boolean isArray() // 判断是否是数组
boolean isPrimitive() // 判断是否是基本类型
T newInstance() // 创建类的实例
```

### 3. System：系统类，用于获取系统相关信息

```java
long currentTimeMillis() // 获取当前时间戳
String getProperty(String key) // 获取系统属性
String getenv(String name) // 获取环境变量
void exit(int status) // 退出程序
void arraycopy(Object src, int srcPos, Object dest, int destPos, int length) // 复制数组
String setProperty(String key, String value) // 设置系统属性
void gc() // 运行垃圾回收器
```

### 4. String：字符串类，用于处理字符串

```java
String(byte[] bytes) // 根据字节数组创建字符串
String(byte[] bytes, int offset, int length) // 根据字节数组的某一部分创建字符串
String(char[] value) // 根据字符数组创建字符串
String(char[] value, int offset, int length) // 根据字符数组的某一部分创建字符串
String(String original) // 根据字符串创建字符串
String(StringBuffer buffer) // 根据 StringBuffer 创建字符串
String(StringBuilder builder) // 根据 StringBuilder 创建字符串
int length() // 获取字符串长度
char charAt(int index) // 获取指定索引处的字符
int codePointAt(int index) // 获取指定索引处的 Unicode 码点
int codePointBefore(int index) // 获取指定索引前的 Unicode 码点
int codePointCount(int beginIndex, int endIndex) // 获取指定范围内的 Unicode 码点数量
int offsetByCodePoints(int index, int codePointOffset) // 获取指定索引处的偏移量
String getChars(int srcBegin, int srcEnd, char[] dst, int dstBegin) // 将字符串复制到字符数组
String substring(int beginIndex) // 获取子字符串
String substring(int beginIndex, int endIndex) // 获取子字符串
String replace(char oldChar, char newChar) // 替换字符串中的字符
String replaceAll(String regex, String replacement) // 使用正则表达式替换字符串
String replaceFirst(String regex, String replacement) // 使用正则表达式替换字符串中的第一个匹配项
String[] split(String regex) // 使用正则表达式分割字符串
String[] split(String regex, int limit) // 使用正则表达式分割字符串，最多分割 limit 次
String toLowerCase() // 转换为小写
String toUpperCase() // 转换为大写
String trim() // 去除首尾空白字符
boolean isEmpty() // 判断是否为空字符串
boolean equals(Object anObject) // 比较两个字符串是否相等
boolean contentEquals(StringBuffer sb) // 判断两个字符串是否相等
boolean contentEquals(CharSequence cs) // 判断两个字符串是否相等
int compareTo(String anotherString) // 比较两个字符串的大小
String concat(String str) // 连接两个字符串
String intern() // 尝试将字符串加入常量池
boolean contains(CharSequence s) // 判断字符串是否包含指定字符序列
boolean equalsIgnoreCase(String anotherString) // 判断两个字符串是否忽略大小写的相等
```

### 5. StringBuilder：字符串构建器，用于构建字符串

```java
StringBuilder append(String str) // 追加字符串
StringBuilder append(int i) // 追加整数
StringBuilder append(char c) // 追加字符
StringBuilder delete(int start, int end) // 删除指定范围的字符
StringBuilder insert(int offset, String str) // 插入字符串
String toString() // 转换为字符串
```

### 6. Math：数学运算类

```java
int abs(int a) // 绝对值
double abs(double a) // 绝对值
int compare(int x, int y) // 比较两个整数
int compare(long x, long y) // 比较两个长整数
double ceil(double a) // 向上取整
double floor(double a) // 向下取整
double max(double a, double b) // 最大值
double min(double a, double b) // 最小值
double pow(double a, double b) // 计算 a 的 b 次方
double random() // 生成一个随机数
double sqrt(double a) // 计算平方根
long round(double a) // 四舍五入
int signum(int a) // 符号函数
```

### 7. Thread：线程类，用于创建和控制线程

```java
void start() // 启动线程
void run() // 线程执行体
void join() // 等待线程结束
void sleep(long millis) // 线程休眠
Thread.State getState() // 获取线程状态
Thread.interrupt() // 中断线程
Thread.isAlive() // 判断线程是否存活
Thread.yield() // 让出当前线程的执行权
Thread.currentThread() // 获取当前线程
Thread(Runnable target) // 创建线程
```

### 8. Exception：异常类 && RuntimeException 继承异常

```java
String getMessage() // 获取异常信息
String getLocalizedMessage() // 获取本地化异常信息
Throwable getCause() // 获取异常原因
void printStackTrace() // 打印异常栈跟踪信息
```

### 9. Throwable：所有异常类的父类，它包含了异常的基本信息和方法

```java
String getMessage() // 获取异常信息
String getLocalizedMessage() // 获取本地化异常信息
Throwable getCause() // 获取异常原因
void printStackTrace() // 打印异常栈跟踪信息
```

### 10. Integer：整数类，用于处理整数

```java
Integer(int value) // 创建 Integer 对象
int intValue() // 获取整数值
static String toString(int i) // 转换为字符串
static int parseInt(String s) // 转换为整数
static int parseInt(String s, int radix) // 转换为整数
static Integer valueOf(String s) // 转换为 Integer 对象
static Integer valueOf(String s, int radix) // 转换为 Integer 对象
```

### 11. Double：浮点类

```java
Double(double value) // 创建 Double 对象
double doubleValue() // 获取浮点值
static String toString(double d) // 转换为字符串
static double parseDouble(String s) // 转换为浮点数
static Double valueOf(String s) // 转换为 Double 对象
```

### 12. Boolean：布尔类型

```java
Boolean(boolean value) // 创建 Boolean 对象
boolean booleanValue() // 获取布尔值
static Boolean valueOf(String s) // 转换为 Boolean 对象
static Boolean valueOf(boolean b) // 转换为 Boolean 对象
```

### 13. Character：字符类型

```java
Character(char value) // 创建 Character 对象
char charValue() // 获取字符值
static String toString(char c) // 转换为字符串
static Character valueOf(char c) // 转换为 Character 对象
```

</details>

## 2. java.util

<details>
  <summary>展开</summary>

### 1. ArrayList：动态数组

```java
ArrayList() // 创建 ArrayList 对象
ArrayList(int initialCapacity) // 创建 ArrayList 对象，指定初始容量
void add(int index, E element) // 在指定位置添加元素
boolean addAll(Collection<? extends E> c) // 添加集合中的所有元素
boolean addAll(int index, Collection<? extends E> c) // 在指定位置添加集合中的所有元素
void clear() // 清空 ArrayList
boolean contains(Object o) // 判断 ArrayList 中是否包含指定元素
int indexOf(Object o) // 获取 ArrayList 中指定元素的索引
int lastIndexOf(Object o) // 获取 ArrayList 中指定元素的最后出现位置
E remove(int index) // 删除指定位置的元素
boolean remove(Object o) // 删除指定元素
boolean removeAll(Collection<?> c) // 删除所有包含在指定集合中的元素
boolean retainAll(Collection<?> c) // 保留所有包含在指定集合中的元素
E set(int index, E element) // 设置指定位置的元素
int size() // 获取 ArrayList 的大小
List<E> subList(int fromIndex, int toIndex) // 获取子列表
Object[] toArray() // 转换为数组
<T> T[] toArray(T[] a) // 转换为数组
```

### 2. LinkedList：双向链表

```java
LinkedList() // 创建 LinkedList 对象
void add(int index, E element) // 在指定位置添加元素
boolean addAll(Collection<? extends E> c) // 添加集合中的所有元素
boolean addAll(int index, Collection<? extends E> c) // 在指定位置添加集合中的所有元素
void addFirst(E e) // 添加元素到头部
void addLast(E e) // 添加元素到尾部
void clear() // 清空 LinkedList
boolean contains(Object o) // 判断 LinkedList 中是否包含指定元素
int indexOf(Object o) // 获取 LinkedList 中指定元素的索引
int lastIndexOf(Object o) // 获取 LinkedList 中指定元素的最后出现位置
E remove() // 删除头部元素
E remove(int index) // 删除指定位置的元素
boolean remove(Object o) // 删除指定元素
boolean removeAll(Collection<?> c) // 删除所有包含在指定集合中的元素
boolean retainAll(Collection<?> c) // 保留所有包含在指定集合中的元素
E set(int index, E element) // 设置指定位置的元素
int size() // 获取 LinkedList 的大小
List<E> subList(int fromIndex, int toIndex) // 获取子列表
Object[] toArray() // 转换为数组
<T> T[] toArray(T[] a) // 转换为数组
```

### 3. HashMap：哈希表

```java
HashMap() // 创建 HashMap 对象
HashMap(int initialCapacity) // 创建 HashMap 对象，指定初始容量
HashMap(int initialCapacity, float loadFactor) // 创建 HashMap 对象，指定初始容量和负载因子
void clear() // 清空 HashMap
boolean containsKey(Object key) // 判断 HashMap 中是否包含指定键
boolean containsValue(Object value) // 判断 HashMap 中是否包含指定值
Set<Map.Entry<K,V>> entrySet() // 获取 HashMap 的 entrySet
V get(Object key) // 获取指定键对应的值
boolean isEmpty() // 判断 HashMap 是否为空
Set<K> keySet() // 获取 HashMap 的 keySet
V put(K key, V value) // 添加键值对
void putAll(Map<? extends K,? extends V> m) // 添加集合中的所有键值对
V remove(Object key) // 删除指定键对应的值
int size() // 获取 HashMap 的大小
Collection<V> values() // 获取 HashMap 的 values
```

### 4. HashSet：哈希集

```java
HashSet() // 创建 HashSet 对象
HashSet(int initialCapacity) // 创建 HashSet 对象，指定初始容量
boolean add(E e) // 添加元素
void clear() // 清空 HashSet
boolean contains(Object o) // 判断 HashSet 中是否包含指定元素
boolean isEmpty() // 判断 HashSet 是否为空
Iterator<E> iterator() // 获取迭代器
boolean remove(Object o) // 删除指定元素
int size() // 获取 HashSet 的大小
Object[] toArray() // 转换为数组
<T> T[] toArray(T[] a) // 转换为数组
```

### 5. Date：日期类

```java
Date() // 创建当前日期
Date(long date) // 创建指定日期
Date(int year, int month, int date) // 创建指定年月日
Date(int year, int month, int date, int hrs, int min) // 创建指定年月日时分
Date(int year, int month, int date, int hrs, int min, int sec) // 创建指定年月日时分秒
Date(String s) // 创建指定日期字符串
long getTime() // 获取日期的毫秒值
int getYear() // 获取年份
int getMonth() // 获取月份（0-11）
int getDate() // 获取日期（1-31）
int getDay() // 获取星期（0-6，0 代表星期日）
int getHours() // 获取小时（0-23）
int getMinutes() // 获取分钟（0-59）
int getSeconds() // 获取秒（0-59）
void setTime(long time) // 设置日期的毫秒值
void setYear(int year) // 设置年份
void setMonth(int month) // 设置月份（0-11）
void setDate(int date) // 设置日期（1-31）
void setHours(int hours) // 设置小时（0-23）
void setMinutes(int minutes) // 设置分钟（0-59）
void setSeconds(int seconds) // 设置秒（0-59）
String toLocaleString() // 转换为本地日期字符串
String toGMTString() // 转换为 GMT 日期字符串
```

### 6. TreeMap：有序哈希表

```java
TreeMap() // 创建 TreeMap 对象
void clear() // 清空 TreeMap
Comparator<? super K> comparator() // 获取 TreeMap 的比较器
K firstKey() // 获取 TreeMap 中的第一个键
K lastKey() // 获取 TreeMap 中的最后一个键
V get(Object key) // 获取指定键对应的值
V put(K key, V value) // 添加键值对
void putAll(Map<? extends K,? extends V> m) // 添加集合中的所有键值对
V remove(Object key) // 删除指定键对应的值
int size() // 获取 TreeMap 的大小
SortedMap<K,V> subMap(K fromKey, K toKey) // 获取子 TreeMap
SortedMap<K,V> headMap(K toKey) // 获取小于等于指定键的子 TreeMap
SortedMap<K,V> tailMap(K fromKey) // 获取大于等于指定键的子 TreeMap
```

### 7. Collections：集合工具类

```java
static void shuffle(List<?> list) // 随机排序列表
static <T> void sort(List<T> list) // 按自然顺序排序列表
static <T> void sort(List<T> list, Comparator<? super T> c) // 按指定比较器排序列表
static <T> void reverse(List<T> list) // 反转列表
static <T> boolean replaceAll(List<T> list, T oldVal, T newVal) // 替换列表中的所有元素
static <T> List<T> unmodifiableList(List<? extends T> list) // 创建不可修改的列表
static <T> Set<T> unmodifiableSet(Set<? extends T> set) // 创建不可修改的集合
static <T> Set<T> unmodifiableSet(Set<T> set) // 创建不可修改的集合
static <K,V> Map<K,V> unmodifiableMap(Map<? extends K,? extends V> m) // 创建不可修改的映射
static <T> List<T> synchronizedList(List<T> list) // 创建同步的列表
static <T> Set<T> synchronizedSet(Set<T> set) // 创建同步的集合
static <K,V> Map<K,V> synchronizedMap(Map<K,V> m) // 创建同步的映射
```

### 8. Calendar：日历类

```java
Calendar.getInstance() // 获取当前日历
Calendar.getInstance(Locale locale) // 获取指定地区的日历
void add(int field, int amount) // 调整日历字段
int get(int field) // 获取日历字段
void set(int field, int value) // 设置日历字段
int getActualMaximum(int field) // 获取指定日历字段的最大值
int getActualMinimum(int field) // 获取指定日历字段的最小值
String getDisplayName(int field, int style, Locale locale) // 获取指定日历字段的显示名称
String[] getDisplayNames(int field, int style, Locale locale) // 获取指定日历字段的所有显示名称
int getFirstDayOfWeek() // 获取一周的第一天
int getGregorianChange() // 获取格里高利历的变更日
int getLeastMaximum(int field) // 获取指定日历字段的最小值
int getMaximum(int field) // 获取指定日历字段的最大值
int getMinimum(int field) // 获取指定日历字段的最小值
int getWeekYear() // 获取周年
int getWeeksInWeekYear() // 获取周年中的星期数
int get(int field, int[] values) // 获取指定日历字段的多个值
void set(int field, int value) // 设置日历字段
void set(int year, int month, int date) // 设置年月日
void set(int year, int month, int date, int hrs, int min) // 设置年月日时分
void set(int year, int month, int date, int hrs, int min, int sec) // 设置年月日时分秒
```

### 9. Random：随机数生成器

```java
Random() // 创建随机数生成器
Random(long seed) // 创建指定种子的随机数生成器
double nextDouble() // 生成一个随机 double 值
float nextFloat() // 生成一个随机 float 值
double nextGaussian() // 生成一个高斯随机值
int nextInt() // 生成一个随机 int 值
int nextInt(int bound) // 生成一个随机 int 值，范围为 [0, bound)
long nextLong() // 生成一个随机 long 值
void setSeed(long seed) // 设置种子
```

### 10. UUID：通用唯一标识符

```java
UUID.randomUUID() // 生成 UUID
String toString() // 转换为字符串
```

### 11. Scanner：扫描器

```java
Scanner(InputStream in) // 创建 Scanner 对象
Scanner(InputStream in, String charsetName) // 创建 Scanner 对象，指定字符集
Scanner(File file) // 创建 Scanner 对象，指定文件
Scanner(File file, String charsetName) // 创建 Scanner 对象，指定文件和字符集
Scanner(String s) // 创建 Scanner 对象，指定字符串
Scanner(String s, String charsetName) // 创建 Scanner 对象，指定字符串和字符集
void close() // 关闭 Scanner
boolean hasNext() // 判断是否还有下一个元素
String next() // 读取下一个元素
String nextLine() // 读取下一行
String findInLine(String pattern) // 在当前行查找指定模式
String findWithinHorizon(String pattern, int horizon) // 在当前行查找指定模式，指定范围
String useDelimiter(String pattern) // 使用指定模式分隔输入
```

### 12. PriorityQueue：优先级队列

```java
PriorityQueue() // 创建优先级队列
PriorityQueue(int initialCapacity) // 创建优先级队列，指定初始容量
PriorityQueue(int initialCapacity, Comparator<? super E> comparator) // 创建优先级队列，指定初始容量和比较器
boolean add(E e) // 添加元素
boolean offer(E e) // 添加元素
E peek() // 获取第一个元素
E poll() // 获取并删除第一个元素
E remove() // 获取并删除第一个元素
int size() // 获取队列大小
```

### 13. Stack：栈

```java
Stack() // 创建栈
boolean empty() // 判断栈是否为空
E peek() // 获取栈顶元素
E pop() // 弹出栈顶元素
E push(E item) // 压入元素
int search(Object o) // 查找元素
int size() // 获取栈大小
```

</details>

## 3. java.io

<details>
  <summary>展开</summary>

### 1. File：文件类，用于处理文件

```java
boolean canRead() // 判断文件是否可读
boolean canWrite() // 判断文件是否可写
boolean createNewFile() // 创建新文件
boolean delete() // 删除文件
boolean exists() // 判断文件是否存在
String getName() // 获取文件名
String getPath() // 获取文件路径
boolean isDirectory() // 判断是否是目录
boolean isFile() // 判断是否是文件
long length() // 获取文件长度
String[] list() // 获取目录下的文件列表
boolean mkdir() // 创建目录
boolean renameTo(File dest) // 重命名文件
boolean setLastModified(long time) // 设置最后修改时间
boolean setReadOnly() // 设置只读属性
```

### 2. FileInputStream：文件输入流

```java
int available() // 获取输入流中可读取的字节数
void close() // 关闭输入输出流
int read() // 从输入流中读取一个字节
int read(byte[] b) // 从输入流中读取字节数组
long skip(long n) // 跳过输入流中 n 个字节
```

### 3. FileOutputStream 输出文件流

```java
void close() // 关闭输出流
void write(int b) // 写入一个字节
void write(byte[] b) // 写入字节数组
void write(byte[] b, int off, int len) // 写入字节数组的某一部分
```

### 4. BufferedReader：传输输入流

```java
BufferedReader(Reader in) // 创建 BufferedReader
BufferedReader(Reader in, int sz) // 创建 BufferedReader
String readLine() // 读取一行
String readLine(int limit) // 读取一行，最多读取 limit 个字符
void close() // 关闭 BufferedReader
Stream<String> lines() // 获取输入流中每一行的流
```

### 5. BufferedWriter：传输写入流

```java
BufferedWriter(Writer out) // 创建 BufferedWriter
BufferedWriter(Writer out, int sz) // 创建 BufferedWriter
void newLine() // 写入换行符
void write(int c) // 写入一个字符
void write(char[] cbuf) // 写入字符数组
void write(String str) // 写入字符串
void write(String str, int off, int len) // 写入字符串的某一部分
void flush() // 刷新缓冲区
void close() // 关闭 BufferedWriter
```

### 6. InputStreamReader：字符输入流

```java
InputStreamReader(InputStream in) // 创建 InputStreamReader
void close() // 关闭 InputStreamReader
int read() // 读取一个字符
int read(char[] cbuf) // 读取字符数组
int read(char[] cbuf, int off, int len) // 读取字符数组的某一部分
```

### 7. OutputStreamWriter：字符输出流

```java
OutputStreamWriter(OutputStream out) // 创建 OutputStreamWriter
void close() // 关闭 OutputStreamWriter
void flush() // 刷新缓冲区
void write(int c) // 写入一个字符
void write(char[] cbuf) // 写入字符数组
void write(String str) // 写入字符串
void write(String str, int off, int len) // 写入字符串的某一部分
```

### 8. PrintWriter：输出写入

```java
PrintWriter(Writer out) // 创建 PrintWriter
PrintWriter(Writer out, boolean autoFlush) // 创建 PrintWriter
void print(boolean b) // 输出布尔值
void print(char c) // 输出字符
void print(char[] s) // 输出字符数组
void print(double d) // 输出 double 值
void print(float f) // 输出 float 值
void print(int i) // 输出 int 值
void print(long l) // 输出 long 值
void print(Object obj) // 输出对象
void print(String s) // 输出字符串
void println() // 输出换行符
void println(boolean b) // 输出布尔值并换行
void println(char c) // 输出字符并换行
void println(char[] s) // 输出字符数组并换行
void println(double d) // 输出 double 值并换行
void println(float f) // 输出 float 值并换行
void println(int i) // 输出 int 值并换行
void println(long l) // 输出 long 值并换行
void println(Object obj) // 输出对象并换行
void println(String s) // 输出字符串并换行
```

### 9. DataInputStream：日期输入流

```java
DataInputStream(InputStream in) // 创建 DataInputStream
void close() // 关闭 DataInputStream
boolean readBoolean() // 读取布尔值
byte readByte() // 读取字节
char readChar() // 读取字符
double readDouble() // 读取 double 值
float readFloat() // 读取 float 值
void readFully(byte[] b) // 读取字节数组
void readFully(byte[] b, int off, int len) // 读取字节数组的某一部分
int readInt() // 读取 int 值
long readLong() // 读取 long 值
short readShort() // 读取 short 值
String readUTF() // 读取 UTF 字符串
int skipBytes(int n) // 跳过 n 个字节
```

### 10. DataOutputStream：日期输出流

```java
DataOutputStream(OutputStream out) // 创建 DataOutputStream
void close() // 关闭 DataOutputStream
void flush() // 刷新缓冲区
void write(int b) // 写入一个字节
void write(byte[] b) // 写入字节数组
void write(byte[] b, int off, int len) // 写入字节数组的某一部分
void writeBoolean(boolean v) // 写入布尔值
void writeByte(int v) // 写入字节
void writeBytes(String s) // 写入字节数组
void writeChar(int v) // 写入字符
void writeChars(String s) // 写入字符数组
void writeDouble(double v) // 写入 double 值
void writeFloat(float v) // 写入 float 值
void writeInt(int v) // 写入 int 值
void writeLong(long v) // 写入 long 值
void writeShort(int v) // 写入 short 值
void writeUTF(String s) // 写入 UTF 字符串
```

### 11. ObjectInputStream：对象输入流

```java
ObjectInputStream(InputStream in) // 创建 ObjectInputStream
void close() // 关闭 ObjectInputStream
Object readObject() // 读取对象
```

### 12. ObjectOutputStream：对象输出流

```java
ObjectOutputStream(OutputStream out) // 创建 ObjectOutputStream
void close() // 关闭 ObjectOutputStream
void flush() // 刷新缓冲区
void writeObject(Object obj) // 写入对象
```

</details>

## 4. java.net

<details>
  <summary>展开</summary>

### 1. URL：统一资源定位符，用于表示网络资源的位置

```java
URL(String spec) // 创建 URL 对象
URL(String protocol, String host, String file) // 创建 URL 对象
String getProtocol() // 获取协议
String getHost() // 获取主机名
int getPort() // 获取端口号
String getFile() // 获取文件路径
String getPath() // 获取文件路径
String getQuery() // 获取查询字符串
String getRef() // 获取引用
String getUserInfo() // 获取用户信息
String toString() // 转换为字符串
URLConnection openConnection() // 打开连接
```

### 2. URLConnection：网络连接类，用于处理网络连接

```java
void connect() // 建立连接
InputStream getInputStream() // 获取输入流
OutputStream getOutputStream() // 获取输出流
int getContentLength() // 获取内容长度
String getContentType() // 获取内容类型
String getContentEncoding() // 获取内容编码
long getLastModified() // 获取最后修改时间
```

### 3. HttpURLConnection：HTTP 连接类，用于处理 HTTP 连接

```java
void connect() // 建立连接
InputStream getInputStream() // 获取输入流
OutputStream getOutputStream() // 获取输出流
int getContentLength() // 获取内容长度
String getContentType() // 获取内容类型
String getContentEncoding() // 获取内容编码
long getLastModified() // 获取最后修改时间
void setRequestMethod(String method) // 设置请求方法
int getResponseCode() // 获取响应码
void setRequestProperty(String key, String value) // 设置请求头
```

### 4. Socket：套接字类，用于处理网络连接

```java
Socket(String host, int port) // 创建 Socket 对象
Socket(InetAddress address, int port) // 创建 Socket 对象
void connect(SocketAddress endpoint) // 连接到指定地址
void connect(SocketAddress endpoint, int timeout) // 连接到指定地址，最多等待 timeout 毫秒
void bind(SocketAddress bindpoint) // 绑定到指定地址
void close() // 关闭 Socket
InputStream getInputStream() // 获取输入流
OutputStream getOutputStream() // 获取输出流
void setSoTimeout(int timeout) // 设置超时时间
void setTcpNoDelay(boolean on) // 设置 TCP 无延迟
void setKeepAlive(boolean on) // 设置保持连接
void setReuseAddress(boolean on) // 设置复用地址
void setSendBufferSize(int size) // 设置发送缓冲区大小
void setReceiveBufferSize(int size) // 设置接收缓冲区大小
void setSoLinger(boolean on, int linger) // 设置关闭延迟
String getLocalAddress() // 获取本地地址
int getLocalPort() // 获取本地端口
InetAddress getInetAddress() // 获取 InetAddress 对象
```

### 5. ServerSocket：服务器套接字类，用于处理服务器端套接字

```java
ServerSocket() // 创建 ServerSocket 对象
ServerSocket(int port) // 创建 ServerSocket 对象
ServerSocket(int port, int backlog) // 创建 ServerSocket 对象
void bind(SocketAddress endpoint) // 绑定到指定地址
void bind(SocketAddress endpoint, int backlog) // 绑定到指定地址，并设置最大连接数
void close() // 关闭 ServerSocket
Socket accept() // 等待连接
void setReuseAddress(boolean on) // 设置复用地址
void setSoTimeout(int timeout) // 设置超时时间
void setReceiveBufferSize(int size) // 设置接收缓冲区大小
void setPerformancePreferences(int connectionTime, int latency, int bandwidth) // 设置性能偏好
```

### 6. InetAddress：网络地址类，用于表示 IP 地址

```java
InetAddress(String host) // 创建 InetAddress 对象
String getHostAddress() // 获取 IP 地址
String getHostName() // 获取主机名
```

</details>

## 5. java.sql

<details>
  <summary>展开</summary>

### 1. Connection：数据库连接类，用于处理数据库连接

```java
Connection(String url) // 创建数据库连接
void close() // 关闭数据库连接
DatabaseMetaData getMetaData() // 获取数据库元数据

Statement createStatement() // 创建 Statement 对象
PreparedStatement prepareStatement(String sql) // 创建 PreparedStatement 对象
CallableStatement prepareCall(String sql) // 创建 CallableStatement 对象
```

### 2. Statement：SQL 语句对象，用于执行 SQL 语句

```java
boolean execute(String sql) // 执行 SQL 语句
int executeUpdate(String sql) // 执行更新 SQL 语句
ResultSet executeQuery(String sql) // 执行查询 SQL 语句
void close() // 关闭 Statement 对象
int getMaxFieldSize() // 获取最大字段长度
void setMaxFieldSize(int max) // 设置最大字段长度
int getMaxRows() // 获取最大行数
void setMaxRows(int max) // 设置最大行数
void setEscapeProcessing(boolean enable) // 设置转义处理
int getQueryTimeout() // 获取查询超时时间
void setQueryTimeout(int seconds) // 设置查询超时时间
void cancel() // 取消执行
```

### 3. PreparedStatement：预编译 SQL 语句对象，用于执行预编译 SQL 语句

```java
boolean execute() // 执行预编译 SQL 语句
int executeUpdate() // 执行更新预编译 SQL 语句
ResultSet executeQuery() // 执行查询预编译 SQL 语句
void addBatch() // 添加批处理参数
int[] executeBatch() // 执行批处理参数
void clearParameters() // 清除参数
void close() // 关闭 PreparedStatement 对象

void setNull(int parameterIndex, int sqlType) // 设置参数为 null
void setBoolean(int parameterIndex, boolean x) // 设置布尔值参数
void setByte(int parameterIndex, byte x) // 设置字节参数
void setShort(int parameterIndex, short x) // 设置短整型参数
void setInt(int parameterIndex, int x) // 设置整型参数
void setLong(int parameterIndex, long x) // 设置长整型参数
void setFloat(int parameterIndex, float x) // 设置浮点型参数
void setDouble(int parameterIndex, double x) // 设置双精度浮点型参数
void setString(int parameterIndex, String x) // 设置字符串参数
void setBytes(int parameterIndex, byte[] x) // 设置字节数组参数
void setDate(int parameterIndex, Date x) // 设置日期参数
void setTime(int parameterIndex, Time x) // 设置时间参数
void setTimestamp(int parameterIndex, Timestamp x) // 设置时间戳参数
void setAsciiStream(int parameterIndex, InputStream x, int length) // 设置 ASCII 流参数
void setBinaryStream(int parameterIndex, InputStream x, int length) // 设置二进制流参数
void setObject(int parameterIndex, Object x, int targetSqlType, int scale) // 设置对象参数
void setObject(int parameterIndex, Object x, int targetSqlType) // 设置对象参数
void setObject(int parameterIndex, Object x) // 设置对象参数
void setCharacterStream(int parameterIndex, Reader reader, int length) // 设置字符流参数
void setRef(int parameterIndex, Ref x) // 设置 Ref 参数
void setBlob(int parameterIndex, Blob x) // 设置 Blob 参数
void setClob(int parameterIndex, Clob x) // 设置 Clob 参数
void setArray(int parameterIndex, Array x) // 设置 Array 参数
void setURL(int parameterIndex, URL x) // 设置 URL 参数
void setRowId(int parameterIndex, RowId x) // 设置 RowId 参数
void setSQLXML(int parameterIndex, SQLXML xmlObject) // 设置 SQLXML 参数
void setDate(int parameterIndex, Date x, Calendar cal) // 设置日期参数
void setTime(int parameterIndex, Time x, Calendar cal) // 设置时间参数
void setTimestamp(int parameterIndex, Timestamp x, Calendar cal) // 设置时间戳参数
```

### 4. ResultSet：结果集对象，用于处理查询结果

```java
boolean next() // 移动到下一行
boolean previous() // 移动到上一行
boolean first() // 移动到第一行
boolean last() // 移动到最后一行
int getRow() // 获取当前行号
boolean isBeforeFirst() // 是否在第一行之前
boolean isAfterLast() // 是否在最后一行之后
boolean isFirst() // 是否在第一行
boolean isLast() // 是否在最后一行
void close() // 关闭 ResultSet 对象

<!-- 获取字符处理，已经注释隐藏，需要自行查看 -->
```

<!-- ```java
String getString(int columnIndex) // 获取字符串值
boolean getBoolean(int columnIndex) // 获取布尔值
byte getByte(int columnIndex) // 获取字节值
short getShort(int columnIndex) // 获取短整型值
int getInt(int columnIndex) // 获取整型值
long getLong(int columnIndex) // 获取长整型值
float getFloat(int columnIndex) // 获取浮点型值
double getDouble(int columnIndex) // 获取双精度浮点型值
BigDecimal getBigDecimal(int columnIndex) // 获取 BigDecimal 值
byte[] getBytes(int columnIndex) // 获取字节数组值
Date getDate(int columnIndex) // 获取日期值
Time getTime(int columnIndex) // 获取时间值
Timestamp getTimestamp(int columnIndex) // 获取时间戳值
InputStream getAsciiStream(int columnIndex) // 获取 ASCII 流值
InputStream getUnicodeStream(int columnIndex) // 获取 Unicode 流值
InputStream getBinaryStream(int columnIndex) // 获取二进制流值
String getString(String columnLabel) // 获取字符串值
boolean getBoolean(String columnLabel) // 获取布尔值
byte getByte(String columnLabel) // 获取字节值
short getShort(String columnLabel) // 获取短整型值
int getInt(String columnLabel) // 获取整型值
long getLong(String columnLabel) // 获取长整型值
float getFloat(String columnLabel) // 获取浮点型值
double getDouble(String columnLabel) // 获取双精度浮点型值
BigDecimal getBigDecimal(String columnLabel) // 获取 BigDecimal 值
byte[] getBytes(String columnLabel) // 获取字节数组值
Date getDate(String columnLabel) // 获取日期值
Time getTime(String columnLabel) // 获取时间值
Timestamp getTimestamp(String columnLabel) // 获取时间戳值
InputStream getAsciiStream(String columnLabel) // 获取 ASCII 流值
InputStream getUnicodeStream(String columnLabel) // 获取 Unicode 流值
InputStream getBinaryStream(String columnLabel) // 获取二进制流值
SQLWarning getWarnings() // 获取警告
void clearWarnings() // 清除警告
ResultSetMetaData getMetaData() // 获取结果集元数据
Object getObject(int columnIndex) // 获取对象值
Object getObject(String columnLabel) // 获取对象值
int findColumn(String columnLabel) // 查找列索引
boolean isClosed() // 是否关闭
void setFetchDirection(int direction) // 设置获取方向
int getFetchDirection() // 获取获取方向
void setFetchSize(int rows) // 设置获取行数
int getFetchSize() // 获取获取行数
int getType() // 获取结果集类型
int getConcurrency() // 获取并发性
boolean rowUpdated() // 是否有行更新
boolean rowInserted() // 是否有行插入
boolean rowDeleted() // 是否有行删除
void updateNull(int columnIndex) // 更新指定列为 null
void updateBoolean(int columnIndex, boolean x) // 更新布尔值列
void updateByte(int columnIndex, byte x) // 更新字节值列
void updateShort(int columnIndex, short x) // 更新短整型值列
void updateInt(int columnIndex, int x) // 更新整型值列
void updateLong(int columnIndex, long x) // 更新长整型值列
void updateFloat(int columnIndex, float x) // 更新浮点型值列
void updateDouble(int columnIndex, double x) // 更新双精度浮点型值列
void updateBigDecimal(int columnIndex, BigDecimal x) // 更新 BigDecimal 值列
void updateString(int columnIndex, String x) // 更新字符串值列
void updateBytes(int columnIndex, byte[] x) // 更新字节数组值列
void updateDate(int columnIndex, Date x) // 更新日期值列
void updateTime(int columnIndex, Time x) // 更新时间值列
void updateTimestamp(int columnIndex, Timestamp x) // 更新时间戳值列
void updateAsciiStream(int columnIndex, InputStream x, int length) // 更新 ASCII 流值列
void updateBinaryStream(int columnIndex, InputStream x, int length) // 更新二进制流值列
void updateCharacterStream(int columnIndex, Reader x, int length) // 更新字符流值列
void updateObject(int columnIndex, Object x, int scaleOrLength) // 更新对象值列
void updateObject(int columnIndex, Object x) // 更新对象值列
void updateNull(String columnLabel) // 更新指定列为 null
void updateBoolean(String columnLabel, boolean x) // 更新布尔值列
void updateByte(String columnLabel, byte x) // 更新字节值列
void updateShort(String columnLabel, short x) // 更新短整型值列
void updateInt(String columnLabel, int x) // 更新整型值列
void updateLong(String columnLabel, long x) // 更新长整型值列
void updateFloat(String columnLabel, float x) // 更新浮点型值列
void updateDouble(String columnLabel, double x) // 更新双精度浮点型值列
void updateBigDecimal(String columnLabel, BigDecimal x) // 更新 BigDecimal 值列
void updateString(String columnLabel, String x) // 更新字符串值列
void updateBytes(String columnLabel, byte[] x) // 更新字节数组值列
void updateDate(String columnLabel, Date x) // 更新日期值列
void updateTime(String columnLabel, Time x) // 更新时间值列
void updateTimestamp(String columnLabel, Timestamp x) // 更新时间��值列
void updateAsciiStream(String columnLabel, InputStream x, int length) // 更新 ASCII 流值列
void updateBinaryStream(String columnLabel, InputStream x, int length) // 更新二进制流值列
void updateCharacterStream(String columnLabel, Reader reader, int length) // 更新字符流值列
void updateObject(String columnLabel, Object x, int scaleOrLength) // 更新对象值列
void updateObject(String columnLabel, Object x) // 更新对象值列
void insertRow() // 插入行
void updateRow() // 更新行
void deleteRow() // 删除行
void refreshRow() // 刷新当前行
void cancelRowUpdates() // 取消行更新
void moveToInsertRow() // 移动到插入行
void moveToCurrentRow() // 移动到当前行
Statement getStatement() // 获取 Statement 对象
Map<String, Class<?>> getTypeMap() // 获取类型映射
void setTypeMap(Map<String, Class<?>> map) // 设置类型映射
``` -->

### 5. DatabaseMetaData：数据库元数据类，用于获取数据库元数据

```java
ResultSet getTables(String catalog, String schemaPattern, String tableNamePattern, String[] types) // 获取表信息
ResultSet getColumns(String catalog, String schemaPattern, String tableNamePattern, String columnNamePattern) // 获取列信息
ResultSet getSchemas() // 获取模式信息
ResultSet getCatalogs() // 获取目录信息
ResultSet getTableTypes() // 获取表类型信息
ResultSet getColumns(String catalog, String schemaPattern, String tableNamePattern, String columnNamePattern) // 获取列信息
ResultSet getPrimaryKeys(String catalog, String schema, String table) // 获取主键信息
ResultSet getImportedKeys(String catalog, String schema, String table) // 获取外键信息
ResultSet getIndexInfo(String catalog, String schema, String table, boolean unique, boolean approximate) // 获取索引信息
ResultSet getCrossReference(String parentCatalog, String parentSchema, String parentTable, String foreignCatalog, String foreignSchema, String foreignTable) // 获取外键信息
ResultSet getTypeInfo() // 获取类型信息
ResultSet getUDTs(String catalog, String schemaPattern, String typeNamePattern, int[] types) // 获取用户定义类型信息
ResultSet getVersionColumns(String catalog, String schema, String table) // 获取版本列信息
ResultSet getBestRowIdentifier(String catalog, String schema, String table, int scope, boolean nullable) // 获取最佳标识列信息
ResultSet getTablePrivileges(String catalog, String schemaPattern, String tableNamePattern) // 获取表权限信息
ResultSet getColumnPrivileges(String catalog, String schemaPattern, String tableNamePattern, String columnNamePattern) // 获取列权限信息
ResultSet getPrimaryKeys(String catalog, String schema, String table) // 获取主键信息
ResultSet getImportedKeys(String catalog, String schema, String table) // 获取外键信息
ResultSet getIndexInfo(String catalog, String schema, String table, boolean unique, boolean approximate) // 获取索引信息
ResultSet getCrossReference(String parentCatalog, String parentSchema, String parentTable, String foreignCatalog, String foreignSchema, String foreignTable) // 获取外键信息
ResultSet getTypeInfo() // 获取类型信息
ResultSet getUDTs(String catalog, String schemaPattern, String typeNamePattern, int[] types) // 获取用户定义类型信息
ResultSet getVersionColumns(String catalog, String schema, String table) // 获取版本列信息
ResultSet getBestRowIdentifier(String catalog, String schema, String table, int scope, boolean nullable) // 获取最佳标识列信息
ResultSet getTablePrivileges(String catalog, String schemaPattern, String tableNamePattern) // 获取表权限信息
ResultSet getColumnPrivileges(String catalog, String schemaPattern, String tableNamePattern, String columnNamePattern) // 获取列权限信息
```

### 6. CallableStatement：存储过程调用对象，用于执行存储过程

```java
void registerOutParameter(int parameterIndex, int sqlType) // 注册输出参数
void registerOutParameter(int parameterIndex, int sqlType, int scale) // 注册输出参数
void registerOutParameter(String parameterName, int sqlType) // 注册输出参数
void registerOutParameter(String parameterName, int sqlType, int scale) // 注册输出参数
boolean wasNull() // 是否为 null
String getString(int parameterIndex) // 获取字符串值
boolean getBoolean(int parameterIndex) // 获取布尔值
```

</details>

## 6. javax.swing

<details>
  <summary>窗体组件</summary>

### 1. JFrame：窗体组件

```java
JFrame() // 创建 JFrame 对象
void setSize(int width, int height) // 设置大小
void setLocation(int x, int y) // 设置位置
void setTitle(String title) // 设置标题
void setContentPane(Container contentPane) // 设置内容面板
Container getContentPane() // 获取内容面板
void setJMenuBar(JMenuBar menuBar) // 设置菜单栏
JMenuBar getJMenuBar() // 获取菜单栏
void setExtendedState(int state) // 设置窗口状态
int getExtendedState() // 获取窗口状态
void setIconImage(Image image) // 设置图标
Image getIconImage() // 获取图标
void setDefaultCloseOperation(int operation) // 设置默认关闭操作
int getDefaultCloseOperation() // 获取默认关闭操作
void setVisible(boolean visible) // 设置是否可见
boolean isVisible() // 是否可见
void toFront() // 前置窗口
void toBack() // 后置窗口
void setAlwaysOnTop(boolean alwaysOnTop) // 设置是否总在最前
boolean isAlwaysOnTop() // 是否总在最前
void pack() // 自动调整大小
void setBounds(int x, int y, int width, int height) // 设置位置和大小
void setBounds(Rectangle r) // 设置位置和大小
Rectangle getBounds() // 获取位置和大小
void setBounds(int x, int y, int width, int height, int op) // 设置位置和大小
void setExtendedState(int state, Rectangle bounds) // 设置窗口状态和位置和大小
void setBounds(Rectangle r, int op) // 设置位置和大小
void setSize(Dimension size) // 设置大小
Dimension getSize() // 获取大小
void setSize(int width, int height, int op) // 设置大小
void setSize(Dimension size, int op) // 设置大小
void setMinimumSize(Dimension minimumSize) // 设置最小大小
Dimension getMinimumSize() // 获取最小大小
void setMaximumSize(Dimension maximumSize) // 设置最大大小
Dimension getMaximumSize() // 获取最大大小
void setLayout(LayoutManager mgr) // 设置布局管理器
LayoutManager getLayout() // 获取布局管理器
void add(Component comp) // 添加组件
void remove(Component comp) // 移除组件
void add(Component comp, Object constraints) // 添加组件
void remove(Component comp, int index) // 移除组件
void removeAll() // 移除所有组件
void validate() // 验证布局
void invalidate() // 失效布局
void repaint() // 重绘
void repaint(long tm, int x, int y, int width, int height) // 重绘
void setCursor(Cursor cursor) // 设置光标
Cursor getCursor() // 获取光标
void setEnabled(boolean enabled) // 设置是否可用
boolean isEnabled() // 是否可用
void enableInputMethods(boolean enable) // 设置是否启用输入法
boolean isInputMethodEnabled() // 是否启用输入法
void setFocusTraversalKeysEnabled(boolean enabled) // 设置是否启用焦点遍历键
boolean getFocusTraversalKeysEnabled() // 是否启用焦点遍历键
void setFocusCycleRoot(boolean root) // 设置是否为焦点循环根
boolean isFocusCycleRoot() // 是否为焦点循环根
void setFocusTraversalPolicy(FocusTraversalPolicy policy) // 设置焦点遍历策略
FocusTraversalPolicy getFocusTraversalPolicy() // 获取焦点遍历策略
void setFocusTraversalPolicyProvider(boolean provider) // 设置是否为焦点遍历策略提供者
boolean isFocusTraversalPolicyProvider() // 是否为焦点遍历策略提供者
void setFocusTraversalKeys(int forwardTraversalKeys, int backwardTraversalKeys) // 设置焦点遍历键
int getFocusTraversalKeys(int id) // 获取焦点遍历键
void addVetoableChangeListener(VetoableChangeListener listener) // 添加否决监听器
void removeVetoableChangeListener(VetoableChangeListener listener) // 移除否决监听器
```

### 2. JDialog：对话框组件

```java
JDialog() // 创建 JDialog 对象
void setSize(int width, int height) // 设置大小
void setLocation(int x, int y) // 设置位置
void setTitle(String title) // 设置标题
void setContentPane(Container contentPane) // 设置内容面板
Container getContentPane() // 获取内容面板
void setModal(boolean modal) // 设置是否模态
boolean isModal() // 是否模态
void setAlwaysOnTop(boolean alwaysOnTop) // 设置是否总在最前
boolean isAlwaysOnTop() // 是否总在最前
void pack() // 自动调整大小
void setBounds(int x, int y, int width, int height) // 设置位置和大小
void setBounds(Rectangle r) // 设置位置和大小
Rectangle getBounds() // 获取位置和大小
void setBounds(int x, int y, int width, int height, int op) // 设置位置和大小
void setExtendedState(int state, Rectangle bounds) // 设置窗口状态和位置和大小
void setBounds(Rectangle r, int op) // 设置位置和大小
void setSize(Dimension size) // 设置大小
Dimension getSize() // 获取大小
void setSize(int width, int height, int op) // 设置大小
void setSize(Dimension size, int op) // 设置大小
void setMinimumSize(Dimension minimumSize) // 设置最小大小
Dimension getMinimumSize() // 获取最小大小
void setMaximumSize(Dimension maximumSize) // 设置最大大小
Dimension getMaximumSize() // 获取最大大小
void setLayout(LayoutManager mgr) // 设置布局管理器
LayoutManager getLayout() // 获取布局管理器
void add(Component comp) // 添加组件
void remove(Component comp) // 移除组件
void add(Component comp, Object constraints) // 添加组件
void remove(Component comp, int index) // 移除组件
void removeAll() // 移除所有组件
void validate() // 验证布局
void invalidate() // 失效布局
void repaint() // 重绘
void repaint(long tm, int x, int y, int width, int height) // 重绘
void setCursor(Cursor cursor) // 设置光标
Cursor getCursor() // 获取光标
void setEnabled(boolean enabled) // 设置是否可用
boolean isEnabled() // 是否可用
void enableInputMethods(boolean enable) // 设置是否启用输入法
boolean isInputMethodEnabled() // 是否启用输入法
void setFocusTraversalKeysEnabled(boolean enabled) // 设置是否启用焦点遍历键
boolean getFocusTraversalKeysEnabled() // 是否启用焦点遍历键
void setFocusCycleRoot(boolean root) // 设置是否为焦点循环根
boolean isFocusCycleRoot() // 是否为焦点循环根
void setFocusTraversalPolicy(FocusTraversalPolicy policy) // 设置焦点遍历策略
FocusTraversalPolicy getFocusTraversalPolicy() // 获取焦点遍历策略
void setFocusTraversalPolicyProvider(boolean provider) // 设置是否为焦点遍历策略提供者
boolean isFocusTraversalPolicyProvider() // 是否为焦点遍历策略提供者
void setFocusTraversalKeys(int forwardTraversalKeys, int backwardTraversalKeys) // 设置焦点遍历键
int getFocusTraversalKeys(int id) // 获取焦点遍历键
void addVetoableChangeListener(VetoableChangeListener listener) // 添加否决监听器
void removeVetoableChangeListener(VetoableChangeListener listener) // 移除否决监听器
```

### 1. JComboBox：下拉列表框组件

```java
JComboBox() // 创建 JComboBox 对象
void addItem(Object item) // 添加选项
void removeItem(Object item) // 移除选项
void insertItemAt(Object item, int index) // 插入选项
void removeItemAt(int index) // 移除选项
void setSelectedIndex(int index) // 设置当前选择项索引
int getSelectedIndex() // 获取当前选择项索引
Object getSelectedItem() // 获取当前选择项
void setPrototypeDisplayValue(Object prototypeValue) // 设置原型显示值
Object getPrototypeDisplayValue() // 获取原型显示值
void setEditable(boolean editable) // 设置是否可编辑
boolean isEditable() // 是否可编辑
void setItemListener(ItemListener l) // 设置选项监听器
void setRenderer(ListCellRenderer<? super E> renderer) // 设置渲染器
ListCellRenderer<? super E> getRenderer() // 获取渲染器
void setPrototypeCellValue(Object prototypeValue) // 设置原型单元格值
Object getPrototypeCellValue() // 获取原型单元格值
```

### 2. JTable：表格组件

```java
JTable() // 创建 JTable 对象
void setModel(TableModel model) // 设置表格模型
TableModel getModel() // 获取表格模型
void setSelectionMode(int selectionMode) // 设置选择模式
int getSelectionMode() // 获取选择模式
void setRowSelectionInterval(int row, int column) // 设置行选择区间
void addRowSelectionInterval(int row, int column) // 添加行选择区间
void removeRowSelectionInterval(int row, int column) // 移除行选择区间
int[] getSelectedRows() // 获取选中行索引
int[] getSelectedColumns() // 获取选中列索引
int getSelectedRow() // 获取选中行索引
int getSelectedColumn() // 获取选中列索引
void setColumnSelectionAllowed(boolean allowed) // 设置是否允许列选择
boolean getColumnSelectionAllowed() // 是否允许列选择
void setRowSelectionAllowed(boolean allowed) // 设置是否允许行选择
boolean getRowSelectionAllowed() // 是否允许行选择
void setCellSelectionEnabled(boolean enabled) // 设置是否允许单元格选择
boolean isCellSelectionEnabled() // 是否允许单元格选择
void setAutoCreateRowSorter(boolean autoCreate) // 设置是否自动创建行排序器
boolean getAutoCreateRowSorter() // 是否自动创建行排序器
void setRowSorter(RowSorter<? extends TableModel> sorter) // 设置行排序器
RowSorter<? extends TableModel> getRowSorter() // 获取行排序器
void setPreferredScrollableViewportSize(Dimension size) // 设置首选滚动视窗大小
Dimension getPreferredScrollableViewportSize() // 获取首选滚动视窗大小
void setAutoResizeMode(int mode) // 设置自动调整大小模式
int getAutoResizeMode() // 获取自动调整大小模式
void setRowHeight(int row, int height) // 设置行高
int getRowHeight(int row) // 获取行高
void setRowMargin(int margin) // 设置行间距
int getRowMargin() // 获取行间距
void setIntercellSpacing(Dimension spacing) // 设置单元格间距
Dimension getIntercellSpacing() // 获取单元格间距
void setFillsViewportHeight(boolean fillsViewportHeight) // 设置是否填充视窗高度
boolean getFillsViewportHeight() // 是否填充视窗高度
void setSurrendersFocusOnKeystroke(boolean surrendersFocus) // 设置是否丢失焦点
boolean getSurrendersFocusOnKeystroke() // 是否丢失焦点
void setCellEditor(TableCellEditor editor) // 设置单元格编辑器
TableCellEditor getCellEditor() // 获取单元格编辑器
void setCellRenderer(TableCellRenderer renderer) // 设置单元格渲染器
TableCellRenderer getCellRenderer() // 获取单元格渲染器
void setDefaultRenderer(Class<?> columnClass, TableCellRenderer renderer) // 设置默认渲染器
TableCellRenderer getDefaultRenderer(Class<?> columnClass) // 获取默认渲染器
void setDefaultEditor(Class<?> columnClass, TableCellEditor editor) // 设置默认编辑器
TableCellEditor getDefaultEditor(Class<?> columnClass) // 获取默认编辑器
void setSelectionBackground(Color color) // 设置选择背景色
Color getSelectionBackground() // 获取选择背景色
void setSelectionForeground(Color color) // 设置选择前景色
Color getSelectionForeground() // 获取选择前景色
void setGridColor(Color color) // 设置网格颜色
Color getGridColor() // 获取网格颜色
void setFocusable(boolean focusable) // 设置是否可聚焦
boolean isFocusable() // 是否可聚焦
```

### 3. JCheckBox：复选框组件

```java
JCheckBox() // 创建 JCheckBox 对象
void setSelected(boolean selected) // 设置是否选中
boolean isSelected() // 是否选中
void setText(String text) // 设置文本
String getText() // 获取文本
void setMnemonic(char mnemonic) // 设置助记符
char getMnemonic() // 获取助记符
void setDisplayedMnemonicIndex(int index) // 设置显示助记符索引
int getDisplayedMnemonicIndex() // 获取显示助记符索引
void setHorizontalAlignment(int alignment) // 设置水平对齐方式
int getHorizontalAlignment() // 获取水平对齐方式
void setVerticalAlignment(int alignment) // 设置垂直对齐方式
int getVerticalAlignment() // 获取垂直对齐方式
void setHorizontalTextPosition(int position) // 设置水平文本位置
int getHorizontalTextPosition() // 获取水平文本位置
void setVerticalTextPosition(int position) // 设置垂直文本位置
int getVerticalTextPosition() // 获取垂直文本位置
void setIcon(Icon icon) // 设置图标
Icon getIcon() // 获取图标
void setBorderPainted(boolean painted) // 设置是否绘制边框
boolean isBorderPainted() // 是否绘制边框
void setOpaque(boolean isOpaque) // 设置是否不透明
boolean isOpaque() // 是否不透明
void setForeground(Color fg) // 设置前景色
Color getForeground() // 获取前景色
void setBackground(Color bg) // 设置背景色
Color getBackground() // 获取背景色
void setFont(Font font) // 设置字体
Font getFont() // 获取字体
void setEnabled(boolean enabled) // 设置是否可用
boolean isEnabled() // 是否可用
void setVisible(boolean visible) // 设置是否可见
boolean isVisible() // 是否可见
```

### 4. JRadioButton：单选按钮组件

```java
JRadioButton() // 创建 JRadioButton 对象
void setSelected(boolean selected) // 设置是否选中
boolean isSelected() // 是否选中
void setText(String text) // 设置文本
String getText() // 获取文本
void setMnemonic(char mnemonic) // 设置助记符
char getMnemonic() // 获取助记符
void setDisplayedMnemonicIndex(int index) // 设置显示助记符索引
int getDisplayedMnemonicIndex() // 获取显示助记符索引
void setHorizontalAlignment(int alignment) // 设置水平对齐方式
int getHorizontalAlignment() // 获取水平对齐方式
void setVerticalAlignment(int alignment) // 设置垂直对齐方式
int getVerticalAlignment() // 获取垂直对齐方式
void setHorizontalTextPosition(int position) // 设置水平文本位置
int getHorizontalTextPosition() // 获取水平文本位置
void setVerticalTextPosition(int position) // 设置垂直文本位置
int getVerticalTextPosition() // 获取垂直文本位置
void setIcon(Icon icon) // 设置图标
Icon getIcon() // 获取图标
void setBorderPainted(boolean painted) // 设置是否绘制边框
boolean isBorderPainted() // 是否绘制边框
void setOpaque(boolean isOpaque) // 设置是否不透明
boolean isOpaque() // 是否不透明
void setForeground(Color fg) // 设置前景色
Color getForeground() // 获取前景色
void setBackground(Color bg) // 设置背景色
Color getBackground() // 获取背景色
void setFont(Font font) // 设置字体
Font getFont() // 获取字体
void setEnabled(boolean enabled) // 设置是否可用
boolean isEnabled() // 是否可用
void setVisible(boolean visible) // 设置是否可见
boolean isVisible() // 是否可见
```

### 5. JTextArea：多行文本框组件

```java
JTextArea() // 创建 JTextArea 对象
void setText(String text) // 设置文本
String getText() // 获取文本
void setEditable(boolean editable) // 设置是否可编辑
boolean isEditable() // 是否可编辑

void setLineWrap(boolean wrap) // 设置是否自动换行
boolean getLineWrap() // 是否自动换行
void setWrapStyleWord(boolean wrap) // 设置是否自动换行单词
boolean getWrapStyleWord() // 是否自动换行单词
void setRows(int rows) // 设置行数
int getRows() // 获取行数
void setColumns(int columns) // 设置列数
int getColumns() // 获取列数
void setCaretPosition(int position) // 设置光标位置
int getCaretPosition() // 获取光标位置
void setSelectionStart(int position) // 设置选中开始位置
int getSelectionStart() // 获取选中开始位置
void setSelectionEnd(int position) // 设置选中结束位置
int getSelectionEnd() // 获取选中结束位置
void setCaretColor(Color color) // 设置光标颜色
Color getCaretColor() // 获取光标颜色
void setDisabledTextColor(Color color) // 设置禁用文本颜色
Color getDisabledTextColor() // 获取禁用文本颜色
void setMargin(Insets m) // 设置边距
Insets getMargin() // 获取边距
void setLineBorder(Border border) // 设置行边框
Border getLineBorder() // 获取行边框
void setMarginBorder(Border border) // 设置边界边框
Border getMarginBorder() // 获取边界边框
void setOpaque(boolean isOpaque) // 设置是否不透明
boolean isOpaque() // 是否不透明
void setBackground(Color bg) // 设置背景色
Color getBackground() // 获取背景色
void setForeground(Color fg) // 设置前景色
Color getForeground() // 获取前景色
void setFont(Font font) // 设置字体
Font getFont() // 获取字体
void setEnabled(boolean enabled) // 设置是否可用
boolean isEnabled() // 是否可用
void setVisible(boolean visible) // 设置是否可见
boolean isVisible() // 是否可见
```

### 6. JTextField：单行文本框组件

```java
JTextField() // 创建 JTextField 对象
void setText(String text) // 设置文本
String getText() // 获取文本
void setEditable(boolean editable) // 设置是否可编辑
boolean isEditable() // 是否可编辑
```

### 7. JPasswordField：密码文本框组件

```java
JPasswordField() // 创建 JPasswordField 对象
void setEchoChar(char echoChar) // 设置隐藏字符
char getEchoChar() // 获取隐藏字符
void setText(String text) // 设置文本
String getText() // 获取文本
void setEditable(boolean editable) // 设置是否可编辑
boolean isEditable() // 是否可编辑
void setColumns(int columns) // 设置列数
int getColumns() // 获取列数
```

### 8. JMenu：菜单组件

```java
JMenu() // 创建 JMenu 对象
void setText(String text) // 设置文本
String getText() // 获取文本
JMenuItem add(JMenuItem menuItem) // 添加子菜单项
void addSeparator() // 添加分隔符
```

### 9. JMenuBar：菜单栏组件

```java
JMenuBar() // 创建 JMenuBar 对象
JMenu add(JMenu menu) // 添加菜单
```

### 10. JMenuItem：子菜单项组件

```java
JMenuItem() // 创建 JMenuItem 对象
String getText() // 获取文本
void setText(String text) // 设置文本
void setMnemonic(char mnemonic) // 设置助记符
```

### 11. JTabbedPane：选项卡组件

```java
JTabbedPane() // 创建 JTabbedPane 对象
void addTab(String title, Component component) // 添加选项卡
void setEnabledAt(int index, boolean enabled) // 设置选项卡是否可用
boolean isEnabledAt(int index) // 是否可用
void setSelectedIndex(int index) // 设置选中选项卡索引
int getSelectedIndex() // 获取选中选项卡索引
void setTitleAt(int index, String title) // 设置选项卡标题
String getTitleAt(int index) // 获取选项卡标题
void setComponentAt(int index, Component component) // 设置选项卡内容
Component getComponentAt(int index) // 获取选项卡内容
void removeTabAt(int index) // 移除选项卡
int getTabCount() // 获取选项卡数量
void setTabLayoutPolicy(int policy) // 设置选项卡布局策略
int getTabLayoutPolicy() // 获取选项卡布局策略
void setTabPlacement(int placement) // 设置选项卡位置
int getTabPlacement() // 获取选项卡位置
```

### 12. JScrollPane：滚动面板组件

```java
JScrollPane() // 创建 JScrollPane 对象
void setViewportView(Component view) // 设置视图
Component getViewportView() // 获取视图
void setHorizontalScrollBarPolicy(int policy) // 设置水平滚动条策略
int getHorizontalScrollBarPolicy() // 获取水平滚动条策略
void setVerticalScrollBarPolicy(int policy) // 设置垂直滚动条策略
int getVerticalScrollBarPolicy() // 获取垂直滚动条策略
void setViewportBorder(Border border) // 设置视窗边框
Border getViewportBorder() // 获取视窗边框
void setViewport(JViewport viewport) // 设置视窗
JViewport getViewport() // 获取视窗
```

### 13. JList：列表组件

```java
JList() // 创建 JList 对象
void setListData(Object[] listData) // 设置列表数据
Object[] getListData() // 获取列表数据
void setSelectionMode(int selectionMode) // 设置选择模式
int getSelectionMode() // 获取选择模式
void setSelectedIndex(int index) // 设置选中索引
int getSelectedIndex() // 获取选中索引
void setSelectedIndices(int[] indices) // 设置选中索引数组
int[] getSelectedIndices() // 获取选中索引数组
void setSelectionInterval(int index0, int index1) // 设置选中区间
void addSelectionInterval(int index0, int index1) // 添加选中区间
void removeSelectionInterval(int index0, int index1) // 移除选中区间
void ensureIndexIsVisible(int index) // 确保索引可见
void setListData(Vector<?> data) // 设置列表数据
void setCellRenderer(ListCellRenderer<? super E> renderer) // 设置单元格渲染器
ListCellRenderer<? super E> getCellRenderer() // 获取单元格渲染器
void setFixedCellWidth(int width) // 设置固定单元格宽度
int getFixedCellWidth() // 获取固定单元格宽度
void setFixedCellHeight(int height) // 设置固定单元格高度
int getFixedCellHeight() // 获取固定单元格高度
void setLayoutOrientation(int orientation) // 设置布局方向
int getLayoutOrientation() // 获取布局方向
void setVisibleRowCount(int rows) // 设置可见行数
int getVisibleRowCount() // 获取可见行数
void setBorder(Border border) // 设置边框
Border getBorder() // 获取边框
```

### 14. JFileChooser：文件选择器组件

```java
JFileChooser() // 创建 JFileChooser 对象
int showOpenDialog(Component parent) // 打开文件选择器
int showSaveDialog(Component parent) // 保存文件选择器
int showDialog(Component parent, String approveButtonText) // 显示文件选择器
File getSelectedFile() // 获取选中文件
void setSelectedFile(File file) // 设置选中文件
File[] getSelectedFiles() // 获取选中文件数组
void setSelectedFiles(File[] files) // 设置选中文件数组
void setFileSelectionMode(int mode) // 设置文件选择模式
int getFileSelectionMode() // 获取文件选择模式
void setMultiSelectionEnabled(boolean enabled) // 设置是否允许多选
boolean isMultiSelectionEnabled() // 是否允许多选
void setFileHidingEnabled(boolean enabled) // 设置是否隐藏文件
boolean isFileHidingEnabled() // 是否隐藏文件
void setFileFilter(FileFilter filter) // 设置文件过滤器
FileFilter getFileFilter() // 获取文件过滤器
void setApproveButtonText(String approveButtonText) // 设置确认按钮文本
String getApproveButtonText() // 获取确认按钮文本
void setDialogTitle(String title) // 设置对话框标题
String getDialogTitle() // 获取对话框标题
void setDialogType(int type) // 设置对话框类型
int getDialogType() // 获取对话框类型
void setApproveButtonToolTipText(String toolTipText) // 设置确认按钮工具提示文本
String getApproveButtonToolTipText() // 获取确认按钮工具提示文本
void setControlButtonsAreShown(boolean areShown) // 设置是否显示控制按钮
boolean getControlButtonsAreShown() // 是否显示控制按钮
void setDialogTitle(String title) // 设置对话框标题
String getDialogTitle() // 获取对话框标题
void setApproveButtonText(String approveButtonText) // 设置确认按钮文本
String getApproveButtonText() // 获取确认按钮文本
void setDialogTitle(String title) // 设置对话框标题
String getDialogTitle() // 获取对话框标题
void setDialogType(int type) // 设置对话框类型
int getDialogType() // 获取对话框类型
void setApproveButtonToolTipText(String toolTipText) // 设置确认按钮工具提示文本
String getApproveButtonToolTipText() // 获取确认按钮工具提示文本
void setControlButtonsAreShown(boolean areShown) // 设置是否显示控制按钮
boolean getControlButtonsAreShown() // 是否显示控制按钮
void setDialogTitle(String title) // 设置对话框标题
String getDialogTitle() // 获取对话框标题
void setApproveButtonText(String approveButtonText) // 设置确认按钮文本
String getApproveButtonText() // 获取确认按钮文本
void setDialogTitle(String title) // 设置对话框标题
String getDialogTitle() // 获取对话框标题
void setDialogType(int type) // 设置对话框类型
int getDialogType() // 获取对话框类型
void setApproveButtonToolTipText(String toolTipText) // 设置确认按钮工具提示文本
String getApproveButtonToolTipText() // 获取确认按钮工具提示文本
void setControlButtonsAreShown(boolean areShown) // 设置是否显示控制按钮
boolean getControlButtonsAreShown() // 是否显示控制按钮
void setDialogTitle(String title) // 设置对话框标题
String getDialogTitle() // 获取对话框标题
void setApproveButtonText(String approveButtonText) // 设置确认按钮文本
String getApproveButtonText() // 获取确认按钮文本
void setDialogTitle(String title) // 设置对话框标题
String getDialogTitle() // 获取对话框标题
void setDialogType(int type) // 设置对话框类型
int getDialogType() // 获取对话框类型
void setApproveButtonToolTipText(String toolTipText) // 设置确认按钮工具提示文本
String getApproveButtonToolTipText() // 获取确认按钮工具提示文本
void setControlButtonsAreShown(boolean areShown) // 设置是否显示控制按钮
boolean getControlButtonsAreShown() // 是否显示控制按钮
```

### 15.JButton：按钮组件

```java
JButton() // 创建 JButton 对象
void setText(String text) // 设置文本
String getText() // 获取文本
void setMnemonic(char mnemonic) // 设置助记符
char getMnemonic() // 获取助记符
void setHorizontalAlignment(int alignment) // 设置水平对齐方式
int getHorizontalAlignment() // 获取水平对齐方式
void setVerticalAlignment(int alignment) // 设置垂直对齐方式
int getVerticalAlignment() // 获取垂直对齐方式
void setHorizontalTextPosition(int position) // 设置水平文本位置
int getHorizontalTextPosition() // 获取水平文本位置
void setVerticalTextPosition(int position) // 设置垂直文本位置
int getVerticalTextPosition() // 获取垂直文本位置
void setIcon(Icon icon) // 设置图标
Icon getIcon() // 获取图标
void setBorderPainted(boolean painted) // 设置是否绘制边框
boolean isBorderPainted() // 是否绘制边框
void setOpaque(boolean isOpaque) // 设置是否不透明
boolean isOpaque() // 是否不透明
void setForeground(Color fg) // 设置前景色
Color getForeground() // 获取前景色
void setBackground(Color bg) // 设置背景色
Color getBackground() // 获取背景色
void setFont(Font font) // 设置字体
Font getFont() // 获取字体
void setEnabled(boolean enabled) // 设置是否可用
boolean isEnabled() // 是否可用
void setVisible(boolean visible) // 设置是否可见
boolean isVisible() // 是否可见
void setContentAreaFilled(boolean filled) // 设置是否填充内容区
boolean isContentAreaFilled() // 是否填充内容区
void setContentAreaFilled(boolean filled) // 设置是否填充内容区
void setBorder(Border border) // 设置边框
Border getBorder() // 获取边框
void setMargin(Insets m) // 设置边距
Insets getMargin() // 获取边距
void setPressedIcon(Icon icon) // 设置按下图标
Icon getPressedIcon() // 获取按下图标
void setRolloverIcon(Icon icon) // 设置悬停图标
Icon getRolloverIcon() // 获取悬停图标
void setDisabledIcon(Icon icon) // 设置禁用图标
Icon getDisabledIcon() // 获取禁用图标
void setPressed(boolean pressed) // 设置是否按下
boolean isPressed() // 是否按下
void setRolloverEnabled(boolean enabled) // 设置是否悬停
boolean isRolloverEnabled() // 是否悬停
void setRollover(boolean rollover) // 设置是否悬停
boolean isRollover() // 是否悬停
void setMnemonic(char mnemonic) // 设置助记符
char getMnemonic() // 获取助记符
void setToolTipText(String text) // 设置工具提示文本
String getToolTipText() // 获取工具提示文本
void addActionListener(ActionListener l) // 添加动作监听器
void removeActionListener(ActionListener l) // 移除动作监听器
void addItemListener(ItemListener l) // 添加项监听器
void removeItemListener(ItemListener l) // 移除项监听器
void addChangeListener(ChangeListener l) // 添加变化监听器
void removeChangeListener(ChangeListener l) // 移除变化监听器
void addInputMethodListener(InputMethodListener l) // 添加输入法监听器
void removeInputMethodListener(InputMethodListener l) // 移除输入法监听器
void addPropertyChangeListener(PropertyChangeListener listener) // 添加属性监听器
void removePropertyChangeListener(PropertyChangeListener listener) // 移除属性监听器
void addMouseListener(MouseListener l) // 添加鼠标监听器
void removeMouseListener(MouseListener l) // 移除鼠标监听器
void addMouseMotionListener(MouseMotionListener l) // 添加鼠标移动监听器
void removeMouseMotionListener(MouseMotionListener l) // 移除鼠标移动监听器
void addMouseWheelListener(MouseWheelListener l) // 添加鼠标滚轮监听器
void removeMouseWheelListener(MouseWheelListener l) // 移除鼠标滚轮监听器
void addFocusListener(FocusListener l) // 添加焦点监听器
void removeFocusListener(FocusListener l) // 移除焦点监听器
void addKeyListener(KeyListener l) // 添加键盘监听器
void removeKeyListener(KeyListener l) // 移除键盘监听器
void addAncestorListener(AncestorListener l) // 添加祖先监听器
void removeAncestorListener(AncestorListener l) // 移除祖先监听器
void addComponentListener(ComponentListener l) // 添加组件监听器
void removeComponentListener(ComponentListener l) // 移除组件监听器
void addPropertyChangeListener(String propertyName, PropertyChangeListener listener) // 添加属性监听器
void removePropertyChangeListener(String propertyName, PropertyChangeListener listener) // 移除属性监听器
```

</details>
