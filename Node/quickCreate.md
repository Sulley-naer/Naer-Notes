# 本文档用于快速构建一个 Node 服务器

## 准备工作

- 安装 Node.js
- 安装 npm
- 安装 Express

## 创建项目

```bash
mkdir quickCreate
cd quickCreate
npm init -y
```

## 安装依赖

```bash
npm install express
npm install koa
npm install path
```

## 创建服务器 Index.js

> [!IMPORTANT]
> 注：服务端路径拼接请一定要使用 `path` 模块，如果使用终端的相对路径 `process.cwd()`，它是会基于终端运行目录来拼接路径，如果终端使用的不是项目根路径，就会导致路径错误。 `path` 的路径是基于运行当前文件 `main.js` 的路径来拼接的。不同系统的`/` 和 `\`也能处理，并且是先获取绝对路径，再使用 **相对路径** 拼接的。 `__dirname` 是 Node 内置方法

```javascript
//开启服务器端口
const Koa = require("koa");
//处理服务器请求
const fs = require("fs").promises;
//获取路径
const path = require("path");

const app = new Koa();

app.listen(5177, () => {
  console.log("端口开启成功");
});

app.use(async (ctx) => {
  // console.log("visit:", ctx.request, ctx.response);
  if (ctx.request.url === "/" || ctx.request.url === "") {
    //拼接html文件路径,并读取文件内容,返回给浏览器
    let lj = path.resolve(__dirname, "./index.html");
    let data = await fs.readFile(lj, "utf8");
    ctx.response.body = data;
    //设置返回内容格式,使浏览器解析
    ctx.response.headers["content-type"] = "text/html; charset=utf-8";
  } else {
    //此用于返回静态JS文件
    let lj = path.resolve(__dirname, "./" + ctx.request.url);
    console.log(lj);
    let data = await fs.readFile(lj);
    ctx.response.body = data;
    //配置返回的文件格式 Js 其他格式根据实际情况配置
    ctx.response.headers["content-type"] = "text/javascript; charset=utf-8";
  }
});
```

> [!TIP]
> 浏览器只支持 2 中类型格式解析,HTML 地址栏更新会重新请求并且刷新页面只有 JS 文件的导入和引入不会刷新页面,浏览器直支持执行 JS 代码. Vue 框架是将 Vue 后缀文件编译成 JS 文件,所以浏览器会直接执行 JS 文件. 利用 JS 去修改 HTML 内容 , Vue 强大之处就在于 将文件重新构建,将编译好的组件功能渲染到 HTML 页面上.并且还能添加对应的 JS 事件监听.

## 运行服务器

```bash
node index.js
```

## 浏览器访问

```base
http://localhost:3000
```
