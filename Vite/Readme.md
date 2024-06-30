# 手动构建 Vite 项目，学习 webpack 原理

## 正常使用直接去 Vite 文档查看 npm 代码直接脚手架构建 [官方文档](https://vitejs.cn/)

1. 首先使用 npm init -y 初始化项目
2. 创建`main.js` `index.html` `counter.js`

> [!TIP]
>
> > `index` 注意引入的是 type="module" 使用此语法才能使用 `import` `require` 语法
> >
> > `defer` | `async` 同步:AMD | 异步:CMD 同步是可以保证顺序执行「防止阻塞」 ，异步是可以提高性能
> >
> > ```html
> > <script src="./main.js" type="module" defer | async></script>
> > ```
>
> > [!NOTE]
> > 安装依赖
> >
> > ```bash
> > npm i lodash
> > ```
> >
> > Main.js 引入依赖配置
> >
> > ```javascript
> > import _ from "lodash";
> > console.log("_");
> > //基础文件格式配置完成，配置启动脚本来运行服务段项目,报错很正常
> > ```
>
> > [!WARNING]
> > 现在报错无法引入很正常，因为还没有配置 webpack，下面开始配置 webpack

## 配置 Vite 启动项目

- 安装依赖

```bash
npm i vite -D
-D 是devDependencies 开发环境依赖
-S 是 dependencies 生产环境依赖
-g 是全局安装
```

- 配置启动脚本 `package.json`

```json
{
  "scripts": {
    "dev": "vite"
  }
}
```

> [!TIP]
> 运行 `npm run dev` 启动项目，没有 Import 报错 能正常输出 `_` 代表构建成功。

## 配置 webpack

- 安装依赖

```bash
npm i webpack webpack-cli -D
```

- 配置 webpack.config.js

```javascript
const path = require("path");

module.exports = {
  entry: "./src/main.js",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "bundle.js",
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
    ],
  },
};
```

1. `entry` 入口文件
2. `output` 输出文件配置
3. `module` 模块配置
4. `test` 匹配规则
5. `exclude` 排除规则
6. `use` 使用的 loader

- 配置启动脚本 `package.json`

```json
{
  "scripts": {
    "build": "webpack --config webpack.config.js"
  }
}
```

> [!TIP]
> 运行 `npm run build` 构建项目，没有报错 能正常输出 `bundle.js` 文件代表构建成功。

## 构建原理

- Vite 启动项目，会自动执行 `vite build` 命令，执行流程如下：

1. 读取配置文件 `vite.config.js`
2. 读取入口文件 `index.html`
3. 读取入口文件 `main.js`
4. 读取 `main.js` 依赖的模块 `lodash`
5. 打包 `lodash` 模块
6. 打包 `main.js` 文件
7. 输出 `index.html` 文件
8. 输出 `bundle.js` 文件

- webpack 启动项目，会自动执行 `webpack` 命令，执行流程如下：

1. 读取配置文件 `webpack.config.js`
2. 读取入口文件 `main.js`
3. 读取 `main.js` 依赖的模块 `lodash`
4. 打包 `lodash` 模块
5. 打包 `main.js` 文件
6. 输出 `bundle.js` 文件

- 两者的区别在于，Vite 启动项目，会自动读取配置文件，不需要手动配置 webpack，而 webpack 启动项目，需要手动配置 webpack 配置文件。

- 两者的构建原理相同，都是将入口文件，依赖的模块，打包成一个文件，然后输出到指定目录。

> [!IMPORTANT]
> 他们 运行时均会 扫描所有 JS 文件 将其中的 import 文件路径 自动解析修改成 node_modules 目录下的模块相对路径。
>
> > [!TIP]
> > 简单点说，Vite 就是帮助我们自动引入依赖，不需要手动配置引入依赖路径。
> >
> > 还能自动压缩代码，提高性能。还具备热更新功能，可实时更新查看修改效果

## Vite 构建逻辑

由于每个不同的库 `export` 的格式不同，有些是 `export default`，有些是 `export const`，Vite 构建时会自动处理这些情况，将其转换成统一的格式。

- 对于 export default 的情况，Vite 会自动将其转换成 export const xxx，并将 xxx 赋值给一个变量，比如：

> [!IMPORTANT]
> 导出格式差异，直观展示 require 是 Node 环境下的 import 语法，而 export default 是浏览器环境下的 export 语法。

```javascript
// counter.js
var firstName = "Michael";
var lastName = "Jackson";
var year = 1958;
/* 直接导出整个对象，访问直接使用里面的属性和方法 */
export default {
  firstName: firstName,
  lastName: lastName,
  year: year,
};
/* 导出对象属性，访问时使用变量名.属性名 */
export { firstName, lastName, year };
// 看不懂还有个写法
export const firstName = "Michael";
export const lastName = "Jackson";
export const year = 1958;
// 再库文件中，他们的数据是通过导入的方式来访问的 不是我这样写死的，使用的时候会全部导入进来运行加载。
export { default as counter } from "./counter";
```

> [!IMPORTANT]
> 不同导入方法和使用

```javascript
// main.js

/* CommonJS 直接调用对象的属性和方法 */
import counter from "./counter";
console.log(
  counter.firstName + " " + counter.lastName + " was born in " + counter.year
);

/* ES6 使用变量名.属性名 */
import { firstName, lastName, year } from "./counter";
console.log(firstName + " " + lastName + " was born in " + year);
```

> > [!TIP]
> > 方式一再 es 中叫做 `commonjs` 命名空间导入，方式二叫做 `es6` 按需导入 更贴近组件化开发的思维。
>
> > [!NOTE]
> > Vite 构建时会自动处理这些情况，将其转换成统一的`ES6`格式。
> >
> > 并且识别你未导入使用的对象，并且自动删除不用的导出对象，再运行导入的时候 最终浏览器 访问到的 `bundle.js` 已经将时候不用的 `export{default as name} from './xxx'` 删除导出的无用 导出对象 不会再去请求 无用对象的引入代码 减少了大量的请求 最终性能翻了 >10 倍。减轻了很大的服务器压力。
