# Mock 手写 并学习 configureServer 配置服务端

> configureServer 是 Vite 提供的配置服务端的钩子函数，可以用来自定义服务端的行为，响应客户端请求的处理并且配置

## configureServer [文档](https://cn.vitejs.dev/guide/api-plugin.html#configureserver)

1. req 请求对象 --> 客户端请求 包含了请求信息 URL、Header、Body cookie
2. res 响应对象 --> 客户端响应 包含了响应信息 Header、Body、Status
3. next 回调函数 --> 调用下一个中间件 或者 结束请求

```javascript
configureServer(server) {
server.middlewares.use((req, res, next) => {
// 自定义请求处理...
res.setHeader('Content-Type', 'application/json') // 设置响应头
res.end(JSON.stringify({ success: true })) // 响应数据
next() /* 调用下一个中间件 */
})
},
```

## 编写前准备工作

配置插件让 vite 加载

```javascript
// vite.config.js
import myPlugin from "./myPlugin";

plugins: [myPlugin()];
```

- 查看所有请求信息 了解 node 端请求处理流程
- 可进行判断请求地址，是否为对应配置，再根据请求地址进行相应的处理

```javascript
module.exports = (options) => {
  return {
    configureServer(server) {
      server.middlewares.use((req, res, next) => {
        console.log(req.url, req.url);
        if (req.url === "/api/login") {
          res.end("login success"); //返回数据均为异步操作
        }
        next();
      });
    },
  };
};
```

## 编写完成代码，自行查看代码逻辑

```javascript
const fs = require("fs");
const path = require("path");

const createDate = () => {
  //读取目录
  let children = fs.readdirSync("mock");
  let date = [];
  //便利数组，把数组中每一个对象添加进，date中
  children.forEach((item) => {
    //不要用__dirname 这是个插件，node环境里运行，对于插件不能用插件目录当初根目录的，cwd相比更加准确
    //__dirname 获取的是当前文件路径!!! cwd获取的是终端路径
    require(path.resolve(process.cwd(), "mock", item)).forEach((item) => {
      date.push(item);
    });
    // console.log(date);
  });
  return date;
};

const GetDirList = (date) => {
  let matchList = [];
  let dir = fs.statSync("mock");
  //判断是否为文件夹,防止意外错误
  if (dir.isDirectory()) {
    const frachlist = date;
    frachlist.forEach((item, index) => {
      matchList.push(item.url);
    });
  }
  return matchList;
};

module.exports = (options) => {
  //用于拿取mock文件夹下声明的接口
  const date = createDate();
  //用于获取全部的接口地址,并进行判断是否是接口地址,减轻服务器每一次都需要进行判断的资源,只用在启动的时候获取一次
  let src = GetDirList(date);
  return {
    configureServer(server) {
      server.middlewares.use((req, res, next) => {
        //没有这一层拦截请求地址是否在所有接口里面,会导致每一次请求都会去便利每一个接口路径,导致巨大的资源浪费!
        if (src.includes(req.url)) {
          //必须通过这个方式判断是否当前路径在date数据中,并且把对于的数据给保存下来
          //不能通过foreach进行判断是否在 date 数据中,循环遍历可能导致重复下去发送,而请求只能返回一次,结果导致node会直接退出进程
          let matchedItem = date.find((item) => item.url === req.url);
          if (matchedItem) {
            console.log(matchedItem);
            const response = matchedItem.response(req);
            res.setHeader("Content-Type", "application/json");
            //返回对应接口数据
            res.end(JSON.stringify(response));
          } else {
            console.log("未找到匹配的项");
            res.setHeader("Content-Type", "application/json");
            res.end(JSON.stringify({ error: "未找到匹配的项" }));
          }
        } else {
          next();
        }
      });
    },
  };
};
```
