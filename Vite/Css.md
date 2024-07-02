# Vite css 处理 [官方文档](https://cn.vitejs.dev/guide/features.html#css)

> [!NOTE]
>
> > Vite 支持将 JS 中导入的 css 文件 解析 为 JS 并且使用预处理器 构建后 再将 esm 格式的 css 文件添加进页面的 style 中
>
> > [!WARNING]
> > CSS 导入的可能会出现变量名重复，并且导致样式冲突失效的情况，所以 Vite 中添加了 css modules 功能，可以解决这个问题。

```javascript
import styles from "./index.module.css";

const div = document.createElement("div");
// 这样绑定的类名会根据导入的对象 会加上内存位置生成不同的类名前嘴 js是可以直接写类名的
div.className = styles.container;
document.body.appendChild(div);
```

通常不用手动配置 直接 vue 里面 scope，只是说下 Vite 处理方式

## Vite config 配置方式 [哈希配置](https://github.com/css-modules/postcss-modules#generating-scoped-names)

```javascript
// vite.config.js
import { defineConfig } from "vite";
// Vite 是利用了 postcss-modules 处理css modules
export default defineConfig({
  css: {
    preprocessor: "sass", // 预处理器
    modules: true, // css modules
    // 模块化默认行为 自定义方式
    modules: {
      localIdentName: "[name]__[local]___[hash:base64:5]",
      // 自定义模块化类名规则
      //camelCase | camelCaseOnly 驼峰式 | dashes | dashesOnly 短横线连接符 | 短横线连接符
      //其他自定义规则 [name] 代表文件名 [local] 代表局部变量名 [hash:base64:5] 代表哈希值 前5位 base64 编码 可以自定义长度
      // 也可以自定义生成规则 如 自动生成前缀 后缀 等等 具体看文档

      // 直接配置当前 是模块化 还是全局化 css
      scopeBehaviour: "global",
      // 拿去css文件名和文件位置和 css文件内容 进行自定义处理
      generateScope: (name, fileNames, css) => {},
    },
    // 自定义预处理器配置项
    preprocessorOptions: {
      //对象里面存 key 对应的值 vite 不会智能提示，需自己查看配置预处理的文档
      less: {
        math: "always",
        //全局变量配置，css 支持 :root{--变量名:值;}进行配置 兼容性较差
        globalVars: {
          MainTheme: "blue",
          //less 配置 自定义 全局变量 使用的使用 需import less 文件，变量使用：@变量名 Vite 自动解析 并且修改对应值
        },
      },
    },
  },
});
```

## postcss 进行 css 降级处理

```bash
# 普遍版本 vita 中不需要手动安装 postcss
npm i postcss -D
# 降级版本 预设需用
npm install postcss-preset-env -D
# node 版本
npm i postcss postcss-cli -D
```

node 环境使用提前预留效果 [文档|代理](https://www.npmjs.com/package/postcss-cli)

```bash
# 路径 -o 输出文件 输出文件路径名称
npx postcss src/index.css -o dist/index.css
```

配置文件

### Node 版本配置文件

```javascript
// postcss.config.js
module.exports = {
  plugins: [
    require("postcss-preset-env")({
      // 这里配置降级处理的浏览器版本
      browsers: "last 2 versions",
    }),
  ],
};
```

### Vite 配置文件配置降级处理[官方文档](https://cn.vitejs.dev/guide/features#postcss)

> [!TIP]
> 如果项目包含有效的 PostCSS 配置 (任何受 postcss-load-config 支持的格式，例如 postcss.config.js)，它将会自动应用于所有已导入的 CSS。

```javascript
// vite.config.js
import { defineConfig } from "vite";
import postcssPresetEnv from "postcss-preset-env";

export default defineConfig({
  css: {
    preprocessorOptions: {
      // 这里配置降级处理的插件，可跟配置 postcss.config.js 二选一
      postcss: {
        plugins: [
          postcssPresetEnv({
            // 这里配置降级处理的浏览器版本
            browsers: "Chrome >= 55, Firefox >= 50, Safari >= 10, Edge >= 13",
          }),
        ],
      },
    },
  },
});
```

测试 css Vite 中配置的只会再 Vite 网页中看到，Node 运行的只认 postcss.config.js [查看兼容](https://developer.mozilla.org/zh-CN/docs/Web/CSS/clamp#浏览器兼容性)

```css
/* index.css */
.container {
  width: clamp(200px, 50%, 800px);
}
```

### 可能会出现 导入 less 文件无法降级的情况

使用 `vite-plugin-legacy` 可以解决这个问题

```bash
npm i vite-plugin-legacy -D
```

```javascript
// vite.config.js
import { defineConfig } from "vite";
import legacy from "vite-plugin-legacy";

export default defineConfig({
  plugins: [
    legacy({
      targets: ["defaults", "not IE 11"], // 这里配置降级处理的浏览器版本
      additionalLegacyPolyfills: ["regenerator-runtime/runtime"], // 这里配置需要额外添加的 polyfill
    }),
  ],
  css: {
    preprocessorOptions: {
      less: {
        math: "always",
        globalVars: {
          MainTheme: "skyblue",
        },
      },
      postcss: {
        plugins: [
          postcssPresetEnv({
            // 这里配置降级处理的浏览器版本
            browsers: "Chrome >= 80",
          }),
        ],
      },
    },
  },
});
```
