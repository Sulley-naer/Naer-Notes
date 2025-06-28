# Vue 组件通讯

## 方法一

> 通过 emit 事件传递数据给父组件

子组件

```javascript
<template>
  <div>
    <input v-model="searchQuery" @input="handleInput" placeholder="搜索..." />
  </div>
</template>

<script setup lang="ts">
import { ref, defineEmits } from 'vue';

const searchQuery = ref('');
const emit = defineEmits(['update:search']);

function handleInput() {
  emit('update:search', searchQuery.value);
}
</script>
```

父组件

```javascript
<template>
  <div id="shop">
    <div class="common-layout">
      <el-container>
        <el-header>
          <Head @update:search="handleSearch"></Head>
        </el-header>
        <el-main>Main</el-main>
      </el-container>
    </div>
  </div>
</template>

<script setup lang="ts">
import Head from '@/views/shop/header.vue';

function handleSearch(query) {
  console.log('Search query:', query);
  // 调用父组件的方法处理搜索查询
}
</script>
```

## 方法二

> 子组件中，使用 props 和 emit 实现双向绑定。弊端：父组件无法准确监听子组件对数据的变化。

子组件

一定要记得是 lang="ts" 才可以。

```javascript
<template>
  <div>
    <input v-model="search" placeholder="搜索..." />
  </div>
</template>

<script setup lang="ts">
import { ref, defineProps, defineEmits, watch } from 'vue';

const props = defineProps<{ modelValue: string }>();
const emit = defineEmits(['update:modelValue']);

const search = ref(props.modelValue);

watch(search, (newVal) => {
  emit('update:modelValue', newVal);
});
</script>
```

父组件

```javascript
<template>
  <div id="shop">
    <div class="common-layout">
      <el-container>
        <el-header>
          <Head v-model="searchQuery"></Head>
        </el-header>
        <el-main>Main</el-main>
      </el-container>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import Head from '@/views/shop/header.vue';

const searchQuery = ref('');

watch(searchQuery, (newQuery) => {
  console.log('Search query updated:', newQuery);
  // 调用父组件的方法处理搜索查询
});
</script>
```

## 方式三

> 子组件触发自定义属性，变相实现双向绑定。解决了数据变化监听不准确的问题。

子组件

在子组件中，我们使用 emit 手动触发自定义事件 custom-update，并传递新值给父组件。

```typescript
<template>
  <div>
    <!-- 按钮点击时触发自定义事件 -->
    <button @click="updateChosen('新的值')">更新 chosen</button>
  </div>
</template>

<script setup lang="ts">
import { defineProps, defineEmits } from 'vue';

// 接收父组件的 v-model 绑定值
const props = defineProps<{ modelValue: string }>();
const emit = defineEmits(['update:modelValue', 'custom-update']);

// 手动触发自定义事件
const updateChosen = (newValue: string) => {
  emit('custom-update', newValue);
};
</script>
```

父组件

在父组件中，我们将定义一个自定义属性 @custom-update，并通过它来接收子组件的触发事件。

```typescript
<template>
  <div>
    <!-- 通过 v-model 绑定 chosen，并监听自定义事件 custom-update -->
    <Navbar v-model="chosen" @custom-update="handleCustomUpdate"></Navbar>
    <p>Chosen: {{ chosen }}</p>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const chosen = ref('初始值');

// 自定义事件处理函数
const handleCustomUpdate = (newValue: string) => {
  console.log('自定义事件触发，新的值为:', newValue);
  chosen.value = newValue;
};
</script>
```

异步数据更新处理

> 由于是通过父组件的 props 接收异步数据，所以需要在父组件中监听 props 的变化，并更新子组件的数据。

```TypeScript
const props = defineProps<{ modelValue: [] }>()

data.value = props.modelValue

watch(
  () => props.modelValue,
  (newValue) => {
    data.value = newValue
  },
  { immediate: true }
)
```

## 方式四

> 解决多参数传递，v-model 单独问题，可使用 props 和 emit 双向绑定

父组件

