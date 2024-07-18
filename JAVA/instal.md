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

通过命令行运行 javac hello.java 编译代码，然后 java hello 运行程序。
