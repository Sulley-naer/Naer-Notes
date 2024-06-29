# Build()[]

## 1. 安装依赖

```base
npm install electron-builder -D
```

## 2. 配置 package.json [官方文档](https://www.electron.build/configuration/configuration)

```json
{
  "name": "your-app-name",
  "version": "1.0.0",
  "description": "Your app description",
  "main": "main.js",
  "scripts": {
    "start": "electron.",
    "build": "electron-builder"
  },
  "build": {
    "productName": "Your App Name",
    "appId": "com.yourcompany.yourappname",
    "directories": {
      "buildResources": "build"
    },
    "files": ["dist/**/*", "node_modules/**/*"],
    "mac": {
      "category": "your.app.category.type"
    },
    "linux": {
      "target": ["AppImage", "deb", "rpm"]
    }
    "win": {
      "icon": "./icon.ico",
      //   "target": ["nsis", "zip"],
      "target": [
        {
          "target": "nsis",
          "arch": ["x64", "ia32", "zip"]
        }
      ]
    },
    "nsis": {
      "oneClick": false, // 是否一键安装
      "allowToChangeInstallationDirectory": true, // 是否允许用户修改安装目录
      "installerIcon": "./build/icon.ico", // 安装图标
      "uninstallerIcon": "./build/icon.ico", // 卸载图标
      "installerHeaderIcon": "./build/icon.ico", // 安装时头部图标
      "createDesktopShortcut": true, // 是否创建桌面快捷方式
      "createStartMenuShortcut": true // 是否创建开始菜单快捷方式
    }
  },
  "keywords": ["Electron", "app", "your-app-name"],
  "author": "Your Name <<EMAIL>>",
  "license": "MIT",
  "dependencies": {
    "electron": "^11.0.3"
  },
  "devDependencies": {
    "electron-builder": "^22.10.5"
  }
}
```

- 绝对能过版

````json
{
  "name": "elct",
  "version": "1.0.0",
  "main": "main.js",
  "scripts": {
    "start": "nodemon --exec electron .",
    "build": "electron-builder"
  },
  "author": "naer",
  "license": "ISC",
  "description": "111",
  "devDependencies": {
    "electron": "^31.1.0",
    "electron-builder": "^24.13.3"
  },
  "build": {
    "productName": "Your App Name",
    "appId": "com.yourcompany.yourappname",
    "directories": {
      "buildResources": "build",
      "output": "dist"
    },
    "files": [
      "main.js",
      "preload.js",
      "pages/**/*",
      "node_modules/**/*",
      "package.json"
    ],
    "win": {
      "target": [
        {
          "target": "nsis",
          "arch": [
            "x64"
          ]
        }
      ]
    },
    "nsis": {
      "oneClick": false,
      "allowToChangeInstallationDirectory": true,
      "createDesktopShortcut": true,
      "createStartMenuShortcut": true
    }
  }
}
```


## 3. 运行命令

```base
npm run build
````

## 4. 打包后的文件

- Windows: `Your App Name Setup 1.0.0.exe`
- macOS: `Your App Name-1.0.0.dmg`
- Linux: `Your App Name-1.0.0.AppImage` or `Your App Name_1.0.0_amd64.deb` or `Your App Name_1.0.0_amd64.rpm`
- 其他: `Your App Name-1.0.0.zip`
- 构建后的文件位于 `build` 目录下。

## 5. 注意事项

- 请确保 `package.json` 中 `main` 字段指定的是主进程入口文件。
- 请确保 `package.json` 中 `build` 字段指定的是正确的配置。
- 请确保 `build` 目录下有 `index.html` 文件。
- 请确保 `build` 目录下有 `main.js` 文件。
- 请确保 `build` 目录下有 `package.json` 文件。
- 请确保 `build` 目录下有 `node_modules` 目录。
- 请确保 `build` 目录下有 `dist` 目录。
- 请确保 `build` 目录下有 `build` 目录。
