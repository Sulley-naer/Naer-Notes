# [vite-ts](https://cn.vitejs.dev/guide/features#typescript)

> [!TIP]
> Vite 天生自持 ts 可直接创建 ts 文件
>
> 但是 ts 的报错它编译时不会处理，可通过配置启动
>
> `tsc --noEmit && vite build` 逻辑是前面的未通过就不会执行后面的启动

## 额外插件

### [checker](https://github.com/fi3ework/vite-plugin-checker)

> [!IMPORTANT]
> TS 的类型检查 在编辑器中的错误提示 浏览器运行时却是正常的 防止有人忽略错误
>
> 每当编辑器有警告时，会在控制台输出警告信息，但不会阻止代码运行。
>
> Checker 可以将控制台中的错误提示 以弹窗的形式提示给用户，并阻止代码运行。

```bash
npm i -D vite-plugin-checker
# 插件需要依赖TS所以必须安装
npm i -D typescript @types/node
```

配置中使用 [checker](https://github.com/fi3ework/vite-plugin-checker)

```js
// vite.config.js
import checker from "vite-plugin-checker";

export default {
  plugins: [
    checker({
      typescript: true, // enable type-checking with TypeScript
    }),
  ],
};
```

随后在需创建 `tsconfig.json` ：`tsc --init` [官方 API](https://www.typescriptlang.org/tsconfig)

```json
{
  "compilerOptions": {
    //设置引入模块为node类型，防止ts找不到模块
    "moduleResolution": "node",
    //关闭node_modules检查
    "SkipLibCheck": true,
    //指定Es版本
    "module": "esnext"
  }
}
```

## env

需配置 `env.d.ts` 文件 `vite-env.d.ts` vite 会自动导入

```typescript
// 三斜杠指令 让ts读取文件使用 自动导入这些类型
/// <reference types="vite/client" />
/// <reference types="vite-plugin-checker/client" />

//配置提示变量
declare const __DEV__: boolean;
declare const __PROD__: boolean;
// 或者
interface ImportMeta {
  env: {
    [key: string]: string | boolean;
  };
}
// 或者
interface importMetaEnv {
  VITE_APP_TITLE: string;
  VITE_APP_ENV: "development" | "production" | "test";
  VITE_APP_DEBUG_MODE: boolean;
}
// 或者
interface window {
  __USE_MOCK__: boolean;
}
```

## [dotenv](./dotenv.md) | [config](./config.md)
