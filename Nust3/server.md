# nuxt 服务器接口管理

## `server`/api 自动接口管理

```typescript
/* name.get.ts 加一个 get 是名称可选 必须在 server/api/*/
export default defineEventHandler((event) => {
  return {
    hello: "world",
  };
});
```

> 组件中调用

```html
<template>
  <div>
    <h1>{{ message }}</h1>
    <h2>服务器返回：{{ server }}</h2>
    <nuxt-child />
  </div>
</template>

<script setup lang="ts">
  const message = ref("我是首页");
  const server = ref("");

  const data = await useFetch("/api/channel");
  console.log(data.data.value);

  server.value = data.data.value?.msg; //解构对象

  //vue 的所有事件都无法调用useFetch方法，必须放弃异步调用nuxt
</script>
```
