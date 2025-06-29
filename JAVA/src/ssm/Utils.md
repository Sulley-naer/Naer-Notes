# Spring 工具类集

> [!TIP]
> 用于开发中常用的工具类

## email

[原文](./SpringBoot.md#发送邮件-demo)

优化后工具类

### 独立版 

需要 properties 中有email 等信息 可以脱离 spring 使用

<details>
<summary>查看代码</summary>

```java
package org.naer.blog.utils;

import jakarta.mail.MessagingException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Component;

import java.util.Properties;

@Component
public class emailUtil {

    static Logger logger = LoggerFactory.getLogger(emailUtil.class);

    private final JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

    public emailUtil(
            @Value("${email.user}") String user,
            @Value("${email.code}") String code,
            @Value("${email.step}") String host,
            @Value("${email.port}") int port
    ) {
        mailSender.setHost(host);
        mailSender.setPort(port);
        mailSender.setUsername(user);
        mailSender.setPassword(code);
        mailSender.setDefaultEncoding("UTF-8");

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.debug", "false");
        props.put("mail.transport.protocol", "smtp");

        try {
            mailSender.testConnection();
        } catch (MessagingException e) {
            logger.warn("Email connection failed", e);
        }
    }

    public boolean send(String to, String title, String context) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(mailSender.getUsername());
        message.setTo(to);
        message.setSubject(title);
        message.setText(context);
        mailSender.send(message);
        return true;
    }
}
```

</details>

### 自动装配版

利用 Spring 自动配置 并且提供 JavaMailSender

配置类

<details>
<summary>查看代码</summary>

```java
package org.naer.blog.config;

import jakarta.mail.MessagingException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration
public class MailConfig {

    static Logger logger = LoggerFactory.getLogger(MailConfig.class);

    @Value("${email.user}")
    private String user;

    @Value("${email.code}")
    private String code;

    @Value("${email.step}")
    private String host;

    @Value("${email.port}")
    private int port;

    @Bean
    public JavaMailSenderImpl mailSender() {
        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setHost(host);
        sender.setPort(port);
        sender.setUsername(user);
        sender.setPassword(code);
        sender.setDefaultEncoding("UTF-8");

        Properties props = sender.getJavaMailProperties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.debug", "false");
        props.put("mail.transport.protocol", "smtp");

        //多线程测试链接，防止阻塞启动服务 完成后JVM自动回收线程
        new Thread(() -> {
            try {
                sender.testConnection();
                logger.info("email initial success");
            } catch (MessagingException e) {
                logger.warn("Email connection failed", e);
            }
        }).start();

        return sender;
    }
}
```

</details>

工具类

<details>
<summary>查看代码</summary>

```java
@Component
public class emailUtil {

    Logger logger = LoggerFactory.getLogger(emailUtil.class);

    @Resource
    private JavaMailSenderImpl mailSender;

    public emailUtil(JavaMailSenderImpl mailSender) {
        this.mailSender = mailSender;
    }

    public boolean send(String to, String title, String context) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(mailSender.getUsername());
            message.setTo(to);
            message.setSubject(title);
            message.setText(context);
            mailSender.send(message);
            return true;
        } catch (MailException e) {
            logger.error("普通邮件发送失败");
            logger.error(e.getMessage());
            return false;
        }
    }

    public boolean sendHtml(String to, String title, String htmlContent) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom(Objects.requireNonNull(mailSender.getUsername()));
            helper.setTo(to);
            helper.setSubject(title);
            // true 表示发送 HTML 格式
            helper.setText(htmlContent, true);
            mailSender.send(message);
            return true;
        }
        catch (MessagingException e) {
            logger.error("HTML邮件发送失败");
            logger.error(e.getMessage());
            return false;
        }
    }

    // ----------------------------  可选功能 --------------------------------- \\

    // 缓存模板内容的变量 多线程 volatile
    private static volatile String cachedTemplate;
    // 使用锁确保线程安全
    private static final ReentrantLock lock = new ReentrantLock();

    //注册 验证码
    public boolean sendCaptchaEmail(String to, String captcha) {
        try {
            // 1. 加载HTML模板 调用缓存方法
            String htmlContent = getCachedTemplate();

            // 2. 替换验证码占位符
            htmlContent = htmlContent.replace("{{code}}", captcha);

            // 3. 发送邮件
            return sendHtml(to, "blog 网站注册", htmlContent);
        } catch (IOException e) {
            logger.error("加载邮件模板失败: {}", e.getMessage());
            return false;
        }
    }

    // 加载邮件模板
    private String loadEmailTemplate() throws IOException {
        ClassPathResource resource = new ClassPathResource("templates/CaptchaEmail.html");
        try (Reader reader = new InputStreamReader(resource.getInputStream(), StandardCharsets.UTF_8)) {
            return FileCopyUtils.copyToString(reader);
        }
    }

    //多线程适配 并发不会出现问题
    private String getCachedTemplate() throws IOException {
        String template = cachedTemplate;
        if (template == null) {
            // 类级别锁
            synchronized (emailUtil.class) {
                template = cachedTemplate;
                if (template == null) {
                    template = loadEmailTemplate();
                    // volatile保证可见性
                    cachedTemplate = template;
                }
            }
        }
        return template;
    }
}

```

</details>

## Jwt

[原文](./JWT.md#java-工具类)

并为增加新功能，两边一致

<details>
<summary>查看代码</summary>

```java
public class JwtTokenUtil {

    // 固定的密钥 (可以在配置文件中或环境变量中定义)
    private static final String SECRET_KEY_STRING = "1234567890abcdef1234567890abcdef"; // HS256 密钥长度要求32字符

    // 将密钥转为Key类型
    private static final Key SECRET_KEY = new SecretKeySpec(SECRET_KEY_STRING.getBytes(), SignatureAlgorithm.HS256.getJcaName());


    // JWT有效时间 七天
    private static final long VALIDITY = 1000 * 60 * 60 * 24 * 7;


    /*
     * 生成JWT
     * 参数二 用户权限集
     * */
    public static String generateToken(String username, Map<String, List<String>> claims) {
        // 获取当前时间戳
        long currentTimeMillis = System.currentTimeMillis();
        // 将时间戳加到subject中
        String subject = username + "_" + currentTimeMillis;

        // 构建JWT
        JwtBuilder builder = Jwts.builder()
                // 设置token 头部标识符
                .subject(subject)
                // 设置用户名为JWT的subject
                .issuer("MyBlog")
                // 可选，设置发行者
                .issuedAt(new Date())
                // 设置签发时间
                .expiration(new Date(System.currentTimeMillis() + VALIDITY))
                // 设置过期时间
                .id(UUID.randomUUID().toString())
                // 使用HS256算法签名
                .claim("username", username)
                // 可选：添加关键数据
                .signWith(SECRET_KEY);
        // 可选：添加其他数据

        if (claims != null) {
            builder = builder.claims(claims);
        }

        return builder.compact();

    }

    /*
     * 从JWT中解析Claims
     */
    private static Claims getClaimsFromToken(String token) {
        return Jwts.parser().setSigningKey(SECRET_KEY).build().parseSignedClaims(token).getPayload();
    }

    /*
     * 从JWT中解析用户名
     */
    public static String getUsernameFromToken(String token) {
        return getClaimsFromToken(token).getSubject();
    }

    /*
     * 获取JWT的过期时间
     */
    public static Date getExpirationDateFromToken(String token) {
        return getClaimsFromToken(token).getExpiration();
    }

    /*
     * 检查JWT是否过期 false 未过期
     */
    public static boolean isTokenExpired(String token) {
        return getExpirationDateFromToken(token).before(new Date());
    }

    /*
     ** 验证JWT有效性
     **
     */
    public static boolean validateToken(String token) {
        return (getUsernameFromToken(token) != null) && !isTokenExpired(token);
    }

    /*
     *  验证JWT数据
     */
    public static boolean validateTokenWithName(String token, String field) {
        return (field.equals(getUsernameFromToken(token)) && !isTokenExpired(token));
    }

    /*
     * 验证JWT并解析
     */
    public static Claims parseJwt(String token) throws JwtException {
        try {
            // 解析JWT并返回Claims
            return Jwts.parser().setSigningKey(SECRET_KEY).build().parseSignedClaims(token).getPayload();
        } catch (JwtException e) {
            // 解析或签名验证失败，抛出JwtException
            throw new JwtException("无效Token", e);
        }
    }
}
```

</details>
