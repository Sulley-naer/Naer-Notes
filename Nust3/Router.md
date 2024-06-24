# nuxt3 路由配置 [官方文档](https://www.nuxtjs.cn/guide/routing)

## 基于 `pages` 自动路由

```html
<template>
  <div>
    <!-- 默认显示 pages/index 文件夹下 index.vue 组件 -->
    <NuxtPage />
    <!-- 点击后显示 pages/test 文件夹下 index.vue 组件 -->
    <NuxtLink to="/test">点我</NuxtLink>
    <!-- 点击后前往test 文件夹下 one 组件 自定义父组件 -->
    <NuxtLink to="/test/one">点我</NuxtLink>
    <!-- 动态路由 常用与切换组件 pages/test 下 _toggle.vue 下划线区分 -->
    <NuxtLink to="/test:toggle">点我</NuxtLink>
    <!-- 嵌套动态路由 见官网案例！ -->
    <!-- /test/:tg/comment 显示test index 激活 _tg文件夹下 comment 不显示 index 依然能套动态文件夹-->

    <!-- 子路由需 同级下拥有 同名文件夹与组件 ，文件夹下的组件为子路由 -->
    <nuxt-child /><!-- 路由出口 -->
  </div>
</template>
```

## 全局跳转过度动画

> [!TIP]
> 创建文件 `assets/main.css` 并且添加属性

```css
.page-enter-active,
.page-leave-active {
  transition: opacity 0.5s;
}
.page-enter,
.page-leave-active {
  opacity: 0;
}
```

```javascript
// nuxt.config.js
module.exports = {
  css: ["assets/main.css"],
};
```

## 自定义组件过度动画

> assets/main.css

```css
.test-enter-active,
.test-leave-active {
  transition: opacity 0.5s;
}
.test-enter,
.test-leave-active {
  opacity: 0;
}
```

> 自定义页面组件过度动画

```javascript
export default { transition: "test" };
```

> 记得 nuxt 配置动画文件

```javascript
// nuxt.config.js
module.exports = {
  css: ["assets/main.css"],
};
```
