# 环境配置
## 安装node.js
- [官网](https://nodejs.org/zh-cn/)
## 安装vue-cli `-g`为全局 `install` 可简写为i
```bash
npm install -g @vue/cli
```

## 创建项目
> 再对应文件夹地址栏输入`cmd` 输入 `vue ui`图形化创建

> npm代码创建 命令行输入
初始化项目
1.  npm init
2.  npm install @vue/cli  其他版本可加@版本号 其余插件同理
3. vue create my-project

# 认识 @Vue/cli
1. `public` 文件夹存放全局静态文件,`html` `api` `favicon`
2. `src` 存放组件与动态资源.
3. `main.js`必须存放在 `src`中
4. `src/components`存放组件
5. `src/assets`存放静态资源 img css js……
6. `router`存放路由配置 用于组件/页面切换
7. `store`存放状态管理
8. `views`存放页面组件
9. `App.vue`为根组件
10. `main.js`为入口文件

# 认识入口文件
```js
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
//引入所需主页组件

createApp(App).use(store).use(router).mount('#app')
// 实例化App组件并挂载到#app 使用router 配置路由
```

# 组件
> 通过`template` 模板语法编写组件 注册组件改为`export default {}`,引入其他组件`import 组件名 from '组件路径'`

```html
<template>
  <div class="hello">
    <h1>{{msg}}</h1>
  </div>
  <hr>
    <ban></ban>
</template>

<script>
import ban from './ban.vue'

export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
    components: {
        ban
    }
}
//组件跳转请务必使用 this.$router.push('/new-route')
</script>
```

```html
<template>
    <div class="ban">
        <h1>我是ban</h1>
    </div>
</template>
<!-- scoped为独立样式,其余组件无法使用,lang可定义less -->
<style scoped>
    .ban {
        color: red;
    }
</style>

<script>
export default {
    name: 'Ban',
}
</script>

```

# 路由 「[官网](https://router.vuejs.org/zh/installation.html)」
> 通过`vue-router`配置路由 入口文件`main.js`中引入并使用`router`配置路由 组件不刷新跳转`this.$router.push('/new-route')`

> 如子组件需要通过 父组件获取数据，使用`component`引入父级，隐藏对象，在`onMounted`获取其参数
```js
//必须引入
import { createRouter, createWebHistory } from 'vue-router'
//子组件引入
import HomeView from '../views/HomeView.vue'

const routes = [
  {
    path: '/',
    // 俩种引入方式 2选1
    // component: HomeView,
    component: function () {
      return import('../views/HomeView.vue')
    },
    children:[
      {
        // 子路由 /home/ban
        path:'ban',
        component:()=>import('../views/Ban.vue')
        //多出口模式
        /* components: {
          default: BanView,
          pop:()=> import('../components/well.vue')
        } */
      }
    ]
  }
]

//创建路由,基本上不动
const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
```

# router-view & router-link
> `router-view`用于显示路由组件 `router-link`用于跳转路由

```html
<router-link to="/"></router-link>
<router-link to="/about/ban">打开弹窗</router-link>
<!-- 路由中配置了子级页面，将在下方显示 -->
<router-view/>

<!-- 多出口模式 -->
<router-view/>
<router-view name="pop"/>
```

# 项目打包
> `npm run build` 打包项目,生成`dist`文件夹
> `npm run serve` 本地运行项目

# 依赖注入「[官方文档](https://cn.vuejs.org/api/composition-api-dependency-injection.html)」
> `provide` `inject` 用于父子组件传值

```html