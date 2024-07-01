# 路由 [官网](https://router.vuejs.org/zh/installation.html)

> 通过
>
> 1. `vue-router`配置路由 入口文件
> 2. `main.js`中引入并使用
> 3. `router`配置路由 组件不刷新跳转
> 4. `this.$router.push('/new-route')` 跳转路由

## 安装

```bash
npm install vue-router
```

## 配置路由 [官方文档](https://router.vuejs.org/zh/guide/)

```js
//必须引入
import { createRouter, createWebHistory } from "vue-router";
//子组件引入
import HomeView from "../views/HomeView.vue";

const routes = [
  {
    path: "/",
    // 俩种引入方式 2选1
    // component: HomeView,
    component: function () {
      return import("../views/HomeView.vue");
    },
    children: [
      {
        // 子路由 /home/ban
        path: "ban",
        component: () => import("../views/Ban.vue"),
        //多出口模式
        /* components: {
          default: BanView,
          pop:()=> import('../components/well.vue')
        } */
      },
    ],
  },
];

//创建路由,基本上不动
const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
```

## router-view & router-link

> `router-view`用于显示路由组件 `router-link`用于跳转路由

```html
<router-link to="/"></router-link>
<router-link to="/about/ban">打开弹窗</router-link>
<!-- 路由中配置了子级页面，将在下方显示 -->
<router-view />

<!-- 多出口模式 -->
<router-view />
<router-view name="pop" />
```

> ## Router Api
>
> > [!TIP]
> > 使用 api 进行路由操作
>
> > [!NOTE]
> >
> > 1. 配置： `router.push()` 跳转路由 `router.push({path: '/about'})`
> > 2. 配置： `router.replace()` 替换当前路由 `router.replace({path: '/about'})`
> > 3. 配置： `router.go()` 前进后退 `router.go(1)`
> > 4. 配置： `router.back()` 返回上一级路由 `router.back()`
> > 5. 配置： `router.forward()` 前进一级路由 `router.forward()`
> > 6. 配置： `router.currentRoute` 当前路由信息 `router.currentRoute.path`
> > 7. 配置： `router.resolve()` 解析路由 `router.resolve({name: 'about'}).href`
> > 8. 配置： `router.beforeEach()` 全局前置守卫 `router.beforeEach((to, from, next) => {})`
> > 9. 配置： `router.afterEach()` 全局后置守卫 `router.afterEach((to, from) => {})`

## 组合式 api [官方文档](https://router.vuejs.org/zh/guide/advanced/composition-api.html)

> [!TIP]
> Vue3.2 新增的组合式 api 方式，可以更方便的进行路由操作 」

```html
<template>
    <div>
    <h1> 当前页面 路由id {{ id }}</</h1>
</div>

<script setup>
import { useRoute } from 'vue-router's
const route = useRoute()
const id = route.params.id

//如子路需要可通过 Props 传递当前路由id
defineProps({
    id: id
})
</script>
```

- router.js

```javascript
// 父路由需配置运行props;
const routes = [{ path: "/user/:id", component: User, props: true }];
```
