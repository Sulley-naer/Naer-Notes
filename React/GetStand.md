# GetStand

> 使用 Vite + React + Typescript 项目

```bash
# 安装依赖
npm create vite@latest my-react-app -- --template react-ts
```

> [!TIP]
> 核心依赖：React + React-dom + Typescript + Vite

## 目录结构

```node
my-react-app
├── node_modules
├── public
│   ├── index.html
│   └── favicon.ico
├── src
│   ├── App.tsx
│   ├── index.css
│   ├── index.tsx
│   ├── react-app-env.d.ts
│   └── setupTests.ts
├── package.json
├── tsconfig.json
├── vite.config.ts
├── index.html
└── README.md
```

1. `node_modules`：依赖包
2. `public`：静态资源 `/file` 使用
3. `src`：源码目录
4. `package.json`：项目配置文件
5. `tsconfig.json`：TypeScript 配置文件
6. `vite.config.ts`：Vite 配置文件
7. `index.html`：入口 HTML 文件
8. `README.md`：项目说明文件

## 入口函数

Src/main.tsx 是项目的入口文件，入口文件是在 index.html 唯一直接引用的 JS 文件。

绑定根元素渲染可操作的虚拟 Dom ，并使用 Module 模式导入其他 React 组件。

> [!TIP]
> 虚拟 DOM: 即描述页面结构的一种数据结构，它是由标签、属性、文本内容等组成的树形结构。
>
> React 通过 `babel` 解析器使用 JSX 语法将 JSX 代码转换成 DOM 最终渲染到页面上。
>
> React 对元素的操作方法都是在解析器转换过程之前执行的。
>
> `StrictMode` 入口函数中使用次标签，代表使用 React 的严格模式，可以帮助你发现潜在的错误。

## 组件

React 组件是 React 应用的基本单元，组件可以组合成更复杂的组件，组件可以包含 JSX 语法，可以包含 JavaScript 逻辑，可以包含样式,组件命名需首字母大写，用于区分函数等变量.

### 组件类型

> [!TIP]
> 组件都需要 Module 语法 `export default` 导出，在需要使用的时候导入进来，再通过 JSX 语法使用。
>
> 根组件一般命名为 `App`，入口函数会导入并渲染，再 App 组件中去渲染其他组件。

React 组件可以分为三种类型：

1. 函数组件：函数组件是纯 JavaScript 函数，它接受 props 作为输入，返回 JSX 元素作为输出。

   <details>
   <summary>示例</summary>

   ```jsx
   function Greeting(props) {
     return <h1>Hello, {props.name}!</h1>;
   }

   function App() {
     return <Greeting name="小米" />;
   }

   export default App;
   ```

   </details>

2. 类组件：类组件是 React.Component 的子类，它可以包含状态和生命周期方法。

   <details>
   <summary>示例</summary>

   ```jsx
   class Greeting extends React.Component {
     render() {
       return <h1>Hello, {this.props.name}!</h1>;
     }
   }

   class App extends React.Component {
     render() {
       return <Greeting name="小米" />;
     }
   }

   export default app;
   ```

   </details>

3. 受控组件：受控组件是指组件的状态由父组件管理，子组件只负责渲染。

   <details>
   <summary>示例</summary>

   ```jsx
   class Input extends React.Component {
     constructor(props) {
       super(props);
       this.state = { value: "" };
     }

     handleChange = (event) => {
       this.setState({ value: event.target.value });
     };

     render() {
       return (
         <div>
           <input
             type="text"
             value={this.state.value}
             onChange={this.handleChange}
           />
           <p>You typed: {this.state.value}</p>
         </div>
       );
     }
   }
   export default Input;
   ```

   </details>

## React 操作方法集

> React 中用来操作元素的方法，包括 `循环生成`，`事件绑定`, `条件渲染`, `状态管理`, `生命周期` 等。

## 插值表达式

React 使用 JSX 语法来描述组件的结构，JSX 语法可以直接在 JSX 元素中嵌入 JavaScript 表达式，这些表达式会在组件渲染时求值。

```jsx
const name = "小米";
const age = 25;

function Greeting() {
  return <h1>Hello, {name}!</h1>;
}

function App() {
  return (
    <div>
      <Greeting />
      <p>I am {age} years old.</p>
    </div>
  );
}

ReactDOM.render(<App />, document.getElementById("root"));
```

