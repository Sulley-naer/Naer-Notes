# Shell 和 iframe 通信 外部访问 [官方文档](https://www.electronjs.org/zh/docs/latest/api/shell)

> [!TIP]
> 均为 Renderer 进程的 JavaScript API。可直接使用 `require('electron').shell` 调用 **方法**。

## Shell

Shell 模块提供了创建快捷方式、打开文件、打开 URL、打开目录等功能。

### 创建快捷方式

```javascript
const { app, shell } = require("electron");

app.on("ready", () => {
  const shortcutPath = app.getPath("desktop") + "/MyApp.lnk";
  shell.writeShortcutLink(shortcutPath, "My App", app.getPath("exe"), [
    app.getPath("exe"),
    "--my-app-argument",
  ]);
});
```

### 打开文件

```javascript
const { app, shell } = require("electron");

app.on("ready", () => {
  shell.openItem("C:\\Users\\Me\\Documents\\MyFile.txt");
});
```

### 打开 URL

```javascript
const { app, shell } = require("electron");

app.on("ready", () => {
  shell.openExternal("https://www.electronjs.org");
});
```

### 打开目录

```javascript
const { app, shell } = require("electron");

app.on("ready", () => {
  shell.openPath("C:\\Users\\Me\\Documents");
});
```

## iframe

iframe 元素可以嵌入到 web 页面中，可以用来实现多窗口的应用。

### 加载 URL

```html
<iframe src="https://www.electronjs.org"></iframe>
```

### 加载本地文件

```html
<iframe src="file:///C:/Users/Me/Documents/MyFile.html"></iframe>
```

### 通信

通过 window.postMessage() 方法可以实现 iframe 与父窗口的通信。

```javascript
const iframe = document.querySelector("iframe");

iframe.contentWindow.postMessage("Hello from the iframe", "*");

window.addEventListener("message", (event) => {
  console.log(event.data);
});
```

父窗口可以通过 event.source 属性获取 iframe 的 window 对象，然后调用 window.postMessage() 方法向 iframe 发送消息。

```javascript
const iframe = document.querySelector("iframe");

window.addEventListener("message", (event) => {
  if (event.source === iframe.contentWindow) {
    console.log(event.data);
  }
});

iframe.contentWindow.postMessage("Hello from the parent window", "*");
```

### 限制跨域

默认情况下，iframe 元素可以加载任意 URL，可以通过设置 sandbox 属性来限制跨域访问。

```html
<iframe src="https://www.electronjs.org" sandbox></iframe>
```

设置 sandbox 属性后，iframe 元素只能加载同源的 URL，不能访问其他域的资源。

## 参考

- [Electron 官方文档](https://www.electronjs.org/zh/docs/latest/api/shell)
- [Electron 官方文档-iframe](https://www.electronjs.org/zh/docs/latest/api/web-contents#iframe)
