# Preload.js [文档](https://www.electronjs.org/zh/docs/latest/tutorial/quick-start#%E9%80%9A%E8%BF%87%E9%A2%84%E5%8A%A0%E8%BD%BD%E8%84%9A%E6%9C%AC%E4%BB%8E%E6%B8%B2%E6%9F%93%E5%99%A8%E8%AE%BF%E9%97%AEnodejs)

> 让你在渲染进程中运行的 JavaScript 脚本，可以访问 Node 的**部分** API，并且也能可以访问渲染进程中的 DOM 元素。

```JavaScript
// Preload.js
window.addEventListener('DOMContentLoaded', () => {
  const replaceText = (selector, text) => {
    const element = document.getElementById(selector)
    if (element) element.innerText = text
  }

  for (const dependency of ['chrome', 'node', 'electron']) {
    replaceText(`${dependency}-version`, process.versions[dependency])
  }
})
// 方式二主动暴露接口 注入方法到window全局对象 中
window.myAPI = {
  sayHello: () => {
    console.log(process.versions['electron']);
  }
}

// Preload 自己 调用接口
const { myAPI } = window.electron;
myAPI.sayHello();

// 方式四 contextBridge 通信 同样暴露到 window 对象中
import {contextBridge} from 'electron';
contextBridge.exposeInMainWorld('myAPI', {
  sayHello: () => {
    console.log("Hello from Render.js");
  }
});
```

> [Main](Main.md)

```JavaScript
const { app, BrowserWindow } = require("electron");
const path = require("node:path");

// 启动 Electron 窗口
app.on("ready", () => {
  new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      // 预加载脚本 必须绝对路径 调用path获取当前目录 join 拼接
      preload: path.join(__dirname, "preload.js")
      // 开启 Node.js 集成 只介意再后端组件中开启
      nodeIntegration: true,
      // 开启远程内容（如网页）
      enableRemoteModule: true,
      // 禁用 Node.js 隔离 不介意有安全风险
      contextIsolation: false,
    }
  });
});
```

> [!CAUTION]
> nodeIntegration 和 contextIsolation 关闭 后，可以访问 Node.js 的
> API，并且可以访问渲染进程中的 DOM 元素。 非常危险的做法，请谨慎使用。 preload 能解决部分问题

- 方式一 reload 页面 预加载脚本 自动识别替换

```html
<!-- 添加 DOM 元素 preload 自动识别替换 -->
<div id="chrome-version">Chrome Version Placeholder</div>
<div id="node-version">Node Version Placeholder</div>
<div id="electron-version">Electron Version Placeholder</div>
```

- 方式二, 方式三 主动暴露接口

```html
<!-- 调用接口 -->
<button onclick="myAPI.sayHello()">Say Hello</button>
```

- 方式三 contextBridge 通信

```html
<!-- 调用接口 -->
<button onclick="window.myAPI.sayHello()">Say Hello</button>
```

## 主 渲 通 信

- contextBridge 通信

- preload.js

```javascript
// 方式一 ipcRenderer 通信 preload 直接发送消息给主进程 主进程监听消息并处理
// preload 可识别文档 获取元素内容 发送对应消息给主进程 或者添加事件监听
const { ipcRenderer } = require("electron");
ipcRenderer.send("my-channel", "Hello from Render.js");
ipcRenderer.on("my-channel-reply", (event, arg) => {
  console.log(arg); // prints "pong"
});

// 方式二 利用contextBridge 将ipcRenderer 通信暴露到 window 使得渲染进程直接与 preload 通信 再使用 reload层方法 通讯给主进程
import { contextBridge, ipcRenderer } from "electron";
contextBridge.exposeInMainWorld("ipcRenderer", {
  send: (channel, data) => {
    ipcRenderer.send(channel, data);
  },
  on: (channel, func) => {
    ipcRenderer.on(channel, (event, ...args) => func(...args));
  },
});

// 方式七 remote 模块 通信 能访问主进程的模块 几乎不用
const { remote } = require("electron");
const mainProcess = remote.require("./main");
mainProcess.doSomething();
```

主进程

```javascript
import { app, BrowserWindow, ipcMain } = require("electron");
const path = require("path");

// 启动 Electron 窗口
app.on("ready", () => {
  const mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: path.join(__dirname, "preload.js"),
    },
  });
    // 剪头事件需写在渲染进程中
  // 监听渲染进程的消息 并输出到控制台
  ipcMain.on("my-channel", (event, arg) => {
    console.log(arg); // prints "Hello from Render.js"
  });
  mainWindow.loadFile("./pages/index.html");
});
```

- Renderer 方式二 开放了 ipcRenderer 特定通讯方法到 window 对象中，渲染进程可以直接调用 ipcRenderer 的方法。

Renderer

```html
<!-- 发送消息 -->
<button onclick="ipcRenderer.send('my-channel', 'ping')">Send Message</button>
<!-- 接收消息 -->
<script>
  ipcRenderer.on("my-channel-reply", (event, arg) => {
    console.log(arg); // prints "pong"
    //向主进程 `my-channel-reply` 发送内容 主进程监听再进行处理
  });
</script>
```

## 双向通信

main

```javascript
// 主进程
const { app, BrowserWindow, ipcMain } = require("electron");
const path = require("path");

// 启动 Electron 窗口
app.on("ready", () => {
  const mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: path.join(__dirname, "preload.js"),
    },
  });
  //注意使用的是 handle 方法，而不是 on 方法
  ipcMain.handle("call-main", (_, value) => {
    return value + " 主进程已收到";
  });
});
```

preload

```javascript
// 预加载脚本
const { ipcRenderer, contextBridge } = require("electron");

contextBridge.exposeInMainWorld("ipcRenderer", {
  callMain: (value) => {
    //注意用的是 invoke 方法，而不是 send 方法
    // invoke 方法返回一个promise对象，resolve返回值
    return ipcRenderer.invoke("call-main", value);
  },
});
```

render

```html
// 渲染进程
<button onclick="callMain('Hello from Render.js')">Send Message</button>

<script>
  const callMain = async (value) => {
    // 调用preload中的callMain方法，返回一个promise对象，resolve返回值
    const result = await ipcRenderer.callMain(value);
    console.log(result);
  };
</script>
```

[Render](Render.md)
