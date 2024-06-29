# Render 进程 [官方文档](https://www.electronjs.org/zh/docs/latest/tutorial/quick-start#%E9%A2%9D%E5%A4%96%E5%B0%86%E5%8A%9F%E8%83%BD%E6%B7%BB%E5%8A%A0%E5%88%B0%E6%82%A8%E7%9A%84%E7%BD%91%E9%A1%B5%E5%86%85%E5%AE%B9)

## DOM 引入直接使用的 Render 进程

```javascript
//renderer.js
let btn = document.getElementById("btn");

const fn1 = () => {
  alert("成功");
};

btn.addEventListener("click", fn1);
```

```html
<!--index.html-->
<button id="btn">点击</button>
<script src="renderer.js"></script>
```

> 它只是用来渲染 Dom 的，只是普通网页 JS 功能 Vue React 等框架的渲染功能是在主进程中运行的。

[Build](Build.md)