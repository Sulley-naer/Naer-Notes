# Thread「线程」

> [!TIP]
> 简单理解：应用软件中互相独立，可以同时运行的功能
> 
> 线程是操作系统能够进行运算调度的最小单位。它被包含在进程之中，是进程中的实际运作单位,多线程提高效率。
> 
> 单线程就是cpu只能等待之前的代码运行完毕后才能继续执行，使用多线程就能使电脑性能充分发挥。
>
> 1．并发：在同一时刻，有多个指令在单个 CPU 交替执行
> 
> 2.并行：在同一时刻，有多个指令在多个 CPU 同时执行

## 创建线程

> Thread 常用方法

| 方法                                        | 说明                   |
|-------------------------------------------|----------------------|
| ----                                      | 构造函数                 |
| public Thread(Runnable task)              | 创建线程,默认别名            |
| public Thread(Runnable task, String name) | 创建线程,设置别名            |
| public void sleep(long time)              | 让主线程休眠               |
| ----                                      | 静态方法                 |
| static Thread currentThread()             | 获取当前线程的对象            |
| static void sleep(long time)              | 让线程休眠指定的时间，单位为毫秒     |
| static void join()                        | 插入线程/插队线程            |
| static void yield()                       | 出让线程/礼让线程            |
| ----                                      | 成员方法                 |
| String getName()                          | 返回此线程的名称             |
| void setName(String name)                 | 设置线程的名字(构造方法也可以设置名字) |
| setPriority(int newPriority)              | 设置线程的优先级 1~10        |
| final int getPriority()                   | 获取线程的优先级 默认 5        |
| final void setDaemon(boolean on)          | 设置为守护线程 (跟随绑定主进程死活)  |


### 方式一

> 快速创建线程，弊端拓展性差，无法再次继承

```java
//? 创建线程，需继承 Thread 或实现 Runnable
class test extends Thread {
    @Override
    public void run() {
        for (int i = 0; i < 10; i++) {
            System.out.println(getName()+"now is"+i);
        }
    }
}

public static void main(String[] args) {
    test t = new test();
    t.setName("我是第一个");
    test t2 = new test();
    t2.setName("我是第二个");
    t.start();
    t2.start();
}
```

### 方式二

> 使用接口创建，弥补了拓展性，降低简易性

```java
//方式二
class test implements Runnable {
    @Override
    public void run() {
        for (int i = 0; i < 10; i++) {
            //?方式二获取线程对象，接口并不存在方法，可通过Java保留的当前运行时线程，拿取并通过它使用方法。
            Thread t = Thread.currentThread();
            System.out.println(t.getName()+"now is"+i);
        }
    }
}

public static void main(String[] args) {
    Thread t = new Thread(new test());
    t.setName("我是第一个");
    Thread t2 = new Thread(new test());
    t2.setName("我是第二个");
    t.start();
    t2.start();
}
```

### 推荐方式：可管理线程

> 具备前者特点，并且方便重复调用、取消线程、定义超时 ...

| 方法                         | 参数                          | 说明              |
|----------------------------|-----------------------------|-----------------|
| ----                       | 构造函数                        | ----            |
| public class FutureTask<V> | Callable                    | 管理专用线程类         |
| public FutureTask          | Runnable runnable, V result | 通用接口适配,无返回需结束标识 |
| ----                       | 成员方法                        | ----            |
| public start               | void                        | 启动线程            |
| public isDone              | void                        | 是否完成            |
| public cancel              | boolean                     | 取消线程            |
| public get                 | void                        | 获取结果 通用式 返回传入标识 |
| public get                 | lone TimeUnit               | 获取结果 定义超时时间     |
| public run                 | void                        | 再次启动            |
| public state               | void                        | 线程状态            |
| public exceptionNow        | void                        | 根据状态产出异常        |


```java
//? Callable 也是线程主函数，返回值会返回到 管理类内部 使用泛型限制类型。
class test implements Callable<Integer> {
    @Override
    public Integer call() throws Exception {
        int sum = 0;
        for (int i = 0; i < 50; i++) {
            sum += i;
        }
        return sum;
    }
}

public static void main(String[] args) {
    // FutureTask就是负责管理多线程，内部拥有多方法，查看是否完成 isDone , get 获取结果。
    FutureTask<Integer> task = new FutureTask<>(new test());
    //? 它也是多线程实现类一种，使用start来启动,它启动之后才能传入的线程对象同时会执行。
    new Thread(task).start();

    System.out.println(task.get());
}
```


## 演示Demo

### 守护进程

> 用处：子窗口，比如浏览器与标签的关系，浏览器关闭了，标签就没有存在的必要了，自动销毁。
> 
> 自动结束逻辑：守护线程 不是跟随创建 线程者的生命周期，而是“跟随”所有 非守护线程 的生命周期。守护线程会在所有非守护线程结束后自动退出。
> 
> 这样的弊端：守护线程只适用于两层主与守的关系，如果主创建另一个主，而守护需要指定绑定第二个主，就不能通过守护来实现了，需独立控制线程了。

```java
public static void main(String[] args) {
    test t1 = new test();
    test t2 = new test();

    t2.setDaemon(true);
    //? 设置优先级，优先级只能提高先执行的概率，而不是直接先后区分的,范围 1 ~ 10 默认:5
    t1.setPriority(10);
    t1.start();

    t2.start();
}
//
class test extends Thread {
    @Override
    public void run() {
        for (int i = 0; i < 100; i++) {
            System.out.println(getName() +";" +i);
        }
    }
}
```

### 插入线程

```java
public static void main(String[] args) throws Exception {
    test test = new test();
    test.setPriority(10);
    test.start();
    
    //?插入线程，必须由非自己线程去调用插入，这样线程和调用者 会优先让线程执行
    test.join();//!Main 是调用者 ，因此 Main 会等到线程执行完成在执行

    for (int i = 0; i < 100; i++) {
        System.out.println("main" + i);
    }
}

class test extends Thread {
    @Override
    public void run() {
        for (int i = 0; i < 100; i++) {
            System.out.println(getName() + ";" + i);
        }
    }
}

```

### 出让线程

```java
public static void main(String[] args) {
    
}

class test extends Thread {
    @Override
    public void run() {
        for (int i = 0; i < 100; i++) {
            System.out.println(getName() +";" +i);
            //Thread出让线程，底层是根据内部记录的 currentThread 来获取当前线程
            Thread.yield();//?就算出让也无法确保自己是最后结束的线程,不如线权 很少使用。
        }
    }
}
```
