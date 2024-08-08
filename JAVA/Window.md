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
import javax.security.auth.login.LoginContext;
import javax.swing.*;

public void CreateMenu() {
    JMenuBar menuBar = new JMenuBar();

    //?菜单项
    JMenu FunctionMenu = new JMenu("功能");
    JMenu AboutMenu = new JMenu("关于我们");
    //?子菜单项
    JMenuItem FunctionItem1 = new JMenuItem("功能一");
    JMenuItem FunctionItem2 = new JMenuItem("功能二");

    JMenuItem AboutItem1 = new JMenuItem("公众号");

    //!事件中间件
    ActionListener event = new ActionListener() {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (e.getSource() == FunctionItem1) {
                System.out.println("来自FunctionItem1!");
            } else if (e.getSource() == features2) {
                System.out.println("来自FunctionItem2!");
            } else if (e.getSource() == AboutItem1) {
                //!自行查看弹窗
            } else {
                System.out.println("不知道来自谁");
                game.setVisible(false);//游戏隐藏
                LoginContext loginContext = new LoginContext();//再去调用登录
                System.exit(0);//!进程结束，是整个应用进程
            }
        }
    };

    //?中间件
    FunctionMenu.add(event);//!Bar对象添加事件没有任何作用！
    FunctionItem1.add(event);//!这样就能拦截了!
    FunctionItem2.add(event);
    AboutItem1.add(event);
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

窗口弹窗

```java
import javax.swing.*;

public static void main(String[] args) {
    JDialog dialog = new JDialog();
    JLabel Label = new JLabel("Img");
    Label.setBounds(0, 0, 255, 255);
    dialog.getContentPane().add(Label);//添加容器
    dialog.setSize(300, 300);//大小
    dialog.setAlwaysOnTop(true);//置顶
    dialog.setLocationRelativeTo(null);//居中
    dialog.setModal(true);//不关闭父窗口无法点击
    dialog.setVisible(true);
    //!更多组件
    JTextField textField = new JTextField()//Input框
    JPasswordField ps = new JPasswordField()//密码框
    JButton btn1 = new JButton()//按钮
    //?更多的你就看Idea的智能提示吧
}
```

