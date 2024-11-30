# GetStand

> [!TIP]
> tailwindcss 是基于 css 预处理器来实现的，它的生命周期是在构建工具运行的时候。
>
> 当客户端访问的时候，拿取的文件是已经被修改过了，已经在 head 里面写入了样式代码，并没有使用网络请求。

> tailwindcss 是基于类名绑定样式的 CSS 框架，它提供了一系列的类名，可以快速的实现常见的 UI 效果。

## [安装](https://tailwindcss.com/docs/guides/vite#react)

```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

## 配置

1. 在 `tailwind.config.js` 文件中配置 `purge` 选项，指定需要清除的 CSS 类名。

   ```js
   module.exports = {
     purge: ["./src/**/*.{js,jsx,ts,tsx,html}"],
     darkMode: false, // or 'media' or 'class'
     theme: {
       extend: {},
     },
     variants: {},
     //基于 tailwindcss 的ui框架 基本上都需要挂载插件
     plugins: [],
   };
   ```

2. 在 `postcss.config.js` 文件中配置 `tailwindcss` 插件。

   ```js
   //postcss 是构建工具中的 css 预处理器，挂载插件就能在对应的阶段对 css 进行处理
   module.exports = {
     plugins: [require("tailwindcss"), require("autoprefixer")],
   };
   ```

## 导入使用

> 方式一 使用 预处理器导入

```css
<!-- 预处理器会识别 @ 开头的语句，并执行对应的操作 -->
@tailwind base;
@tailwind components;
 <!-- 可选：它用于生成一系列的 utility 类，可以帮助你快速实现常见的 UI 效果 -->
@tailwind utilities;
```

> 方式二 不推荐 通过 Js module 导入 css 文件

```js
// 导入样式文件
//! 注：这样的方式 不是预处理器执行的 ，而是浏览器通过网络请求获取样式文件
import "tailwindcss/tailwind.css";
```

## 使用

```tsx
//使用方式一
import "./index.css";

return (
  <div className="bg-gray-100 p-4">
    <h1 className="text-3xl font-bold">Hello World</h1>
    {/* Nextui 测试 */}
    <Button color="primary">Button</Button>
  </div>
);
```

## 参考

- [Tailwind CSS](https://tailwindcss.com/)
- [Tailwind CSS 安装](https://tailwindcss.com/docs/installation)
- [Tailwind CSS 文档](https://tailwindcss.com/docs)
