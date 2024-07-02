# 高级 JS 语法笔记

1. augmented 动态形参

```javascript
function aug() {
  console.log(arguments);
}

const list = [{ name: "a", age: 18 }];
const obj = { name: "b", age: 20 };
aug(list, obj, ...list); // 数组, 对象, 对象

// ...为展开运算符，自动将数组中的元素拼接到参数列表中。
```
