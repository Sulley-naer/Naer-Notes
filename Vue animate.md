# Vue通过Transition实现定义动画 「[官方文档](https://cn.vuejs.org/guide/built-ins/transition.html)」

```html
<template>
	<button @click="show = !show">Toggle Slide + Fade</button>
  <Transition name="name"><!-- 调用同动画类名 -->
  <!-- <Transition @before-enter="onBeforeEnter" @enter="onEnter" @leave="onLeave"> -->
    <!-- 上面为调用js动画 -->
    <p v-if="show">hello</p>
  </Transition>
</template>

<style>
.name-enter-active {
  transition: all 0.3s ease-out;
}

.name-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}

.name-enter-from,
.name-leave-to {
  transform: translateX(20px);
  opacity: 0;
}
</style>

<script setup>
import { ref } from 'vue'

const show = ref(true)
</script>
```

# transition-group
> 在动画组标签上添加`group`属性，可以实现列表动画，无则只有单个元素动画
>> JS动画同理 @before-enter="name" @enter="name" @leave="name"
```html
<template>
  <button @click="show = !show">Toggle Slide + Fade</button>
  <TransitionGroup name="name" tag="ul">
    <li v-for="item in items" :key="item">{{ item }}</li>
  </TransitionGroup>
</template>

<style>
.name-enter-active {
  transition: all 0.3s ease-out;
}

.name-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}

.name-enter-from,
.name-leave-to {
  transform: translateX(20px);
  opacity: 0;
}
</style>

<script setup>
import { ref } from 'vue'

const show = ref(true)
const items = ref([1, 2, 3, 4, 5])

setInterval(() => {
  items.value.push(items.value.length + 1)
}, 1000)
</script>
```
