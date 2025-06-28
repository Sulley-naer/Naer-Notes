# 菜单栏 [官方文档](https://www.electronjs.org/zh/docs/latest/api/menu)

## 菜单栏的创建

### Main 进程创建

```javascript
const { app, Menu } = require("electron");

//通常设计俩套系统菜单，分别为Mac和Windows。
console.log(process.platform); //获取系统平台

const template = [{}];
//可放置在生命周期函数中 菜单配置在窗口创建之前。
const menu = Menu.buildFromTemplate(template);
Menu.setApplicationMenu(menu);
//注意顺序，先创建菜单，再创建窗口。
app.loadFile("index.html");
```

### Render 进程创建

> 高版本 remote 模块已弃用，并且 Render 无法直接导入 Menu 模块 [解决方法](Preload.md#双向通信)

```javascript
const { remote } = require("electron");
const { Menu } = remote;

const template = [{}};

const menu = Menu.buildFromTemplate(template);
Menu.setApplicationMenu(menu);
```

default menu template [官方示例](https://www.electronjs.org/zh/docs/latest/api/menu#示例)

```javaScript
const template = [
    {
        label:"管理",
        subMenu:[
            {
                label:"切换控制台",
                accelerator: "CommandOrControl+Shift+I",
                click: () => {
                  const win = BrowserWindow.getFocusedWindow();
                  win.webContents.toggleDevTools();
                },
            }
        ]
    },
  {
    label: "文件",
    submenu: [
      {
        label: "新建",
        accelerator: "CommandOrControl+N",
        click: () => {
          console.log("新建文件");
        },
      },
      {
        label: "打开",
        accelerator: "CommandOrControl+O",
        click: () => {
          console.log("打开文件");
        },
      },
      {
        label: "保存",
        accelerator: "CommandOrControl+S",
        click: () => {
          console.log("保存文件");
        },
      },
      {
        label: "另存为",
        accelerator: "CommandOrControl+Shift+S",
        click: () => {
          console.log("另存为");
        },
      },
      {
        //官方分割线样式
        type: "separator",
      },
      {
        label: "退出",
        accelerator: "CommandOrControl+Q",
        click: () => {
          remote.app.quit();
        },
      },
    ],
  },
  {
    label: "编辑",
    submenu: [
      {
        label: "撤销",
        accelerator: "CommandOrControl+Z",
        click: () => {
          console.log("撤销");
        },
      },
      {
        label: "重做",
        accelerator: "CommandOrControl+Shift+Z",
        click: () => {
          console.log("重做");
        },
      },
      {
        type: "separator",
      },
      {
        label: "复制",
        accelerator: "CommandOrControl+C",
        click: () => {
          console.log("复制");
        },
      },
      {
        label: "粘贴",
        accelerator: "CommandOrControl+V",
        click: () => {
          console.log("粘贴");
        },
      },
      {
        label: "剪切",
        accelerator: "CommandOrControl+X",
        click: () => {
          console.log("剪切");
        },
      },
    ],
  },
  {
    label: "视图",
    submenu: [
      {
        label: "全屏",
        accelerator: "F11",
        click: () => {
          console.log("全屏");
        },
      },
      {
        label: "缩放",
        submenu: [
          {
            label: "放大",
            accelerator: "CommandOrControl+Shift+=",
            click: () => {
              console.log("放大");
            },
          },
          {
            label: "缩小",
            accelerator: "CommandOrControl+-",
            click: () => {
              console.log("缩小");
            },
          },
          {
            label: "还原",
            accelerator: "CommandOrControl+0",
            click: () => {
              console.log("还原");
            },
          },
        ],
      },
    ],
  },
  {
    label: "帮助",
    submenu: [
      {
        label: "关于",
        click: () => {
          console.log("关于");
        },
        //可自定义图标
        icon: "path/to/icon.png",
        //关键字，特定key，具有默认快捷键，默认函数，比如copy，paste等。
        Role: "about",
        //快捷键配置
        accelerator: "CommandOrControl+H",
        //跳转链接，可以是http，也可以是本地路径。
        Redirection: "https://www.electronjs.org",
        //是否可点击，默认true。
        enabled: true,
        //是否可选中，默认true。
        visible: true,
        //类型,复选框…… 文档有说明。
        type: "normal",
        submenu: [
            {
                label:"子菜单"
            },
            {
                label:"window",
                //侧面展开菜单
                type:"submenu",
                role:"windowMenu",
                //可以不用自己配置子菜单了，Role属性使用系统默认的。
            }
        ],
      },
    ],
  },
];
```

## 动态菜单

### Main 进程添加菜单

```javascript
const { app, Menu } = require("electron");

const template = [
  {
    label: "默认",
    submenu: [
      {
        label: "新建",
        click: () => {
          console.log("新建");
        },
      },
    ],
  },
];

const menu = Menu.buildFromTemplate(template);
Menu.setApplicationMenu(menu);

const addMenu = (name, callback) => {
  const newMenu = {
    label: "name",
    click: () => {
      callback();
    },
  };
  template[0].submenu.push(newMenu);
  const newMenuInstance = Menu.buildFromTemplate(template);
  Menu.setApplicationMenu(newMenuInstance);
};

addMenu("新建", () => {
  console.log("新建");
});
```

## 右键菜单

### Main 进程创建右键菜单

```javascript
const { app, BrowserWindow, Menu } = require("electron");

let win;

app.on("ready", () => {
  win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
    },
  });

  win.loadFile("./pages/index.html");

  // 创建右键菜单模板
  const templateR = [
    {
      label: "刷新",
      click: () => {
        win.reload();
      },
    },
    {
      label: "打开开发者工具",
      click: () => {
        win.webContents.openDevTools();
      },
    },
  ];

  // 构建右键菜单
  const menuR = Menu.buildFromTemplate(templateR);

  // 在窗口上监听右键事件以显示右键菜单
  win.webContents.on("context-menu", (event) => {
    menuR.popup({ window: win });
  });
});
```

## [Shell](Shell&iframe.md) | [Dialog](Dialog.md) | [Register](Register.md)