## 样式

React 中可以使用 CSS 样式，通过 JSX 语法直接在 JSX 元素中嵌入样式。

```jsx
import "./index.css";

function App() {
  return (
    <div>
      <h1 style={{ color: "red" }}>Hello, 小米!</h1>
      <p style={{ fontSize: "20px" }}>I am 25 years old.</p>
      <p className="my-class">I am a paragraph.</p>
    </div>
  );
}
```

1. `style`：一个对象，用来设置 JSX 元素的样式
2. `color`：CSS 样式属性，用来设置文本颜色
3. `fontSize`：CSS 样式属性，用来设置字体大小

> [!TIP]
> 类名动态控制推荐使用 `classNames` 库 ，它可以在 classnName 传递对象 `键为类名`，`值是布尔` 控制样式是否生效。
>
> `classNames={classNames("default-class", { active: isActive })}`

## 循环生成

React 中可以使用 `map` 方法来循环生成 JSX 元素。

```jsx
function List() {
  const names = ["小米", "苹果", "华为"];
  return (
    <ul>
      {names.map((name) => (
        <li key={name}>{name}</li>
      ))}
    </ul>
  );
}
```

1. `names`：一个数组，包含要渲染的元素
2. `map` 方法：遍历数组，返回 JSX 元素
3. `Key` React 内部标识符，提升渲染效率

## 条件渲染

React 中可以使用 `if` 语句来条件渲染 JSX 元素。

```jsx
const show = flase;

function Greeting(props) {
  //通常多条件使用，根据参数返回不同的 JSX 元素
  if (props.show) {
    return <h1>Hello, {props.name}!</h1>;
  } else {
    return null;
  }
}

function App() {
  return (
    <div>
      <Greeting name="小米" show={true} />
      <Greeting name="苹果" show={false} />
      {show && <span> Show is true </span>}
      {show ? <span> Show is true </span> : null}
    </div>
  );
}
```

1. `show`：一个布尔值，用来控制是否渲染 JSX 元素
2. `null`：React 元素，用来表示空值
3. `props` React 元素，在触发事件时传递的`对象`，里面有标签中的属性。

## 事件绑定

React 中可以使用 `bind` 方法来绑定事件。

```jsx
class Input extends React.Component {
  // 构造函数 super 调用父类构造函数
  constructor(props) {
    super(props);
    this.state = { value: "" };
  }

  handleChange = (event) => {
    this.setState({ value: event.target.value });
  };

  clickHandler = (parms, event) => {
    //多参数需要event对象
    console.log(parms);
    console.log(event.target.value);
  };

  render() {
    return (
      <div>
        <input
          type="text"
          value={this.state.value}
          onChange={this.handleChange}
          onClick={(e) => clickHandler("123", e)}
        />
        <p>You typed: {this.state.value}</p>
      </div>
    );
  }
}

export default Input;
```

1. `handleChange`：一个函数，用来处理事件
2. `onChange`：React 元素的属性，用来绑定事件
3. `event`：事件对象，包含事件相关信息

## Hooks

React 16.8 版本引入了 Hooks，它可以让函数组件中使用状态和其他 React 特性，而无需使用 class。

> [!TIP]
> 规则:
>
> 1. 只能在`函数组件`中使用 Hooks
> 2. Hooks 不能在`条件`和`循环语句`中调用，只能在函数组件的`顶层`调用
> 3. 只能在`函数组件`中使用 Hooks，不能在类组件中使用

### useState ⭐

useState 是一个函数，它可以让函数组件中使用状态。

> [!CAUTION]
> 响应是数据修改必须调用`更新函数`修改，直接修改会丢失响应状态。
>
> 数组类型推荐使用: 添加: `concat`、`...arr` 、删除: `filter`、`splice` 修改: `map`、`filter`、`reduce` 排序: `...arr` `arr.reverse()`
>
> 对象类型推荐使用:`...obj` 展开再添加新 键值，可以直接覆盖实现修改

1. `useState`：一个函数，用来声明状态变量和状态更新函数
2. `count`：状态变量，初始值为 0
3. `setCount`：状态更新函数，用来更新状态变量

