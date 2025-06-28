# dialog 模块 [官方文档](https://www.electronjs.org/zh/docs/latest/api/dialog)

> [!IMPORTANT]
> 如需在 Renderer 进程中使用 dialog 模块，需要获取 BrowserWindow 进程对象 再 使用 .dialog 属性。

## 打开文件对话框

> [!CAUTION]
> dialog 是个方法，不是一个对象。主程序直接调用代码，第一个参数是 BrowserWindow 进程对象
>
> > ```javascript
> > dialog.showMessageBox(win, {
> >   message: "成功激活",
> > });
> > ```

```javascript
const { dialog } = require("electron");

add.addEventListener("click", () => {
  dialog.showOpenDialog();
});
```

## 打开文件夹对话框

```javascript
const { dialog } = require("electron");

add.addEventListener("click", () => {
  dialog.showOpenDialog({ properties: ["openDirectory"] });
});
```

## 打开保存文件对话框

```javascript
const { dialog } = require("electron");

add.addEventListener("click", () => {
  dialog.showSaveDialog();
});
```

## 打开消息框

```javascript
const { dialog } = require("electron");

add.addEventListener("click", () => {
  dialog.showMessageBox({
    message: "Hello World",
    buttons: ["OK", "Cancel"],
  });
});
```

## 打开警告框

```javascript
const { dialog } = require("electron");

add.addEventListener("click", () => {
  dialog.showErrorBox("Error", "Something went wrong");
});
```

## 打开选择颜色对话框

```javascript
const { dialog } = require("electron");

add.addEventListener("click", () => {
  dialog.showColorPicker({
    color: "#000000",
  });
});
```

## 打开选择文件对话框

```javascript
const { dialog } = require("electron");

add.addEventListener("click", () => {
  dialog.showOpenDialog({
    properties: ["openFile"],
  });
});
```

## 打开选择多个文件对话框

```javascript
const { dialog } = require("electron");

add.addEventListener("click", () => {
  dialog.showOpenDialog({
    properties: ["multiSelections"],
  });
});
```

## [Main](Main.md) | [Renderer](Renderer.md) | [Dialog](Dialog.md) | [msg](msg.md)
