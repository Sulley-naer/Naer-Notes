# Vite 项目结构[官方文档](https://cn.vitejs.dev/guide/)

1. `index.html`：入口 HTML 文件，通常包含了页面的骨架结构、CSS 引用、JavaScript 引用等。
2. `main.js`：项目的 JavaScript 入口文件，通常包含了项目的业务逻辑。
3. `App.vue`：项目的组件入口文件，通常包含了项目的组件定义。
4. `assets`：静态资源目录，通常包含了图片、字体、音频、视频等。
5. `components`：组件目录，通常包含了项目的公共组件。
6. `views`：视图目录，通常包含了项目的页面视图。
7. `router`：路由目录，通常包含了项目的路由配置。
8. `store`：状态管理目录，通常包含了项目的状态管理配置。
9. `styles`：样式目录，通常包含了项目的公共样式文件。
10. `utils`：工具目录，通常包含了项目的工具函数。
11. `vite.config.js`：Vite 配置文件，通常包含了项目的 Vite 相关配置。

## src 目录

`Css` | `components` | `views` | `router` | `store` | `utils` | `assets` | `styles` | `index.html` | `main.js` | `App.vue`

```javascript
├── src
│   ├── css
│   ├── components
│   ├── views
│   ├── router
│   ├── store
│   ├── utils
│   ├── assets
│   ├── styles
│   ├── index.html
│   ├── main.js
│   └── App.vue
│   └──Json
│   └────Data.json
```

所有文件都能导入并使用

> [!IMPORTANT]
> Vite 会自动过滤掉 未使用的依赖 能省下非常大的资源 在引入第三方库时 务必请 **按需引入** `import{ 对应组件 } from '第三方库名'`

```javascript
// 传统引入方式
import "./assets/style.css";
import img from "./assets/img.png";

// 入口文件

import App from "./App.vue";
import { createApp } from "vue";

import App from "./App.vue";

const app = createApp(App);

app.use(router).use(store).mount("#app");
```

## 配置路径别名

```javascript
// vite.config.js
/* 一定要使用 path 模块 能正确处理不同平台的路径 */
import path from "path";
/*
npm i path -D
*/
export default {
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "src"),
      "@assets": path.resolve(__dirname, "src/assets"),
      "@components": path.resolve(__dirname, "src/components"),
      "@views": path.resolve(__dirname, "src/views"),
      "@router": path.resolve(__dirname, "src/router"),
      "@store": path.resolve(__dirname, "src/store"),
      "@utils": path.resolve(__dirname, "src/utils"),
      "@styles": path.resolve(__dirname, "src/styles"),
    },
  },
};
```

> 这样就能解决不同目录下的文件引入问题

```javascript
// 别名引入
import img from "@assets/img.png";
import style from "@styles/style.css";
import { 对应组件 } from "@components";
```
