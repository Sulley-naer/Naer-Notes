# pinia 实现状态管理 [官方文档](https://pinia.vuejs.org/zh/ssr/nuxt.html)

```bash
yarn add pinia @pinia/nuxt
# 或者使用 npm
npm install pinia @pinia/nuxt
```

> [!TIP]
> 如果你正在使用 npm，你可能会遇到 ERESOLVE unable to resolve dependency tree 错误。如果那样的话，将以下内容添加到 package.json 中

```typescript
"overrides": {
    // 版本号记得对应，Vueuse需要判断
    "vue": "^3.4.29"
  }
```

## 创建 `store` /name.ts

```javascript
import { defineStore } from "pinia";
//本地存储
import { useStorage } from "@vueuse/core";

export const useMyDefaultStore = defineStore({
  id: "myDefaultStore",
  state: () => ({
    username: "张三",
    //本地存储
    username: useStorage("username", "张三"),
  }),
  getters: {
    getUsername: (state) => state.username,
  },
  actions: {
    setUsername(newUsername: any) {
      this.username = newUsername;
    },
    async fetchUsername() {
      // 异步获取数据的示例方法
      // const response = await fetch('/api/username')
      // this.username = await response.json()
    },
  },
});
```

> 调用 store

```typescript
//敲id名会提示
import { useMyDefaultStore } from "~/stores/default";
const store = useMyDefaultStore();

const name = ref("");

name.value = store.$state.username;
store.setUsername("李四");
name.value = store.getUsername;
```

## 其余高级语法 [pinia](/数据交互/pinia.md)
