# JWT

> [!TIP]
> JWT的发明是为了增加网站性能，减少用户交互所诞生
> 
> 为了使其不被修改，必须使用了加密手段，和最大期限

Token：记录用户的id 名称等关键信息，因为它有加密无法被修改，数据库就可以选择不记录它

在用户登录时候，因为加密是可逆的，解密后拿取信息和验证token，正确解密就代表未修改 使用信息内容即可

## Java 工具类

> [!TIP]
> 在Spring-boot 中使用的工具类，实现加密、解密、期限、验证功能
> 
> 更多信息查看[文档](https://blog.csdn.net/qq_42690281/article/details/144719305)

<details>
<summary>查看代码</summary>

```xml
<dependency>
    <groupId>io.jsonwebtoken</groupId>
    <artifactId>jjwt</artifactId>
    <version>0.12.6</version>
</dependency>
```

```java
// 固定的密钥 (可以在配置文件中或环境变量中定义) 没有他重启服务token失效
// ! 使用你自己的密钥字符串 HS256 有密钥等级要求 太低生成密钥会异常
private static final String SECRET_KEY_STRING = "1234567890abcdef1234567890abcdef"; 

// 将密钥转为Key类型
private static final Key SECRET_KEY = new SecretKeySpec(SECRET_KEY_STRING.getBytes(), SignatureAlgorithm.HS256.getJcaName());
```

</details>
