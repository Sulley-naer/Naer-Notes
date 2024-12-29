# Java 动态代理

| 方法                                                                                                    | 说明     |
|-------------------------------------------------------------------------------------------------------|--------|
| public static Object newProxyInstance(ClassLoader loader, Class<?>[] interfaces, InvocationHandler h) | 获取代理对象 |

> 当一个方法后续需要修改，添加新的功能出来，但是又不想去修改方法
> 
> 就是比如方法写太多功能了，我需要拆出来，让别人做，怕动了就异常。

代理就是这时候有用了，让代理实现部分功能，完成后再去调用原方法。

## 创建代理人

> 在编程语言中接口就是代理人，先定义出需要被代理的方法。

### 创建接口，定义代理方法

```java
package src;

public class Player implements ProxyTool{

    @Override
    public void run(String name) {

    }

    @Override
    public void dance() {

    }
}
```

### 实现接口

```java
public class Player implements ProxyTool{

    @Override
    public void run(String name) {
        System.out.println("我只会跑步");
    }

    @Override
    public void dance() {
        System.out.println("我开始跳舞");
    }
}


```

### 创建代理对象

```java
public static void main(String[] args) {
    Player p = new Player();
    ProxyTool proxy = createProxy(p);
    /*
     * 与前端防抖节流一样，只要你触发调用方法事件 invoke 就会触发，并且它就会走你自定义的代码
     * 而在第一次执行代码是在被声明的时候，类型检查是Object,由于你强制转换类型检查就过了
     * 而实际上方法的 调用事件已经被替换了，然后你内部拦截操作不管，最后去调用本应该触发的方法
     * 只需要把指针改为方法自己调用自己，这样就实现了完全替换，而被代理者完全不知道是谁拦截了
     * 而你做的拦截事件，也已经能正确触发了。本质：替换调用类方法的事件，变为可拦截式而已。
     */
    
    proxy.run("张三");
}

public static ProxyTool createProxy(Player player){
    /*
     * 参数一：用于指定用哪个类加载器，去加载生成的代理类
     * 参数二：指定接口，这些接口用于指定生成的代理长什么，也就是有哪些方法
     * 参数三：用来指定生成的代理对象要干什么事情
     * */
    ProxyTool instance = (ProxyTool) Proxy.newProxyInstance(App.class.getClassLoader()
            ,new Class[]{ProxyTool.class}
            ,new InvocationHandler() {
                @Override
                public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                    if("run".equals(method.getName())){
                        System.out.println("代理事件触发");
                        method.invoke(player, args);
                    }else {
                        //? 其他方法就根据你调用方法的字符，去调用原对象中的方法
                        method.invoke(player, args);
                    }
                    return proxy;
                }
            }
    );
    
    return instance;
}
```
