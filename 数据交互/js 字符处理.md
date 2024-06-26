# 字符处理「[在线预览](https://segmentfault.com/a/1190000016603159)」

## JS

1.获取网站地址

```javascript
window.location.host; //www.xxx.com
window.location.hostname; //www.xxx.com (不包含子域名)
window.location.port; //80 获取端口号
window.location.pathname; // /index 获取当前路径名
// router.currentRoute.value.path Vue直接获取最后子路由
window.location.search; //?search=1 获取Get方式数据
window.location.hash; //#page1 获取页面锚点
```

1.获取当前网站 GET 参数

```JS
const value = new URLSearchParams(window.location.search).get('URL');
```

## axios

1 axios 处理 xml 单返回值

```javascript
console.log($(res.data).text().trim()); // 去除空格
```

2 axios 处理 xml 标签

```javascript
console.log($(res.data).find("title").text()); // 获取title标签的值
```

3 axios 处理 返回 list 对象

```javascript
const models = $(res.data)
  .find("model")
  .map((index, element) => {
    return {
      name: $(element).find("name").text(),
      CheckInStatus: $(element).find("CheckInStatus").text(),
      Date: $(element).find("Date").text(),
      id: $(element).find("id").text(),
    };
  })
  .get();
data.value = models;
```

4 余弦相似度

```javascript
function cosineSimilarity(str1: string, str2: string) {
  const vec1 = Array(128).fill(0),
    vec2 = Array(128).fill(0);
  let dotProduct = 0,
    mag1 = 0,
    mag2 = 0;

  for (let i = 0; i < str1.length; i++) vec1[str1.charCodeAt(i)]++;
  for (let i = 0; i < str2.length; i++) vec2[str2.charCodeAt(i)]++;

  for (let i = 0; i < 128; i++) {
    dotProduct += vec1[i] * vec2[i];
    mag1 += vec1[i] ** 2;
    mag2 += vec2[i] ** 2;
  }

  (mag1 = Math.sqrt(mag1)), (mag2 = Math.sqrt(mag2));
  return mag1 === 0 || mag2 === 0 ? 0 : dotProduct / (mag1 * mag2);
}
```

## sessionStorage 与 localStorage

```javascript
sessionStorage.setItem('name', 1);
localStorage.setItem('name', 1);
/* 拿取对象 */
sessionStorage.getItem('name');
...
/* 删除对象 */
sessionStorage.removeItem('name');
...
```

## cookie [「支持库」](https://github.com/js-cookie/js-cookie)

```javascript
// 新版浏览器方法
//创建cookie
if ("cookieStore" in window) {
  cookieStore
    .set("name", 1)
    .then(() => console.log("Cookie set successfully"))
    .catch((err) => console.error("Failed to set cookie:", err));
  //获取
  cookieStore
    .get("name")
    .then((cookie) => console.log("Cookie value:", cookie.value))
    .catch((err) => console.error("Failed to get cookie:", err));
} else {
  setCookieFallback("name", 1, 1);
  const nameValue = getCookieFallback("name");
  console.log("Cookie value (fallback):", nameValue);
}
//老板浏览器方法
function setCookieFallback(name, value, days) {
  const d = new Date();
  d.setTime(d.getTime() + days * 24 * 60 * 60 * 1000);
  const expires = "expires=" + d.toUTCString();
  document.cookie = name + "=" + value + ";" + expires + ";path=/";
}

function getCookieFallback(name) {
  const nameEQ = name + "=";
  const ca = document.cookie.split(";");
  for (let i = 0; i < ca.length; i++) {
    let c = ca[i];
    while (c.charAt(0) === " ") c = c.substring(1, c.length);
    if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
  }
  return null;
}
//直接使用老板
setCookieFallback("name", 1, 1);
const nameValue = getCookieFallback("name");
console.log("Cookie value (fallback):", nameValue);
```
