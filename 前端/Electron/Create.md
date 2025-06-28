# Electron 入门 [官方文档](https://www.electronjs.org/zh/docs/latest/tutorial/quick-start)[Vite 版本](https://cn.electron-vite.org/)

## 安装

```base
# 官方命令
npm install --save-dev electron
# 简写命令
npm i -D electron

服务器不是很好使用代理
npm config set proxy=http://127.0.0.1:8087

Vite 版本
npm i electron-vite -D
```

- 规范

```javascript
{
  "name": "project-name",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    //设置启动脚本! 注意空格 electron .
    "start": "electron ."
  },
  // 必须填写 author 和 license
  "author": "Your name,
  // 必须填写 license
  "license": "ISC",
  // 非强制规范填写项目「版本」描述
  "description": "Hello world",
}
```

## 运行

```base
# 启动项目
npm start
```

> - 不出意外 抛出异常 你没有创建 index.js 入口文件

## 配置启动脚本

```javascript
// index.js
console.log("成功启动 Electron 项目");
```

## [正式开始](Main.md)
