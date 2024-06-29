# slot

在组件中，我们可以定义一些插槽，供父组件使用。父组件可以通过 `<slot>` 标签来引用这些插槽。

```html
<template>
  <div>
    <h1>{{ name }}</h1>
    <slot name="header"></slot>
    <p>This is the main content</p>
    <slot name="footer"></slot>
  </div>
</template>

<script setup>
  import { ref } from "vue";

  const name = ref("子组件");
</script>
```

- 使用插槽

```html
<template>
  <div>
    <h1>父组件</h1>
    <my-component>
      <template #header>
        <h2>This is the header</h2>
      </template>
      <template #footer>
        <p>This is the footer</p>
      </template>
    </my-component>
  </div>
</template>

<script>
  import { defineComponent } from "vue";

  export default defineComponent({
    name: "ParentComponent",
    components: {
      MyComponent: () => import("./MyComponent.vue"),
    },
  });
</script>
```
