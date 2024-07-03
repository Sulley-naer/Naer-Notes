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
const GetTotal = () => {
  const RelativePath = "./src";
  //拿去文件夹对象 记得用异步方法 防止加载过长
  const fileList = fs.readdirSync(path.resolve(__dirname, RelativePath));
  const diffResult = difffile(fileList, RelativePath);

  const resolveAliases = {};

  diffResult.dir.forEach((dirname) => {
    const key = `@${dirname}`;
    const asbPath = path.resolve(__dirname, RelativePath + "/" + dirname);
    resolveAliases[key] = asbPath;
  });

  return resolveAliases;
};

const keyword = ["API", "component"];

module.exports = () => {
  return {
    config(config, env) {
      const resolveAliasesObj = GetTotal();
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

记得在 `vite.config.js` 中引入插件

```javascript
const Aliases = require("./plugins/Aliases");

module.exports = {
  plugins: [Aliases()],
};
```
