# 状态管理

安装第三方库

```bash
npm i express-session -D

npm i @types/express-session -D
```

挂载中间件|否者 req 没有 session 属性

```typescript
import session from "express-session";

app.use(
  session({
    secret: "keyboard cat",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: true },
  })
);
```
