# Java 窗口程序开发

利用 Java `JFrame` 组件 开发些小游戏 加强 Java 语言开发经验

基础窗口创建 主入口推荐关闭策略用 "3"

```java
public static void main(String[] args) {
// Region 主入口
    JFrame index = new JFrame();
    index.setSize(300, 400);
    index.setVisible(true);
    loginForm.setLocationRelativeTo(null);//设置窗口居中
    game.setAlwaysOnTop(true);//窗口是否置顶
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

游戏完成体

开发过程遇到问题

1. 用的普通数组，定以后新增容量超出处理很麻烦
2. 可以将一维度数组设置为动态数组，再将类型设置为数组用着舒服点。
3. 数组长度问题多加注意，根据一维数组去获取二维数组的长度，能很大程度避免问题！
4. 余数能防止超出长度|超了会进位的，但是如果被除数是 `0` 就会错误，加个判定防止问题！

```java
package src;

import javax.swing.*;
import java.util.Random;

/**
 * @author naer
 */
public class Game extends App {
    JFrame game = new JFrame();
    PicManager Manager = new PicManager();
    private final int length = 6;

    public Game() {
        // Region 游戏窗口
        picture();
        window();
        // End
    }

    private void picture() {
        pictures();

        Manager.upset();

        JLabel[][] labels = new JLabel[8][8];

        for (int i = 0; i <= Manager.getRows(); i++) {
            for (int k = 0; k < length; k++) {
                JLabel label = new JLabel(Manager.get(i, k));

                if (i < 1) {
                    label.setBounds(((k) * 240), 0, 240, 240);
                } else {
                    label.setBounds((k * 240), (i * 240), 240, 240);
                }

                game.add(label);
                labels[i][k] = label;
            }
        }

        game.setLayout(null);
    }

    private void window() {
        game.setSize(length * 240, Manager.row * 240);
        game.setVisible(true);
        game.setTitle("游戏窗口");
        game.setAlwaysOnTop(true);
        game.setLocationRelativeTo(null);
        game.setDefaultCloseOperation(game.DISPOSE_ON_CLOSE);
    }

