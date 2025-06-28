# 使用 Vue 3.0 「[官网](https://v3.cn.vuejs.org/guide/introduction.html)」

```html
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
```

## 事件绑定 「[官网](https://cn.vuejs.org/guide/components/events.html)」

```html
<div id="app">
  <!-- V-on:可简写为@ -->
  <button v-on:click="count++">点击我</button>
  <p>这个按钮被点击了 {{ count }} 次。</p>
</div>

<script>
  var app3 = new Vue({
    el: "#app",
    data: {
      message: "Hello Vue!",
    },
  });
</script>
```

## `watch` 数据监听 「[官网](https://cn.vuejs.org/api/options-state.html#watchl)」

> 用于监听数据变化，当数据变化时，自动执行函数

```html
<div id="app">
  <input v-model="message" />
  <p>当前值: "{{ message }}"</p>
</div>

<script>
  var app3 = Vue.createApp({
    data() {
      return {
        message: "Hello Vue!",
      };
    },
    watch: {
      message(newValue, oldValue) {
        console.log(
          "message 发生变化了，新值为:",
          newValue,
          "旧值为:",
          oldValue
        );
        // 在这里可以执行你想要的操作，比如发送请求、更新其他数据等
      },
    },
  }).mount("#app");
</script>
```

## computed 计算属性 「[官网](https://cn.vuejs.org/api/reactivity-core.html#computed)」

> 常用于数据处理，也能监听数据。

```html
<div id="app">
  <input v-model="firstName" />
  <input v-model="lastName" />
  <p>全名: "{{ fullName }}"</p>
</div>

<script>
  var app3 = Vue.createApp({
    data() {
      return {
        firstName: "John",
        lastName: "Doe",
      };
    },
    computed: {
      fullName() {
        return this.firstName + " " + this.lastName;
      },
    },
  }).mount("#app");
</script>
```

## 基础语法 「[官网](https://cn.vuejs.org/guide/essentials/template-syntax.html#directives)」

```html
<div id="app-2">
  <!-- 简写为:title  -->
  <span v-bind:title="message">
    鼠标悬停几秒钟查看此处动态绑定的提示信息！
  </span>
</div>

<script>
  var app2 = new Vue({
    el: "#app-2",
    data: {
      message: "页面加载于 " + new Date().toLocaleString(),
    },
  });
</script>
```

## 表单数据绑定 「[官网](https://cn.vuejs.org/guide/essentials/forms.html#form-input-bindings)」

```html
<div id="app-3">
  <p>{{ message }}</p>
  <input v-model="message" />
</div>

<script>
  var app3 = new Vue({
    el: "#app-3",
    data: {
      message: "Hello Vue!",
    },
  });
</script>
```

## 类名与内联样式绑定 「[官网](https://cn.vuejs.org/v2/guide/class-and-style.html)」

```html
<div id="app-4">
  <div v-bind:class="{ active: isActive }">1</div>
  <div v-bind:class="classObject">1</div>
  <div v-bind:style="styleObject">1</div>
</div>

<script>
  var app4 = new Vue({
    el: "#app-4",
    data: {
      isActive: true,
      classObject: {
        active: true,
        "text-danger": true,
      },
      styleObject: {
        color: "red",
        fontSize: "30px",
      },
    },
  });
</script>

<style>
  .active {
    color: red;
  }
  .text-danger {
    font-size: 50px;
  }
</style>
```

## 指令 「[官网](https://cn.vuejs.org/api/built-in-directives.html)」

1. v-text `<span v-text="msg"></span>` 绑定文本内容

2. v-html `<span v-html="msg"></span>` 绑定 HTML 内容

3. v-show `<div v-show="isShow"></div>` 绑定值 true/false 显示隐藏

4. v-if/v-else/v-else if

> 必须包含在一个元素内，并且挨在一起，否则会报错

```html
<div id="app">
  <p v-if="status === 'success'">操作成功！</p>
  <p v-else-if="status === 'warning'">警告：操作可能存在风险。</p>
  <p v-else>操作失败。</p>
</div>

<script>
  const app = Vue.createApp({
    data() {
      return {
        status: "success", // 可以根据不同的状态来显示不同的内容
      };
    },
  }).mount("#app");
</script>
```

### v-for

