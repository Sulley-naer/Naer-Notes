# Typescript 强类型语言([TypeScript](https://www.typescriptlang.org/zh))

Q: 什么是Typescript?

A: TypeScript 是 JavaScript 的一个超集，支持 ECMAScript 6 标准，TypeScript 由微软开发的自由和开源的编程语言。

Q: 为什么要使用Typescript?

A: TypeScript 增加了代码的可读性和可维护性，同时还能让你定义代码结构，提高代码的质量。

Q: Typescript的优点有哪些?

A: 
1. 增加了代码的可读性和可维护性
1. 静态类型检查
2. 支持ES6标准
3. 更好的代码提示
4. 更好的重构
5. 更好的语法
6. 更好的面向对象编程
7. 更好的工具支持
8. 更好的生态系统
9.  更好的大型项目的支持

Q: Typescript的缺点有哪些?

A: 
1. 有一定的学习成本
1. 项目初期会增加一些开发成本
2. 集成到构建流程需要一些工作量
3. 可能和一些库结合的不是很完美
4. 短期可能会增加一些开发成本

## Typescript的安装

```al
npm install -g typescript
```

## Typescript的使用

> 普通项目中使用Typescript

1. 初始化项目

```al
npm init -y
```

2.安装Typescript

```al
npm install typescript
```

3.创建tsconfig.json文件

```json
{
  "compilerOptions": {
    "target": "es5",
    "module": "commonjs",
    "outDir": "./dist",
    "strict": true
  }
}
```

4..编写Typescript代码

```ts
// index.ts
function greeter(person: string) {
    return "Hello, " + person;
}

let user = "Jane User";

document.body.innerHTML = greeter(user);
```

5.编译Typescript代码

```al
tsc index.ts
```

6.运行编译后的js代码

```al
node index.js
```

> 在Vue/cli框架升级使用typescript 新建勾选Typescript

1. 在Vue ui Plugins 中添加`@vue/cli-plugin-typescript` 勾选默认配置即可
2. 卸载jquery 并且重新安装`npm uninstall jquery` 
3. 重新安装type版本`jquery npm install @types/jquery --save-dev`
4. 配置tsconfig 使入口函数能正常使用

```json
"types": [
      "webpack-env",
      "jquery"
    ],
    "paths": {
      "@/*": [
        "src/*"
      ]
    },
    "lib": [
      "esnext",
      "dom",
      "dom.iterable",
      "scripthost"
    ]
-----------------------
//添加后缀识别，与 `compilerOptions` 同级
  "include": [
    "src/**/*.ts",
    "src/**/*.tsx",
    "tests/**/*.ts",
    "tests/**/*.tsx",
    "src/main.js"
    // "src/**/*.vue"
  ],
  "exclude": [
    "node_modules"
  ]
```

1. 确保依赖齐全 -dex 为开发环境
```
npm install typescript --save-dev
npm install @vue/cli-plugin-typescript --save-dev
npm install @types/node --save-dev
npm install @types/jquery --save-dev
```

## Typescript 语法

智能识别类型

```typescript
let helloWorld = "Hello World";
    //let helloWorld: string
```

对象类型 name : string  id : number

```typescript
const user = {
  name: "Hayes",
  id: 0,
};
```

接口 遵守规则 否则警告

```typescript
interface User {
  name: string;
  id: number;
}
// ---分割线---
const user: User = {
  name: "Hayes",
  id: 0,
};
```

面向对象
```typescript
interface User {
  name: string;
  id: number;
}

class UserAccount {
  name: string;
  id: number;

  constructor(name: string, id: number) {
    this.name = name;
    this.id = id;
  }
}

const user: User = new UserAccount("Murphy", 1);
```

参数对接口

```typescript
//注意用 ; 隔开
interface User {
  name: string;
  id: number;
}

/* ---分割线--- */

//参数 : 限制返回值类型
function getAdminUser(): User {
  const user:User={
    name:"s",
    id:1
  }
  return user
}
//参数 : 限制参数类型 可直接写 string number
function deleteUser(user: User):void {
  // ...
}
```

组合类型

```typescript
// true|false = boolean
interface User {
  name: string;
  id: 1|2;
}
// id值会抛错
const user:User={
    name:"s",
    id:3
}
```

根据参数返回对象

```typescript
function wrapInArray(obj: string | string[]) {
  if (typeof obj === "string") {
    return [obj];
  }
  return obj;
}
```

数组 泛型

```typescript
// type 自己选择类型 var let
type StringArray = Array<string>;
type NumberArray = Array<number>;
type ObjectWithNameArray = Array<{ name: string }>;
```

自声明泛型类型

```typescript
interface Backpack<Type> {
  add: (obj: Type) => void;
  get: () => Type;
}

// 简写，声明`backpack`常量，限制类型
declare const backpack: Backpack<string>;

// declare类型不能直接使用，相当于实例化对象
const object = backpack.get();

// 因为 backpack 限制为字符串，数字抛错。
backpack.add(23);

//declare 为ts 语言单独类型，他只是用来限制类型的，用于代码方便操作，js本身不支持，只能在转义过程使用
```

实际使用

```typescript
interface Point {
  x: number;
  y: number;
}

function logPoint(p: Point) {
  console.log(`${p.x}, ${p.y}`);
}

// 打印 "12, 26"
const point = { x: 12, y: 26 };
logPoint(point);

const point3 = { x: 12, y: 26, z: 89 };
logPoint(point3); // 打印 "12, 26"

const rect = { x: 33, y: 3, width: 30, height: 80 };
logPoint(rect); // 打印 "33, 3"
```

## 因最后ts终将换为js,限制也将不复存在，它只能用在开发阶段，防止bug之类

### 如果不是大项目使用就是sb
