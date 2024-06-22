# 状态管理库「[官网](https://vuex.vuejs.org/zh/)」
> # 多数用于解决组件数据通讯问题

>## 长用于解决组件之间共享状态（如登录状态、购物车、主题等）的问题

>## Vuex 的核心概念： State、Getter、Mutation、Action、Module

>### Vuex 是一个专为 Vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态，并以相应的规则保证状态只能按照一定的方式进行修改。

>## 数据会在刷新后丢失，故使用`this.$router.push('/new-route')` 跳转页面

# 框架安装vuex
```bash
npm install vuex --save
```

# 创建store
```javascript
//main.js
import store from './store'
import App from './App.vue'

//全局化store
window.store = store;
createApp(App).use(store).mount('#app')

```

# 利用store 创建一个全局变量
```javascript
// store.js
import { createStore } from 'vuex'

export default createStore({
  state: {
    count: 0
  },
  mutations: {
    increment (state) {
      state.count++
    }
  }
})

```

# 在组件中使用全局变量
```html
<template>
  <div>
    <p>{{ count }}</p>
    <button @click="increment">Increment</button>
  </div>
</template>

<script>
export default {
  computed: {
    count () {
      return this.$store.state.count
    }
  },
  methods: {
    increment () {
      this.$store.commit('increment')
    }
  }
}
```

# store 修改数据
```javascript
// store.js
import { createStore } from 'vuex'

export default createStore({
  state: {
    count: 0
  },
  mutations: {
    increment (state) {
      state.count++
    },
    incrementBy (state, newCount) {
      state.count = newCount
    }
  }
})

```

# store 获取全部数据
```javascript
// store.js
import { createStore } from 'vuex'

export default createStore({
  state: {
    count: 0
  },
  mutations: {
    increment (state) {
      state.count++
    },
    incrementBy (state, newCount) {
      state.count = newCount
    }
  },
  getters: {
    getCount: state => {
      return state.count
    }
  }
})

```

# 在组件中使用全局变量
```html
<template>
  <div>
    <p>{{ count }}</p>
    <button @click="increment">Increment</button>
    <button @click="incrementBy">Increment By 5</button>
  </div>
</template>

<script>
export default {
  computed: {
    count () {
      return this.$store.getters.getCount
    }
  },
  methods: {
    increment () {
      this.$store.commit('increment')
    },
    incrementBy () {
      this.$store.commit('incrementBy', this.$store.state.count + 5)
    }
  }
}

```

# store 动作
```javascript
// store.js
import { createStore } from 'vuex'

export default createStore({
  state: {
    count: 0
  },
  mutations: {
    increment (state) {
      state.count++
    },
    incrementBy (state, newCount) {
      state.count = newCount
    }
  },
  getters: {
    getCount: state => {
      return state.count
    }
  },
  actions: {
    incrementAsync ({ commit }) {
      setTimeout(() => {
        commit('increment')
      }, 1000)
    }
  }
})

```

# 使用动作「api.异步」
```html
<template>
  <div>
    <p>{{ count }}</p>
    <button @click="increment">Increment</button>
    <button @click="incrementBy">Increment By 5</button>
    <button @click="incrementAsync">Increment Async</button>
  </div>
</template>

<script>
export default {
  computed: {
    count () {
      return this.$store.getters.getCount
    }
  },
  methods: {
    increment () {
      this.$store.commit('increment')
    },
    incrementBy () {
      this.$store.commit('incrementBy', this.$store.state.count + 5)
    },
    incrementAsync () {
      this.$store.dispatch('incrementAsync')
    }
  }
}
</script>
```


# store 模块化
```javascript
// store.js
import { createStore } from 'vuex'

const moduleA = {
  state: { count: 0 },
  mutations: {
    increment (state) {
      state.count++
    }
  },
  getters: {
    getCount: state => {
      return state.count
    }
  }
}

const moduleB = {
  state: { count: 0 },
  mutations: {
    increment (state) {
      state.count++
    }
  },
  getters: {
    getCount: state => {
      return state.count
    }
  }
}

export default createStore({
  modules: {
    a: moduleA,
    b: moduleB
  }
})
```

# 使用模块化的store
```html
<template>
  <div>
    <p>{{ countA }}</p>
    <button @click="incrementA">Increment A</button>
    <p>{{ countB }}</p>
    <button @click="incrementB">Increment B</button>
  </div>
</template>

<script>
export default {
  computed: {
    countA () {
      return this.$store.getters['a/getCount']
    },
    countB () {
      return this.$store.getters['b/getCount']
    }
  },
  methods: {
    incrementA () {
      this.$store.commit('a/increment')
    },
    incrementB () {
      this.$store.commit('b/increment')
    }
  }
}
</script>
```

# store 插件 「防止丢失」
```javascript
// store.js
import { createStore } from 'vuex'
//防止刷新丢失数据
import createPersistedState from 'vuex-persistedstate';

const store = createStore({
  state: {
    count: 0
  },
  mutations: {
    increment (state) {
      state.count++
    }
  },
  plugins: [
    createPersistedState()
  ]
})

export default store
```

# store 插件配置
```javascript
// store.js
import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate';

//npm install vuex-persistedstate --save

export default createStore({
  state: {
    count: 0
  },
  mutations: {
    increment (state) {
      state.count++
    }
  },
  plugins: [
    createPersistedState({
      storage: window.localStorage,
    })
  ]
})
```