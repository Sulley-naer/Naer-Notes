# Vite [配置](https://cn.vitejs.dev/config/)

Vite 的配置文件是一个 `vite.config.js` 文件，它是一个 Node.js 模块，导出一个默认导出函数，接收一个 `config` 对象作为参数。

> [!NOTE]
> 配置文件是通过导出对象来配置的，而不是通过命令行参数。
>
> ```javascript
> // vite.config.js
> export default {
>   optimizeDeps: {
>     include: ["foo", "bar"],
>   },
> };
> ```
