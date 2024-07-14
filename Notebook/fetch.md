# fetch [Promise](./Promise.md) [文档](https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API/Using_Fetch)

> [!NOTE]
> fetch API 是一个用于从服务器获取资源的 API，它是基于 Promise 的 API。 它提供了一种更简单、更强大的方式来处理 HTTP 请求和响应。es6 中引入的 fetch API 使得前端开发者可以更方便地从服务器获取资源，并对其进行处理。

- [fetch Promise 文档](#fetch-promise-文档)
  - [基本用法](#基本用法)
  - [api](#api)

## 基本用法

fetch() 方法用于从服务器获取资源，并返回一个 Promise 对象。该方法接受一个 URL 字符串作为参数，并返回一个 Promise 对象。该 Promise 对象会在请求成功时 resolve，并返回一个 Response 对象。

```javascript
fetch("/test", {
  method: "GET",
  headers: {
    "Content-Type": "application/json",
  },
  //发送数据，类型请与headers中Content-Type匹配
  body: JSON.stringify({
    name: "John",
    age: 30,
  }),
}).then((response) => {
  /* res 就是express里面的 res 参数 是请求返回时的对象 */
  //返回的是Response对象，需要用then()转换成json格式，再用then()获取response对象
  p.json().then((data) => {
    console.log(data);
  });
});
```

## api

- `fetch(url, options)`

  - `url`：必选参数，请求的 URL 地址。
  - `options`：可选参数，配置请求选项。
    - `method`：请求方法，如 GET、POST、PUT、DELETE 等。
    - `headers`：请求头，是一个对象，用于设置 HTTP 请求的头部信息，比如设置 Content-Type。
    - `body`：请求体，用于发送数据，比如 POST 请求。
    - `mode`：请求模式，用于指定请求的模式，比如 cors、no-cors、same-origin。
    - `credentials`：请求是否携带凭据，比如 cookies 和 HTTP 认证信息。
    - `cache`：请求缓存，用于指定请求的缓存机制，比如 default、no-cache、reload、force-cache、only-if-cached。
    - `redirect`：请求重定向，用于指定请求是否自动重定向，比如 follow、error、manual。
    - `referrer`：请求的来源地址，用于指定请求的来源地址。
    - `integrity`：请求的完整性，用于指定请求的完整性。
    - `keepalive`：请求是否保持连接，用于指定请求是否保持连接。
    - `signal`：请求的信号，用于指定请求的信号。

- `Response` 对象

  - `Response.url`：响应的 URL 地址。
  - `Response.status`：响应的 HTTP 状态码。
  - `Response.statusText`：响应的 HTTP 状态信息。
  - `Response.headers`：响应的 HTTP 头部信息，是一个 Headers 对象。
  - `Response.ok`：响应是否成功，如果状态码在 200-299 之间，则为 true，否则为 false。
  - `Response.redirected`：响应是否重定向，如果响应是重定向，则为 true，否则为 false。
  - `Response.type`：响应的类型，比如 basic、cors、error、opaque、opaqueredirect。
  - `Response.body`：响应的 body，是一个 ReadableStream 对象。
  - `Response.bodyUsed`：响应的 body 是否被读取过，如果读取过，则为 true，否则为 false。
  - `Response.arrayBuffer()`：返回一个 Promise 对象，该对象会在请求成功时 resolve，并返回一个 ArrayBuffer 对象。
  - `Response.blob()`：返回一个 Promise 对象，该对象会在请求成功时 resolve，并返回一个 Blob 对象。
  - `Response.formData()`：返回一个 Promise 对象，该对象会在请求成功时 resolve，并返回一个 FormData 对象。
  - `Response.json()`：返回一个 Promise 对象，该对象会在请求成功时 resolve，并返回一个 JSON 对象。
  - `Response.text()`：返回一个 Promise 对象，该对象会在请求成功时 resolve，并返回一个文本字符串。

- `Headers` 对象

  - `Headers.append(name, value)`：添加一个 HTTP 头部信息。
  - `Headers.delete(name)`：删除一个 HTTP 头部信息。
  - `Headers.get(name)`：获取一个 HTTP 头部信息的值。
  - `Headers.has(name)`：判断是否存在一个 HTTP 头部信息。
  - `Headers.set(name, value)`：设置一个 HTTP 头部信息的值。
  - `Headers.forEach(callback, thisArg)`：遍历所有 HTTP 头部信息。

- `Request` 对象

  - `Request.url`：请求的 URL 地址。
  - `Request.method`：请求的方法，比如 GET、POST、PUT、DELETE 等。
  - `Request.headers`：请求的头部信息，是一个 Headers 对象。
  - `Request.body`：请求的 body，是一个 ReadableStream 对象。
  - `Request.mode`：请求的模式，比如 cors、no-cors、same-origin。
  - `Request.credentials`：请求是否携带凭据，比如 cookies 和 HTTP 认证信息。
  - `Request.cache`：请求的缓存机制，比如 default、no-cache、reload、force-cache、only-if-cached。
  - `Request.redirect`：请求的重定向，比如 follow、error、manual。
  - `Request.referrer`：请求的来源地址。
  - `Request.integrity`：请求的完整性。
  - `Request.keepalive`：请求是否保持连接。
  - `Request.signal`：请求的信号。

- `fetch()` 方法返回的 Promise 对象

  - `Promise.then(onFulfilled, onRejected)`：Promise 对象的 then() 方法，用于指定 Promise 对象的状态改变时执行的回调函数。
  - `Promise.catch(onRejected)`：Promise 对象的 catch() 方法，用于指定 Promise 对象的状态为 rejected 时执行的回调函数。
  - `Promise.finally(onFinally)`：Promise 对象的 finally() 方法，用于指定 Promise 对象的状态改变时执行的回调函数，无论 Promise 对象的状态如何都会执行。

- `fetch()` 方法的错误处理

  - `fetch()` 方法返回的 Promise 对象，如果请求失败，会抛出一个错误。
  - 可以使用 `try...catch` 语句捕获错误。
  - 也可以使用 `Promise.catch()` 方法捕获错误。

- `fetch()` 方法的跨域请求

  - 默认情况下，fetch() 方法不允许跨域请求。
  - 可以使用 CORS 协议或者 JSONP 协议来实现跨域请求。
  - CORS 协议：使用自定义的 HTTP 头部信息来实现跨域请求。
  - JSONP 协议：使用 `<script>` 标签来实现跨域请求。
