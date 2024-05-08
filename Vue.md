
# 使用Vue 3.0 「[官网](https://v3.cn.vuejs.org/guide/introduction.html)」
```html
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
```

## 通过Vue创建一个简单的计数器 「[官网](https://v3.cn.vuejs.org/guide/introduction.html)」
```html
<div id="app">
    <!-- V-on:可简写为@ -->
  <button v-on:click="count++">点击我</button>
  <p>这个按钮被点击了 {{ count }} 次。</p>
</div>

<script>
  var app = new Vue({
    el: '#app',
    data: {
      count: 0
    }
  })
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
    el: '#app-2',
    data: {
      message: '页面加载于 ' + new Date().toLocaleString()
    }
  })
</script>
```

## 表单数据绑定 「[官网](https://cn.vuejs.org/guide/essentials/forms.html#form-input-bindings)」
```html
<div id="app-3">
  <p>{{ message }}</p>
  <input v-model="message">
</div>

<script>
  var app3 = new Vue({
    el: '#app-3',
    data: {
      message: 'Hello Vue!'
    }
  })
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
    template: '<button v-on:click="count++">你点击了我 {{ count }} 次。</button>',
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
  <alert-box>
    我是父级组件的内容
  </alert-box>
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
> 多个插槽时，可以通过name属性进行区分 `v-if="$slots.header"`判断存在
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