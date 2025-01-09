# Vue Watch 监听器

Vue 的 Watch 监听器可以监听数据的变化，并执行相应的函数, 它是 Vue 响应式核心

快速使用

```Vue
<template>
  <div>
    <p>{{ count }}</p>
    <button @click="changeCount()">change</button>
  </div>
</template>

<script setup>
  import { ref, watch } from "vue";

  const count = ref(0);

  function changeCount() {
    message.value += 1;
  }

  watch(count, (newVal, oldVal) => {
    console.log("原数据:" + oldVal);
    console.log("数据更新:" + newVal);
  });
</script>
```

## 多种情况

1. 数组变化

   ```Vue
   <template>
     <div>
       <p>{{ arr }}</p>
       <button @click="push()">push</button>
     </div>
   </template>

   <script setup>
   import { ref } from 'vue'

   const arr = ref([1, 2, 3])

   function push() {
     arr.value.push(4)
   }

   watch(arr, (newVal, oldVal) => {
     console.log('newVal:', newVal)
     console.log('oldVal:', oldVal)
   })
   </script>
   ```

2. 对象变化

   ```Vue
   <template>
     <div>
       <p>{{ obj }}</p>
       <button @click="set()">set</button>
     </div>
   </template>

   <script setup>
   import { ref } from 'vue'

   const obj = ref({ name: 'John', age: 30 })

   function set() {
     obj.value.name = 'Mike'
   }
   //对象变化时，需要设置 deep: true，也就是监听里面的所有属性
   watch(obj, (newVal, oldVal) => {
     console.log('newVal:', newVal)
     console.log('oldVal:', oldVal)
   },{ deep: true })

   //或者单独监听对象里面的某个属性
   watch(() => obj.value.name, (newVal, oldVal) => {
     console.log('newVal:', newVal)
     console.log('oldVal:', oldVal)
   })
   </script>
   ```

3. 计算属性变化

   ```Vue
   <template>
     <div>
       <p>{{ fullName }}</p>
       <button @click="setName()">set</button>
     </div>
   </template>

   <script setup>
   import { ref, computed } from 'vue'

   const firstName = ref('John')
   const lastName = ref('Doe')

   const fullName = computed(() => {
     return firstName.value + '|' + lastName.value
   })

   function setName() {
     firstName.value = 'Mike'
   }

   watch(firstName, (newVal, oldVal) => {
     console.log('newVal:', newVal)
     console.log('oldVal:', oldVal)
   })
   </script>
   ```
