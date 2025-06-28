# React Router

React Router 是 React 官方提供的路由管理库，它可以帮助我们管理应用的路由，实现不同 URL 对应的组件的切换。

## 安装

React Router 可以通过 npm 安装：

```bash
npm install react-router-dom -D
# history 库用于管理历史记录
npm install history -D
```

## 初始化路由

React Router 提供了 `BrowserRouter` 和 `HashRouter` 两种路由组件，我们可以根据项目的需求选择其中一个。

1. BrowserRouter：使用 HTML5 的 History API 来管理路由，可以实现前进、后退、刷新等功能。
2. HashRouter：使用 URL 的 hash 值来管理路由，可以实现无刷新跳转。

下面以 BrowserRouter 为例，创建一个简单的路由：

```jsx
/* Router/index.tsx */
import { createBrowserRouter } from "react-router-dom";

import { Suspense, lazy } from "react";

const App = lazy(() => import("../App.tsx"));

const router = createBrowserRouter({
  routes: [
    {
      path: "/",
      element: <div>Home</div>,
    },
    {
      path: "/about",
      element: <div>About</div>,
      //子路由 /about/team 路由出口标签： `<Outlet />`
      children: [
        {
          path: "/team",
          element: <div>Team</div>,
        }
      ]
    },
    {
      //动态导入
      path:"/test"
      element: (
        <Suspense fallback={<div>Loading...</div>}>
          <App />
        </Suspense>
      ),
    },
    {
      //动态路由
      path: "/:id",
      element: (
        //路由里肯定不能这样写，这只是展示获取参数
        import{ useParams } from "react-router-dom";
        const { id } = useParams();//在函数组件里面使用，不要写Js层
        <div>Dynamic Page : {id}</div>
      ),
    }，
    //404页面
    {
      path: "*",
      element: <div>404 Not Found</div>,
    },
  ],
});

export default router;

/* 入口文件 */
import { createRoot } from "react-dom/client";
import { Provider } from "react-redux";
import store from "./store";

import { RouterProvider } from "react-router-dom";
import Router from "./Router/index.tsx";

createRoot(document.getElementById("root")!).render(
  <Provider store={store}>
    <RouterProvider router={Router}></RouterProvider>
  </Provider>
);
```

## 路由跳转

### 标签式跳转

React Router 提供了 `<Link>` 组件来实现标签式跳转，它可以帮助我们在页面中创建链接，点击链接后会触发路由跳转。

```jsx
import { Link } from "react-router-dom";
//注意大小写！小写是原生引入资源，大写才是 React 组件 Dom
<Link to="/about">About</Link>;
```

### 编程式跳转

React Router 提供了 `useNavigate` 钩子函数来实现编程式跳转，它可以帮助我们在组件中触发路由跳转。

```jsx
import { useNavigate } from "react-router-dom";

//需要写在函数组件里面，不要写在最外层！
const navigate = useNavigate();

navigate("/about");
```

## 路由参数

React Router 提供了 `useParams` 钩子函数来获取路由参数，它可以帮助我们在组件中获取 URL 中的参数。

```jsx
const router = createBrowserRouter({
  routes: [
    {
      //多层动态路由 `useParams` 中获取值
      path: "/:id/:name",
      children: [
        {
          //子路由出口标签 import { Outlet } from "react-router-dom";
          // return <Outlet />
          path: "/test",
          indent: true, //默认直接显示的子路由
        },
      ],
    },
  ],
});
```

### 参数解析

Get 请求式参数：

```jsx
// URL: /index?id=123&name=test
import { useParams } from "react-router-dom";

const [params] = useSearchParams();
let id = params.get("id");
let name = params.get("name");
```

动态路由式：

```jsx
// URL: /123
import { useParams } from "react-router-dom";

const { id } = useParams(); //id 是你在动态路由时 : 后面的参数名，多层 : 也是根据对应名称拿取
```

## 路由模式「[文档](https://reactrouter.com/en/main/router-components/browser-router)」

React Router 提供了 `BrowserRouter` 和 `HashRouter` 两种路由模式，它们的区别主要在于 URL 的形式。

- BrowserRouter：使用 HTML5 的 History API 来管理路由，可以实现前进、后退、刷新等功能。
- HashRouter：使用 URL 的 hash 值来管理路由，可以实现无刷新跳转。

- 切换很简单，创建路由的方法切换，根组件包裹路由标签也切换

## 特殊路由功能

1. `loader`: 是一个异步函数，用于在路由组件加载之前获取数据。路由定义
2. `action`: 也是一个异步函数，主要用于处理数据变更操作，如创建、更新或删除数据。路由定义
3. `redirect` Hooks 用于重定向到其他路由，组件调用路由无法配置重定向。
4. `useLocation` 钩子函数用于获取当前路由信息。
5. `useMatch` 钩子函数用于匹配当前路由是否匹配某个路径。
6. `useParams` 钩子函数用于获取当前路由参数。
7. `useResolvedPath` 钩子函数用于获取当前路由的解析路径。
8. `useSearchParams` 钩子函数用于获取当前路由的查询参数。
9. `useOutlet` 钩子函数用于渲染子路由。
10. `useOutletContext` 钩子函数用于获取子路由的上下文。
11. `useLinkClickHandler` 钩子函数用于处理 `<a>` 标签的点击事件。
