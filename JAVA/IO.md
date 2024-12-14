# Java IO（Input/Output）

## 输入输出流

Java IO 包括输入流和输出流。输入流用于从源（如文件、网络、控制台）**读取数据**

输出流用于向目标（如文件、网络、控制台）**写入数据**。

读取也分为：`字节流`和`字符流`。字节流用于处理`二进制`数据<sup>图片...</sup>，字符流用于处理 `文本数据`。

快速使用

```java
public static void main(String[] args) {

    //?写入方法首次会将文件中所有字符 全部删除再进行写入,append参数为true时追加写入,就不会删除原有内容
    FileOutputStream fos = new FileOutputStream("test.txt");

    fos.write('6');

    fos.close();
}
```

## 字节流(二进制)

### FileOutputStream :: 写入文件

> [!TIP]
> FileOutputStream 用于将字节数据写入文件。

| 方法                                                          | 参数                     | 描述                                                       |
| ------------------------------------------------------------- | ------------------------ | ---------------------------------------------------------- |
| FileOutputStream(String name)                                 | name:文件路径            | 实例化对象                                                 |
| FileOutputStream(File file)                                   | file:文件对象            | 实例化对象                                                 |
| FileOutputStream([File file, boolean append],append:是否追加) | file:文件对象            | 实例化对象                                                 |
| write(int b)                                                  | b:写入的字节             | 将单个字节写入文件,写入不能超出一字节！                    |
| write(byte[] b)                                               | b:写入的字节数组         | 将字节数组写入文件                                         |
| write(byte[] b , int off, int len)                            | b:写入的字节数组自选范围 | 将字节数组范围写入 `len` 是个数不是结束位置                |
| flush()                                                       | 无                       | 刷新缓冲区，将缓冲区中的数据立即写入文件                   |
| close()                                                       | 无                       | 关闭 FileOutputStream，释放系统资源                        |
| Str.getBytes()                                                | 将字符串转换为字节数组   | 返回值是字节数组,write 可用                                |
| Str.getBytes()                                                | charsetName              | 使用特点格式编码器，返回格式对应字符码 \[数组\] 查看需解码 |

> [!NOTE]
> 换行符：**windows** 换行符是 `\r\n`, **Unix** 换行符是 `\n` **Mac** 换行符是 `\r`。

```java
FileOutputStream fos = new FileOutputStream("test.txt");
```

### FileInputStream :: 读取文件

> [!TIP]
> FileInputStream 用于从文件中读取字节数据，它是指针读取，读一次移动一个字节。
>
> 弊端一次只能读取一个字节，文件过大会循环次数太多导致低效率。
>
> 不要用字节流读取文本文件，它会导致乱码的问题，它的字节需要解码，拷贝不影响。

| 方法                                 | 参数                                 | 描述                                               |
| ------------------------------------ | ------------------------------------ | -------------------------------------------------- |
| FileInputStream(String name)         | name:文件路径                        | 实例化对象,指针读取形势                            |
| FileInputStream(File file)           | file:文件对象                        | 实例化对象                                         |
| int read()                           | 无                                   | 从文件中读取单个字节，返回值是字节值,无数据返回 -1 |
| int read(byte[] b)                   | b:字节数组                           | 从文件中读取字节数组，返回值是读取的字节数         |
| int read(byte[] b, int off, int len) | b:字节数组,off:偏移量,len:读取字节数 | 从文件中读取字节数组范围，返回值是读取的字节数     |
| close()                              | 无                                   | 关闭 FileInputStream，释放系统资源,先开后关        |

<details>
<summary>示例代码</summary>

适用于小文件拷贝

```java
//?拷贝文件,写入文件时候 找不到文件就异常 需要自己创建文件
public static void main(String[] args) {

    File file = new File("test2.txt");
    System.out.println(file.createNewFile());

    FileInputStream fus = new FileInputStream("test.txt");
    FileOutputStream fos = new FileOutputStream("test2.txt");

    while (true) {
        int i = fus.read();
        if(i == -1) {
            fus.close();
            break;
        }else {
            fos.write(i);
        }
    }
}
```

