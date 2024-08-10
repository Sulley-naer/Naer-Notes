# Java 常用标准库

> ![TIP]
> Java中常使用的api，标准库使用不需要导包 [完整点我](./Class.md)

## System

| 方法名               | 说明         | 参数                              | 说明            |
|-------------------|------------|---------------------------------|---------------|
| exit              | 终止当前虚拟机    | status                          | 0:正常停止,其余异常   |
| currentTimeMillis | 返回系统时间〖毫秒〗 | 方法                              | long 类型       |
| arraycopy         | 数组复制       | srcPos \[arr2\] ,destPos,length | 数组 记录数组 索引 长度 |

### 说明

1. 记得在前面添加 `System` 它们是静态类方法
2. `currentTimeMillis` 从 `1970年1月1日 0:0:0` 开始计算毫秒时间,时差则在 **时分秒** 做加法
3. `arraycopy` 是 **可选数组** `arr2` 是将原数组的内容 放到数组2中,类型必须一致,Idea无错误提示 <br>
   -遵循多态继承语法,同样可以用基类最为类型

## Runtime

| 方法名                 | 说明           |
|---------------------|--------------|
| getRuntime          | 当前系统的运行环境对象  |
| exit                | 停止虚拟机        |
| availableProcessors | 获得CPU的线程数    |
| MaxMemory           | Jvm能获取最大内存大小 |
| totalMemory         | Jvm已获得内存大小   |
| freeMemory          | Jvm 剩余内存大小   |
| exec                | 运行cmd命令      |

### 说明

1. Runtime 是单列模式，不能new出来，构造函数私有化。`Runtime.getRuntime()`通过方法区实现。
2. 这里的 `exit` 才是真实的，System 同样是调用这个， Runtime 是管理当前进程的类！
3. `MaxMemory` 内存相关获取默认是 Byte /1024 /104 就是 Kb MB 了
4. `exec` 是执行的 `cmd` 的命令 传入字符串 可尝试 `notepad` JDK18 废弃直接使用 Idea 解决方案 `try`

## Object

| 方法名      | 说明      |
|----------|---------|
| toString | 转换字符串类型 |
| equals   | 对象比较    |
| clone    | 对象克隆    |

### 说明

1. `toString` Idea 可以生成覆写方法，使当前类对象的 toString 方法返回你写的字符串。<br>
2. `Object` 中的 `equals` 使用的是 `==` 对类进行判断，地址值自然不同，自行利用生成或手动重写
3. `Clone` 并不能直接调用，它是 `protected` 修饰符，因此我们必须方法重写〖IDea〗<br>
   规范：这个方法，它判断对象，是否实现了接口，我们需在使用类上面 实现 `implements Cloneable`

```java
//注意要实现接口，被克隆的类重写 clone 方法！
User u1 = new Users();

Users u2 = (User) u1.clone();//!默认为浅克隆

//Idea 生成的方法，方法区块输入 clone 就行了，是被克隆对象声明和实现接口！
@Override
protected Object clone() throws CloneNotSupportedException {
    return super.clone();
}
```

浅克隆：

是只将类中记录的数据，复制一份存储给变量，这样就会导致引用数据地址相同，一方修改了另一方同样也会被修改！

深克隆：

深克隆就是浅克隆引用地址问题的解决方法，它将引用地址的数据给复制过来，再重新分配了新的地址。

```java
//!手写深度克隆

import javax.xml.crypto.Data;

@Override
protected Object clone() throws CloneNotSupportedException {
    int[] list = this.data;

    int[] newList = new int[list.length];

    for (int i = 0; i < list.length; i++) {
        newList[i] = list[i];
    }
    //使用浅克隆存储基本数据类型
    User user = (Users) super.clone();
    //?将浅克隆数据替换为深克隆数据
    user.data = newList;

    return user;
    //!后续使用比较好的第三方算法类库的深克隆方法
}
```

## Objects

| 方法名     | 说明   |
|---------|------|
| equals  | 比较   |
| isNull  | 判断   |
| nonNull | 判断取反 |

### 说明

1. `equals` 跟前者不同在它会在判断前判断对象是否为空，如果是它就直接返回false，从而避免程序异常
2. `isNull` 判断对象是否为空，返回`boolean`类型。
3. `nonNull` 跟上面一样，只不过返回值取反了。

## BigInteger

| 方法名                  | 说明         | 参数                     |
|----------------------|------------|------------------------|
| BigInteger           | 随机大整数      | int num Random r       |
| BigInteger           | 获取指定的大整数   | String val             |
| BigInteger           | 获取指定进制大整数  | sting val ,int radix   |
| -------------------- | 静态方法       | ---------------------- |
| valueOF              | 转换大整数类型    | long num               |
| -------------------- | 常见方法       | ---------------------- |
| add                  | 加法         |
| subtract             | 减法         |
| multiply             | 乘法         |
| divide               | 除法 获取 商    |
| divideAndRemainder   | 除法 获取 伤 余数 |
| equals               | 比较         |
| pow                  | 次幂         |
| max/min              | 返回较大值      |
| intValue             | 转为int类型整数  |
| double、long value    | 转换指定类型     |

### 说明

1. 随机大整数 第一个数是 (0~2^数字次方) -1 比如4 \[0 ~ 15\] ，第二个实例化随机数类
2. 第二个就是单纯是字符串转换为大整数
3. 指定传入的数据是什么进制的，你写 (101010,2) 它返回的 10 进制中这个数量的大小。
4. 静态方法的有特殊优化，如果数子较小可直接使用。数字最后 `L` 表示 long
5. 额外内容 int 类型变量在内存 第一位 表示的正负数 0 表示数字 0 。

---

1. `a.add(b)`
2. `BigInteger[] arr = a.divideAndRemainder(b)`数组 0商，1余
3. `a.equal(b)` boolean 类型
4. `a.pow(2)` a的2次幂
5. `a.max(b)` 返回最大值 返回的还是原对象，而不是新内存地址
6. 