# Vite css 处理 [官方文档](https://cn.vitejs.dev/guide/features.html#css)

> [!NOTE]
>
> > Vite 支持将 JS 中导入的 css 文件 解析 为 JS 并且使用预处理器 构建后 再将 esm 格式的 css 文件添加进页面的 style 中
>
> > [!WARNING]
> > CSS 导入的可能会出现变量名重复，并且导致样式冲突失效的情况，所以 Vite 中添加了 css modules 功能，可以解决这个问题。

```javascript
import styles from "./index.module.css";

const div = document.createElement("div");
// 这样绑定的类名会根据导入的对象 会加上内存位置生成不同的类名前嘴 js是可以直接写类名的
div.className = styles.container;
document.body.appendChild(div);
```

通常不用手动配置 直接 vue 里面 scope，只是说下 Vite 处理方式