```jsx
import React, { useState } from "react";

function Counter() {
  //第一个参数是变量，第二个是更新函数
  const [count, setCount] = useState(0);

  //响应式对象
  const [name, setName] = useState({ name: "小米", age: 25 });

  const UpdateName = () => {
    //对象更新，必须先展开之前的对象，然后修改你的参数，否则丢失响应式
    setName({ ...name, name: "苹果" });
  };

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
      <p>Your name is {name.name}</p>
      <button onClick={() => setName({ name: "苹果", age: 26 })}>
        Change name
      </button>
    </div>
  );
}

export default Counter;
```

### useTransition ⭐

React `useTransition` 钩子，可以在不影响渲染的情况下，更新状态的 `hook`

`useState` 类似，它可以在状态更新的时候，不立刻调用渲染，而是在后面静默的更新，完成之后再更新 Dom。

```jsx
import { useTransition, useState } from "react";

function App() {
  const [count, setCount] = useState(0);
  const [isPending, startTransition] = useTransition({
    timeoutMs: 2000, //超时时间
  });

  const handleClick = () => {
    startTransition(() => {
      setCount(count + 1);
    });
  };

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={handleClick}>Click me</button>
      {isPending && <p>Pending...</p>}
    </div>
  );
}

export default App;
```

1. `isPending` ，告诉你是否存在待处理的 transition。
2. `startTransition` 更新函数，你可以使用此方法将状态更新标记为 transition。

### ref ⭐

React 中可以使用 `ref` 来获取组件实例。

```jsx
import React, { useState, useRef } from "react";

function Input() {
  const [value, setValue] = useState("");

  //Ref 用来获取组件 元素 实例
  const inputRef = useRef(null);

  const handleClick = () => {
    //element.current 指向元素实例
    inputRef.current.focus();
  };

  return (
    <div>
      <input
        type="text"
        value={value}
        onChange={(e) => setValue(e.target.value)}
      />
      <button onClick={handleClick}>Focus</button>
    </div>
  );
}

export default Input;
```

1. `useRef`：一个函数，用来声明 ref 对象
2. `inputRef`：一个 ref 对象，用来获取组件 元素 实例
3. `current`：一个属性，指向组件 元素 实例
4. `focus`：一个方法，用来聚焦元素

#### 注意事项

> [!TIP]
>
> 1. 如果你拿取不到 Dom 实例，应该是使用了自定义标签或者组件函数，因此无法直接绑定 ref。

解决办法：

1. 使用 `forwardRef` 组件，将自定义组件包装成一个可以拿取 ref 的组件。
2. 使用 `useImperativeHandle` 钩子，将自定义组件的实例暴露给父组件。

```jsx
import React, { forwardRef, useImperativeHandle } from "react";

function Input(props, ref) {
  const inputRef = useRef(null);

  useImperativeHandle(ref, () => ({
    focus: () => {
      inputRef.current.focus();
    },
  }));

  return <input type="text" ref={inputRef} {...props} />;
}

//官方文档案例,简写直接拿 props 获取标签属性

const MyInput = forwardRef(({ value, onChange }, ref) => {
  return <input value={value} onChange={onChange} ref={ref} />;
});

export default forwardRef(Input);
```

1. `forwardRef`：一个函数，用来将自定义组件包装成一个可以拿取 ref 的组件
2. `useImperativeHandle`：一个钩子，用来将自定义组件的实例暴露给父组件
3. `ref`：一个参数，用来拿取组件实例
4. `focus`：一个方法，用来聚焦元素

### context ⭐

React 中可以使用 `context` 来实现跨组件数据共享。

```jsx
import React, { createContext, useState } from "react";

const msg = createContext();

function Parent() {
  const [name, setName] = useState("小米");

  return (
    <msg.Provider value={{ name, setName }}>
      <Child />
    </msg.Provider>
  );
}

function Child() {
  const { name, setName } = React.useContext(msg);

  return (
    <div>
      <p>Hello, {name}!</p>
      <button onClick={() => setName("苹果")}>Change name</button>
    </div>
  );
}

//父组件调用子组件

return (
  <>
    <Parent />
  </>
);
```

1. `createContext`：一个函数，用来创建上下文对象
2. `Provider`：一个组件，用来提供上下文
3. `useContext`：一个函数，用来消费上下文
4. `name`：一个状态变量，用来存储数据
5. `setName`：一个方法，用来修改数据

### useEffect ⭐

useEffect 是一个函数，它可以让函数组件中执行副作用操作，比如数据获取、设置、订阅、取消订阅等。