游戏开发

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
    private final int length = 4;

    public Game() {
        // Region 游戏窗口
        picture();
        window();
        // End
    }

    private void picture() {
        pictures();

        Manager.upset();//!打乱图片

        //留着 后续用户移动使用
        JLabel[][] labels = new JLabel[8][8];

        for (int i = 0; i <= Manager.row; i++) {
            for (int k = 0; k < length; k++) {
                JLabel label = new JLabel(Manager.get(i, k));

                if (i < 1) {
                    label.setBounds(((k) * 120 + 10), 10, 120, 150);
                } else {
                    label.setBounds((k * 120 + 10), (i * 150) + 10, 120, 150);
                }

                game.add(label);
                labels[i][k] = label;
            }
        }

        game.setLayout(null);
    }

    private void window() {
        //?窗口宽高，我是根据图片大小设置的。
        game.setSize((length * 120) + 10, (Manager.row * 150) + 10);
        game.setVisible(true);
        game.setTitle("游戏窗口");
        game.setAlwaysOnTop(true);
        game.setLocationRelativeTo(null);
        game.setDefaultCloseOperation(game.DISPOSE_ON_CLOSE);
    }

    private void pictures() {
        //!路径解决方案，跟Node的Path模块一样
        String path = Thread.currentThread().getContextClassLoader().getResource("").toExternalForm();
        String decodedPath = URLDecoder.decode(path, StandardCharsets.UTF_8);
        String finalPath = decodedPath.replace("file:/", "");
        //finalPath = finalPath.replace("/", "\\"); 可以不加，但是看起来舒服些
        System.out.println(finalPath);
        
        Manager.add(new ImageIcon(
                finalPath + "InstallAppWizard-1.jpg"
        ));
//        ... 自行添加图片
    }

    /**
     * @params ImageIcon[][];
     * ? 整个类都是在处理二维速度的麻烦！
     */
    public final class PicManager {
        ImageIcon[][] Pictures = new ImageIcon[1][length];
        int row = 0;
        int col = 0;
        //!虚拟行 特别重要！自动扩容是在还有容量前一次就会触发
        //!正是因为不确定一上次是否就是最后一次添加，需要通过它才判断真实数据行
        boolean vRow = false;

        public PicManager() {
        }

        public PicManager(ImageIcon[][] Pictures) {
            this.Pictures = Pictures;
        }

        public void add(ImageIcon image) {
            //?修改图片属性
            Image img = image.getImage();

            Image newImg = img.getScaledInstance(120, 150, Image.SCALE_SMOOTH);
            image.setImage(newImg);

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
                    //将虚拟ROw关闭，必须设置在这里，因为异常触发在上面，过了就能把它关闭。
                    vRow = false;
                } catch (ArrayIndexOutOfBoundsException e) {
                    ImageIcon[][] temp = Pictures;
                    Pictures = new ImageIcon[temp.length + 1][length]; // 扩容为原来的两倍
                    // 复制数据
                    for (int i = 0; i < temp.length; i++) {
                        System.arraycopy(temp[i], 0, Pictures[i], 0, temp[i].length);
                    }
                    vRow = true;
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
            return vRow ? row - 1 : row;
        }

        private int getTotal() {
            return vRow ? ((row - 1) * length) : ((row - 1) * length) + col;
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
            row = vRow ? row - 1 : row;

            Random random = new Random();
            int totalRows = row + 1; // 总行数
            int totalCols = (col == 0) ? length : col; // 当前行的列数，若 col 为 0 则设为 length

            disruptTheAlgorithm(totalRows, totalCols, random);
        }

        private void disruptTheAlgorithm(int totalRows, int totalCols, Random random) {
            // 将二维数组转换为一维数组
            ImageIcon[] tempArray = new ImageIcon[totalRows * length];
            int index = 0;
            for (int i = 0; i < totalRows; i++) {
                //判断当前循环是否是最后一行，是的话 循环次数 将增长到 总列 次
                for (int j = 0; j < (i == row ? totalCols : length); j++) {
                    //总行最后一行循环 『手动增长了一行』 前是正常填充数组 ，
                    //!最后一行可能出现没填充满，在调用之前使用了判断，表达式可以根据最后一行的数据数量执行循环次数！
                    tempArray[index++] = Pictures[i][j];
                    //!注意它是直接++ 而0的哪一个直接留空的 ！
                }
            }

            // 使用 Fisher-Yates shuffle 算法打乱一维数组
            for (int i = tempArray.length - 1; i > 0; i--) {
                //?一维数组打乱，很简单一下就明白了。
                int j = random.nextInt(i + 1); //! 这里随机数是限定的大小，所以它才能让空格也能变化。
                ImageIcon temp = tempArray[i];
                tempArray[i] = tempArray[j];
                tempArray[j] = temp;
            }

            // 将打乱后的一维数组转换回二维数组
            index = 0;
            for (int i = 0; i < totalRows; i++) {
                for (int j = 0; j < (i == row ? totalCols : length); j++) {
                    Pictures[i][j] = tempArray[index++];
                }
            }
        }
    }
}
```

超级改动，让游戏能正确识别到空格位置

```java
private void disruptTheAlgorithm(int totalRows, int totalCols, Random random) {
    // 将二维数组转换为一维数组
    ImageIcon[] tempArray = new ImageIcon[totalRows * length];
    int index = 0;
    for (int i = 0; i < totalRows; i++) {
        for (int j = 0; j < (i == row ? totalCols : length); j++) {
            tempArray[index++] = Pictures[i][j];
        }
    }

    // 找到空格的位置并记录
    for (int i = 0; i < tempArray.length; i++) {
        if (tempArray[i] == null) {
            Position = i;
            break;
        }
    }

    // 使用 Fisher-Yates shuffle 算法打乱一维数组
    FisherYatesShuffle(random, tempArray);

    // 将打乱后的一维数组转换回二维数组
    restores(totalRows, totalCols, tempArray);
}