```html
<head
  v-model="searchQuery"
  :anotherProp="goods"
  @update:search="handleSearch"
  @update:anotherProp="handleAnotherProp"></head>
```

子组件

```Typescript
const props = defineProps<{
  modelValue: string
  anotherProp: string
}>()

// v-Model() 3.4推荐使用api defineModel()

const search = ref(props.modelValue)

const user = ref(props.anotherProp)

watch(search, (newVal) => {
  emit('update:modelValue', newVal)
})

watch(user, (newVal) => {
  emit('update:anotherProp', newVal)
})

```

## 双向绑定

> Vue model 双向绑定 [说明](https://cn.vuejs.org/guide/components/v-model) [Api](https://cn.vuejs.org/api/sfc-script-setup.html#definemodel)

- 父组件

```html
<son
  v-model:kit='"two"'
  v-model='"hello"'
  @update:kit="handleKit"
  @update:model="handleModel"></son>
```

- 子组件

```Typescript
//接受 3.4+
const model = defineModel()
const kit = defineModel("Kit", { type: string, default: "one" })

//监听
watch(model, (newVal) => {
  console.log(newVal)
  emit("update:model", newVal)
})

watch(kit, (newVal) => {
  console.log(newVal)
  emit("update:kit", newVal)
})
```

## Watcher

- 监听数据的变化，当数据变化时，执行回调函数。

```html
<template>
  <div>
    <input v-model="searchQuery" placeholder="搜索..." />
  </div>
</template>

<script setup lang="ts">
  import { ref, watch } from "vue";

  const searchQuery = ref("");

  //Vue3 的watch是拦截式，所以必须要保证使用的最后，让新数据保存给变量，否则无法更新数据了，后续的watch不会生效
  watch(searchQuery, (newVal) => {
    console.log("Search query updated:", newVal);
    searchQuery.value = newVal;
  });

  //Vue 新语法省去了填写对象，也不需要给他赋值，弊端就是无法获取到新值 [链接](https://cn.vuejs.org/api/reactivity-core#watcheffect)
  watchEffect(() => console.log(searchQuery.value));
</script>
```

- 监听多个数据变化，当多个数据变化时，执行回调函数。

```html
<template>
  <div>
    <input v-model="searchQuery" placeholder="搜索..." />
    <input v-model="searchCategory" placeholder="分类..." />
  </div>
</template>

<script setup lang="ts">
  import { ref, watch } from "vue";

  const searchQuery = ref("");
  const searchCategory = ref("");

  watch([searchQuery, searchCategory], (newVal) => {
    console.log("Search query and category updated:", newVal);
    ...自行将 newVal 赋值给原对象
  });
</script>
```

- 监听数据的变化，并执行异步操作。

```html
<template>
  <div>
    <input v-model="searchQuery" placeholder="搜索..." />
  </div>
</template>

<script setup lang="ts">
  import { ref, watch } from "vue";

  const searchQuery = ref("");

  const fetchData = async () => {
    const response = await fetch(
      `https://api.example.com/search?q=${searchQuery.value}`
    );
    const data = await response.json();
    console.log(data);
  };

  watch(searchQuery, () => {
    fetchData();
  });
</script>
```

## Dom 绑定

- Ref 给模板对象添加一个引用，方便操作 DOM。

```html
<template>
  <div>
    <h1 ref="title">我的标题</h1>
  </div>
</template>

<script setup lang="ts">
  import { ref, onMounted } from "vue";

  const title = ref(null);

  onMounted(() => {
    // 这里可以通过 myElement.value 操作 DOM 元素
    console.log(myElement.value); // 访问 DOM 元素
    console.log(myElement.value.ref); // elementPlus 访问
    myElement.value.style.backgroundColor = "yellow"; // 修改背景颜色
  });
</script>
```

- 点击事件获取元素

```html
<template>
  <div>
    <el-button @click="handleClick($event)">点击</el-button>
  </div>
</template>

<script setup lang="ts">
  import { ref } from "vue";

  const handleClick = (element: MouseEvent) => {
    console.log(element);// 访问 DOM 元素
    console.log(element.target);// element.target 访问点击的元素
  };
```
