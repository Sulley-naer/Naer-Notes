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

## 字符流(文本)

### FileOutputStream :: 写入文件

> [!TIP]
> FileOutputStream 用于将字节数据写入文件。

| 方法                                                          | 参数                     | 描述                                        |
| ------------------------------------------------------------- | ------------------------ | ------------------------------------------- |
| FileOutputStream(String name)                                 | name:文件路径            | 实例化对象                                  |
| FileOutputStream(File file)                                   | file:文件对象            | 实例化对象                                  |
| FileOutputStream([File file, boolean append],append:是否追加) | file:文件对象            | 实例化对象                                  |
| write(int b)                                                  | b:写入的字节             | 将单个字节写入文件                          |
| write(byte[] b)                                               | b:写入的字节数组         | 将字节数组写入文件                          |
| write(byte[] b , int off, int len)                            | b:写入的字节数组自选范围 | 将字节数组范围写入 `len` 是个数不是结束位置 |
| Str.getBytes()                                                | 将字符串转换为字节数组   | 返回值是字节数组,write 可用                 |
| flush()                                                       | 无                       | 刷新缓冲区，将缓冲区中的数据立即写入文件    |
| close()                                                       | 无                       | 关闭 FileOutputStream，释放系统资源         |

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

| 方法                                 | 参数                                 | 描述                                               |
| ------------------------------------ | ------------------------------------ | -------------------------------------------------- |
| FileInputStream(String name)         | name:文件路径                        | 实例化对象,指针读取形势                            |
| FileInputStream(File file)           | file:文件对象                        | 实例化对象                                         |
| int read()                           | 无                                   | 从文件中读取单个字节，返回值是字节值,无数据返回 -1 |
| int read(byte[] b)                   | b:字节数组                           | 从文件中读取字节数组，返回值是读取的字节数         |
| int read(byte[] b, int off, int len) | b:字节数组,off:偏移量,len:读取字节数 | 从文件中读取字节数组范围，返回值是读取的字节数     |
| close()                              | 无                                   | 关闭 FileInputStream，释放系统资源,先开后关        |

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

## 缓存流
