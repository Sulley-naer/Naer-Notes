# 状态管理

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
