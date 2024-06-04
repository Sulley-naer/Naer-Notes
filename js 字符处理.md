# 字符处理「[在线预览](https://segmentfault.com/a/1190000016603159)」

##

1 axios 处理 xml 单返回值

```javascript
console.log($(res.data).text().trim()) // 去除空格
```

2 axios 处理 xml 标签

```javascript
console.log($(res.data).find('title').text())  // 获取title标签的值
```

3 axios 处理 返回list对象

```javascript
const models = $(res.data).find("model").map((index, element) => {
    return {
        name: $(element).find("name").text(),
        CheckInStatus: $(element).find("CheckInStatus").text(),
        Date: $(element).find("Date").text(),
        id: $(element).find("id").text(),
    };
}).get();
data.value = models;
```