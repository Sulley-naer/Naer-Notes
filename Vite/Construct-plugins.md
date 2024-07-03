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
    config(config, env) {
      console.log(arguments);
      return {
        envPrefix: env ? env.envPrefix : "",
        resolve: {},
      };
    },
  };
};
```
