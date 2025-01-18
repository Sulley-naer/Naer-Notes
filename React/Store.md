# React Store

React 的状态管理库 Redux 是一个很好的选择。
Redux 是一个集中式的状态管理库，它将状态存储在一个单一的对象中，并通过 reducer 函数来更新状态。

安装 Redux

```Bash
npm install redux -D
npm install @reduxjs/toolkit
```

<details>
<summary>查看代码</summary>

## React 配置 Redux

React 配置 Redux 的过程可以分为以下几个步骤：

1. 安装 Redux 相关依赖

   ```Bash
   npm install redux react-redux redux-thunk -D
   npm install @reduxjs/toolkit
   ```

2. 创建 Redux state

   ```Javascript
   import { createSlice } from "@reduxjs/toolkit";


    /*
    * Reducer 想想成为一个盒子，盒子里面有很多的对象，每个对象都有自己的状态，
    * 这些对象需要修改更新状态，reducer就去负责写修改状态的逻辑。
    * 搞这么复杂就是为了防止状态不能被修改，只能通过reducer去修改状态。
    * 目录结构推荐是在 store>modules>counterSlice.js
    */
   const counterSlice = createSlice({
     name: "global",
     //初始化状态
     initialState: {
       count: 0,
     },
     //修改状态方法
     reducers: {
       increment(state) {
         state.count += 1;
       },
       decrement(state) {
         state.count -= 1;
       },
       upload(state, action){
         //传入参数
         state.count = action.payload;
       }
     },
   });

   //解构出 action
   const { increment, decrement } = counterSlice.actions;

   //获取reducer
   const counterReducer = counterSlice.reducer;

   //按需导出
   export {increment, decrement, upload}
   //默认导出
   export default counterReducer;
   ```

3. 创建 Redux Store

   ```Javascript
   import { configureStore } from "@reduxjs/toolkit";
   import counterReducer from "./counterSlice";

   /*
    * Store 想像成一个仓库，仓库存储很多盒子，我们可以在仓库中找到对应盒子
    * 仓库就是管理对应盒子的地方，仓库中拿取盒子，盒子去修改状态。
    * 目录结构推荐是在 store>index.js
    */

   const store = configureStore({
     reducer: {
       global: counterReducer,
     },
   });

   export default store;
   ```

4. 创建 Redux Provider

   ```Javascript
   import React from "react";
   import { Provider } from "react-redux";
   import store from "./store";

   //在`根组件`中使用Provider包裹，可以使Store的状态变为响应式！

   const App = () => {
     return (
       <Provider store={store}>
         <Counter />
       </Provider>
     );
   };

   export default App;
   ```

5. 组件使用 Redux Store

   ```Javascript
   import React, { useState } from "react";
   import { useSelector, useDispatch } from "react-redux";
   import { increment, decrement } from "./store/modules/counter";//拿取修改状态的函数

   const Counter = () => {
     const count = useSelector((state) => state.global.count);//拿取状态，state是所有的状态，第二个是仓库里面存放的盒子时 `键命`，第三个就是你存储的变量了。

    //通过useSelector可以拿到状态，useDispatch可以触发修改状态的函数。
     const dispatch = useDispatch();

     const handleIncrement = () => {
       dispatch(increment());
     };

     const handleDecrement = () => {
       dispatch(decrement());
     };
      const uploadvalue = () => {
      //不能直接顶层调用，需要在useEffect中调用，会导致丢失响应式
       dispatch(upload(100));
      };

      useEffect(() => {
        //useEffect 必须在组件渲染完后执行，留空是更新的时候执行，会导致重复执行
       uploadvalue();
      }, []);



     return (
       <div>
         <h1>{count}</h1>
         <button onClick={handleIncrement}>Increment</button>
         <button onClick={handleDecrement}>Decrement</button>
       </div>
     );
   };

   export default Counter;
   ```

   在组件中，我们通过 `useSelector` 选择 Redux Store 中的 `count` 状态，并通过 `useDispatch` 获取 Redux Store 的 `dispatch` 方法。

   我们可以点击按钮来触发 Redux Store 的 action 函数，来更新状态。

</details>
