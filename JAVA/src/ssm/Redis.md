# Spring-Redis

> [!TIP]
> 在Spring 中使用 Redis 服务

```xml
<!-- 推荐的Redis工具类 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

## 配置类

```java
@Configuration
public class RedisConfig {

    @Bean
    public RedisTemplate<String, String> redisTemplate(RedisConnectionFactory redisConnectionFactory) {
        RedisTemplate<String, String> template = new RedisTemplate<>();
        template.setConnectionFactory(redisConnectionFactory);
        return template;
    }

    @Bean
    public StringRedisTemplate stringRedisTemplate(RedisConnectionFactory redisConnectionFactory) {
        return new StringRedisTemplate(redisConnectionFactory);
    }
}
```

## 控制器使用

```java
@RestController
public class Main {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private getUser getUser;

    @RequestMapping("/login")
    @PreAuthorize("permitAll()")
    public ResponseEntity<?> test(String user, String pwd) {
        // MyBatis 查询用户
        users select = getUser.select(user, pwd);

        if (select != null) {
            // 生成 JWT token
            String token = JwtTokenUtil.generateToken(user);

            //! 缓存token 毫无作用 token 本身通过密钥可加密 可逆向和放修改 根本不需要验证！ 只是演示使用方法
            stringRedisTemplate.opsForValue().set(user, token, Duration.of(1,HOURS));

            // 返回 token
            return ResponseEntity.ok(new Object() {
                public String status = "success";
                public Object data = token;
            });
        }

        return ResponseEntity.notFound().build();
    }
}
```
