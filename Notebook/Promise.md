# Promise

> [!NOTE]
> Promise 是异步编程的一种解决方案，它代表了一个异步操作的最终完成或失败及其结果值。 用于解决回调地狱的问题。

回调地狱：原版异步请求必须再写请求的时候，在后面的回调函数中再去发送后续的请求，这样的请求嵌套，代码阅读性太差

举例回调地狱

```javascript
// 模拟回调地狱的例子

// es6 发送请求 promise 返回形式
fetch("url1").then((data) => {
  console.log(data);
});

function request(url, callback) {
  setTimeout(() => {
    const response = `Response from ${url}`;
    callback(response);
  }, 1000);
}

request("url1", (response1) => {
  console.log(response1);
  //判断第一个返回值，再去进行其他请求操作，造成回调地狱
  if (response1.includes("success")) {
    request("url2", (response2) => {});
  } else {
    request("url3", (response3) => {});
  }
});
```

## Promise 基本用法

Promise 是异步编程的一种解决方案，它代表了一个异步操作的最终完成或失败及其结果值。

Promise 有三种状态：

- Pending（等待）：初始状态，既没有完成也没有失败。
- Fulfilled（已完成）：操作成功完成。
- Rejected（已失败）：操作失败。

```javascript
// 创建一个 Promise 对象
const p = new Promise((resolve, reject) => {

  这里面写异步请求，根据返回值调用 resolve 或 reject 方法

  当然你可以调用另一个promise对象，判断它的返回值再进行请求操作

  这样写的好处是，可以将多个异步操作串联起来，避免回调地狱

  // 异步操作成功时调用 resolve 方法，并将结果作为参数传递
  resolve(result);
  // 异步操作失败时调用 reject 方法，并将错误信息作为参数传递
  reject(error);
});

// 链式调用
p.then((result) => {
  // 成功时调用的回调函数
  console.log(result);
}).catch((error) => {
  // 失败时调用的回调函数
  console.log(error);
});
```

## 高级用法

1. Promise.all()

Promise.all() 方法用于将多个 Promise 实例包装成一个新的 Promise 实例。

```javascript
const p1 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("p1");
  }, 1000);
});

const p2 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("p2");
  }, 2000);
});

const p3 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("p3");
  }, 3000);
});

Promise.all([p1, p2, p3])
  .then((results) => {
    console.log(results);
  })
  .catch((error) => {
    console.log(error);
  });

//三个请求有一个错误就会，变为catch方法
```

2. Promise.race()

Promise.race() 方法用于将多个 Promise 实例包装成一个新的 Promise 实例，只要有一个 Promise 实例率先完成，就返回那个 Promise 实例的结果。

```javascript
const p1 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("p1");
  }, 1000);
});

const p2 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("p2");
  }, 2000);
});

const p3 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("p3");
  }, 3000);
});

Promise.race([p1, p2, p3])
  .then((result) => {
    console.log(result);
  })
  .catch((error) => {
    console.log(error);
  });

//返回的结果是第一个，第一个最先完成，其余的Promise实例都将被忽略
//返回错误也是谁先完成，谁的错误就返回
```

3. Promise.resolve()

Promise.resolve() 方法用于将现有对象转为 Promise 对象。

```javascript
const p = Promise.resolve("Hello");

p.then((result) => {
  console.log(result);
});
//相当于直接写死了成功返回，省去了创建promise实例的过程
//常用于功能性接口测试，在没有接口之前用静态数据测试
```

4. Promise.reject()

Promise.reject() 方法用于生成一个失败的 Promise 实例。

```javascript
const p = Promise.reject(new Error("Error"));

p.catch((error) => {
  console.log(error);
});
//与上面同理，直接写请求错误
//常用于功能性接口测试，预览在接口错误下的处理流程
```

5. Promise.prototype.finally()

Promise.prototype.finally() 方法用于指定不管 Promise 对象最后状态如何，都会执行的操作。

```javascript
const p = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("Hello");
  }, 1000);
});

p.then((result) => {
  console.log(result);
})
  .catch((error) => {
    console.log(error);
  })
  .finally(() => {
    console.log("finally");
  });
//finally方法无论promise成功还是失败都会执行
```

## 参考

- [Promise - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise)
- [Promises - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Using_promises)
- [Promises/A+](https://promisesaplus.com/)
- [Promises/A+中文版](https://www.promisejs.org/zh-cn/)
