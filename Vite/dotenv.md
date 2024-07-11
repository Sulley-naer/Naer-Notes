# dotenv [配置](https://cn.vitejs.dev/guide/env-and-mode.html)

> [!TIP]
> 使用 dotenv 可以将环境变量导入到项目中，可以将敏感信息如 API 密钥、数据库连接等隐藏在 `.env` 文件中，而不必暴露在代码中。

防止项目上线后忘记修改 api 等问题，只能根据环境模式切换不同环境的配置。

## 快速使用 [TS 版](./VIteTS.md#env)

```bash
# 安装 dotenv 可不用安装，因为 vite 已经内置
npm install dotenv --save
```

在项目根目录下创建 `.env` 文件，添加环境变量。 利用 node 环境下的 `process.env` 对象可以获取环境变量。

```bash
# .env
PORT=3000
API_KEY=your_api_key
```

在 `vite.config.js` 文件中，导入 `dotenv` 并使用 `config` 对象导入 `.env` 文件。

使用 `process.env` 对象获取环境变量。

```javascript
// vite.config.js
import { defineConfig, loadEnv } from "vite";
import dotenv from "dotenv";

import devconfig from "./vite.dev.config";
import prodconfig from "./vite.prod.config";

const envResolver = {
  build: () => Object.assign({}, prodconfig),
  serve: () => Object.assign({}, devconfig),
  //es6语法 合并对象
  build: () => ({ ...prodconfig }),
  serve: () => ({ ...devconfig }),
};

export default defineConfig(({ command, mode }) => {
  console.log(process.env);
  //使用vite 内置方法
  //process.cwd() 获取当前项目根目录 node的api
  // 参数1 当前运行环境 参数2 项目根目录 参数3 环境变量前缀
  const env = loadEnv(mode, process.cwd(), "");
  console.log(env);
  console.log(env.PORT); // 3000 名称必须对应
  //自定义env文件前缀名称
  envPrefix: "VITE_",
  //返回当前环境配置下的env文件 command：development/production mode： build/serve
  //对应不同环境的env文件 command：development.env/production.env mode：build.env/serve.env
  return envResolver[command]();
});
```

> [!TIP]
> loadEnv 方法 第一个参数 mode 对应环境变量前缀，我们可通过修改环境来使它加载不同环境下的 env 文件

Vite 获取当前 mode 和 command 环境变量

```javascript
export default defineConfig(({ command, mode }) => {
  console.log(command, mode);
  return envResolver[command]();
});
```

修改启动环境模式

```bash
# 开发环境
npm run dev

# 生产环境
npm run build


# 或者

# 开发环境
vite --mode development

# 生产环境
vite --mode production

# package 脚本里面修改修改默认启动模式
```

## 客户端获取 环境变量 数据

> [!IMPORTANT]
> 通常情况下，我们需要在客户端获取环境变量数据，如 API 密钥、数据库连接等。并且自动随着 环境模式 切换不同的数据。

Main.js

```javascript
console.log(import.meta.env);
```

注意 vite 内置的环境变量 必须以 VITE\_ 开头 vite 出于安全考虑 会拦截注入的环境变量

```env
VITE_API_KEY=your_api_key
```

如果不想使用 VITE\_ 开头的环境变量 可以在 vite.config.js 文件中配置

```javascript
export default defineConfig({
  envPrefix: "MY_",
  //...
});
```

这样修改了之后,VITE\_ 前缀的就无法获取到环境变量了