1. `无依赖`：省略第二个参数，useEffect 会在组件更新和完成渲染时执行
2. `变量`：参数，用来指定 useEffect 仅在 变量 变化时执行
3. `[]`：一个空数组，用来指定 useEffect 仅在组件挂载和卸载时执行

```jsx
import React, { useState, useEffect } from "react";

function App() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    const intervalId = setInterval(() => {
      setCount(count + 1);
    }, 1000);
    //清理负作用，定时器会在组件卸载时清除
    return () => {
      clearInterval(intervalId);
    };
  }, [count]);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
    </div>
  );
}

export default App;
```

### useEffect 和 useLayoutEffect

useEffect 和 useLayoutEffect 都是用来处理副作用操作的，但是两者的区别是：

1. useEffect：在浏览器完成布局和绘制之后， useEffect 内部的函数才会执行。
2. useLayoutEffect：useEffect 内部的函数在浏览器完成布局之前执行，useLayoutEffect 内部的函数在浏览器完成布局和绘制之后执行。

```jsx
//useEffect，第二个参数有三种情况，无参数就在组件更新，渲染完成时执行,空数组则就在初始化渲染完成时执行,有参数则在参数变化时执行
import React, { useState, useEffect, useLayoutEffect } from "react";

function App() {
  //参数必须是响应式，否者 useEffect 不会执行
  const [count, setCount] = useState(0);

  //useEffect 在浏览器完成布局和绘制之后， useEffect 内部的函数才会执行
  useEffect(() => {
    console.log("useEffect"); //在Vue 中是 mounted
    return () => {
      console.log("useEffect clean up");
    };
  }, [count]);

  //useLayoutEffect 在浏览器完成布局之前执行，useLayoutEffect 内部的函数在浏览器完成布局和绘制之后执行
  useLayoutEffect(() => {
    console.log("useLayoutEffect");
    return () => {
      console.log("useLayoutEffect clean up");
    };
  }, [count]);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
    </div>
  );
}

export default App;
```

### 自定义 Hook

自定义 Hook 可以让函数再多个组件之间代码复用，方便复用，比如 bool 切换

```jsx
import React, { useState, useEffect } from "react";

function useBool(initialValue = false) {
  const [value, setValue] = useState(initialValue);

  const toggle = () => {
    setValue(!value);
  };

  return [value, toggle];
}

function App() {
  const [show, toggle] = useBool(false);

  return (
    <div>
      <p>You clicked {show ? "true" : "false"} times</p>
      <button onClick={() => toggle()}>Click me</button>
    </div>
  );
}

export default App;
```

### Suspense ⭐

React 16.6 版本引入了 `Suspense` 组件，它可以在组件更新时候触发，从而控制显示加载中元素。

当内容正在加载时显示的占位符，可以用来提升用户体验。

```jsx
import { Suspense } from "react";
import Albums from "./Albums.js";

export default function ArtistPage({ artist }) {
  return (
    <>
      <h1>{artist.name}</h1>
      <Suspense fallback={<Loading />}>
        <Albums artistId={artist.id} />
      </Suspense>
    </>
  );
}

function Loading() {
  return <h2>🌀 Loading...</h2>;
}
```

### UseDeferredValue

React 18 版本引入了 `useDeferredValue` 钩子，它可以实现延迟渲染，即只有在组件渲染时才渲染组件。

```jsx
import { useDeferredValue, useState, Suspense } from "react";

function App() {
  const [query, setQuery] = useState("");
  const deferredQuery = useDeferredValue(query);
  return (
    <>
      <label>
        Search albums:
        <input value={query} onChange={(e) => setQuery(e.target.value)} />
      </label>
      <Suspense fallback={<h2>Loading...</h2>}>
        <SearchResults query={deferredQuery} />
      </Suspense>
    </>
  );
}
```

1. `useDeferredValue`：一个钩子，用来实现延迟渲染
2. `value`：一个状态变量，用来存储数据
3. `deferredValue`：一个变量，用来存储延迟渲染的数据
4. `timeoutMs`：一个参数，用来设置延迟时间

### Lazy ⭐

React 18 版本引入了 `lazy` 组件，它可以实现懒加载，即只有在组件渲染时才加载组件。

```jsx
import React, { Suspense, lazy } from "react";

const OtherComponent = lazy(() => import("./OtherComponent"));

function App() {
  return (
    <div>
      <Suspense fallback={<div>Loading...</div>}>
        <OtherComponent />
      </Suspense>
    </div>
  );
}

export default App;
```

