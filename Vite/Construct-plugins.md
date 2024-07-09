# 手写 Aliases 插件 for Vite

> [!TIP]
> 入学 **module** knowledge，学习 Vite 插件开发。

## module 规范化语法

插件 应根据 不同环境 进行 不同配置， 还应预留可配置项，以便用户自定义。

```javascript
// Node 环境 优先使用commonjs规范
module.exports = () => {
  return {
    // 获取当前环境变量前缀，和envPrefix配合使用
    // config 这个对象 是 Vite 的配置对象，可以进行修改
    config(config, env) {
      console.log(arguments);
      return {
        envPrefix: env ? env.envPrefix : "",
        //配置环境的别名配置
        resolve: {
          aliases: {},
        },
      };
    },
  };
};
```

## 编写 Aliases 插件

```javascript
//fs 用于文件处理
const fs = require("fs");
//path 用于路径处理
const path = require("path");

/* 注意函数逻辑 这个函数结构 处理非常完美
 * 文件数组 相对路径
 * */

const difffile = (DirFileArr = [], BasePath) => {
  const result = {
    dir: [],
    files: [],
  };
  // 遍历所有文件 根据文件相对路径+名字 判断是否是 文件？文件夹
  DirFileArr.forEach((dirname) => {
    // 绝对 + 相对 + / + 文件名
    //fs读取文件用记得同步，不然后面操作会报错找不到 x `stat` | ✓ `statSync`
    const currentFileStat = fs.statSync(
      path.resolve(__dirname, BasePath + "/", dirname)
    );
    currentFileStat.isDirectory()
      ? result.dir.push(dirname)
      : result.files.push(dirname);
  });
  return result;
};

//获取路径 文件数组 再进行文件类型判断
const GetTotal = (keyword) => {
  const RelativePath = "./src";
  //拿取文件夹对象 记得用异步方法 防止加载过长
  const fileList = fs.readdirSync(path.resolve(__dirname, RelativePath));
  const diffResult = difffile(fileList, RelativePath);

  const resolveAliases = {};

  diffResult.dir.forEach((dirname) => {
    const key = `${keyword}${dirname}`;
    const asbPath = path.resolve(__dirname, RelativePath + "/" + dirname);
    resolveAliases[key] = asbPath;
  });

  return resolveAliases;
};

const keyword = ["API", "component"];
//定义前缀 但是这样写无法修改配置项
module.exports = () => {
  keyword: "@";
//可配置版，注意的语法！！！ 对象 设置 键值对 再 = {}  用于配置传入对象后 默认配置项 修改配置项 JS 形参 语法 options 也能实现但是无法让编辑器识别，接受所有参数 并且默认参数还不能直接定义
module.exports = ({ keyword = "@" } = {}) => {
  console.log(keyword);
  return {
    // Vita api 钩子函数 修改配置项
    config(config, env) {
      const resolveAliasesObj = GetTotal(keyword);
      return {
        envPrefix: env ? env.envPrefix : "",
        resolve: {
          alias: resolveAliasesObj,
        },
      };
    },
  };
};
```

记得在 `vite.config.js` 中引入插件，只能用在 js 导入插件时候的路径替换，dom 里面无效 如需 dom 使用 请使用 `createHtml` 方法

```javascript
const Aliases = require("./plugins/Aliases");

module.exports = {
  plugins: [Aliases(), Aliases({ keyword: "API" })],
};
```

### 相关链接

- [Vite 插件开发指南](https://cn.vitejs.dev/guide/api-plugin.html)
- [Vite 插件开发模板](https://github.com/vitejs/vite/tree/main/packages/create-vite/template-vue-ts)
- [Vite 唯有钩子](https://cn.vitejs.dev/guide/api-plugin#vite-specific-hooks)

## 手写 EJS 嵌入式 Dom 插件

> [!TIP]
> EJS 类似 `{{ name }}` 用于模板替换 在 config 中预配置，便于环境变量配置

```javascript
//plugin.js

/* option 参数是插件配置项，不传入也不会报错 */
module.exports = (options) => {
  return {
    //无指定加载顺序 Vite 根据配置文件执行
    /*transformIndexHtml: (html, value) => {
      console.log(html);
      return html.replaceAll(/<%= title %>/g, options.title);
    },*/
    // 指定为pre 保证在其他插件之前执行
    transformIndexHtml: {
      enforce: "pre",
      transform: (html, ctx) => {
        console.log(html);
        //利用 正则/g 实现全局替换
        return html.replace(/<%= title %>/g, options.title);
        //利用 replaceAll 实现全局替换 新语法
        return html.replaceAll(/<%= title %>, options.title);
      },
    },
  };
};
```

```javascript
import { createHtml } from "./plugins/EJS";
//vite.config.js
  plugins: [
    createHtml({
      title: "我是标题",
    }),
  ],
```

### 有关链接

- [插件顺序](https://cn.vitejs.dev/guide/api-plugin.html#plugin-ordering)
- [Dom 钩子](https://cn.vitejs.dev/guide/api-plugin.html#transformindexhtml)
- [正则](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Regular_expressions)