private void restores(int totalRows, int totalCols, ImageIcon[] tempArray) {
    int index;
    index = 0;
    for (int i = 0; i < totalRows; i++) {
        for (int j = 0; j < (i == row ? totalCols : length); j++) {
            if (index == Position) {
                spaceX = i;
                spaceY = j;
            }
            Pictures[i][j] = tempArray[index++];
        }
    }
}

private void FisherYatesShuffle(Random random, ImageIcon[] tempArray) {
    for (int i = tempArray.length - 1; i > 0; i--) {
        // 确保不打乱空格
        //if (i == Position) continue;

        int j = random.nextInt(i + 1);
        // 确保不打乱空格
        //if (j == Position) continue;

        ImageIcon temp = tempArray[i];
        tempArray[i] = tempArray[j];
        tempArray[j] = temp;

        // 更新空格位置
        if (tempArray[i] == null) {
            Position = i;
        } else if (tempArray[j] == null) {
            Position = j;
        }
    }
}

private void finalValidation(int X, int Y, int index) {
    if (index == Position) {
        spaceX = X;
        spaceY = Y;
    }
}

private void DimensionalRecords(int i, int j) {
    //废弃无用，想了半天，其实找空，可以直接用 null 识别
    if (i == 0) {
        Position = i;
    } else if (i == Position) {
        Position = j;
    } else if (j == Position) {
        Position = i;
    }
}

int Position = 0;

public int getSpaceX() {
    return spaceX;
}

public int getSpaceY() {
    return spaceY;
}
```

测底完成

获取空对象，靠null进行判断！

```java
package src;

import javax.swing.*;
import javax.swing.border.BevelBorder;
import java.awt.*;
import java.awt.event.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Random;

/**
 * @author naer
 */
public class Game extends App {
    JFrame game = new JFrame();
    PicManager Manager = new PicManager();
    ArrayList<ImageIcon> Images = new ArrayList<>();
    private final int length = 4;
    int step = 0;
    boolean state = false;
    int score = 0;
    boolean Preview = false;

    public Game() {
        // Region 游戏窗口
        picture();//!加载图片
        window();//!渲染窗口
        // End
    }

    private void picture() {
        pictures();

        Manager.upset(); // 打乱图片

        initImg();

        game.setLayout(null);
    }

    private void initImg() {
        game.getContentPane().removeAll(); // 移除所有旧的组件，确保重新渲染

        score = 0;//重新渲染充值分数

        for (int i = 0; i <= Manager.row; i++) {
            for (int k = 0; k < length; k++) {
                int real = getReall(i, k);
                JLabel label;

                if (Preview) {
                    label = new JLabel(Images.get(real));
                } else {
                    label = new JLabel(Manager.get(i, k));
                }

                label.setFocusable(true); // 使 JLabel 可获得焦点

                if (i < 1) {
                    label.setBounds(((k) * 120 + 10), 10 + 30, 120, 150);
                } else {
                    label.setBounds((k * 120 + 10), (i * 150) + 10 + 30, 120, 150);
                }

                victoryJudgment(i, k, real);//计算分数

                label.setBorder(new BevelBorder(BevelBorder.LOWERED));

                MouseEvent(label, i, k, Manager, this);

                game.getContentPane().add(label);

            }
        }

        JLabel sum = new JLabel("步数:'" + step + "'");
        sum.setBounds(50, 10, 100, 20);

        JLabel Score;

        if (score == Images.size() - 1) {
            Score = new JLabel("游戏胜利");
        } else {
            Score = new JLabel("分数：'" + score + "'");
        }

        Score.setBounds(150, 10, 100, 20);

        game.getContentPane().add(sum);
        game.getContentPane().add(Score);

        game.revalidate(); // 确保重新布局
        game.repaint(); // 重新绘制
        System.out.println("重新渲染");
    }

    private int getReall(int i, int k) {
        int real = 0;
        if (i == 0) {
            real = k;
        } else {
            real = ((i) * length) + k;
        }
        if (real >= Images.size()) {
            return Images.size() - 1;
        } else {
            return real;
        }
    }

    private void victoryJudgment(int i, int k, int real) {
        state = Manager.get(i, k) == Images.get(real) && k != length - 1;
        if (state) {
            this.score++;
        }
    }