```html
<div id="app">
  <table>
    <thead>
      <tr>
        <th>学号</th>
        <th>班级</th>
        <th>姓名</th>
        <th>性别</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="item in students" :key="item.sno">
        <td>{{ item.sno }}</td>
        <td>{{ item.class }}</td>
        <td>{{ item.name }}</td>
        <td>{{ item.gender }}</td>
      </tr>
    </tbody>
  </table>
</div>

<script>
  const app = Vue.createApp({
    data() {
      return {
        students: [
          { sno: "001", class: "A", name: "张三", gender: "男" },
          { sno: "002", class: "B", name: "李四", gender: "女" },
          { sno: "003", class: "A", name: "王五", gender: "男" },
        ],
      };
    },
  }).mount("#app");
</script>
```

- v-on `<button v-on:click="alert('点击')">` 绑定事件 v-on 可以简写为 @

```HTML
<!-- 方法处理函数 -->
<button v-on:click="doThis"></button>

<!-- 动态事件 -->
<button v-on:[event]="doThis"></button>

<!-- 内联声明 -->
<button v-on:click="doThat('hello', $event)"></button>

<!-- 缩写 -->
<button @click="doThis"></button>

<!-- 使用缩写的动态事件 -->
<button @[event]="doThis"></button>

<!-- 停止传播 -->
<button @click.stop="doThis"></button>

<!-- 阻止默认事件 -->
<button @click.prevent="doThis"></button>

<!-- 不带表达式地阻止默认事件 -->
<form @submit.prevent></form>

<!-- 链式调用修饰符 -->
<button @click.stop.prevent="doThis"></button>

<!-- 按键用于 keyAlias 修饰符-->
<input @keyup.enter="onEnter" />

<!-- 点击事件将最多触发一次 -->
<button v-on:click.once="doThis"></button>

<!-- 对象语法 -->
<button v-on="{ mousedown: doThis, mouseup: doThat }"></button>
<!-- 自定义事件,通过其他事件触发 cli中常用 -->
<div id="app1">
  <button @fn="fn1">
  <button @click="$emit(fn)">
</div>
```

## 模板引用 「[官网](https://cn.vuejs.org/v2/guide/components.html)」

```html
<div id="app-5">
  <button-counter></button-counter>
</div>

<script>
  Vue.component("button-counter", {
    data: function () {
      return {
        count: 0,
      };
    },
    template:
      '<button v-on:click="count++">你点击了我 {{ count }} 次。</button>',
  });

  var app5 = new Vue({
    el: "#app-5",
  });
</script>
```

### 全局组件 「[官网](https://cn.vuejs.org/guide/components/registration.html#global-registration)」

```HTML
<div id="app-5">
  <button-counter></button-counter>
</div>

<script>
  Vue.component("button-counter", {
    data: function () {
      return {
        count: 0,
      };
    },
    template: '<button v-on:click="count++">你点击了我 {{ count }} 次。</button>',
  });

  var app5 = new Vue({
    el: "#app-5",
  });
</script>
```

### 模板引用「查找形式」 「[官网](https://cn.vuejs.org/v2/guide/components.html)」

```html
<div id="app-5">
  <custom-button></custom-button>
</div>

<template id="custom-button-template">
  <button v-on:click="count++">你点击了我 {{ count }} 次。</button>
</template>

<script>
  Vue.component("custom-button", {
    data: function () {
      return {
        count: 0,
      };
    },
    template: "#custom-button-template",
  });

  var app5 = new Vue({
    el: "#app-5",
  });
</script>
```

## 插槽 「[官网](https://cn.vuejs.org/guide/components/slots.html)」

> 用于在父级组件中插入子级组件的内容

```html
<div id="app-6">
  <alert-box> 我是父级组件的内容 </alert-box>
</div>

<template id="alert-box-template">
  <div class="demo-alert-box">
    <strong>我是子组件</strong>
    <!-- slot标签为父组件内容位置 -->
    <slot></slot>
  </div>
</template>

<script>
  Vue.component("alert-box", {
    template: "#alert-box-template",
  });
  var app6 = new Vue({
    el: "#app-6",
  });
</script>
```

### 具名插槽 「[官网](https://cn.vuejs.org/guide/components/slots.html#named-slots)」

> 多个插槽时，可以通过 name 属性进行区分 `v-if="$slots.header"`判断存在

```html
<!-- 子级 -->
<template id="alert-box-template">
  <div class="demo-alert-box">
    <header v-if="$slots.header">
      <slot name="header"></slot>
    </header>
    <main>
      <slot></slot>
    </main>
    <footer>
      <slot name="footer"></slot>
    </footer>
  </div>
</template>
<!-- 父级 -->
<div id="app-6">
  <alert-box>
    <template v-slot:header>
      <strong>我是头部</strong>
    </template>
    主要内容
    <template v-slot:footer>
      <em>我是脚步</em>
    </template>
  </alert-box>
</div>

<script>
  Vue.component("alert-box", {
    template: "#alert-box-template",
  });
  var app6 = new Vue({
    el: "#app-6",
  });
</script>
```

