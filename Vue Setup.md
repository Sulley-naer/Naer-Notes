# Vue Script Setup「[官方文档](https://cn.vuejs.org/api/sfc-script-setup.html)」

> 语法糖，用于简化 Vue 组件的编写, 从 Vue 3.0 开始支持，并且是推荐的写法，自动防止数据泄漏。

## 例子

1. 数据绑定 注：`setup`获取变量为 `name.value` 不需要添加`this.`

```HTML
<template>
  <div>
    <h1>{{msg}}</h1>
    <p>{{ count }}</p>
    <!-- 双向绑定 -->
    <input type="text" v-model="count" />
    <button @click="increment">点我加一</button>
    <button @click="count--">点我减一</button>
    <!-- 动态组件，定义组件 -->
    <component :is="count%2==0?app:about" />
  </div>
</template>

<script setup>
//导入组件会自动注册
import app from './App.vue'
import about from './About.vue'
// 引入 ref 用于创建响应式数据。
import { ref } from 'vue'

// 创建响应式数据
var count = ref(0)
var msg = 'Hello Vue 3.0'

//props
const props = {
  msg: String
}

// 创建方法
const increment = () => {
  count.value++
}

//暴露数据
defineExpose({msg})

//获取组件实例并打印
import { getCurrentInstance } from 'vue';
const instance = getCurrentInstance();
console.log(instance)

</script>
```

1. 父子通讯

```HTML
<!-- 父 -->
<template>
  <div>
    <h1>{{msg}}</h1>
    <!-- 子组件 -->
    <component :is="child" parentMsg="传递成功" @receiveParent="send"/>
  </div>
</template>

<script setup>
import child from './child.vue'
var msg = '我是父级'

const send = (data) => {
  console.log(data)
}
</script>
```

```html
<!-- 子 -->
<template>
  <div>
    <h1>{{msg}}</h1>
    <p>父传递值:{{parentMsg}}</p>
    <button @click="sendToParent">点我传递数据</button>
  </div>

</template>

<script setup>
//需要引入emit
import { defineEmits } from 'vue';

var msg = '我是子级'
//props
const props=defineProps({
  parentMsg:String
})

// 先声明 emit 函数
const emit = defineEmits(['receiveParent']);

// 新增的方法，用于向父组件发送消息
const sendToParent = () => {
  emit('receiveParent', '我是子组件传递的数据');
};

</script>
```

3.可导入函数

```html
<template>
  <div>
    <p>{{ count }}</p>
    <button @click="increment">+1</button>
    <button @click="count--">-1</button>
  </div>
</template>

<script setup>
// 引入 ref 用于创建响应式数据。
import { ref } from 'vue'
//引入 reactive 用于创建响应式对象
import { reactive } from 'vue'
//引入 toRefs 用于解构响应式对象
import { toRefs } from 'vue'
//引入 computed 用于创建计算属性
import { computed } from 'vue'
//引入 onMounted 用于在组件挂载后执行 onUnmounted 用于在组件卸载后执行
import { onMounted } from 'vue'
//引入 watch 用于监听数据变化
import { watch } from 'vue'
//引入 inject 用于向上获取数据
import { inject } from 'vue'
//引入 provide 用于向下传递数据
import { provide } from 'vue'
//引入组件自动注入的 props
import { props } from 'vue'

// 创建响应式数据
const count = ref(0)

var msg = 'Hello Vue 3.0'
const increment = () => {
  count.value++
}

//创建响应式对象
const state = reactive({
  count: 0
})

//解构响应式对象
const { count } = toRefs(state)
//创建计算属性
const double = computed(() => count.value * 2)
//在组件挂载后执行
onMounted(() => {
  console.log('mounted')
})
//监听数据变化
watch(count, (newVal, oldVal) => {
  console.log('count changed', newVal, oldVal)
})
//向上获取数据
const count = inject('count')
//向下传递数据
provide('count', count)

</script>
```

3.使用Vuex 进行组件间通信

```html
<script setup>
import { useStore } from 'vuex';
import $ from 'jquery';

// 获取 Vuex store 实例
const store = useStore();
//使用store调用Vuex声明方法
onMounted(() => {
    const user = store.getters.getAllUsernames[0];
    username.value = user.username;
    password.value = user.password;
});
//commit调用mutation方法 引号内为方法名
const userUp = () => {
  store.commit('updateFirstUser', { username: username.value, password: password.value });
};
//dispatch调用action 引号内为方法名
const userDown = () => {
  store.dispatch('updateFirstUser', { username: username.value, password: password.value });
};

</script>
```

## [依赖注入](https://cn.vuejs.org/api/composition-api-dependency-injection.html)「父子路由通讯」

> 父级向所有子级传递传递「不管有几层！」，子级是否接受那就要考虑很多了！

```html
<!-- 父级 -->
<script setup>
import { provide } from 'vue'

provide(/* 注入名 */ 'message', /* 值 */ 'hello!')
provide(/* 注入名 */ 'message2', /* 值 */ 'hello!')
</script>

<!-- 不管几层子级 -->
<script setup>
import { inject } from 'vue'
//层级根据路由的/区分的
const message = inject('message')
</script>
```

>### 普通组件跳转用`router.push('/new-route')`