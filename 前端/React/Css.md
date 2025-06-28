# React Css

> [!TIP]
> React 本身不为组件单独提供样式的解决方案，Jsx 直接写 `Style` 标签导致浏览器频繁渲染，影响性能。

## Styled-Components

Styled-Components 是 React 中用于解决样式问题的库，它可以让我们在 JSX 中使用类似 CSS 的语法来写样式，并且可以将样式封装成组件，使得样式代码和组件代码分离，提高代码的可维护性。

### 安装

```bash
npm install --save styled-components -D
```

## 快速上手

```jsx
import React from "react";
import styled, { css } from "styled-components";

const Title = styled.h1`
  font-size: 24px;

  //动态样式
  color: ${(props) => props.color || "#333"};

  &:hover {
    color: #666;
  }

  & span {
    //组件内部的标签样式
    color: red;
  }

  & ~ & {
    //当前组件出现多次时候，会在除开第一个里面添加的样式
    margin-top: 10px;
  }

  & + & {
    //组件出现多次，并且紧挨着的时候，就会添加
  }

  &.active {
    //当前组件有 active 类名的时候，会添加的样式
  }
`;

const App = () => {
  return (
    <div>
      <Title>Hello World</Title>
      <Title>Hello World</Title>
      <Title>Hello World</Title>
    </div>
  );
};

export default App;
```

## 样式隔离

Styled-Components 提供了 `styled` 方法来创建组件，并且可以将样式封装成组件，使得样式代码和组件代码分离，提高代码的可维护性。

```jsx
import React from "react";
import styled from "styled-components";

const Title = styled.h1`
  font-size: 24px;
  color: #333;
`;

const SubTitle = styled.h2`
  font-size: 18px;
  color: #666;
`;

const App = () => {
  return (
    <div>
      <Title>Hello World</Title>
      <SubTitle>This is a subtitle</SubTitle>
    </div>
  );
};

export default App;
```

## 动态样式

Styled-Components 提供了 `css` 方法来动态设置样式，可以根据 props 动态设置样式。

```jsx
import React from "react";
import styled, { css } from "styled-components";

const Title = styled.h1`
  font-size: 24px;
  //推荐写成这样，如果没有 props.color，默认是#333
  color: ${(props) => props.color || "#333"};
  //多个属性需要修改时，推荐写法
  ${(props) =>
    props.color &&
    css`
      color: ${props.color};
    `}
`;

const App = () => {
  return (
    <div>
      <Title color="#333">Hello World</Title>
      <Title color="#666">This is a subtitle</Title>
    </div>
  );
};

export default App;
```

## 全局样式

Styled-Components 提供了 `createGlobalStyle` 方法来创建全局样式，可以将样式封装成组件，使得样式代码和组件代码分离，提高代码的可维护性。

```jsx
import React from "react";
import styled, { createGlobalStyle } from "styled-components";

const GlobalStyle = createGlobalStyle`
  body {
    margin: 0;
    padding: 0;
    font-family: sans-serif;
  }
`;

const Title = styled.h1`
  font-size: 24px;
  color: #333;
`;

const App = () => {
  return (
    <div>
      {/* 全局样式尽量放在根组件中 */}
      <GlobalStyle />
      <Title>Hello World</Title>
    </div>
  );
};

export default App;
```

## Animations

Styled-Components 提供了 `keyframes` 方法来创建动画，可以将动画封装成组件，使得动画代码和组件代码分离，提高代码的可维护性。

```jsx
import React from "react";
import styled, { keyframes } from "styled-components";

const rotate = keyframes`
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
`;

const Title = styled.h1`
  font-size: 24px;
  color: #333;
  animation: ${rotate} 2s linear infinite;
`;

const App = () => {
  return <Title>Hello World</Title>;
};

export default App;
```

## 嵌套选择器 预处理器

Styled-Components 先天直接支持使用嵌套语法，预处理器也是直接支持。

```jsx
import React from "react";
import styled, { createGlobalStyle } from "styled-components";

const GlobalStyle = createGlobalStyle`
  body {
    margin: 0;
    padding: 0;
    font-family: sans-serif;
  }
`;

const Title = styled.h1`
  font-size: 24px;
  color: #333;
  //默认是嵌套语法，由于是通过组件注册的样式，能出现元素的位置，只可能在组件里面
  //里面的标签少,就可以不需要使用嵌套语法,但是层数多了就不能这样写,使用预处理器就能解决这个问题
  & span {
    //& 代表当前组件下的元素
    color: red;
  }
`;

const App = () => {
  return (
    <div>
      <GlobalStyle />
      <Title>
        <span>Hello</span> World
      </Title>
    </div>
  );
};

export default App;
```

## 多态属性

Styled-Components 提供了 `attrs` 方法来设置多态样式，可以根据 props 动态设置 组件的属性。

```jsx
import React from "react";
import styled from "styled-components";

const Title = styled.h1.attrs({
  //当 props.active 为 true 时，添加 active 类名
  className: (props) => props.active && "active",
  //也可以设置其他属性
  Type: "password",
  size: props.size || "12px",
})`
  font-size: 24px;
  color: #333;
`;

const App = () => {
  return (
    <div>
      <Title active>Hello World</Title>
      <Title>This is a subtitle</Title>
    </div>
  );
};

export default App;
```

## 继承样式

Styled-Components 提供了 `extend` 方法来继承样式，可以将样式从一个组件继承到另一个组件。

```jsx
import React from "react";
import styled from "styled-components";

const button=styled.button`
  background-color: #333;
  color: #fff;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
`;
//继承样式，并且覆写
const PrimaryButton=styled(button)`
  background-color: #666;
`;

const App = () => {
  return (
    <div>
      <button>Default Button</button>
      <PrimaryButton>Primary Button</PrimaryButton>
    </div>
  );
};

## 参考

- [Styled-Components](https://styled-components.com/)
- [Styled-Components 中文文档](https://www.styled-components.com/docs/basics)
- [Styled-Components 官方文档](https://styled-components.com/docs/api)
- [Styled-Components 预处理器](https://styled-components.com/docs/tooling#preprocessors)
- [Styled-Components 动态样式](https://styled-components.com/docs/basics#adapting-based-on-props)
```
