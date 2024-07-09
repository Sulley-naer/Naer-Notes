# [Mock](http://mockjs.com/) | [文档](http://mockjs.com/0.1/#Mock)

> [!TIP]
> Mock 是一个模拟数据生成器，可以帮助前端开发人员快速生成模拟数据，避免开发过程中因缺乏真实数据而造成的假死。帮助前端开发人员在没有后端接口实现功能性测试。

## 安装

```bash
npm install mockjs -dev
# vite 需额外安装
npm install vite-plugin-mock -dev
```

[x] 快速上手

```js
import Mock from "mockjs";

const data = Mock.mock({
  "list|1-10": [
    {
      "id|+1": 1,
      name: "@cname",
      "age|1-100": 1,
      email: "@email",
    },
  ],
});

console.log(data);
//转换格式
console.log(JSON.stringify(data, null, 4));
```

-RESULT-

```json
{
  "list": [
    {
      "id": 1,
      "name": "彭伟",
      "age": 64,
      "email": "p.xszh@gnbcsb.sh"
    },
    {
      "id": 2,
      "name": "余磊",
      "age": 85,
      "email": "e.mgjlbicq@jwsbkemgx.org.cn"
    },
    {
      "id": 3,
      "name": "赖娜",
      "age": 37,
      "email": "f.niuok@szw.yu"
    },
    ...
  ]
}
```

## Vite 配置使用

Vita 项目中，使用 `vite-plugin-mock` 插件，需手动配置

[x]快速上手

```javascript
// vite.config.js
import { viteMockServe } from "vite-plugin-mock";

plugins: [viteMockServe()];
```

> 在 根目录下创建 mock 文件夹，再创建 `user.js` 或者其他 mock 文件，文件名必须以 `.js` 结尾，主配置尽量为 index.js

```javascript
//格式必须为导出数组
module.exports = [
  {
    method: "post",
    url: "/api/user",
    response: ({ body }) => {
      return {
        //返回参数模拟后端数据格式
        code: 200,
        /* status: 200, */
        data: ["name", "age", "email"],
        msg: "success",
      };
    },
  },
];
```

调用测试

```javascript
//再配置了Vite后 ，调用接口
/* main.js */

fetch("/api/user", {
  method: "POST",
}).then((res) => {
  console.log(res);
});
```

利用 mock 生成数据，并让接口返回

```javascript
import Mock from "mockjs";

const list = Mock.mock({
  "date|100": [
    {
      name: "@cname",
      "id|+1": 1,
      time: "@time",
    },
  ],
});

console.log(list);
//开放接口
module.exports = [
  {
    method: "post",
    url: "/api/user",
    response: ({ body }) => {
      return {
        code: 200,
        status: 200,
        data: list,
        msg: "success",
      };
    },
  },
];
```

## 可配置项

```javascript
// Vite.config.js

plugins: [
  viteMockServe({
    // 配置项
    mockPath: "mock", // mock 文件夹路径
    localEnabled: true, // 是否开启本地模式
    prodEnabled: true, // 是否开启生产模式
    injectCode: `
      // 此处可增加自定义的代码，如：
      // const mock = require('./mock/index.js')
      // mock.setup()
    `, // 注入代码，可用于自定义 mock 数据
  }),
];
```

## 相关链接

- [Vite-config](npmjs.com/package/vite-plugin-mock)
- [文档](http://mockjs.com/0.1/#Mock)
