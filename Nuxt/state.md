# Nuxt3 [状态管理](https://nuxt.com/docs/getting-started/state-management)

## 基本用法 [高级管理](store.md)

> 组件中创建的无法直接共享的状态，可以通过 `store` 进行管理。既然创建了那直接使用 `pinia` 便利很多

```html
<script setup lang="ts">
  const counter = useState("counter", () => Math.round(Math.random() * 1000));
</script>

<template>
  <div>
    Counter: {{ counter }}
    <button @click="counter++">+</button>
    <button @click="counter--">-</button>
  </div>
</template>
```

## 状态共享 [store](store.md)

> 由于 Vue 的 `provide/inject`机制 太宝贝的难用了，所以推荐使用 [`pinia`](store.md) 进行状态共享。

## [cookie](https://github.com/js-cookie) 「[通用版本](/数据交互/js%20字符处理.md#cookie)」

> 键值对形式的 cookie 库，可以方便的操作 cookie。

```bash
npm i js-cookie
```

> 兼容性一般 ES6+

```javascript
//创建cookie
cookieStore
  //cookie中设置name为value，有效期为365天,path为根目录 子级可以访问
  .set("name", "value", { expires: 365, path: "/" })
  .then(() => console.log("Cookie set successfully"))
  .catch((err) => console.error("Failed to set cookie:", err));
//获取
cookieStore
  .get("name")
  .then((cookie) => console.log("Cookie value:", cookie.value))
  .catch((err) => console.error("Failed to get cookie:", err));
```
