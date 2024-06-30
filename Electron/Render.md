# Render 进程 [官方文档](https://www.electronjs.org/zh/docs/latest/tutorial/quick-start#%E9%A2%9D%E5%A4%96%E5%B0%86%E5%8A%9F%E8%83%BD%E6%B7%BB%E5%8A%A0%E5%88%B0%E6%82%A8%E7%9A%84%E7%BD%91%E9%A1%B5%E5%86%85%E5%AE%B9)

## DOM 引入直接使用的 Render 进程

```javascript
//renderer.js
let btn = document.getElementById("btn");

const fn1 = () => {
  alert("成功");
};

btn.addEventListener("click", fn1);
```

```html
<!--index.html-->
<button id="btn">点击</button>
<script src="renderer.js"></script>
```

> 它只是用来渲染 Dom 的，只是普通网页 JS 功能 可以使用 Vue ...

## Electron render 事件

> [electron 事件](https://www.electronjs.org/zh/docs/latest/api/web-contents) [完整事件](https://www.electronjs.org/zh/docs/latest/api/web-contents#实例事件) [窗口方法](https://www.electronjs.org/zh/docs/latest/api/web-contents#方法) [完整方法](https://www.electronjs.org/zh/docs/latest/api/web-contents#实例方法) [BrowserWindow API](https://www.electronjs.org/zh/docs/latest/api/browser-window)
>
> > electron 事件是基于 webContents 实例的，webContents 实例是每个渲染进程的核心，负责渲染网页内容。

[获取当前 webContents 实例](https://www.electronjs.org/zh/docs/latest/api/web-contents#方法)

```javascript
//renderer.js
const { remote } = require("electron");
// 使用remote 中 webContents 实例 打开开发者工具
const webContents = remote.getCurrentWebContents();

const fn1 = () => {
  webContents.openDevTools();
};

// 打开窗口
let subWin = new remote.BrowserWindow({
  //绑定父窗口
  parent: remote.getCurrentWindow(),
  // modal 为 true 则窗口为模态窗口，父窗口不可点击 常配套使用
  modal: true,
  width: 400,
  height: 300,
});
subWin.loadFile("sub.html");
// 窗口事件
subWin.on("closed", () => {
  console.log("子窗口已关闭");
  subWin = null;
});
```

## [Build](Build.md)
