# Node.js 入门

- [Node.js 入门](#nodejs-入门)
  - [安装 Node.js](#安装-nodejs)
  - [模块加载](#模块加载)
  - [文件操作](#文件操作)
  - [路径拼接](#路径拼接)
  - [提取 HTML 样式|JS 并保存](#提取-html-样式js-并保存)
  - [服务器 | 插件编写 | 插件规范](#服务器--插件编写--插件规范)

## 安装 Node.js

Node.js 是一个基于 Chrome V8 引擎的独立 JavaScript 运行环境。

你可以从官方网站下载安装包安装 [Node.js](httpshttps://nodejs.org/en/download/)

安装完成后，你应该可以打开命令提示符（Command Prompt）或者 PowerShell，输入 `node -v` 命令查看 Node.js 的版本号。

TypeScript 环境下，可以使用 `@types/node` 类型定义文件来获得更好的代码提示。

```bash
npm install -g @types/node
```

## 模块加载

Node.js 使用 `require()` 方法来加载模块。

> [!NOTE]
> 路径中有 `./` `../` `/` 开头的路径，它会按照你的路径来查找
>
> 当路径只用名称，它会自动在 `node_modules` 目录下查找
>
> 无则路径父级去找`node_modules`目录 一直到根目录
>
> 路径查找模块顺序：
>
> 1. 名称
> 2. 名称.js
> 3. 名称.json
> 4. 名称.node
>
> 路径文件夹查找顺序：
>
> 1. package.json 的 main 字段
> 2. 根据 main 字段查找入口文件 回到之前的路径查找
> 3. main 字段不存在，查找 index.js

## 文件操作

读取文件

```typescript
// @ts-ignore
const fs: any = require("fs");

fs.readFile("./test.txt", "utf8", (err: any, data: string) => {
  if (err) {
    console.log(err);
  } else {
    console.log(data);
  }
});
```

写入文件

> [!NOTE]
> 写入文件会覆盖原来的所有内容，如果只需要追加内容，可以使用 `fs.appendFile()` 方法。

```javascript
fs.writeFile("./test.txt", "已经被重新写入", (err: any, data: string) => {
  console.log(data);
});
```

## 路径拼接

Node 环境路径拼接可以使用 `path` 模块，它提供了一系列的方法用于处理文件和目录路径。

```javascript
const path = require("path");

//__dirname 获取当前文件的绝对路径

const filePath = path.join(__dirname, "test.txt");

//process.cwd() 为获取终端的运行目录
filePath = path.join(process.cwd(), "test.txt");
```

相对路径拼接 path.resolve 方法 用来处理路径拼接问题，智能识别绝对和相对路径，判断的是`/` 和 `./`开头就拼接上之前绝对路径，前者就是重新生成绝对路径，相对可以一直嵌套拼接下去，注开头必须用`./` 或者直接名称 就是不能用 `/` 开头。

```javascript
/* 也能用process.cwd()获取当前目录 */
let filePath = path.resolve(__dirname, "./test.txt");
```

## 提取 HTML 样式|JS 并保存

> [!TIP]
> 利用正则表达式提取 HTML 样式和 JS 代码并保存到本地文件。

```javascript
const regstyle = /<style>[\s\S]*<\/style>/;
const regscript = /<script[^>][\s\S]*<\/script>/;

fs.readFile(filePath, "utf8", (err, data) => {
  const styles = regstyle.exec(data);
  const resolveStyles = styles[0]
    .replace("<style>", "")
    .replace("</style>", "");
  console.log("提取css" + resolveStyles);

  const cssPath = path.join(__dirname, "./assets/index.css");
  console.log("生成路径", cssPath);

  fs.stat(path.resolve(cssPath), (err, state) => {
    if (state) {
      console.log("有文件夹");
      writeCss();
    } else {
      console.log("没有文件夹");
      fs.mkdirSync(path.resolve(cssPath, ".."));
      writeCss();
    }
  });

  const writeCss = () => {
    fs.writeFile(cssPath, resolveStyles, (err: string) => {
      if (err) console.log("写入失败");
      console.log("写入成功");
    });
  };
});
```

## [服务器](./express.md) | [插件编写](../Vite/Construct-plugins.md) | [插件规范](./Package%20specification.md)