大文件拷贝

```java
public static void main(String[] args) throws RuntimeException {
    /*
     * ?由于一次只能读取一个字节导致慢，我们可以自定义一次读取大小，
     * 方法是传递一个byte[]根据长度来定义一次读取大小。
     * 注意重复读取的时候，数组第一次读取的数据并不会删除而是重新覆盖第二次字节位置的
     * 比如第一次 50 字节 ，第二次只读取到 10 字节 数组0~10 是第二次数据 后面还是首次数据。
     */
        File file = new File("test2.txt");
        System.out.println(file.createNewFile());

        FileInputStream fus = new FileInputStream("test.txt");
        FileOutputStream fos = new FileOutputStream("test2.txt");

        while (true) {
            byte[] bytes = new byte[1024 * 1024/* 1Mb */];
            //读取的数据会全部存入传递的数组里面，没有读取到就是 null
            int i = fus.read(bytes);//?read 传递数组 返回值就是读取字节数
            if(i == -1) {
                //? 指针一开始就没读取到数据就是 -1，有数据才会返回读取到的字节数
                fus.close();
                break;
            }else {
                //? 写入也支持传入数组，但是数组长度是写实的，里面会包含null数据
                //! 我们可以根据读取到的字节数来限制它写入范围，不会写入null 和 前一次的数据
                fos.write(bytes,0,i);
            }
        }
}
```

编译异常,解决方法

```java
public static void main(String[] args) {
    //JDK 7
    try(FileInputStream fus = new FileInputStream("test.txt");
        FileOutputStream fos = new FileOutputStream("test2.txt")) {}
    catch(Exception e) {
        /*
         * 注意 只有实现了AutoCloseable按口的类，才能在小括号中创建对象。
         * 这是简写版，如果在try大括号里面写创建对象，我们无法获取到fos
         * 无法获取到 无法确保 资源被释放
         */
        e.printStackTrace();
    }
    //JDK 9
    //?JDK9就是实例化的过程不需要写在括号里面，可以在外面写完 括号写变量名称就行了，需要 throws 过编译异常
}
```

</details>

## 字符流(文本)

> [!NOTE]
> 字节流只能一字节的解析，再遇到文字编码后 会多字节存储 时候无法处理
>
> 码表中 Ascii 系列只有 1 字节，因为英语的码表中编码最大就 999 内，不需要多字节存储
>
> 而国家语言增加后 一字节 8 的长度不够使用 所以引入的字符编码器 utf 8 (Unicode Transformation Format)
>
> 中文数量很多在 utf8 中为中文划分的区间是 3 个字节 左边第一字节 10 就表示 一字节 110 两字节 0 是断开符
>
> 由于上面的编码问题所以通过字节读取文件，一字节可能会出现文字解码错误，字符流就是 utf 解码器
>
> 字符刘 = 字节流 + 字符集

### FileReader :: 读取文本

快速使用

```java
public static void main(String[] args) {
  //没有指定编码格式，默认使用系统默认编码格式
  FileReader f1 = new FileReader(new File("test.txt"));
  while (f1.ready()) {
      //?读取之后它会 自动解码并转换成 10 进制，它返回的是编码值，编码值可以转换字符。
      int text =f1.read();
      if(text > 0) {
          System.out.println((char) text);
      }else {
          break;
      }
  }
  f1.close();
}
```

| 方法                                       | 参数     | 说明                 |
|------------------------------------------|--------|--------------------|
| public FileReader(File file)             | File   | 传入文件对象             |
| public FileReader(String path)           | String | 传入文件路径             |
| --------分割符-------                       | 分割符    | 分割符                |
| public int read ()                       | void   | 读取数据,结束返回-1        |
| public int read (char[])                 | 数组长度   | 指定读取数,返回读取文字数 -1   |
| public int read (char[],int off,int len) | int    | 指定读取数,并指定起始位置,往后长度 |
| public void close ()                     | void   | 结束资源占用             |

