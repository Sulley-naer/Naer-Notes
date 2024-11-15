# Ts_declare 全局声明文件

> [!TIP]
> Ts 全局声明类型，可以让 Js 文件可以使用 Ts 的类型系统，并非直接运行。
>
> 所有填写类型的地方，都可以使用 ts 的类型系统，接口、类、函数等。 直接可以实现接口

## 命名空间声明

```typescript
//使用
MyNamespace.myFunction("hello");

//命名空间就是一个对象，可以包含函数和变量……
declare namespace MyNamespace {
  function myFunction(arg: string): void;
  const myVar: number;
}
```

## 变量声明

```typescript
//使用
console.log(myGlobalVar);

//声明全局变量 const 、let 、var 都可以
declare var myGlobalVar: string;
```

## 函数声明

```typescript
//使用
myFunction("hello");

//声明全局函数
declare function myFunction(arg: string): void;
//多类型参数 | 重载
declare function myFunction(arg: number | string): number;
//回调函数类型，? 表示可选参数
declare function myFunction(callback?: (arg: string) => void): void;
```

## 类声明

```typescript
//使用
const myClass = new MyClass();

//声明全局类
declare class MyClass {
  constructor(name: string);
  sayHello(): void;
}

class MyClass {
  private name: string;
  constructor(public name: string = "world") {}
  sayHello(msg?: string): void {
    if (msg) {
      console.log(`${msg}, ${this.name}!`);
    } else {
      console.log(`Hello, ${this.name}!`);
    }
  }
}
```

## 接口类型

```typescript
//使用
const myInterface: MyInterface = { name: "hello" };

//声明全局接口
interface MyInterface {
  name: string;
  age?: number;
}

function myFunction(arg: MyInterface): void {
  if (arg.age) {
    console.log(`My name is ${arg.name}, and I am ${arg.age} years old.`);
  } else {
    console.log(`My name is ${arg.name}.`);
  }
}
```

## 类型别名

```typescript
//使用
const myType: MyType = "hello";

//声明全局类型别名
declare type MyType = string | number;
```

## Vue 组件 Props 声明

```typescript
//使用
<template>
  <Mybutton size="small" type="primary" disabled>
    默认
  </Mybutton >
</template>

//声明全局组件 Props

declare type size = "small" | "medium" | "large";

declare interface ButtonProps {
  size?: size;
  type?: "primary" | "success" | "warning" | "danger";
  disabled?: boolean;
  onClick?: (event: MouseEvent) => void;
}

//组件
<template>
  <button
    :class="{
      [`btn-${size}`]:size,
      [`btn-${type}`]:type,
      "is-disabled":disabled
    }">
      <slot></slot>
  </button>
</template>;

<script lang="ts" setup>
//Vue 提供 defineProps 定义 props 类型
defineProps<buttonProps>();
</script>;
```
