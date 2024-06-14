# 认识pinia [pinia](https://pinia.vuejs.org/zh/)

1. 安装

```bash
npm install pinia
# ts版本
npm install pinia@next
```

2.使用

```js
//入口文件应用
import { createPinia } from 'pinia'
import { createApp } from 'vue'
import App from './App.vue'
const app = createApp(App)
app.use(createPinia())
app.mount('#app')
```

## store&getters&actions

> 用于存储数据、计算属性、方法 | 异步方法

```js
import { defineStore } from 'pinia'
// 定义Store
export const useStore = defineStore({
  id: 'main', // Store的唯一标识
  state: () => ({
    count: 0, // 定义状态
  }),
  getters: {
    // 计算属性，返回count的两倍
    doubleCount(state) {
      return state.count * 2
    },
  },
  actions: {
    // Action，用于修改count
    increment() {
      this.count++
    },
  },
})
```

> 在组件中使用

```html
<template>
  <div>
    <p>{{ count }}</p>
    <p>{{ doubleCount }}</p>
    <button @click="increment">Increment</button>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useStore } from './store'
const store = ref(useStore())
//获取数据，调用state
const count = ref(store.count)
//获取数据，调用getters
const doubleCount = ref(store.doubleCount)
//修改数据，调用actions
const increment = ref(store.increment)
</script>
```

## 多个store，均通过 `store().方法`来调用

```js
import { defineStore } from 'pinia'
//引入式
import { useStore3 } from './store'
// 定义Store
export const useStore = defineStore({
  id: 'main', // Store的唯一标识
  state: () => ({
    count: 0, // 初始状态
    //获取store3的name数据
    name: useStore3().name,
  }),
  getters: {
    // 计算属性，返回count的两倍
    doubleCount(state) {
      return state.count * 2
      // return useStore3().name
    },
  },
  actions: {
    // Action，用于增加count
    increment(value) {
      this.count += value
      // useStore3().changeName('newName')
    },
  },
})
// 定义Store
export const useStore2 = defineStore({
  id: 'main2', // Store的唯一标识
  state: () => ({
    count: useStore().count,
  }),
  getters: {
    // 计算属性，返回count的两倍
    doubleCount(state) {
      //使自己与useStore的count保持一致
      return useStore().doubleCount
    },
  },
  actions: {
    increment(value) {
      useStore().increment(value)
    },
  },
})
```

> 使用store2修改store1的数据

```html
<template>
  <div>
    <p>{{ count }}</p>
    <p>{{ doubleCount }}</p>
    <button @click="increment">Increment</button>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useStore } from './store'
import { useStore2 } from './store'
const store = ref(useStore())

const store2 = ref(useStore2())
//获取数据，调用state
const count = ref(store.count)
//处理数据，调用getters
const doubleCount = ref(store.doubleCount)
//修改数据，调用actions
const increment = () => {
  store2.increment(1)
}
</script>
```

## 额外拓展

1. 变为本地存储

```bash
npm install @vueuse/core
```

```js
import { defineStore } from 'pinia'
import { useStorage } from '@vueuse/core'
// 定义Store
export const useStore = defineStore({
  id: 'main', // Store的唯一标识
  state: () => ({
    count: useStorage('count', 0), // 初始状态
    // count: useStorage('count', 0, sessionStorage) // 使用sessionStorage
  }),
  getters: {
    // 计算属性，返回count的两倍
    doubleCount(state) {
      return state.count * 2
    },
  },
  actions: {
    // Action，用于增加count
    increment(value) {
      this.count += value
    },
  },
})
```
