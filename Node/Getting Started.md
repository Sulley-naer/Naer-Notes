# Node.js 入门

## 安装 Node.js

Node.js 是一个基于 Chrome V8 引擎的独立 JavaScript 运行环境。

你可以从官方网站下载安装包安装 [Node.js](httpshttps://nodejs.org/en/download/)

安装完成后，你应该可以打开命令提示符（Command Prompt）或者 PowerShell，输入 `node -v` 命令查看 Node.js 的版本号。

TypeScript 环境下，可以使用 `@types/node` 类型定义文件来获得更好的代码提示。

```bash
npm install -g @types/node
```

## 文件操作

读取文件

```javascript
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

## [服务器](./CreateServer.md)