指定长度 Demo

```java
public static void main(String[] args) {
    try (FileReader f1 = new FileReader("test.txt")) {
        int i;
        char[] chars = new char[100];
        //?数组里面装的已经是chars的数组了，编码已经转换成字符了，只需要拿取对应位置的使用即可。
        while ((i = f1.read(chars)) != -1) {
            //! read 数组方法返回的是 读取到的 **文字数量** 使用的时候注意位置避免使用错误位置 否则出现 null
            System.out.println((new String(chars, 0, i)));//换行符也算在文字数量里面 \r 算一个文字 \n 同样如此
        }
    }
}
```

### FileWriter :: 写入文本

快速入手

```java
public static void main(String[] args) {
    try (FileWriter fw = new FileWriter("test.txt")) {
        //也可以用char[]数组,可以指定范围,注意范围是 起始位置和起始位置长度
        fw.write("Hello World");
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

| 方法         | 参数                          | 说明    | 额外           |
|------------|-----------------------------|-------|--------------|
| -----      | 构造方法                        | ----- |              |
| FileWriter | File                        | 文件对象  |              |
| FileWriter | (Str Path)                  | 文件路径  |              |
| FileWriter | (File,boolean)              | 续写开关  | 关续写，清空数据     |
| FileWriter | (Path,boolean)              | 续写开关  | 关续写，清空数据     |
| -----      | 成员方法                        | ----- |              |
| Write      | Int、str                     | 写入字符  | Int 需对应 字符编码 |
| Write      | \[Int、str\],int off,int len | 写入部分  | 写入可以超出一字节    |
| Write      | char[]                      | 写入字组  |              |
| Write      | char[],int off,int len      | 指定范围  | 起始位置 往后长度    |
| flush      | void                        | 刷新资源  | 同步数据，然无更新    |
| close      | void                        | 释放资源  | 关闭占用         |

## 原理

### 字符输入流

字符输入流是字节输入流的封装，它会自动解码字节为字符，并返回。

> [!CAUTION]
> 字节流没有缓存区，操作比较细化没必要。

在实例化的时候，它会先创建 8192 长度的数组，然后创建内存与硬盘的通道

等你首次使用了 read 后，再贪婪填充数组，这样就实现了\[`缓存`、`缓冲区`\]，通道开启休眠。

在读取的时候，它会依次将二进制转换十进制，再返回给你，在内存操作因此速度很快。

在读取指针到数组末尾的时候，它就重写激活通道，从上次结束的位置重写填充，覆盖数组并还原指针

如果遇到了文件字节不注意填满数组，它就会将读取的字节数记录下来，读取全部完成后就返回 -1

传入的是数组也是同理，会根据你的数组长度依次对照修改，不足以填充完成不重要 返回值是修改的数量

逻辑上你读取使用起始位置和填充数量就能正确拿取使用。

特殊情况：

最后一字节是中文多字节编码，它每次从硬盘加载都会判断最后一字节是不是多字节编码，是就通过变量记录

等到我们使用到最后一字节的时候，它会判断是不是多字节，是的话就重新走硬盘缓存覆盖数组。

前一次我们保存了最后一字节的位置，读取完成会看多字节变量存在，有就把多字节和数组前面的字节拼接成字符再返回。

### 字符输出流

字符输出流是字节输出流的封装，它会自动编码字符为字节，并写入。

> [!CAUTION]
> 字符写入流同样有 缓冲区，对数据进行写入操作是在内存中进行，没有同步和关闭资源，会导致数据丢失。

它与字符读取一样 拥有 8192 长度的数组，然后创建内存与硬盘的通道。

自动更新会触发逻辑 等写入的数据已经把数组全部写完，它就执行同步操作，将数据写入硬盘。

然后清空数组，正确移动指针到写入后，手动执行刷新也是同样的操作。

特殊情况：

数组最后是多字符,它会先将字符的前部分写入数组，等待同步完成后，自动续写入上一次多字节的后续部分

## 缓存流
