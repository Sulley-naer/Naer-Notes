# Clipboard 剪切板 [官方文档](https://www.electronjs.org/docs/api/clipboard)

Electron 提供了 `clipboard` 模块，可以用来读写剪切板内容。

## 读写剪切板

### 读剪切板内容

```javascript
const { clipboard } = require("electron");

const text = clipboard.readText();
```

### 写剪切板内容

```javascript
const { clipboard } = require("electron");

clipboard.writeText("Hello, world!");
```

## 监听剪切板事件

```javascript
const { clipboard } = require("electron");

clipboard.on("change", () => {
  console.log("Clipboard content changed");
});
```

## demo

> 读取剪切板内容，写入通知

```javascript
const { clipboard } = require("electron");

let add = document.getElementById("add");

add.addEventListener("click", () => {
  // shell.openExternal("https://www.nuxtjs.cn/");
  const msg = {
    title: "通知",
    body: "点我在线查看谛听可爱录像",
    icon: "../earth.ico",
  };
  msg.title = clipboard.readText();
  const send = new window.Notification(msg.title, msg);
});
```

## 其他方法

- `clipboard.readImage()`: 读取剪切板中的图片。
- `clipboard.writeImage(image)`: 写入剪切板中的图片。
- `clipboard.readFindText()`: 读取剪切板中的查找文本。
- `clipboard.writeFindText(text)`: 写入剪切板中的查找文本。
- `clipboard.readAvailableFormats()`: 读取剪切板中可用的格式。
- `clipboard.clear([type])`: 清空剪切板内容。
- `clipboard.availableFormats()`: 获取剪切板中可用的格式。
- `clipboard.read(type)`: 读取指定格式的剪切板内容。
- `clipboard.write(data)`: 写入剪切板内容。
- `clipboard.readHTML()`: 读取剪切板中的 HTML 内容。
- `clipboard.writeHTML(html)`: 写入剪切板中的 HTML 内容。
- `clipboard.readRTF()`: 读取剪切板中的 RTF 内容。
- `clipboard.writeRTF(rtf)`: 写入剪切板中的 RTF 内容。
- `clipboard.readBookmark()`: 读取剪切板中的书签。
- `clipboard.writeBookmark(title, url)`: 写入剪切板中的书签。
- `clipboard.readText(type)`: 读取指定格式的剪切板文本内容。
- `clipboard.writeText(text)`: 写入剪切板文本内容。
- `clipboard.readData(type)`: 读取指定格式的剪切板数据内容。
- `clipboard.writeData(data, type)`: 写入剪切板数据内容。
- `clipboard.readSecureContent()`: 读取安全内容。
- `clipboard.writeSecureContent(contentType, data)`: 写入安全内容。
- `clipboard.readAvailableMimeTypes()`: 读取剪切板中可用的 MIME 类型。

## [dialog](dialog.md) | [msg](msg.md) | [shell](Shell&iframe.md)
