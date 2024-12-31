# 安装并配置 Java

1. 前往官网下载 [JDK](https://www.oracle.com/cn/java/technologies/downloads/)
2. 运行安装程序，选择安装路径，点击下一步
3. 选择安装类型，点击下一步
4. 选择自定义安装，点击下一步
5. 选择安装组件，点击下一步
6. 选择安装路径，点击下一步
7. 选择开始安装，等待安装完成
8. 配置环境变量，添加 `JAVA_HOME` 和 `PATH` 变量，值为 JDK 安装路径

## HelloWorld

创建 java 文件，编写代码

```java
public class hello {
    public static void main(String[] args) {
        System.out.println('Hello, World!');
    }
}
```

通过命令行运行 javac hello.java 编译代码，然后 java hello 运行程序。 还有

## JDK 工具集合

- javac：编译 Java 源文件
- java：运行 Java 类
- javadoc：生成 Java API 文档
- jar：创建和管理 Java 归档文件
- jdb：Java 调试器
- jconsole：Java 监视和管理工具
- jvisualvm：Java 性能分析工具
- appletviewer：运行 Java Applet
- extcheck：检查 Java 扩展
- idlj：Java IDL 编译器
- jarsigner：签名和验证 Java 归档文件
- javah：生成 JNI 头文件
- javap：反汇编 Java 类文件
- java-rmi.cgi：远程方法调用工具
- jps：Java 进程状态工具
- jinfo：Java 系统信息工具
- jmap：Java 内存映像工具
- jstack：Java 堆栈跟踪工具
- jstat：Java 性能监控工具
- jdeps：Java 类依赖分析工具
