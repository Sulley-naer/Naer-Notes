# Typescript 强类型语言([TypeScript](https://www.typescriptlang.org/zh))

- [Typescript 强类型语言(TypeScript)](#typescript-强类型语言typescript)
  - [Typescript 的安装](#typescript-的安装)
  - [Typescript 的使用](#typescript-的使用)
  - [Typescript 语法](#typescript-语法)
  - [遵守类型规则 否则警告](#遵守类型规则-否则警告)
  - [面向对象](#面向对象)
  - [接口 数据类型 限制](#接口-数据类型-限制)
  - [组合类型](#组合类型)
  - [根据参数返回对象](#根据参数返回对象)
  - [数组 泛型 List\<类型\> 同理](#数组-泛型-list类型-同理)
  - [自声明泛型类型](#自声明泛型类型)
  - [类的使用](#类的使用)
  - [私有化类属性](#私有化类属性)
  - [受保护的类属性](#受保护的类属性)
  - [枚举类型](#枚举类型)
  - [any 类型 关闭 Ts 类型检查](#any-类型-关闭-ts-类型检查)
  - [ai 补充笔记](#ai-补充笔记)
    - [类型别名](#类型别名)
    - [类型断言](#类型断言)
    - [类型推断](#类型推断)
    - [类型兼容性](#类型兼容性)
  - [类型别名与接口的区别](#类型别名与接口的区别)
  - [参考](#参考)
  - [配置文件 在线](#配置文件-在线)
    - [Node 环境快速配置](#node-环境快速配置)
    - [全配置中文注释](#全配置中文注释)

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

```bash
npm init -y
```

2.安装 Typescript

```bash
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

```bash
tsc index.ts
# 监听文件变化 自动转换
tsc index.ts -w
```

6.运行编译后的 js 代码

```bash
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

## 配置文件 [在线](https://www.cnblogs.com/Chary/p/18277915)

```bash
# 自动生成，或者在项目跟目录下创建 tsconfig.json 文件
tsc --init
```

### Node 环境快速配置

```json
{
  "compilerOptions": {
    "target": "es2016",
    "module": "commonjs",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    // 严格模式
    "strict": true,
    // 编译为 es5
    "lib": ["ES2015", "DOM"],
    // 输出目录
    "outDir": "./dist",
    "rootDir": ".",
    "sourceMap": true
  },
  // 编译的文件
  "include": ["main.ts", "router.ts"],
  // 编译排除的文件
  "exclude": ["node_modules", "**/*.spec.ts"]
}
```

### 全配置中文注释

```json
{
  "compilerOptions": {
    /*请访问 https://aka.ms/tsconfig.json 阅读有关此文件的更多信息*/
    /* 指定需要编译的文件目录 tsc -w 自动监听文件 */
    "files": ["./src/**/*"],
    /* 指定需要编译的类型定义文件 白名单 */
    "include": [
    "src/**/*.ts",
    "src/**/*.d.ts",
    "src/**/*.tsx",
    "src/**/*.vue",
    "types/**/*.d.ts",
    "types/**/*.ts",
    "build/**/*.ts",
    "build/**/*.d.ts",
    "vite.config.ts"
    ],
    // 不编译某些文件 黑名单
    "exclude": ["node_modules", "dist", "**/*.js"],
    /*指定输出目录*/,
    "outDir": "./dist",

    /*项目*/
    // "incremental": true,                              /*启用增量编译——只编译修改过的文件,这个时候会生成tsconfig.tsbuildinfo,下次编译的时候会进行对比只编译修改过的文件*/
    // "composite": true,                                /*启用允许TypeScript项目与项目引用一起使用的约束——指定文件用来存储增量编译信息,默认是tsconfig.tsbuildinfo*/
    // "tsBuildInfoFile": "./",                          /*指定的文件夹。tsbuildinfo增量编译文件——指定文件用来存储增量编译信息,默认是tsconfig.tsbuildinfo*/
    // "disableSourceOfProjectReferenceRedirect": true,  /*在引用复合项目时禁用首选源文件而不是声明文件*/
    // "disableSolutionSearching": true,                 /*编辑时从多项目引用检查中选择一个项目*/
    // "disableReferencedProjectLoad": true,             /*减少TypeScript自动加载的项目数*/

    /*语言与环境*/
    "target": "es2016" /*为发出的JavaScript设置JavaScript语言版本，并包含兼容的库声明——指定 ECMAScript 目标版本: 'ES3' (default), 'ES5', 'ES2015', 'ES2016', 'ES2017', or 'ESNEXT'*/,
    /* 注意：如果未指定--lib，则会注入默认的librares列表。注入的默认库为：
       对于 --target ES5: DOM,ES5,ScriptHost
       对于 --target ES6: DOM,ES6,DOM.Iterable,ScriptHost
       TS 绝不会在您的代码中注入polyfill,所以需要你自己制定编译lib */
    // "lib": [],                                        /*指定一组描述目标运行时环境的绑定库声明文件*/
    // "jsx": "preserve",                                /*指定生成的jsx代码——指定 jsx 代码的生成: 'preserve', 'react-native', or 'react'*/
    // "experimentalDecorators": true,                   /*为TC39第2阶段草稿装饰器启用实验支持——用于指定是否启用实验性的装饰器特性*/
    // "emitDecoratorMetadata": true,                    /*为源文件中的修饰声明发出设计类型元数据——用于指定是否为装上去提供元数据支持，关于元数据，也是ES6的新标准，可以通过Reflect提供的静态方法获取元数据，如果需要使用Reflect的一些方法，需要引用ES2015.Reflect这个库*/
    // "jsxFactory": "",                                 /*指定在针对React JSX emit时使用的JSX工厂函数，例如“React”。createElement'或'h'*/
    // "jsxFragmentFactory": "",                         /*指定在以React JSX emit为目标时用于片段的JSX片段引用，例如“React”。“碎片”或“碎片”*/
    // "jsxImportSource": "",                            /*指定在使用`JSX:react JSX*`时用于导入JSX工厂函数的模块说明符*/
    // "reactNamespace": "",                             /*指定为“createElement”调用的对象。这仅适用于目标为'react`JSX emit的情况*/
    // "noLib": true,                                    /*禁用包含任何库文件，包括默认库。d、 ts*/
    // "useDefineForClassFields": true,                  /*发出符合ECMAScript标准的类字段*/

    /*模块*/
    "module": "commonjs" /*指定生成的模块代码——指定使用模块: 'commonjs', 'amd', 'system', 'umd' or 'es2015'*/,
    // "rootDir": "./",                                  /*指定源文件中的根文件夹——《后面单独介绍》*/
    // "moduleResolution": "node",                       /*指定TypeScript如何从给定的模块说明符中查找文件——用于选择模块解析策略，有'node'和'classic'两种类型*/
    // "baseUrl": "./",                                  /*指定用于解析非相对模块名称的基本目录——《后面单独介绍》*/
    // "paths": {},                                      /*指定将导入重新映射到其他查找位置的一组条目——《后面单独介绍》*/
    // "rootDirs": [],                                   /*允许在解析模块时将多个文件夹视为一个文件夹——《后面单独介绍》*/
    // "typeRoots": [],                                  /*指定多个类似于`xxx的文件夹/节点_modules/@types`——typeRoots用来指定声明文件或文件夹的路径列表，如果指定了此项，则只有在这里列出的声明文件才会被加载*/
    // "types": [],                                      /*指定要包含的类型包名称，而不在源文件中引用——types用来指定需要包含的模块，只有在这里列出的模块的声明文件才会被加载进来*/
    // "allowUmdGlobalAccess": true,                     /*允许从模块访问UMD全局——不把符号链接解析为真实路径，具体可以了解下webpack和node.js的symlink相关知识*/
    // "resolveJsonModule": true,                        /*启用导入。json文件*/
    // "noResolve": true,                                /*禁止`import`s、`require`s或`reference>`s扩展TypeScript应添加到项目中的文件数*/

    /*JavaScript支持*/
    // "allowJs": true,                                  /*允许JavaScript文件成为程序的一部分。使用“checkJS”选项从这些文件中获取错误——允许编译JS*/
    /* 是否检测JS的语法,例如下面的语法编辑器会报错
       let name = 'paul';
       console.log(name.a.b) */
    // "checkJs": true,                                  /*在已检查类型的JavaScript文件中启用错误报告*/
    // "maxNodeModuleJsDepth": 1,                        /*指定用于检查来自“node_模块”的JavaScript文件的最大文件夹深度。仅适用于“allowJs”*/

    /*散发*/
    // "declaration": true,                              /*生成。d、 ts项目中的TypeScript和JavaScript文件中的文件——如果设为true，编译每个ts文件之后会生成一个js文件和一个声明文件，declaration和allowJs不能同时设为true*/
    // "declarationMap": true,                           /*为d.ts文件创建源映射——值为true或false，指定是否为声明文件.d.ts生成map文件*/
    // "emitDeclarationOnly": true,                      /*仅输出d.ts文件，不输出JavaScript文件*/
    // "sourceMap": true,                                /*为发出的JavaScript文件创建源映射文件——用来指定编译时是否生成.map文件*/
    // "outFile": "./",                                  /*指定一个文件，将所有输出捆绑到一个JavaScript文件中。如果'declaration'为true，则还指定一个捆绑所有文件的文件。d、 ts输出——当module设置为 'amd' and 'system'的时候可以使用此命令,这样可以将ts文件打包到一个目录下*/
    // "outDir": "./",                                   /*为所有发出的文件指定一个输出文件夹——编译后的文件存到到哪个目录下,默认是每一个ts文件的当前目录,,下面的配置就是把ts编译到build目录下*/
    // "removeComments": true,                           /*禁用发送注释——编译的时候删除注释*/
    // "noEmit": true,                                   /*禁用从编译发出文件——不生成编译文件，这个一般比较少用,这个build目录下将没有任何文件,但是会进行编译,有错误会抛出*/
    // "importHelpers": true,                            /*允许每个项目从tslib导入一次助手函数，而不是每个文件包含它们——是否引入npm包tslib中的辅助函数,__extends等*/
    // "importsNotUsedAsValues": "remove",               /*为仅用于类型的导入指定发出/检查行为*/
    // "downlevelIteration": true,                       /*为迭代发出更兼容、但冗长且性能较差的JavaScript——当target为'ES5' or 'ES3'时，为'for-of', spread, and destructuring'中的迭代器提供完全支持*/
    // "sourceRoot": "",                                 /*指定调试器查找参考源代码的根路径——sourceRoot用于指定调试器应该找到TypeScript文件而不是源文件的位置，这个值会被写进.map文件里*/
    // "mapRoot": "",                                    /*指定调试器应在其中定位映射文件的位置，而不是生成的位置——mapRoot用于指定调试器找到映射文件而非生成文件的位置，指定map文件的根路径，该选项会影响.map文件中的sources属性*/
    // "inlineSourceMap": true,                          /*在发出的JavaScript中包含sourcemap文件——inlineSourceMap指定是否将map文件内容和js文件编译在一个同一个js文件中，如果设为true,则map的内容会以//#soureMappingURL=开头，然后接base64字符串的形式插入在js文件底部*/
    // "inlineSources": true,                            /*在发出的JavaScript中的sourcemaps中包含源代码——inlineSources用于指定是否进一步将ts文件的内容也包含到输出文件中*/
    // "emitBOM": true,                                  /*在输出文件的开头发出UTF-8字节顺序标记（BOM）*/
    // "newLine": "crlf",                                /*设置用于发送文件的换行符*/
    // "stripInternal": true,                            /*禁用在JSDoc注释中包含“@internal”的声明*/
    // "noEmitHelpers": true,                            /*禁用在编译输出中生成像`u extends`这样的自定义帮助函数*/
    // "noEmitOnError": true,                            /*如果报告任何类型检查错误，则禁用发送文件*/
    // "preserveConstEnums": true,                       /*禁用删除生成代码中的`const enum`声明*/
    // "declarationDir": "./",                           /*指定生成的声明文件的输出目录*/
    // "preserveValueImports": true,                     /*在JavaScript输出中保留未使用的导入值，否则将被删除*/

    /*互操作约束*/
    // "isolatedModules": true,                          /*确保每个文件都可以安全传输，而不依赖其他导入——isolatedModules的值为true或false，指定是否将每个文件作为单独的模块，默认为true，它不可以和declaration同时设定*/
    // "allowSyntheticDefaultImports": true,             /*当模块没有默认导出时，允许“从y导入x”——用来指定允许从没有默认导出的模块中默认导入*/
    "esModuleInterop": true /*发出额外的JavaScript，以简化对导入CommonJS模块的支持。这将启用“allowSyntheticDefaultImports”以实现类型兼容性——通过为导入内容创建命名空间，实现CommonJS和ES模块之间的互操作性*/,
    // "preserveSymlinks": true,                         /*禁用将符号链接解析到其realpath。这与节点中的同一标志相关——不把符号链接解析为真实路径，具体可以了解下webpack和node.js的symlink相关知识*/
    "forceConsistentCasingInFileNames": true /*确保导入中的大小写正确*/,

    /*类型检查*/
    "strict": true /*启用所有严格类型检查选项——严格模式将会打开下面的几个选项*/,
    /* 不允许变量或函数参数具有隐式any类型,例如
       function(name) {
           return name;
       } */
    // "noImplicitAny": true,                            /*为隐含的'any'类型的表达式和声明启用错误报告*/
    // "strictNullChecks": true,                         /*在进行类型检查时，请考虑'null'和'undefined'——null类型检测,const teacher: string = null;会报错*/
    // "strictFunctionTypes": true,                      /*分配函数时，请检查以确保参数和返回值与子类型兼容——对函数参数进行严格逆变比较*/
    // "strictBindCallApply": true,                      /*检查'bind'、'call'和'apply'方法的参数是否与原始函数匹配——严格检查bind call apply*/
    // "strictPropertyInitialization": true,             /*检查构造函数中声明但未设置的类属性——此规则将验证构造函数内部初始化前后已定义的属性。*/
    // "noImplicitThis": true,                           /*当'this'被赋予'any'类型时，启用错误报告——检测this是否隐式指定*/
    // "useUnknownInCatchVariables": true,               /*将catch子句变量键入“unknown”而不是“any”*/
    // "alwaysStrict": true,                             /*确保始终发出“use strict”——使用js的严格模式,在每一个文件上部声明 use strict*/
    // "noUnusedLocals": true,                           /*在未读取局部变量时启用错误报告——默认false,是否检测定义了但是没使用的变量*/
    // "noUnusedParameters": true,                       /*在未读取函数参数时引发错误——用于检查是否有在函数体中没有使用的参数*/
    // "exactOptionalPropertyTypes": true,               /*将可选属性类型解释为书面形式，而不是添加“undefined”*/
    // "noImplicitReturns": true,                        /*为未在函数中显式返回的代码路径启用错误报告——用于检查函数是否有返回值，设为true后，如果函数没有返回值则会提示*/
    // "noFallthroughCasesInSwitch": true,               /*在switch语句中启用故障案例的错误报告——用于检查switch中是否有case没有使用break跳出switch*/
    // "noUncheckedIndexedAccess": true,                 /*在索引签名结果中包含“undefined”*/
    // "noImplicitOverride": true,                       /*确保使用覆盖修饰符标记派生类中的覆盖成员*/
    // "noPropertyAccessFromIndexSignature": true,       /*对使用索引类型声明的键强制使用索引访问器*/
    // "allowUnusedLabels": true,                        /*禁用未使用标签的错误报告*/
    // "allowUnreachableCode": true,                     /*禁用无法访问代码的错误报告*/

    /*完整性*/
    // "skipDefaultLibCheck": true,                      /*跳过类型检查。d、 ts包含在TypeScript中的文件*/
    "skipLibCheck": true /*跳过类型检查全部。d、 ts文件*/
  }
}
```