## 透传 `Attributes` 「[官网](https://cn.vuejs.org/guide/components/attrs.html)」

```html
<div id="app-6">
  <base-input placeholder="请输入内容"></base-input>
  <!-- 自动将placeholder属性写入到input框中 -->
</div>

<template id="base-input-template">
  <input v-bind="$attrs" v-on="$listeners" />
  <!--q：$attrs 是什么
    a：$attrs 是一个对象，包含了父级作用域中不被 prop 所识别 (且获取) 的特性绑定 (class 和 style 除外)。当一个组件没有声明任何 prop 时，这里会包含所有父作用域的绑定 (class 和 style 除外)，并且可以通过 v-bind="$attrs" 传入内部组件。
    q：$listeners 是什么
    a：$listeners 是一个对象，里面包含了作为 v-on 侦听器传入 (不包括 .native 修饰器监听器) 的所有父组件监听器。可以通过 v-on="$listeners" 传入内部组件。
-->
</template>

<script>
  Vue.component("base-input", {
    template: "#base-input-template",
  });
  var app6 = new Vue({
    el: "#app-6",
  });
</script>
```

## 组件自定义事件 「[官网](https://cn.vuejs.org/v2/guide/components-custom-events.html)」

```html
<div id="app-7">
  <button-counter v-on:increment="incrementTotal"></button-counter>
  <p>{{ total }}</p>
</div>

<script>
  Vue.component("button-counter", {
    data: function () {
      return {
        count: 0,
      };
    },
    template:
      '<button v-on:click="increment">你点击了我 {{ count }} 次。</button>',
    methods: {
      increment: function () {
        this.count++;
        this.$emit("increment");
      },
    },
  });

  var app7 = new Vue({
    el: "#app-7",
    data: {
      total: 0,
    },
    methods: {
      incrementTotal: function () {
        this.total++;
      },
    },
  });
</script>
```

## Vue Props 「[官网](https://cn.vuejs.org/v2/guide/components-props.html)」

> 实例化组件时，通过`props`属性传递数据,同级组件使用`vuex`

```html
<div id="app-8">
  <blog-post title="My journey with Vue" @sendParent="receiveEvent"></blog-post>
</div>

<script>
  Vue.component("blog-post", {
    props: ["title"],
    template: "<h3>{{ title }}</h3><button @click='change'>修改</button>",
    methods: {
      change() {
        emit("sendParent", "我是子组件传递的数据");
      },
    },
  });

  var app8 = new Vue({
    el: "#app-8",
    methods: {
      receiveEvent(val) {
        console.log(val);
      },
    },
  });
</script>
```

## Vue 查看当前实例化对象 「[官网](https://cn.vuejs.org/v2/api/#vm-prototype)」

```html
<div id="app-9">
  <p>{{ message }}</p>
</div>

<script>
  var app9 = new Vue({
    el: "#app-9",
    data: {
      message: "Hello Vue!",
    },
    mounted() {
      console.log(this);
    },
  });
  console.log(app9);
</script>
```

## telephoner 「[官网](https://cn.vuejs.org/guide/built-ins/teleport.html)」

> 用于将元素移动到指定位置，常用于弹窗被遮挡问题

```html
<div id="app-10">
  <teleport to="body">
    <div>我是teleport</div>
  </teleport>
</div>

<script>
  var app10 = new Vue({
    el: "#app-10",
  });
</script>
```

## keep-alive 「[官网](https://cn.vuejs.org/guide/built-ins/keep-alive.html)」

> 用于保留组件状态或避免重新渲染，常用于组件切换

```html
<div id="app-11">
  <keep-alive>
    <component :is="currentTabComponent"></component>
    <!-- 此组件不会销毁，在显示切换保留数据 -->
  </keep-alive>
</div>

<script>
  var app11 = new Vue({
    el: "#app-11",
    data: {
      currentTabComponent: "home",
    },
  });
</script>
```

> 组件状态响应

```typescript
import { onActivated, onDeactivated } from 'vue'
import { onMounted } from '@vue/runtime-core'

onMounted(()=>{
  //普通组件使用的hook
})
//? Keep 中必须使用的方式，上面的方式无法再次触发
onActivated(() => {
  // 调用时机为首次挂载
  // 以及每次从缓存中被重新插入时
})

onDeactivated(() => {
  // 在从 DOM 上移除、进入缓存
  // 以及组件卸载时调用
})
```
