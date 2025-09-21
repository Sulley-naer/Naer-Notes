# Security

> [!TIP]
> Spring-Security 保护某些接口不被恶意调用，让接口带有权限认证，没通过权限均返回 401 错误

## 安装

依赖

```xml

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

测试

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
```

## 配置

properties

| 选项                            | 说明    |
|-------------------------------|-------|
| spring.security.user.name     | 管理员账号 |
| spring.security.user.password | 管理员密码 |

## 接口验证 配置类

> [!TIP]
> 使用了 SpringBoot 可以在控制器上指定权限级

```java
//单独的配置类，不能在启动配置上注解开启，必须自己写一个

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@EnableGlobalMethodSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                //禁用开发模式 接口全开放
                .csrf(AbstractHttpConfigurer::disable)
                //回话管理器模式 前后端分离直接关闭
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(auth -> auth
                        // 放行主页、登录接口和 /api/public 路径下的所有 API
                        .requestMatchers("/", "/login", "/api/public/**").permitAll()
                        // 私有化接口
                        .requestMatchers("/api/private/**").authenticated()
                        // 管理员接口
                        .requestMatchers("/api/admin/**").hasRole("ADMIN")
                        //默认模式 开放全部 使用注解声明
                        .anyRequest().permitAll())
                .formLogin(Customizer.withDefaults());
        // ?使用默认登录表单，成功后生成JWT进行 可以给字符串 跳转自己的登录页

        return http.build();
    }

    //定义管理员账号
    @Bean
    public UserDetailsService userDetailsService() {
        UserDetails user = User.withUsername("admin")
                .password(passwordEncoder().encode("123456"))
                .roles("ADMIN") // 角色不要加前缀，Spring 自动加 ROLE_
                .build();

        return new InMemoryUserDetailsManager(user);
    }

    //密码加密器，提供管理员密码加密，防止密码逆向
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

| 注解                    | 说明                   |
|-----------------------|----------------------|
| EnableMethodSecurity  | 配置类上开启               |
| PreAuthorize("权限方法")  | 指定 接口 控制器 放行权限       |
| 接口权限方法                | -------              |
| permitAll()           | 允许所有                 |
| isAuthenticated()     | 允许登录                 |
| hasRole('ADMIN')      | 指定用户 实际检查 ROLE_ADMIN |
| hasAnyAuthority('权限') | 指定权限 需要用户 具有权限       |

## Token 过滤器

> [!TIP]
> 前后端分离时，通过记录令牌，来实现接口用户验证，仅控制器模式可单独由spring控制

[JWT](./JWT.md#java-工具类)

<details>
<summary>查看代码</summary>

```java
package org.naer.blog.Filter;

import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.naer.blog.utils.JwtTokenUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private static final Logger logger = LoggerFactory.getLogger(JwtAuthenticationFilter.class);

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // 放行登录接口
        String uri = request.getRequestURI();
        if ("/login".equals(uri)) {
            filterChain.doFilter(request, response);
            return;
        }

        // 获取 token 令牌
        String token = request.getHeader("Authorization");
        String username = null;

        if (token == null) {
            logger.info("Authorization header is empty");
            filterChain.doFilter(request, response);
        } else {
            try {
                Claims claims = JwtTokenUtil.parseJwt(token);
                // 解析 JWT token 获取用户名
                username = JwtTokenUtil.parseJwt(token).get("username").toString();
                logger.info("LoginUser: {}", username);

                // 根据存储权限 进行赋权
                empowerment(claims, username);

                // 继续处理请求
                filterChain.doFilter(request, response);

            } catch (Exception e) {
                logger.error("Token validation failed\n");
                // Token 无效，返回 401
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("Token is invalid or expired");
            }
        }
    }

    //赋权操作
    private static void empowerment(Claims claims, String username) {
        List<String> permissions = (List<String>) claims.get("permission");
        if(permissions != null) {

            List<SimpleGrantedAuthority> authorities = new ArrayList<>();
            for (String item : permissions) {
                authorities.add(new SimpleGrantedAuthority(item));
            }
            // 将认证信息设置到 SecurityContext
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(username, null, authorities);

            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
    }
}
```

</details>
