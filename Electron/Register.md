# 全局注册[官方文档](https://www.electronjs.org/zh/docs/latest/api/global-shortcut)

```javascript
const { app, globalShortcut } = require("electron");

app.on("ready", () => {
  // 注册快捷键
  globalShortcut.register("CommandOrControl+Shift+A", () => {
    //窗口非焦点，也能触发事件
    console.log("快捷键触发");
  });

  // 注销快捷键
  globalShortcut.unregister("CommandOrControl+Shift+A");
  // 注销所有快捷键
  globalShortcut.unregisterAll();
});
```

## 逻辑局部注册

```javascript
const { app, BrowserWindow, globalShortcut } = require("electron");

let win;

function createWindow() {
  win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
    },
  });

  win.loadFile("index.html");

  win.on("focus", () => {
    // 注册快捷键，当窗口处于焦点时
    globalShortcut.register("CommandOrControl+Shift+A", () => {
      console.log("快捷键触发");
    });
  });

  win.on("blur", () => {
    // 注销快捷键，当窗口失去焦点时
    globalShortcut.unregister("CommandOrControl+Shift+A");
  });

  win.on("closed", () => {
    win = null;
  });
}

app.on("ready", createWindow);

app.on("will-quit", () => {
  // 注销所有快捷键
  globalShortcut.unregisterAll();
});
```
