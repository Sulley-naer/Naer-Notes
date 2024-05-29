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

# 脚手架
```javascript
axios.post('https://localhost:44323/WebService1.asmx/login', {
      username: username.value,
      password: password.value
    }, {
        headers: {
        // 如果服务端要求特定的内容类型，这里设置为SOAP或XML，但大多数ASMX服务对POST请求期望的是'application/x-www-form-urlencoded'
        'Content-Type': 'application/x-www-form-urlencoded',
        // 如果需要指定SOAPAction，根据你的服务端配置来设定，通常格式为"Namespace/MethodName"
        'SOAPAction': 'http://tempuri.org/WebService1/login', // 请根据实际命名空间和方法名替换
    },
    })
    .then(response => {
    // 解析 XML 响应
    const parser = new DOMParser();
    const xmlDoc = parser.parseFromString(response.data, "text/xml");
    console.log(xmlDoc); // 查看整个 XML 文档对象
    const stringNode = xmlDoc.getElementsByTagName("string")[0];
    console.log(stringNode); // 查看 string 节点
    if (stringNode) {
      const value = stringNode.textContent.trim();
      console.log("结果：", value);
      alert(value)
      if(value == '登录成功'){
        //保存cookie
        document.cookie = "username=" + username.value + "password=" + password.value;
        //设置1天过期
        var date = new Date();
        date.setDate(date.getDate() + 1);
        document.cookie = "expires=" + date.toGMTString();

      }
    } else {
      console.error("XML 响应中找不到 string 节点");
    }
    })
    .catch(error => {
      console.error("错误", error);
    });
```


# asmx 接口需配置
```javascript
{
        headers: {
        // 如果服务端要求特定的内容类型，这里设置为SOAP或XML，但大多数ASMX服务对POST请求期望的是'application/x-www-form-urlencoded'
        'Content-Type': 'application/x-www-form-urlencoded',
        // 如果需要指定SOAPAction，根据你的服务端配置来设定，通常格式为"Namespace/MethodName"
        'SOAPAction': 'http://tempuri.org/WebService1/login', // 请根据实际命名空间和方法名替换
    },
}
```
# header 参数百科
```javascript
{
        headers: {
          //内容类型
          'Content-Type': 'application/x-www-form-urlencoded',
          //默认 application/json 表示发送的是JSON数据
          //application/x-www-form-urlencoded 用于表单数据
          //text/xml 或 application/soap+xml 用于SOAP请求
          `Accept`:`application/json`
          //指定客户端能够接收的内容类型
          //application/json 表示客户端希望接收JSON数据
          //application/xml 表示客户端希望接收XML数据
          //text/plain 表示客户端希望接收纯文本格式
          //text/html 表示客户端希望接收HTML格式
          //application/javascript 表示客户端希望接收JSONP格式
          //image/png 表示客户端希望接收PNG图片格式
          `Authorization`: `Bearer ${token}`
          //用于验证当前请求的用户身份
          //Bearer token 表示携带的是JWT令牌
          //Basic token 表示携带的是Basic认证令牌
          //Digest token 表示携带的是Digest认证令牌
          //OAuth token 表示携带的是OAuth认证令牌
          //NTLM token 表示携带的是NTLM认证令牌
          `User-Agent`: `Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3`
          //用于指定客户端的类型
          `Cookie`: `name=value; name2=value2`
          //用于在请求中携带Cookie信息
          `Cache-Control`: `no-cache`
          //用于指定请求和响应的缓存机制
          //no-cache 表示不使用缓存
          //no-store 表示不使用缓存，也不存储缓存
          //max-age=60 表示缓存60秒
          //max-stale=60 表示即使缓存过期，仍然接收
          //min-fresh=60 表示至少缓存60秒
          //only-if-cached 表示只接收缓存
          `Connection`: `keep-alive`
          //用于指定连接是否保持
          //keep-alive 表示连接保持
          //close 表示连接关闭
          `Accept-Encoding`: `gzip, deflate`
          //用于指定客户端能够接收的内容编码
          //gzip 表示客户端能够接收GZIP压缩格式
          //deflate 表示客户端能够接收Deflate压缩格式
          //br 表示客户端能够接收Brotli压缩格式
          `Accept-Language`: `zh-CN,zh;q=0.9,en;q=0.8`
          //用于指定客户端能够接收的自然语言
          `Host`: `www.example.com`
          //用于指定请求的服务器域名和端口号
          `Referer`: `https://www.example.com`
          //告诉服务器请求的原始资源的URI
          `Content-Length`: `348`
          //用于指定请求体的长度
          `Date`: `Tue, 15 Nov 1994 08:12:31 GMT`
          //用于指定请求的日期和时间
          `Origin`: `https://www.example.com`
          //在CORS请求中使用，表示请求的源（协议+域名+端口），用于跨域资源分享的检查。
          `X-Requested-With`: `XMLHttpRequest`
          //表示请求是否是Ajax请求
          //XMLHttpRequest 表示请求是Ajax请求 Fetch 表示请求是Fetch请求 None 表示请求不是Ajax请求
          `Pragma`: `no-cache`
          //类似于Cache-Control，用于指定请求和响应的缓存机制 适用于HTTP/1.0
          `Upgrade-Insecure-Requests`: `1`
          //表示客户端是否支持HTTPS
          //1 表示支持HTTPS 0 表示不支持HTTPS
          `Content-Encoding`: `gzip`
          //用于指定请求体的编码
          //gzip 表示请求体使用GZIP压缩
          //deflate 表示请求体使用Deflate压缩
          //br 表示请求体使用Brotli压缩
          `Content-Disposition`: `inline`; `filename`="document.pdf"
          //指示内容的展示方式或作为附件下载。
          //inline 表示内容内联展示 attachment 表示内容作为附件下载 filename 表示文件名
          `Content-Security-Policy`: `default-src 'self'`
          //用于指定请求体的安全策略
          //default-src 'self' 表示默认策略是只允许加载同源资源
          //script-src 'self' 表示只允许加载同源脚本
          //style-src 'self' 表示只允许加载同源样式
          `If-None-Match`: `W/"67ab43-4e1cb"`
          //用于指定请求的标识符
          //W/"67ab43-4e1cb" 表示资源的标识符
          `If-Match`: `W/"67ab43-4e1cb"`
          //用于条件请求，仅当资源的标识符匹配才返回响应
          `If-Modified-Since`: `Sat, 29 Oct 1994 19:43:31 GMT`
          //用于条件请求，仅当资源自指定日期以来未被修改过才返回响应
          `Content-Language`: `en`
          //用于指定请求体的自然语言
          `Content-Range`: `bytes 0-499/1234`
          //用于指定请求体的范围
    },
}
```
