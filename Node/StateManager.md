# Node 状态管理

- [Node 状态管理](#node-状态管理)
  - [持久化 Session 参考](#持久化-session-参考)
    - [Windows](#windows)
  - [Node JWT 加密验证](#node-jwt-加密验证)
    - [express -JWT](#express--jwt)
    - [JWT 加密数据](#jwt-加密数据)
    - [调用配置](#调用配置)

安装第三方库

```bash
npm i express-session -D

npm i @types/express-session -D
```

挂载中间件|否者 req 没有 session 属性

```typescript
import session from "express-session";

// 挂载中间件 是中间件不是方法哦！ 挂载到你需要的路由上
app.use(
  session({
    secret: "keyboard cat",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: true },
  })
);
```

## 持久化 Session [参考](https://blog.csdn.net/chaoyangsun/article/details/79240888)

安装依赖

```bash
# Windows
npm install --save nedb-session-store  -D
# Linux & Mac
npm install session-file-store -D
```

### Windows

```typescript
const session = require("express-session");
const NedbStore = require("nedb-session-store")(session);

// 就是在session中间件中添加store属性，指定NedbStore的名称，重启node 数据也能读取
router.use(
  session({
    secret: "keyboard cat",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false },
    store: new NedbStore({
      filename: "path_to_nedb_persistence_file.db",
    }),
  })
);
```

## Node JWT 加密验证

安装依赖

```bash
npm i jsonwebtoken -D
npm i @types/jsonwebtoken -D

npm i express-jwt -D
npm i @types/express-jwt -D
```

### express -JWT

express JWT[解密数据](https://www.npmjs.com/package/express-jwt)

> ![TIP]
> 它是一个中间件，你可以挂载到任何地方，也能直接在接口中直接使用。
>
> 它帮助解析请求的，并且验证 token 是否有效。使用的前提是配置好 token 的密钥。
>
> 在访问受保护的路由时候，会自动检查 token 是否有效，如果有效，则可以访问，否则返回 401 错误。

```typescript
const express = require("express");
const expressJwt = require("express-jwt");

router.use(
  expressJwt({
    secret: "your_secret_key",
    algorithms: ["HS256"], // 算法
  }).unless({ path: ["/api/login"] })
  // 排除不需要验证的路由 可以用正则匹配
);

// 这样就指定了需要验证的路由
expressJwt("/api", {
  secret: "your_secret_key",
  algorithms: ["HS256"], // 算法
});

// 直接使用模板
const jwt = require("jsonwebtoken");
const { expressjwt } = require("express-jwt");
// JWT 验证中间件
router.use(
  expressjwt({
    secret: "keyboard cat",
    algorithms: ["HS256"],
  }).unless({ path: ["/api/login"] })
);
```

### JWT 加密数据

> ![TIP]
> 加密数据，生成 token，更多 API 参考[jsonwebtoken](https://www.npmjs.com/package/jsonwebtoken)

```typescript
const jwt = require("jsonwebtoken");

// 生成 token
const token = jwt.sign(user, "keyboard cat", {
  expiresIn: "365d", // 过期时间
  algorithm: "HS256",
});

//登录接口，根据用户信息生成 token 并返回让客户端保存使用

/* 挂载JSON解析中间件 用于获取数据，也可以用我之前自己写的 */
router.use(express.json());

// 登录路由，生成 token
router.post("/login", (req, res) => {
  const user = req.body; // 保存用户信息

  // 根据用户信息 生成 token
  const token = jwt.sign(user, "keyboard cat", {
    expiresIn: "365d", // 过期时间
    algorithm: "HS256",
  });
  //返回token 让用户保存 使用
  res.json({ token });
});
```

### 调用配置

> [!CAUTION]
> 最重要的一步，配置好请求头，才能访问受保护的接口

```html
<button id="loginBtn">Login</button>
<button id="protectedBtn">Access Protected Route</button>
```

<details>
<summary style="font-size: 18px; font-weight: bold;">原生 JS</summary>

```javascript
document.getElementById("loginBtn").addEventListener("click", async () => {
  try {
    const response = await fetch("/api/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ username: "test", password: "password" }), // 模拟登录数据
    });
    const data = await response.json();
    if (data.token) {
      localStorage.setItem("jwtToken", data.token);
      alert("Login successful! Token stored.");
    } else {
      alert("Login failed.");
    }
  } catch (error) {
    console.error("Error:", error);
  }
});

document.getElementById("protectedBtn").addEventListener("click", async () => {
  const token = localStorage.getItem("jwtToken");
  if (!token) {
    alert("No token found. Please login first.");
    return;
  }
  try {
    const response = await fetch("/api/protected", {
      method: "GET",
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    if (response.ok) {
      const data = await response.text();
      alert(`Protected resource accessed: ${data}`);
    } else {
      alert("Access denied.");
    }
  } catch (error) {
    console.error("Error:", error);
  }
});
```

</details>

<details>
<summary style="font-size: 18px; font-weight: bold;">axios</summary>

```javascript
document.getElementById("loginBtn").addEventListener("click", async () => {
  try {
    const response = await axios.post("/api/login", {
      username: "test",
      password: "password", // 模拟登录数据
    });
    const { token } = response.data;
    if (token) {
      localStorage.setItem("jwtToken", token);
      alert("Login successful! Token stored.");
    } else {
      alert("Login failed.");
    }
  } catch (error) {
    console.error("Error:", error);
  }
});

document.getElementById("protectedBtn").addEventListener("click", async () => {
  const token = localStorage.getItem("jwtToken");
  if (!token) {
    alert("No token found. Please login first.");
    return;
  }

  try {
    const response = await axios.get("/api/protected", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    if (response.status === 200) {
      alert(`Protected resource accessed: ${response.data}`);
    } else {
      alert("Access denied.");
    }
  } catch (error) {
    console.error("Error:", error);
    alert("Access denied.");
  }
});
```
