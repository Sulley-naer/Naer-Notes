# Router props [传递数据](https://cn.vuejs.org/guide/components/props.html)

- 父传递数据

```html
<template>
  <div>
    <NuxtPage :cs="'测试测试'"> </NuxtPage>
    <!-- <button @click="change">点击切换显示</button> -->
  </div>
</template>
<script setup>
  // 自动显示 pages/index 文件夹下 index.vue 组件
  /* const change = () => {
    $router.push({ path: "/test" });
  }; */
</script>
```

- 子接受数据

```html
<template>
  <div>
    <h1>{{ myData }}</h1>
  </div>
</template>

<script setup>
  const props = defineProps(["cs"]);
  const myData = ref(props.cs);
</script>
```
