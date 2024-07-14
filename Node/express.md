# express [官网](https://express.nodejs.cn/)

> [!NOTE]
> 介绍：express 是一个基于 Node.js 的 Web 应用框架，它提供一系列强大的功能，帮助你快速搭建各种 Web 应用，包括 API 服务端和 Web 客户端。 相较于 web api 极大的简化了开发流程，使得开发者可以专注于业务逻辑的实现。

- [express 官网](#express-官网)
  - [安装](#安装)
  - [基本使用](#基本使用)
    - [端口监听](#端口监听)
    - [处理请求](#处理请求)
    - [返回请求 query | 搜索 参数](#返回请求-query--搜索-参数)
    - [动态匹配](#动态匹配)
    - [静态文件](#静态文件)
  - [路由](#路由)
  - [中间件](#中间件)
    - [全局中间件](#全局中间件)
    - [局部中间件](#局部中间件)
    - [Router 中间件 | 接近全局|应用级中间件](#router-中间件--接近全局应用级中间件)
    - [错误中间件](#错误中间件)
    - [错误处理](#错误处理)
    - [错误拦截](#错误拦截)
    - [内置中间件 | 解析请求体数据](#内置中间件--解析请求体数据)
    - [自定义中间件](#自定义中间件)
  - [开放跨域](#开放跨域)
    - [插件跨域](#插件跨域)
    - [简单跨域](#简单跨域)
    - [复杂跨域](#复杂跨域)
  - [请求](#请求)
    - [简易请求](#简易请求)
    - [预检请求](#预检请求)
    - [复杂请求](#复杂请求)
  - [JSONP 接口](#jsonp-接口)

## 安装

```bash
npm install express --save
# ts
npm install @types/express --save-dev
```

## 基本使用

### 端口监听

```typescript
import express from "express";

const app = express();

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
```

### 处理请求

```typescript
const path = require("path");

const paths = {
  index: path.join(__dirname, "views", "index.html"),
  about: path.join(__dirname, "views", "about.html"),
};
//监听get请求，第一个参数是请求路径，第二个参数是回调函数
app.get("/", (req, res) => {
  //req是请求对象，res是响应对象
  /* sendFile方法响应文件 */
  res.sendFile(paths.index);
  /* send方法响应文本 */
  res.send({ message: "Hello World!" });
});
```

### 返回请求 query | 搜索 参数

```typescript
app.get("/", (req, res) => {
  //get 方式可直接 路径拼接 测试
  //http://localhost/?name=zs
  res.send(req.query);
});
```

### 动态匹配

> [!TIP]
> 获取自定义路径的下一个子级路径参数,如：`http://localhost/api/123456` id：123456

```typescript
// 注意是 冒号 加了冒号的路径就会被 动态添加到对象值中
app.get("/api/:id", (req: any, res: any) => {
  //返回请求中的动态值
  res.send(req.params);
});

// 多级动态匹配
("/api/:id/name/:name");
/* /api/123456/name/zs */
("/api/:id/:name");
/* /api/123456/zs */
/* 还需注意，动态匹配方法只能监听写的路径，其余父子路径都不会触发 */
```

### 静态文件

```typescript
const express = require("express");
const app = express();

//对应路径下的文件，都可以直接访问
/* /public/index.html */
app.use(express.static("public"));
//多静态文件 可多次使用 express.static 方法

//配置mime 类型防止浏览器无法识别
app.use(
  "/src",
  express.static(paths.srcPath, {
    setHeaders: (res, filePath) => {
      const ext = path.extname(filePath);
      if (ext === ".css") {
        res.setHeader("Content-Type", "text/css");
      } else if (ext === ".html") {
        res.setHeader("Content-Type", "text/html");
      } else if (ext === ".js") {
        res.setHeader("Content-Type", "application/javascript");
      }
    },
  })
);

//伪装路径
app.use("/assets", express.static("public"));
/* /assets/文件名 访问public文件夹就必须添加一个前缀来伪装路径 */
app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
```

## 路由

基础路由 | 不推荐使用

> [!NOTE]
> 路由为 Express 应用的核心，它定义了如何响应客户端的请求，以及如何将请求映射到相应的处理程序。
>
> 自定义服务器路由，根据路由返回不同的响应内容

```typescript
const express = require("express");

const app = express();

// app.alls所有方法都可以监听
//all post get put delete head options trace connect patch 都可以监听
app.post("/api/test", (req, res) => {
  res.setHeader("Content-Type", "application/json");
  res.send(JSON.stringify("成功调用接口"));
});
```

模块化路由便与维护，用单文件记录不同路由的 api，还能自定义前缀，让代码具备高度的可读性 维护性。

创建路由模块 router.ts

```typescript
const express = require("express");
const router = express.Router();
// methods 对应路由方法 req 请求对象 res 响应对象
router.post("/api/test", (req: any, res: any) => {
  res.setHeader("Content-Type", "application/json");
  res.send(JSON.stringify("成功调用接口"));
});
//导出路由模块
module.exports = router;
```

使用路由模块

```typescript
const express = require("express");
const app = express();
const router = require("./router");

//使用路由模块 | 路径前缀可省略
app.use("/api", router);
app.use(router);
// 也可以使用多个路由模块
app.use("/api", require("./router1"));

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
```

## 中间件

> [!TIP]
> 中间件是 Express 应用的一种扩展机制，它可以介入请求响应 cycle，对请求和响应对象进行操作，并可选择是否继续处理请求。
>
> 说直观点就是，中间件就是一个函数，它可以拦截请求，对请求和响应对象进行操作，然后决定是否继续处理请求。
>
> (请求来的时候，中间的处理流程，你也可以自定义一个函数，还能控制是否继续走下一个流程，这个流程包含了 express 的返回请求之类的，不调用中间件就没有请求流程)

### 全局中间件

中间件需在路由之前注册

```typescript
const express = require("express");
const app = express();
//全局中间件
app.use((req, res, next) => {
  console.log("中间件1 写自己的逻辑代码");
  //调用了 next() 才会继续执行下一个中间件 否则一直加载
  /* 可以写判断请求头Header之类的实现拦截请求 */
  req.test = "自定义属性";
  next();
});
//多个全局中间件
app.use((req, res, next) => {
  console.log("中间件2 中间件1已经执行完了，你再写自己的逻辑代码");
  console.log(req.test);
  next();
});

//路由
app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
```

- 多个中间件可以串行执行，也可以并行执行
- 中间件可以对请求和响应对象进行操作，如设置响应头、修改响应数据等
- 中间件可以选择是否继续处理请求，如只对特定请求路径进行处理等
- 错误处理中间件可以捕获并处理应用抛出的错误
- 应用级别的中间件可以对应用的请求响应 cycle 进行拦截和处理
- 第三方中间件可以扩展应用的功能，如实现身份验证、日志记录、缓存、压缩等

### 局部中间件

中间件需在路由之前注册

```typescript
const express = require("express");
const app = express();

//局部中间件
app.all("/api", (req, res, next) => {
  console.log("局部中间件 逻辑代码");
  next();
});

// methods
app.post("/api", (req, res, next) => {
  console.log("局部中间件 逻辑代码");
  next();
});

const middleware = (req, res, next) => {
  req.test = "局部中间件";
  next();
};
//可以传入 数组 来调用你的局部中间件，也可以逗号分隔
app.get("/api", middleware, (req, res) => {
  console.log(req.test);
  res.send("Hello World!");
});
```

### Router 中间件 | 接近全局|应用级中间件

中间件需在路由之前注册

```typescript
const express = require("express");
const app = express();
const router = express.Router();

//路由中间件 已经可以直接传入中间件函数，函数可用数组传入
router.use((req, res, next) => {
  console.log("路由中间件 逻辑代码");
  next();
});
```

### 错误中间件

> [!WARNING]
> 错误中间件 必须注册在所有路由之后 否者无法捕捉 拦截到错误请求

错误中间件用于捕获项目的错误请求，并且可以自定义错误响应，记录错误日志等。

### 错误处理

```typescript
const express = require("express");
const app = express();

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});

//错误处理 全局 中间件 切换局部 路由 同上面方法，只需要增加参数 err
app.use((err, req, res, next) => {
  console.error("错误请求" + err.stack + "消息" + err.message);
  res.status(500).send("Something broke!");
});
```

### 错误拦截

```typescript
const express = require("express");
const app = express();

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});

app.get("/", (req, res) => {
  throw new Error("自定义错误");
  res.send("Hello World!");
});

app.use((err, req, res, next) => {
  console.error("错误请求" + err.stack + "消息" + err.message);
  res.status(500).send("服务器内部错误");
});
```

### 内置中间件 | 解析请求体数据

1. express.json() 解析 JSON 请求体
1. express.urlencoded() 解析 urlencoded 请求体
1. express.static() 静态文件服务
1. express.Router() 路由模块
1. express.text() 解析 text 请求体
1. express.raw() 解析 raw 请求体
1. express.query() 解析 query 参数
1. express.cookie() 解析 cookie
1. express.session() 实现 session
1. express.methodOverride() 实现 HTTP 方法覆盖
1. express.csrf() 实现 CSRF 防护
1. express.directory() 列出目录

使用内置中间件解析请求体数据

```typescript
// 解析 JSON 请求体
app.use(express.json());
// 解析 urlencoded 请求体
app.use(express.urlencoded({ extended: true }));
// 解析 text 请求体
app.use(express.text());
// 解析 raw 请求体
app.use(express.raw());
// 解析 query 参数
app.use(express.query());
// 解析 cookie
app.use(express.cookieParser("secret"));
// 实现 session
app.use(express.session({ secret: "secret" }));
// 实现 HTTP 方法覆盖
app.use(express.methodOverride());
// 实现 CSRF 防护
app.use(express.csrf());
// 列出目录
app.use(express.directory("public"));

app.get("/", (req, res) => {
  //解析到的 JSON 数据
  console.log(req.body);
  //解析到的 query 参数
  console.log(req.query);
  //解析到的 params 参数
  console.log(req.params);
  //解析到的 headers
  console.log(req.headers);
  //解析到的 cookie
  console.log(req.cookies);
  //解析到的 session
  console.log(req.session);
  res.send("Hello World!");
});
```

> [!NOTE]
> 第三方中间件同样是使用 `app.use` 方法去使用，如实现身份验证、日志记录、缓存、压缩等 自行文档查看使用

### 自定义中间件

Json 请求体解析中间件

```typescript
app.post("/test", (req, res) => {
  let bf;
  req.on("data", (chunk: any) => {
    bf = chunk;
  });
  req.on("end", (chunk) => {
    console.log(bf.toString());
    res.send(JSON.parse(bf));
  });
});
```

发送测试

````typescript
fetch("/test", {
  method: "POST",
  headers: {
  'Content-Type': 'application/json; charset=UTF-8',
  },
  body: JSON.stringify(obj) // 序列化对象为 JSON 字符串
})
```

利用自定义中间件实现解析 json 请求体

x-www-form-urlencoded 格式请求数据解析为对象 挂载到 body 上

```typescript
//可以自己挂载到对应的中间件上
app.use((req, res, next) => {
  let str: string;
  let array = {};
  req.on("data", (chunk: any) => {
    str += chunk;
  });
  req.on("end", () => {
    str = str.replace(/^undefined/, "");
    str = str.split("&");
    str.forEach((item: any) => {
      let [key, value] = item.split("=");
      array[key] = value;
    });
    console.log(array);
    req.body = array;
    next();
  });
});
````

封装为 package

入口文件 index.ts

```typescript
const urlCOde = require("Urlcode/lib/handle");

module.exports = urlCOde;
```

lib/handle.ts

```typescript
// 写的非常简单，没有做任何的异常处理，仅供参考
// 后续些响应头类型判断，可以有效防止处理异常

const urlCOde = (req, res, next) => {
  let str;
  let array = {};
  req.on("data", (chunk) => {
    str += chunk;
  });
  req.on("end", () => {
    str = str.replace(/^undefined/, "");
    str = str.split("&");
    str.forEach((item) => {
      let [key, value] = item.split("=");
      array[key] = value;
    });
    console.log(array);
    req.body = array;
    next();
  });
};

module.exports = urlCOde;
```

## 开放跨域

> [!TIP]
> 跨域是浏览器的一种安全策略，它是由浏览器的同源策略造成的。 使用 CORS（Cross-Origin Resource Sharing）可以允许一个域名下的 Web 应用访问另一个域名下的资源。

### 插件跨域

安装插件 cors

```bash
npm install cors --save
npm install @types/cors --save-dev
```

使用插件

> [!TIP]
> cors 只能接受 9 个请求头，超出了它就无法处理，只能手动配置。

```typescript
const express = require("express");
const cors = require("cors");
const app = express();

//使用插件
app.use(cors());
//想在哪使用就在 router app.all 方法里面加一个cors()方法就行了，记得是在写回调函数之前添加

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
```

### 简单跨域

```typescript
const express = require("express");
const app = express();

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  //后面的header也不是很重要，主要是第一个行的验证，*代表允许所有域名跨域访问
  res.header(
    "Access-Control-Allow-Headers",
    "Content-Type,Content-Length,Authorization,Accept,X-Requested-With"
  );
  //指定方式
  res.header("Access-Control-Allow-Methods", "PUT,POST,GET,DELETE,OPTIONS");
  res.header("X-Powered-By", "3.2.1");
  res.header("Content-Type", "application/json;charset=utf-8");
  next();
});

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
```

### 复杂跨域

```typescript
const express = require("express");
const app = express();

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "http://localhost:8080");
  res.header(
    "Access-Control-Allow-Headers",
    "Content-Type,Content-Length,Authorization,Accept,X-Requested-With"
  );
  res.header("Access-Control-Allow-Methods", "PUT,POST,GET,DELETE,OPTIONS");
  res.header("X-Powered-By", "3.2.1");
  res.header("Content-Type", "application/json;charset=utf-8");
  next();
});

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
```

1. Access-Control-Allow-Origin 允许跨域访问的域名
1. Access-Control-Allow-Headers 允许跨域请求携带的请求头
1. Access-Control-Allow-Methods 允许跨域请求使用的请求方法
1. X-Powered-By 服务器信息
1. Content-Type 响应头类型

## 请求

### 简易请求

> [!NOTE]
> 简单请求是指不包含自定义 HTTP 头的 GET、HEAD、POST 请求。只有 GET 和 POST 请求会触发 CORS 预检。

1. 简单请求不包含自定义 HTTP 头，所以不会触发 CORS 预检。
2. 简单请求的请求方法是 GET、HEAD、POST，所以不会触发对请求方法的检查。
3. 简易请求无自定义请求头，所以不会触发跨域请求。

### 预检请求

> [!TIP]
> 预检请求是指使用 OPTIONS 方法发起的，会先发送一个预检请求 带有 OPTIONS 请求头，询问服务器是否响应请求。

1. 预检请求会先发送一个 OPTIONS 请求，服务器端根据你的请求头判断是否响应请求。
2. 预检请求具有安全性，防止接口恶心攻击|调用，需要预检请求自定义请求头。
3. 预检请求能可实现跨域请求，但是需要服务器端响应预检请求。

### 复杂请求

> [!WARNING]
> 复杂请求是指包含自定义 HTTP 头的请求，比如 PUT、DELETE 请求。

1. 复杂请求可帮助服务器端区分请求，使服务器端提高可维护性。

2. 复杂请求的请求方法是 PUT、DELETE …，服务器根据请求头类型进行相应的处理。

3. 复杂请求也需要使用预检进行跨域请求，但是服务器端需要响应预检请求。

## JSONP 接口

> [!TIP]
> JSONP 是一种跨域请求的技术，它利用 `<script>` 标签的 src 属性，请求一个跨域 URL，并在请求中加入回调函数参数，服务器端将响应内容作为参数值返回给回调函数。

JSONP 只支持 GET 请求，所以只能实现 GET 请求的跨域请求。

JSONP 通常是用来传输数据，通常不使用 JSONP 来作为普通接口使用。

> [!CAUTION]
> JSONP 只能返回 JSON 格式的数据，不能返回其他格式的数据。

```typescript
app.get("/jsonp", (req, res) => {
  const data = { name: "张三", age: 20 };
  //通过 query 获取参数
  /* ?callback=jsonpCallback */
  const callback = req.query.callback;
  //将拿取到的参数和数据进行拼接 将数据转化为 JSON 格式
  const jsonp = `${callback}(${JSON.stringify(data)})`;
  res.send(jsonp);
});
```
