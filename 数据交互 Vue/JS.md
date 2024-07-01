# Javascript

1. const 声明的内容无法被修改

> 箭头函数 ES6 中 function 升级版

```javascript
const fn1 = () => {
  console.log("login.js");
};
//简化
const fn2 = () => console.log("只有一行代码，可以不写{}");
//最简
const fn3 = console.log("一行代码且不需要传参，可以省略()和{}");
//箭头函数中this会指向元素父级,function中的为元素本身
/* 但是可以使用event来平替 */
(event) => {
  console.log(event.target);
};
```

> arguments 动态参数

```javascript
function sum(a, ...name) {
  console.log(name);
  console.log(arguments);
}

sum(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
//a被1赋值 name被2-10赋值 arguments被1-10赋值
```

- `...` --展开运算符

> 解析数组中的值，而不是数组本身

```javascript
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];
const arr3 = [...arr1, ...arr2];
console.table(arr3);
// [1,2,3,4,5,6]
```

- 多维数组&&数组解析
  > 给数组中某个元素赋值为数组，就是多维数组
  > 数组解析就是将数组中的值解析出来

````javascript

```javascript
[a, b, [c, d]] = [1, 2, [3, 4]];
console.log(a, b, c, d);
````

- 对象解构语法`{}`

```javascript
/* -解构的变量名必须和对象中的属性名相同
    -解构的变量名不能和其他变量名相同
    -对像属性的值会被赋值给对应的变量
*/
const { name: username, age } = { name: "张三", age: 18 };
console.log(username, age);
//张三 18

/* 以前写法 */
const obj = {
  name: "张三",
  age: 18,
  sayName: function () {
    console.log(this.name);
  },
};
console.log(obj.sayName());
```

- 解析对象中的值

```javascript
const city = [
  {
    city: "北京",
    area: ["朝阳", "海淀", "昌平"],
  },
];

const [{ city: city1, area }] = city;
console.log(city1, area); //北京 ["朝阳", "海淀", "昌平"]
```

- 赛选数组中的值

```javascript
const arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
const newArr = arr.filter((item) => item > 5);
console.log(newArr); // [6,7,8,9]
```

- 遍历对象中的内容添加内容到元素中

```javascript
//声明容器盒子
let itemBox = document.getElementById("item-box");
console.log(itemBox);
//创建对象
const kc = {
  sp1: {
    name: "小米9",
    title: "超轻薄折叠机身设计，小米自研微水",
    price: 2000,
    img: "images/01.png",
    id: 1,
  },
  sp2: {
    name: "小米10",
    title: "超轻薄折叠机身设计，小米自研微水",
    price: 3999,
    img: "images/02.png",
    id: 2,
  },
  sp3: {
    name: "小米11",
    title: "超轻薄折叠机身设计，小米自研微水",
    price: 4999,
    img: "images/03.png",
    id: 2,
  },
  sp4: {
    name: "小米12",
    title: "超轻薄折叠机身设计，小米自研微水",
    price: 5999,
    img: "images/04.png",
    id: 2,
  },
};
//添加内容
let str = "";

Object.values(kc).forEach(({ name, title, price, img, id }) => {
  str += `
    <div class="col-3">
      <div>
        <picture>
          <img src="${img}" alt="" />
        </picture>
        <div class="content">
          <p>${name}</p>
          <span>${title}</span>
          <div class="price">
            <span>￥</span>
            <span>${price}</span>
            <span>起</span>
          </div>
        </div>
      </div>
    </div>
  `;
});
itemBox.innerHTML = str;
/* 如有禁止图片拖拽函数在这里调用 */
```

> 添加赛选价格

```javascript
//声明容器
let itemBox = document.getElementById("item-box");
console.log(itemBox);
//创建对象
const kc = {
  sp1: {
    name: "小米9",
    title: "超轻薄折叠机身设计，小米自研微水",
    price: 2000,
    img: "images/01.png",
    id: 1,
  },
  sp2: {
    name: "小米10",
    title: "超轻薄折叠机身设计，小米自研微水",
    price: 3999,
    img: "images/02.png",
    id: 2,
  },
  sp3: {
    name: "小米11",
    title: "超轻薄折叠机身设计，小米自研微水",
    price: 4999,
    img: "images/03.png",
    id: 3,
  },
  sp4: {
    name: "小米12",
    title: "超轻薄折叠机身设计，小米自研微水",
    price: 5999,
    img: "images/04.png",
    id: 4,
  },
};

//渲染函数
function renderItems(items) {
  let str = "";

  items.forEach(({ name, title, price, img, id }) => {
    str += `
      <div class="col-3">
        <div>
          <picture>
            <img src="${img}" alt="" />
          </picture>
          <div class="content">
            <p>${name}</p>
            <span>${title}</span>
            <div class="price">
              <span>￥</span>
              <span>${price}</span>
              <span>起</span>
            </div>
          </div>
        </div>
      </div>
    `;
  });

  itemBox.innerHTML = str;
}
//价格区间函数
function chooseprice(minPrice, maxPrice) {
  const filteredItems = Object.values(kc).filter(
    (item) => item.price >= minPrice && item.price <= maxPrice
  );
  renderItems(filteredItems);
}

// 初始渲染所有商品
renderItems(Object.values(kc));

// 示例：筛选价格在3000到5000之间的商品
chooseprice(3000, 5000);

/* 可选：调用禁止图片拖拽 */
```

## 网页本地存储

1. localStorage 保存本地文件

   > 语法: `localStorage.setItem('key', 'value')` `localStorage.getItem('key')` `localStorage.removeItem('key')` `localStorage.clear()`

2. sessionStorage 关闭浏览器就清除
   > 语法: `sessionStorage.setItem('key', 'value')` `sessionStorage.getItem('key')` `sessionStorage.removeItem('key')` `sessionStorage.clear()`

## console 输出 [查看](https://www.bilibili.com/video/BV1v34y1w7Ro)

1. console.log() --输出
1. console.error() --错误
1. console.warn() --警告
1. console.table() --表格
1. console.time() --计时开始
1. console.timeEnd() --计时结束
1. console.clear() --清除
1. console.dir() --查看元素属性
1. console.dirxml() --查看元素属性
1. console.trace() --查看函数调用栈
1. console.group() --分组
1. console.groupEnd() --分组结束
1. console.groupCollapsed() --分组收起
1. console.count() --计数
1. console.assert() --断言
1. console.profile() --分析
1. console.profileEnd() --分析结束
1. console.timeStamp() --时间戳
1. console.context() --输出当前作用域
1. console.memory() --输出内存使用情况
1. console.exception() --抛出错误

```Javascript
console.log("输出");
console.error("错误");
console.warn("警告");
console.table("表格");
console.time("计时开始");
/* 代码 */
console.timelog("计时中");
/* 代码 */
console.timeEnd("计时结束");
element.addEventListener("click", function () {
  /* 计数 */
  console.count("click");
});
  /* 重置计数 */
console.countReset("click");

console.group("分组");
console.log("分组内容");
console.groupEnd("分组结束");
/* table */
const list = [
  { name: "小课", age: 20 },
  { name: "张三", age: 19 },
  { name: "李四", age: 18 },
];

console.table(list);

/* 自定义CSS */

const styles =
  "font-weight:500; \
border-radius:4px; \
padding:3px;\
color: white;\
background:linear-gradient(to right,#3b82f6,#06b6d4)";
console.log("%c 打印测试,学习更多的JS语法", styles);
```