    private void pictures() {
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\5ae69421a3a9ae956fc36eced71a4b5d2f8151ec.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\5ae69421a3a9ae956fc36eced71a4b5d2f8151ec.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\5ae69421a3a9ae956fc36eced71a4b5d2f8151ec.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\6a0ec489gy1gblaelnvmyj20i20jpn60.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\6a0ec489gy1gblaelnvmyj20i20jpn60.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\6a0ec489gy1gblaelnvmyj20i20jpn60.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\6a0ec489gy1gblaem9edgj20i20jpakl.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\6a0ec489gy1gblaem9edgj20i20jpakl.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\6a0ec489gy1gblaem9edgj20i20jpakl.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\6a0ec489gy1gj41xn36b2j20go0godie.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\6a0ec489gy1gj41xn36b2j20go0godie.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\6a0ec489gy1gj41xn36b2j20go0godie.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\7dcbccf29237ccacac876237f3718111d95b9785.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\7dcbccf29237ccacac876237f3718111d95b9785.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\7dcbccf29237ccacac876237f3718111d95b9785.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\7dcbccf29237ccacac876237f3718111d95b9785.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\7dcbccf29237ccacac876237f3718111d95b9785.jpg"
        ));
        Manager.add(new ImageIcon(
                "D:\\小米云盘\\图片\\头像\\7dcbccf29237ccacac876237f3718111d95b9785.jpg"
        ));
    }

    /**
     * @params ImageIcon[][];
     * ? 整个类都是在处理二维速度的麻烦！
     */
    public final class PicManager {
        ImageIcon[][] Pictures = new ImageIcon[2][length];
        int row = 0;
        int col = 0;

        public PicManager() {
        }

        public PicManager(ImageIcon[][] Pictures) {
            this.Pictures = Pictures;
        }

        public void add(ImageIcon image) {
            allocation(image);
            update();
        }

        //! 数组扩容这里解决的！
        private void update() {
            col++;
            if (col == length) {
                col = 0;
                try {
                    row++;
                    Pictures[row][col] = null; // 触发数组越界异常
                } catch (ArrayIndexOutOfBoundsException e) {
                    ImageIcon[][] temp = Pictures;
                    Pictures = new ImageIcon[temp.length + 1][length]; // 扩容为原来的两倍
                    // 复制数据
                    for (int i = 0; i < temp.length; i++) {
                        System.arraycopy(temp[i], 0, Pictures[i], 0, temp[i].length);
                    }
                }
            }
        }

        private void allocation(ImageIcon image) {
            Pictures[row][col] = image;
        }

        private ImageIcon get(int row, int col) {
            return Pictures[row][col];
        }

        private ImageIcon[] getRow(int row) {
            return Pictures[row];
        }

        private ImageIcon[][] getAll() {
            return Pictures;
        }

        private int getRows() {
            return row;
        }

        private int getTotal() {
            return (row * length) + col;
        }

        private void remove(int row, int col) {
            Pictures[row][col] = null;
        }

        private void removeRow(int row) {
            Pictures[row] = null;
        }

        private void removeAll() {
            for (int i = 0; i < length; i++) {
                for (int j = 0; j < length; j++) {
                    remove(i, j);
                }
            }
        }

        /**
         * !打乱
         * 打乱也遇到很多问题，数组长度超出，余数不能为0
         * ?随机数获取的范围一定要在数组长度内，通过列看length有多少去获取
         * !一定要根据二维数组长度去修改数组，不要让数组超出，加个判断看看类是否大于0！
         */
        public void upset() {
            Random random = new Random();
            for (int i = 1; i < this.getTotal() + 1; i++) {
                var temp = random.nextInt(row);
                if (this.getRow(temp).length != 0) {
                    Pictures[random.nextInt(row)][random.nextInt(getRow(temp).length)] =
                            get(temp, random.nextInt(getRow(temp).length));
                } else {
                    continue;
                }
            }
        }
    }
}
```

登录窗口|常用UI

> 源码参数查看，转到方法，看参数方法则转，分析类型，参数是接口，则实现接口
> 可使用匿名内部类，也可以单独实现，也可以当前类直接实现，并且实现接口，重写方法
> 额外提示，如果不是接口，继续看类型，分析参数类型，按照类型跳转，自然能看懂参数。

```java
private void render() {
    JLabel text = new JLabel("我是登录页");
    text.setBounds(0, 0, 30, 30);
    //!设置位置
    text.setLocation(300, 300);

    JButton btn = new JButton("Login");
    //添加事件，需使用ActionListener，转到看参数，看到是接口，使用匿名内部类。
    btn.addActionListener(new ActionListener() {
        //也可以在你的类实现接口并方法重写，参数就将自己 this 传过去就行了
        @Override
        public void actionPerformed(ActionEvent e) {
            System.out.println("按钮被点击");
        }
    });
    btn.setBounds(0, 30, 30, 30);
    btn.setSize(100, 100);
    //给文本框添加按钮，别直接给窗口添加，会直接全屏幕按钮
    mouse(btn);//?下面的鼠标事件
    text.add(btn);
    loginForm.add(text);
}
```

鼠标事件

```java
//!鼠标类型事件添加
private void mouse(JButton btn) {
    //?也可以传入 MouseAdapter 它是 适配器！按需重写方法
    btn.addMouseListener(new MouseListener() {
        @Override
        public void mouseClicked(MouseEvent e) {
            //点击事件
        }

        @Override
        public void mousePressed(MouseEvent e) {
            //鼠标按下事件
        }

        @Override
        public void mouseReleased(MouseEvent e) {
            //鼠标松开事件
        }

        @Override
        public void mouseEntered(MouseEvent e) {
            //鼠标划入事件
        }

        @Override
        public void mouseExited(MouseEvent e) {
            //鼠标离开事件
        }
    });
}
```

键盘事件

```java
//!键盘事件，新版原因，不能直接给整个窗体挂载事件，必须添加目标载体
private void shortcutKey(JButton btn) {
    //!这次我使用的就用 适配器 里面不用的事件都可以删除，继承的抽象类
    btn.addKeyListener(new KeyAdapter() {
        @Override
        public void keyTyped(KeyEvent e) {
            //这个事件无法获取按下的键
            System.out.println("输入成功");
        }

        @Override
        public void keyPressed(KeyEvent e) {
            //!获取按键
            var codeChar = e.getKeyChar();//直接获取按键的字符
            var code = e.getKeyCode();//获取到的为 ASCII 字符表
            System.out.println("按键按下" + code + "键");
            if (code == 65) {
                System.out.println("你按下的键是 \"a\" ");
            }

        }

        @Override
        public void keyReleased(KeyEvent e) {
            System.out.println("按键释放");
        }
    });
}
```