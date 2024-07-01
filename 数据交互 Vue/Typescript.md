# Typescript 强类型语言([TypeScript](https://www.typescriptlang.org/zh))

Q: 什么是 Typescript?

A: TypeScript 是 JavaScript 的一个超集，支持 ECMAScript 6 标准，TypeScript 由微软开发的自由和开源的编程语言。

Q: 为什么要使用 Typescript?

A: TypeScript 增加了代码的可读性和可维护性，同时还能让你定义代码结构，提高代码的质量。

Q: Typescript 的优点有哪些?

A:

1. 增加了代码的可读性和可维护性
2. 静态类型检查
3. 支持 ES6 标准
4. 更好的代码提示
5. 更好的重构
6. 更好的语法
7. 更好的面向对象编程
8. 更好的工具支持
9. 更好的生态系统
10. 更好的大型项目的支持

Q: Typescript 的缺点有哪些?

A:

1. 有一定的学习成本
2. 项目初期会增加一些开发成本
3. 集成到构建流程需要一些工作量
4. 可能和一些库结合的不是很完美
5. 短期可能会增加一些开发成本

## Typescript 的安装

```al
npm install -g typescript
```

## Typescript 的使用

> 普通项目中使用 Typescript

1. 初始化项目

```al
npm init -y
```

2.安装 Typescript

```al
npm install typescript
```

3.创建 tsconfig.json 文件

```json
{
  "compilerOptions": {
    // 编译选项 编译目标 es3 es5 es6 等
    "target": "es5",
    "module": "commonjs",
    "outDir": "./dist",
    "strict": true
  }
}
```

4..编写 Typescript 代码

```ts
// index.ts
function greeter(person: string | number) {
  return "Hello, " + person;
}

let user = "Jane User";

document.body.innerHTML = greeter(user);
```

5.编译 Typescript 代码

```al
tsc index.ts
```

6.运行编译后的 js 代码

```al
node index.js
```

> 在 Vue/cli 框架升级使用 typescript 新建勾选 Typescript

1. 在 Vue ui Plugins 中添加`@vue/cli-plugin-typescript` 勾选默认配置即可
2. 卸载 jquery 并且重新安装`npm uninstall jquery`
3. 重新安装 type 版本`jquery npm install @types/jquery --save-dev`
4. 配置 tsconfig 使入口函数能正常使用

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

```base
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

对象类型 name : string id : number

```typescript
const user = {
  name: "Hayes",
  id: 0,
};
```

## 遵守类型规则 否则警告

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

## 面向对象

```typescript
//接口
interface User {
  name: string;
  id: number;
}
//类
class UserAccount {
  name: string;
  id: number;
  //构造函数
  constructor(name: string, id: number) {
    this.name = name;
    this.id = id;
  }
}

const user: User = new UserAccount("Murphy", 1);
```

## 接口 数据类型 限制

```typescript
//注意用 ; 隔开
interface User {
  name: string;
  id: number;
}

/* ---分割线--- */

//参数 : 限制返回值类型 在形参后冒号
function getAdminUser(): User {
  const user: User = {
    name: "s",
    id: 1,
  };
  return user;
}
//参数 : 限制参数类型 可直接写 string number
function deleteUser(user: User): void {
  // ... void无返回值
}
```

## 组合类型

```typescript
// 定义接口，限制数据结构
interface User {
  name: string;
  id: 1 | 2;
}
// id值会抛错
const user: User = {
  name: "s",
  id: 3,
};
```

## 根据参数返回对象

```typescript
function wrapInArray(obj: string | string[]) {
  if (typeof obj === "string") {
    return [obj];
  }
  return obj;
}
```

## 数组 泛型 List<类型> 同理

```typescript
// type 自己选择类型 var let
type StringArray = Array<string>;
type NumberArray = Array<number>;
type ObjectWithNameArray = Array<{ name: string }>;
```

## 自声明泛型类型

> **接口定义结构** 用于数据限制 类和变量均能 限能接口类型

```typescript
// 声明接口 定义泛型类型 类型
//接口可重复声明 属性叠加 属性可重复定义 不能定义方法
interface Backpack<Type> {
  add: (obj: Type) => void;
  get: () => Type;
}

// 引用接口 修改类型
declare const backpack: Backpack<string>;

// 无法调用方法 因为 declare 只是限制类型，并未实例化
const object = backpack.get();

// 实例化接口 并调用方法
class myBackpack implements Backpack<string> {
  add(obj: string) {
    this.items.push(obj);
  }
  get() {
    return this.items.join(", ");
  }
}

// 因为 backpack 限制为字符串，数字抛错。
backpack.add(23);

//declare 为ts 语言单独类型，他只是用来限制类型的，用于代码方便操作，js本身不支持，只能在转义过程使用
```

## 类的使用

```typescript
// 类 前面加abstract 则为抽象类 只能被继承不能实例化 拟似接口
/* abstract */ class Animal {

  // 设置为公共属性
  public name: string;

  //构造函数
  constructor(theName: string) {
    this.name = theName;
  }
  // 方法
  move(distanceInMeters: number = 0) {
    console.log(`${this.name} moved ${distanceInMeters}m.`);
  }
}

