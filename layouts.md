# Nuxt layouts[文档](https://nuxt.com.cn/docs/guide/directory-structure/layouts)

## 使用布局 `layouts` /name

```html
<!-- name为地址,可使用文件夹,默认加载 default -->
<NuxtLayout name="default">
  <NuxtPage />
</NuxtLayout>
```

## api 式调用

```html
<script setup lang="ts">
  // 可以基于 API 调用或登录状态进行选择
  const layout = "custom";
</script>

<template>
  <NuxtLayout :name="layout">
    <NuxtPage />
  </NuxtLayout>
</template>
```

## 动态切换

```html
//父
<template>
  <div>
    //只能切换无定义布局 可多重复无调用 均会修改
    <NuxtLayout></NuxtLayout>
    <!-- 被定义无法修改,可通过api方式实现修改 -->
    <NuxtLayout name="default"></NuxtLayout>
    <NuxtPage />
  </div>
</template>
```

> 切换布局

```html
//子
<template>
  <div>我是子</div>
  <button @click="tg">layout</button>
</template>

<script lang="ts" setup>
  const tg = () => {
    setPageLayout("custom");
  };
</script>

<style></style>
```

## 页媒布局 [文档](https://nuxt.com.cn/docs/guide/directory-structure/layouts#%E5%9C%A8%E6%AF%8F%E4%B8%AA%E9%A1%B5%E9%9D%A2%E4%B8%8A%E8%A6%86%E7%9B%96%E5%B8%83%E5%B1%80)

```html

```
