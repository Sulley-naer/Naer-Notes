# 认识axios
1. axios是一个基于promise的HTTP库，可以用在浏览器和node.js中
2. axios的主要特点：
    - 从浏览器中创建XMLHttpRequest
    - 从node.js创建http请求
    - 支持Promise API
    - 拦截请求和响应
    - 转换请求和响应数据
    - 取消请求
    - 自动转换JSON数据
    - 客户端支持防止CSRF
3. 安装axios
    - 使用npm
    ```bash
    npm install axios
    ```
    - 使用bower
    ```bash
    bower install axios
    ```
    - 使用CDN
    ```html
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    ```
# 支持的`api`
## 1. axios API
    - axios(config)
    - axios.request(config)
    - axios.get(url[, config])
    - axios.delete(url[, config])
    - axios.head(url[, config])
    - axios.options(url[, config])
    - axios.post(url[, data[, config]])
    - axios.put(url[, data[, config]])
    - axios.patch(url[, data[, config]])
# 使用axios
1. 发送一个GET请求
```javascript
axios.get('/user?ID=12345')
  .then(function (response) {
    console.log(response);
    //打印返回的数据
  })
  .catch(function (error) {
    console.log(error);
    //打印错误信息
  });
  .finally(function () {
    console.log('请求完成');
  });
```

2. 发送一个POST请求
```javascript
axios.post('/user', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
  .finally(function () {
    console.log('请求完成');
  });
```

3. Put请求
```javascript
axios.put('/user/12345', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  }, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
```

4. 执行多个并发请求
```javascript
function getUserAccount() {
  return axios.get('/user/12345');
}

function getUserPermissions() {
  return axios.post('/user/12345/permissions', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  });
}

axios.all([getUserAccount(), getUserPermissions()])
  .then(axios.spread(function (acct, perms) {
    // 两个请求现在都执行完成
    console.log(acct);
    console.log(perms);
  }))
  .catch(function (error) {
    console.log(error);
  })
  .finally(function () {
    console.log('请求完成');
  });
```
# 拦截器
1. 你可以为请求和响应添加拦截器
2. 添加请求拦截器
```javascript
axios.interceptors.request.use(function (config) {
  // 在发送请求之前做些什么
  return config;
}, function (error) {
  // 对请求错误做些什么
  return Promise.reject(error);
});
```
# 取消请求
1. 你可以通过向cancel token构造函数传递一个executor函数来创建一个cancel token
2. 你可以通过调用cancel函数来取消请求
```javascript
var CancelToken = axios.CancelToken;
var source = CancelToken.source();

axios.get('/user/12345', {
  cancel
})
.then(function (response) {
  console.log(response);
})
.catch(function (error) {
  if (axios.isCancel(error)) {
    console.log('Request canceled', error.message);
  } else {
    // 处理错误
  }
});

// 取消请求（message 参数是可选的）
source.cancel('Operation canceled by the user.');
```
# 自定义请求头
1. 你可以通过设置`headers`属性来自定义请求头
```javascript
axios.get('/user', {
    headers: {
      'Authorization': 'Bearer yourTokenHere',
      'Content-Type': 'application/json'
    }
});

asiox.post('/user', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  }, {
    headers: {
      'Content-Type': 'application/json'
    }
  });
```

# 超时
1. 你可以通过设置`timeout`属性来设置请求超时时间
```javascript
axios.get('/user', {
  timeout: 1000
})
.then(function (response) {
  console.log(response);
})
.catch(function (error) {
  console.log(error);
});
```

# 自定义实例
1. 你可以通过创建一个axios实例来自定义实例的默认值
```javascript
var instance = axios.create({
  baseURL: 'https://some-domain.com/api/',
  timeout: 1000,
  headers: {'X-Custom-Header': 'foobar'}
});

instance.get('/user/12345')
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
```

# 全局默认值
1. 你可以通过设置全局默认值来自定义实例的默认值
```javascript
axios.defaults.baseURL = 'https://api.example.com';
axios.defaults.headers.common['Authorization'] = AUTH_TOKEN;
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
```

# 错误处理
1. 你可以通过设置`validateStatus`属性来自定义HTTP状态码的合法性
```javascript
axios.get('/user/12345', {
  validateStatus: function (status) {
    return status < 500; // 状态码小于500时均为成功
  }
})
.then(function (response) {
  console.log(response);
})
.catch(function (error) {
  console.log(error);
});
```

# 配置默认值
1. 你可以通过设置`defaults`属性来配置默认值
```javascript
axios.defaults.baseURL = 'https://api.example.com';
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
```