// 继承类
class Dog extends Animal {
  age: number;
  constructor(name: string, age: number) {
    //继承类 重写构造函数通常 需要调用一次父类构造函数 再进行自己的构造函数
    //否则父类构造函数功能缺失，子类需要重新实现其功能，造成代码冗余，逻辑上沦为接口|抽象类
    super(theName: name);
    this.age = age;
    }
  // 继承父类 并且 重写「添加」方法
  bark() {
    console.log(`${this.name} barked.`);
  }
}
// 创建实例
const myDog = new Dog(theName: "Rufus");
myDog.move(30);
myDog.bark();
```

接口的使用

```typescript
// 接口
interface ClockInterface {
  currentTime: Date;
  setTime(d: Date): void;
}
// 继承接口 并重写方法 构建类
class Clock implements ClockInterface {
  currentTime: Date;
  constructor(h: number, m: number, s: number) {
    this.currentTime = new Date();
    this.setTime(h, m, s);
  }
  //重写方法
  setTime(h: number, m: number, s: number) {
    //此代码调用父类的方法
    super.setTime(this.currentTime);
    //其余代码均为重写方法
    this.currentTime.setHours(h);
    this.currentTime.setMinutes(m);
    this.currentTime.setSeconds(s);
  }
}

const clock = new Clock(12, 13, 14);
console.log(clock.currentTime.toLocaleTimeString());
```

接口的使用

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

## 私有化类属性

```typescript
class Animal {
  private _name: string;
  constructor(theName: string) {
    this._name = theName;
  }
  /* getter setter 访问器 */
  getName() {
    // 私有属性只能在类内部访问，定义内部方法实现访问，修改同理
    //可选：添加非法验证，可防止恶意修改 比如年龄不能为负数
    return this._name;
  }
  get name() {
    //无感知方法
    return this._name;
  }
}

const animal = new Animal("Cat");
//Ts：error 私有属性不能直接访问，ts警告 Js无法拦截，let类型可防止修改
console.log(animal._name);
// 调用内部方法获取私有属性
console.log(animal.getName());
//无感知获取
console.log(animal.name);
```

## 受保护的类属性

> protected 修饰符 允许自己和子类访问 其他类不允许访问

```typescript
class Animal {
  protected _name: string;
  //构造函数形参 可直接将属性存在实例中 打印实例化对象就能看到属性值
  constructor(public theName: string) {
    this._name = theName;
  }
}

class Dog extends Animal {
  get name() {
    return this._name;
  }
}
//利用子类 访问父类受保护的属性 构造函数依旧继承，有效防止黑客，看到根位置
const dog = new Dog("Rufus");
console.log(dog.name); // "Rufus"
```

## 枚举类型

```typescript
enum Color {
  Red,
  Green,
  Blue,
}

const c: Color = Color.Green;

console.log(c); // 1
```

---

## any 类型 关闭 Ts 类型检查

```typescript
let x: any = 4;
let list: any[] = [1, "string", false];
let obj: any = { a: 1, b: "string" };
let List<any> = [1, "string", false];

as any 断言 关闭类型检查
let x = 4 as any;
let list = [1, "string", false] as any[];
let obj = { a: 1, b: "string" } as any;
let List<any> = [1, "string", false] as any[];
```

---

## ai 补充笔记

### 类型别名

```typescript
type Name = string;
type NameResolver = () => string;

function getName(n: Name | NameResolver): Name {
  if (typeof n === "string") {
    return n;
  } else {
    return n();
  }
}

const name1: Name = "Alice";
const name2: Name = getName(() => "Bob");
```

### 类型断言

```typescript
// 自动根据形参类型 推断变量类型
function fn<T>(a: T): T {
  return a;
}

interface inter {
  count: number;
}

//cast 类型断言 告诉编译器 变量类型为 inter
function fn2(a: inter): number {
  return a.count;
}

// 让类的属性类型与 实例化限制的形参一致，告诉编译器类型推断
class Animal<t> {
  name: t;
  constructor(name: t) {
    this.name = name;
  }
}
// 实例化时，类型推断为 string
animal = new Animal<string>(name:"dog");
```

### 类型推断

```typescript
let someValue = "this is a string";

let strLength = someValue.length;
```

### 类型兼容性

```typescript
let str: string = "hello world";
let num: number = 123;

// 类型兼容
let strOrNum: string | number = str;

// 类型不兼容
// let numOrStr: number | string = num;
```

## 类型别名与接口的区别

- 类型别名是给一个类型起一个新名字，可以用来表示一个类型，可以与其他类型进行交互，可以被赋值给变量，可以被作为函数参数和返回值类型。
- 接口是用来定义对象的结构，不能用来表示一个类型，不能被赋值给变量，只能被用做函数的类型定义。

## 参考

- [TypeScript 官方文档](https://www.typescriptlang.org/docs/home.html)
- [TypeScript 入门教程](https://ts.xcatliu.com/)
- [TypeScript 手册](https://www.tslang.cn/docs/handbook/basic-types.html)