    private static void MouseEvent(JLabel label, int row, int col, PicManager manager, Game ts) {
        // 添加键盘事件监听器
        label.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                char code = e.getKeyChar();
                System.out.println("(" + row + ", " + col + "): " + code);

                int spaceX = manager.spaceX;
                int spaceY = manager.spaceY;

                System.out.println("空格 X :'" + spaceX + "' Y ':" + spaceY + "'");

                int AfterX = -1;
                int AfterY = -1;

                switch (code + "") {
                    case "d":
                        AfterX = row;
                        AfterY = col + 1;
                        System.out.println("右移动");
                        break;
                    case "a":
                        AfterX = row;
                        AfterY = col - 1;
                        System.out.println("左移动");
                        break;
                    case "w":
                        AfterX = row - 1;
                        AfterY = col;
                        System.out.println("上移动");
                        break;
                    case "s":
                        AfterX = row + 1;
                        AfterY = col;
                        System.out.println("下移动");
                        break;
                    case "v":
                        ts.Preview = !ts.Preview;
                        ts.initImg();
                }

                boolean flag = false;

                if (AfterY == spaceY && AfterX == spaceX) {
                    flag = true;
                }

                if (flag) {
                    System.out.println("移动成功");
                    manager.exchange(row, col, AfterX, AfterY);
                    ts.step++;
                    ts.initImg(); // 重新渲染
                } else {
                    System.out.print("错误该方向不可移动");
                }
            }
        });

        // 添加鼠标事件监听器以便请求焦点
        label.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) {
                label.requestFocusInWindow();
            }
        });
    }

    private void window() {
        CreateMenu();

        game.setVisible(true);
        game.setTitle("游戏窗口");
        game.setAlwaysOnTop(true);
        game.setLocationRelativeTo(null);
        game.setDefaultCloseOperation(game.DISPOSE_ON_CLOSE);
        game.setSize((length * 120) + 35, (Manager.row * 150) + 250);
    }

    private void CreateMenu() {
        JMenuBar menuBar = new JMenuBar();
        //?菜单项
        JMenu FunctionMenu = new JMenu("功能");
        //?子菜单项
        JMenuItem features = new JMenuItem("重新游戏");
        JMenuItem features2 = new JMenuItem("退出游戏");

        ActionListener event = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (e.getSource() == features) {
                    System.out.println("重新游戏!");
                    step=0;
                    game.getContentPane().removeAll();
                    Manager.upset(); // 打乱图片
                    initImg();
                }else if (e.getSource() == features2) {
                    System.out.println("退出游戏!");
                    game.setVisible(false);
                    System.exit(0);
                }else{
                    System.out.println("错误");
                }
            }
        };

        features.addActionListener(event);
        features2.addActionListener(event);

        JMenuItem AboutItem1 = new JMenuItem("公众号");

        //? 功能区
        FunctionMenu.add(features);
        FunctionMenu.add(features2);
        //?菜单区
        menuBar.add(FunctionMenu);

        game.setJMenuBar(menuBar);
    }

    private void pictures() {
        String finalPath = getPath();

        Images.add(new ImageIcon(
                finalPath + "InstallAppWizard-1.jpg"
        ));
        //15张图片
        Images.forEach(item -> Manager.add(item));
    }

    private static String getPath() {
        String path = Thread.currentThread().getContextClassLoader().getResource("").toExternalForm();
        String decodedPath = URLDecoder.decode(path, StandardCharsets.UTF_8);
        String finalPath = decodedPath.replace("file:/", "");
        finalPath = finalPath.replace("/", "\\");
        System.out.println(finalPath);
        return finalPath;
    }

    /**
     * @params ImageIcon[][];
     */
    public final class PicManager {
        ImageIcon[][] Pictures = new ImageIcon[1][length];
        int row = 0;
        int col = 0;
        boolean vRow = false;
        int spaceX = 4;
        int spaceY = 4;

        public PicManager() {
        }

        public PicManager(ImageIcon[][] Pictures) {
            this.Pictures = Pictures;
        }

        public void add(ImageIcon image) {
            Image img = image.getImage();

            Image newImg = img.getScaledInstance(120, 150, Image.SCALE_SMOOTH);
            image.setImage(newImg);

            allocation(image);
            update();
        }

        private void update() {
            col++;
            if (col == length) {
                col = 0;
                try {
                    row++;
                    Pictures[row][col] = null; // 触发数组越界异常
                    vRow = false;
                } catch (ArrayIndexOutOfBoundsException e) {
                    ImageIcon[][] temp = Pictures;
                    Pictures = new ImageIcon[temp.length + 1][length]; // 扩容为原来的两倍
                    // 复制数据
                    for (int i = 0; i < temp.length; i++) {
                        System.arraycopy(temp[i], 0, Pictures[i], 0, temp[i].length);
                    }
                    vRow = true;
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
            return vRow ? row - 1 : row;
        }

        private int getTotal() {
            return vRow ? ((row - 1) * length) : ((row - 1) * length) + col;
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

        private void exchange(int row, int col, int newRow, int newCol) {
            // 交换图片
            var temp = Pictures[row][col];
            Pictures[row][col] = Pictures[newRow][newCol];
            Pictures[newRow][newCol] = temp;

            // 更新空格位置
            this.spaceX = row;
            this.spaceY = col;
        }

        /**
         * 打乱
         */
        public void upset() {
            Random random = new Random();
            int totalRows = row + 1; // 总行数
            int totalCols = (col == 0) ? col : length; // 当前行的列数，若 col 为 0 则设为 length

            disruptTheAlgorithm(totalRows, totalCols, random);
        }

        private void disruptTheAlgorithm(int totalRows, int totalCols, Random random) {
            // 将二维数组转换为一维数组
            ImageIcon[] tempArray = new ImageIcon[totalRows * length];
            int index = 0;
            for (int i = 0; i < totalRows; i++) {
                for (int j = 0; j < (i == row ? totalCols : length); j++) {
                    tempArray[index++] = Pictures[i][j];
                }
            }

            // 找到空格的位置并记录
            for (int i = 0; i < tempArray.length; i++) {
                if (tempArray[i] == null) {
                    Position = i;
                    break;
                }
            }

            // 使用 Fisher-Yates shuffle 算法打乱一维数组
            FisherYatesShuffle(random, tempArray);

            // 将打乱后的一维数组转换回二维数组
            restores(totalRows, totalCols, tempArray);
        }

        private void restores(int totalRows, int totalCols, ImageIcon[] tempArray) {
            int index;
            index = 0;
            for (int i = 0; i < totalRows; i++) {
                for (int j = 0; j < (i == row ? totalCols : length); j++) {
                    if (index == Position) {
                        spaceX = i;
                        spaceY = j;
                    }
                    Pictures[i][j] = tempArray[index++];
                }
            }
        }

        private void FisherYatesShuffle(Random random, ImageIcon[] tempArray) {
            for (int i = tempArray.length - 1; i > 0; i--) {
                // 确保不打乱空格
                //if (i == Position) continue;

                int j = random.nextInt(i + 1);
                // 确保不打乱空格
                //if (j == Position) continue;

                ImageIcon temp = tempArray[i];
                tempArray[i] = tempArray[j];
                tempArray[j] = temp;

                // 更新空格位置
                if (tempArray[i] == null) {
                    Position = i;
                } else if (tempArray[j] == null) {
                    Position = j;
                }
            }
        }

        private void finalValidation(int X, int Y, int index) {
            if (index == Position) {
                spaceX = X;
                spaceY = Y;
            }
        }

        private void DimensionalRecords(int i, int j) {
            if (i == 0) {
                Position = i;
            } else if (i == Position) {
                Position = j;
            } else if (j == Position) {
                Position = i;
            }
        }

        int Position = 0;

        public int getSpaceX() {
            return spaceX;
        }

        public int getSpaceY() {
            return spaceY;
        }
    }
}
```
登录窗口|常用UI

> 源码参数查看，转到方法，看参数方法则转，分析类型，参数是接口，则实现接口
> 
> 可使用匿名内部类，也可以单独实现，也可以当前类直接实现，并且实现接口，重写方法
> 
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