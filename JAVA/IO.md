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
| write(int b)                                                  | b:写入的字节             | 将单个字节写入文件                                         |
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

快速使用

```java
public static void main(String[] args) {
  //没有指定编码格式，默认使用系统默认编码格式
  FileReader f1 = new FileReader(new File("test.txt"));
  while (f1.ready()) {
      //读取之后它会 自动解码并转换成 10 进制，它对应的是字符集上面的数据
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

## 缓存流