1. `lazy`：一个函数，用来实现懒加载
2. `Suspense`：一个组件，用来实现懒加载
3. `fallback`：一个 JSX 元素，用来显示加载中的提示
4. `import`：一个函数，用来动态导入组件

## 特殊方法

### 双向绑定

React 中可以使用 `ref` 来实现双向绑定。

```jsx
import React, { useState, useRef } from "react";

function Input() {
  const [value, setValue] = useState("");

  //Ref 用来获取组件 元素 实例
  const inputRef = useRef(null);

  //手动调用更新函数，实现双向绑定
  const handleChange = (event) => {
    //拿取元素中的值
    setValue(event.target.value);
  };

  const handleClick = () => {
    //element.current 指向元素实例
    inputRef.current.focus();
  };

  return (
    <div>
      <input type="text" value={value} onChange={handleChange} ref={inputRef} />
      <button onClick={handleClick}>focus</button>
    </div>
  );
}
export default Input;
```

## 组件通讯

React 中可以使用 `props` 和 `context` 来实现组件通讯。

### 父子组件通讯

#### 父传子：父组件通过 `props` 向子组件传递数据，子组件通过 `props` 接收数据

```jsx
//父组件
function Parent() {
  return <Child name="小米" />;
}

//子组件
function Child(props) {
  //Props 的数据不能直接修改，它是只读属性否则异常
  return <p>Hello, {props.name}!</p>;
}

//父组件调用子组件

return (
  <>
    <Parent />;
  </>
);
```

1. `props`：一个对象，用来传递数据
2. `name`：一个属性，用来接收数据

#### 子传父：子组件通过 `props` 向父组件传递数据，父组件通过 `props` 接收数据

```jsx
//子组件
function Child(props) {
  //调用父组件的方法，并传递参数
  props.handleClick("I am child");
  return null;
}

//父组件
function Parent() {
  //定义响应式变量，用于收到子组件信息后，渲染到页面上去
  const [name, setName] = useState("");

  const handleClick = (name) => {
    setName(name);
  };

  return (
    <div>
      <p>Hello, {name}!</p>
      {/* props 定义属性调用函数 */}
      <Child handleClick={handleClick} />
    </div>
  );
}

//父组件调用子组件

return (
  <>
    <Parent />
  </>
);
```

1. `props`：一个对象，用来传递数据
2. `handleClick`：一个方法，用来接收数据
3. `name`：一个状态变量，用来存储数据

### 兄弟组件通讯

兄弟组件通讯可以借助 `context` 来实现，还有一种通过 `props` 传递数据的方式，但不推荐。

```jsx
//父组件
const context = React.createContext();

function Parent() {
  const [name, setName] = useState("");

  return (
    <context.Provider value={{ name, setName }}>
      <Child />
      <Child />
    </context.Provider>
  );
}

//子组件
function Child() {
  const { name, setName } = React.useContext(context);

  return (
    <div>
      <p>Hello, {name}!</p>
      <button onClick={() => setName("小米")}>Change name</button>
    </div>
  );
}

//父组件调用子组件

return (
  <>
    <Parent />
  </>
);
```

1. `createContext`：一个函数，用来创建上下文对象
2. `Provider`：一个组件，用来提供上下文
3. `useContext`：一个函数，用来消费上下文
4. `name`：一个状态变量，用来存储数据
5. `setName`：一个方法，用来修改数据

## 插槽

React 中可以使用 `slot` 来实现组件插槽。

1. `slot`：一个 HTML 标签，用来定义组件插槽
2. `default`：一个插槽，用来定义默认插槽
3. `named`：一个插槽，用来定义命名插槽

```jsx
//父组件
function Parent() {
  return <Child>父默认插槽</Child>;
}

//子组件
function Child(props) {
  return (
    <div>
      <h1>子组件</h1>
      <slot>子默认插槽</slot>
      <slot name="left">左边插槽</slot>
      <slot name="right">右边插槽</slot>
    </div>
  );
}
//父组件调用子组件

return (
  <>
    <Parent />
    <Parent>
      <span>渲染时默认插槽</span>
      <span slot="left">父组件修改左边插槽</span>
      <span slot="right">父组件修改右边插槽</span>
    </Parent>
  </>
);
```
