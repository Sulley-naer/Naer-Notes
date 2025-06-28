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
    <NuxtPage> </NuxtPage>
    <router-view></router-view>
    <!-- 俩个都是路由出口 调试中看路径 -->
  </div>
</template>
```

## JS 跳转

```typescript
//方法一
navigateTo("/path");
navigateTo({ path: "/path" });
//方法二
const router = useRouter();
router.push("/path");
router.push({ path: "/path" });
```

## 常用 router 方法

```typescript
//获取当前路由信息
const route = useRoute();
const currentSubRoute = route.path;
//覆写
router.replace("/path");
router.replace({ path: "/path" });
//返回 可填写 num 次数
router.back();
//前进 可填写 num 次数
router.forward();
```

## JS 地址栏方法

```typescript
// 地址栏获取 hosts
window.location.href;
//路径获取 去hosts
window.location.pathname;
//查询参数获取
const searchParams = new URLSearchParams(window.location.search);
//跳转
window.location.href = "/new-path";
//跳转锚点 ID 滚动
window.location.hash = "section1";
//网页刷新
window.location.reload();
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

## provide/inject [官方文档](https://v3.nuxtjs.org/docs/directory-structure/plugins#provide-inject)

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
