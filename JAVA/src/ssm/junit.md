# Junit

> [!TIP]
> Java 单元测试类,用于专门测试方法类等相关的语句

## 快速使用

按照Maven目录结构设计，程序目录与测试目录在根目录下分开

主程序

```java
/* src>main */
public class math {
    public int sum(int a, int b) {
        return a + b;
    }

    public int minus(int a, int b) {
        return a - b;
    }
}
```

测试类:

命名规范 被测试的类 + Test ; 方法 test + 方法名

```java
/* src>test */
public class mathTest {
    private math math;

    @BeforeEach
    public void setup() {
        math = new math();
    }

    @Test
    public void testSum() {
        int res = math.sum(1, 2);
        int expected = 3;
        assert res == expected;
    }
}
```

## 注解

| 名称         | 说明     |
|------------|--------|
| BeforeEach | 预加载方法  |
| test       | 允许方法测试 |
| AfterEach  | 结束方法   |
