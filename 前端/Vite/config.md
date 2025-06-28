# Vite [配置](https://cn.vitejs.dev/config/)

Vite 的配置文件是一个 `vite.config.js` 文件，它是一个 Node.js 模块，导出一个默认导出函数，接收一个 `config` 对象作为参数。

相比与传统的 webpack 配置，Vite 的配置更加简单灵活，它提供了一系列的 API，可以用来自定义构建过程。

webpack 的配置通常是一个非常复杂的对象，不同环境都需要重新配置 如 `webpack.dev.js`、`webpack.prod.js`、 `webpack.base,js`、`webpack.merge.js` 等，而 Vite 的配置则更加简单易懂，只需要一个 `vite.config.js` 文件即可。

> [!NOTE]
> 配置文件是通过导出对象来配置的，而不是通过命令行参数。
>
> ```javascript
> // vite.config.js
> import { defineConfig } from "vite";
> //Vite 给的配置 可以让编辑器识别 Vite 语法
> export default defineConfig(config => {
>   optimizeDeps: {
>     include: ["foo", "bar"],
>   },
> });
> ```

- JS 让编辑器识别类型提示 定义好的注释均能再编辑器使用时显示弹窗提示
- 注释中可以添加一些特殊的标记，如 `@type` `@param` `@returns` `@example` `@author` `@version` `@license` `@see` `@todo` `@deprecated` `@copyright` `@link`

> [!TIP]
>
> ```javascript
> // main.js
> /**
>  * 加法函数
>  * @param {number} a 第一个数类型
>  * @param {number,string} b 第二个数类型 对象中2个参数数组和字符串
>  * @returns {数字之合} 标记返回值类型为数字
>  * @type {function} 标记代码类型，这里是函数也可以使用导入类型
>  * @example add(1, 2) // 3 标记函数调用示例
>  * @author 作者名 标记作者
>  * @version 版本号 标记版本号
>  * @license 许可证 标记许可证
>  * @see 参考链接 标记参考链接
>  * @todo 待办事项 标记待办事项
>  * @deprecated 废弃函数 标记废弃函数
>  * @copyright 版权信息 标记版权信息
>  * @see {@link https://www.baidu.com} 标记链接
>  * @see {@link add} 标记链接到函数
>  * @see {@link add|add函数} 标记链接到函数并显示别名
>  * @see {@link add|add函数|百度链接} 标记链接到函数并显示别名和描述
>  * @type import('vite').UserConfig 标记导入的类型
>  */
> function add(a) {}
> ```

## 组件化配置 Vite ，不同环境使用不同的配置文件，如开发环境使用 `vite.config.js` ，生产环境使用 `vite.config.prod.js`

> [!NOTE]
>
> 1. 创建 `vite.config.js` 文件，导出一个默认导出函数，接收一个 `config` 对象作为参数。
> 2. 在 `vite.config.js` 文件中，使用 `import` 导入不同环境的配置文件。
> 3. 使用

```javascript
// vite.config.js
import { defineConfig } from "vite";
import path from "path";

// 开发环境配置文件
const devConfig = {
  // 开发环境配置
};

// 生产环境配置文件
const prodConfig = {
  // 生产环境配置
};

//可通过导入文件形式 去配置不同环境文件

import devConfig from "./vite.config.dev.js";
import prodConfig from "./vite.config.prod.js";
import baseConfig from "./vite.config.base.js";
他们均需要通过export default 导出一个对象

//策略模式 ，高可读性
const envResolver = {
  build: () => Object.assign({},baseConfig,prodConfig),
  serve: () => Object.assign({},baseConfig,devConfig),
  //es6语法 合并对象
  build: () => ({...baseConfig,...prodConfig}),
  serve: () => ({...baseConfig,...devConfig}),
};

// 导出配置 command 获取当前环境 Build/Serve 再返回配置对象
export default defineConfig(({ command }) => {
  console.log(command);
  return envResolver[command]();
});
```

## 打包配置 [配置](https://cn.vitejs.dev/config/build-options.html)

> [!TIP]
> Vite 提供了一些内置的打包配置，如 `build.minify`、`build.target`、`build.rollupOptions` 等。

```javascript
// vite.config.js
import { defineConfig } from "vite";

export default defineConfig({
  build: {
    minify: "terser", // 压缩代码
    target: "es2015", // 编译目标
    rollupOptions: {
      output: {
        assetFileNames: "assets/[ext]/[name]-[hash].[ext]", // 输出静态资源文件名 [ext] 扩展名 [name] 文件名 [hash] 哈希值 [query] 查询参数
      },
    },
    assetsInlineLimit: 4096, // 静态资源内联压缩 Base64 大小限制
    outerDir: "dist", // Build 打包输出目录
    assetsDir: "assets", // 静态资源目录
  },
});
```

- `build.minify` 压缩代码，默认使用 `terser` 压缩代码，也可以设置为 `false` 不压缩代码。
- `build.target` 编译目标，默认使用 `es2015` 编译目标，也可以设置为 `esnext` 编译最新特性。
- `build.rollupOptions.input` 打包入口文件，可以指定多个入口文件。

## 插件 [配置](https://cn.vitejs.dev/plugins/)

> [!TIP]
> Vite 提供了插件机制，可以扩展 Vite 的功能。 如 `vite-plugin-react-refresh`、`vite-plugin-windicss`、`vite-plugin-icons` 等。

插件是用于帮助 Vite 生命周期 中执行 不同的事件 用于丰富拓展 Vite 的功能。同样是在 `vite.config.js` 文件中配置。**中间件** 也是一种插件，但它是在 Vite 生命周期的中间位置执行。

- vite-aliased - 别名插件 自动根据 src 目录设置别名，可以给导入路径设置别名。
- vite-plugin-components - 自动导入组件 自动导入 `.vue` 文件中的组件。
- vite-plugin-icons - 自动导入图标 自动导入 `.svg` 文件中的图标。
- vite-plugin-md - Markdown 编译插件 编译 `.md` 文件为 `.js` 文件。
- vite-plugin-pages - 自动导入路由 自动导入 `.vue` 文件中的路由。

```javascript
// vite.config.js
import { defineConfig } from "vite";
import { ViteAliases } from "vite-aliases";

export default defineConfig({
  plugins: [
    ViteAliases({
      // 手动设置别名
      "@": path.resolve(__dirname, "src"),
    }),
  ],
  //原本别名配置
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "src"),
    },
  },
});
```

## [Configure](./Configure&mock.md) | [Construct](./Construct-plugins.md) | [structure](./structure.md)
