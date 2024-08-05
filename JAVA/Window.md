# Java 窗口程序开发

利用 Java `JFrame` 组件 开发些小游戏 加强 Java 语言开发经验

基础窗口创建 主入口推荐关闭策略用 "3"

```java
public static void main(String[] args) {
// Region 主入口
    JFrame index = new JFrame();
    index.setSize(300, 400);
    index.setVisible(true);
    //设置程序关闭方式，窗口关闭就退出,windows习惯 默认 Mac 点关闭判断是否窗口均关闭
    index.setDefaultCloseOperation(2);//完整写法 index.DISPOSE_ON_CLOSE
    //转到 setDefaultClose 里面去 看第一行判断，继续转看代码，定义的是接口，翻译说明就懂了
// End
}
```

面向对象开发思想，将其他登录注册窗口，分离为一个独立的类，并继承主入口 <br>
继承了也方便子窗口直接调用主入口的方法等……

```java
//?我这里继承的主入口，也可以直接继承 JFame 就不用再单独实例一个 JFrame
//!内存是一样的，继承的会将虚拟表的方法继承过来，单独实例化它同样内存，继承主入口方便调用主方法
public class Login extends App {
    JFrame login = new JFrame();
    //使用构造函数，在类被实例的时候，就直接显示窗口
    public Login() {
        // Region 登录窗口
        //!如果你是继承的 JFrame 直接使用 this 调方法就行了，因为已经继承过来了
        login.setSize(150, 150);
        login.setVisible(false);
        //点击关闭后隐藏
        login.setDefaultCloseOperation(2);
        // End
    }
}
```

窗口菜单栏

```java
public void CreateMenu() {
    JMenuBar menuBar = new JMenuBar();

    //?菜单项
    JMenu FunctionMenu = new JMenu("功能");
    JMenu AboutMenu = new JMenu("关于我们");
    //?子菜单项
    JMenuItem FunctionItem1 = new JMenuItem("功能一");
    JMenuItem FunctionItem2 = new JMenuItem("功能二");

    JMenuItem AboutItem1 = new JMenuItem("公众号");

    //? 功能区
    FunctionMenu.add(FunctionItem1);
    FunctionMenu.add(FunctionItem2);
    //?关于区
    AboutMenu.add(AboutItem1);
    //?菜单区
    menuBar.add(FunctionMenu);
    menuBar.add(AboutMenu);

    index.setJMenuBar(menuBar);
}
```