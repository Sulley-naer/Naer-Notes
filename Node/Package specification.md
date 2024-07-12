# Node 插件开发规范

## 目录

- [Node 插件开发规范](#node-插件开发规范)
  - [目录](#目录)
  - [1. 命名](#1-命名)
  - [2. 版本号](#2-版本号)
  - [3. 目录结构](#3-目录结构)
  - [4. 入口文件](#4-入口文件)
  - [5. 代码规范 模块化](#5-代码规范-模块化)
  - [6. 文档](#6-文档)
  - [发布插件 npm](#发布插件-npm)

## 1. 命名

- 插件名必须符合 npm 包名命名规范，即只能包含小写字母、数字、连字符、下划线。
- 插件名必须与项目名不同，避免与其他插件或项目产生冲突。
- 插件名尽量简洁，避免过长。
- 插件名必须与项目名一致，避免与其他插件或项目产生歧义。

## 2. 版本号

- 插件版本号遵循 semver 规范，即 MAJOR.MINOR.PATCH。
- MAJOR 版本号表示重大变更，如 API 变动、功能重构等。
- MINOR 版本号表示新增功能、优化等。
- PATCH 版本号表示修复 bug、优化等。
- 版本号必须与 npm 包版本号一致。

## 3. 目录结构

- 插件目录结构必须包含以下文件：
  - package.json：插件的配置文件，用于描述插件的基本信息、依赖等。
  - README.md：插件的说明文档，用于介绍插件的功能、使用方法、安装、配置等。
  - lib：插件的主要代码，用于实现插件的功能。
  - test：插件的单元测试代码。
  - examples：插件的示例代码。

## 4. 入口文件

- 插件的入口文件必须是 lib | ./ 目录下的 index.js 文件。
- 入口文件必须导出一个函数，该函数必须返回一个对象，该对象包含插件的主要功能。

## 5. 代码规范 模块化

- 插件的代码规范遵循 ECMAScript 6 规范。

入口文件示例：

```javascript
//必须为导入模块显示
const testModule = require('./lib/testModule');

module.exports = {
  // 插件主要功能代码，参数自行修改
  Object.assign(testModule)
  //ES6语法
  ...testModule,
};
```

模块文件

```javascript
function testModule() {
  console.log("testModule");
}
function testFn() {
  console.log("testFn");
}

module.exports = {
  testModule,
  testFn,
};
```

单元测试文件

```javascript
const testModule = require("../lib/testModule");

describe("testModule", () => {
  it('should return "testModule"', () => {
    expect(testModule()).toBe("testModule");
  });
});
```

## 6. 文档

- 插件的文档必须包含 README.md 文件，该文件必须包含插件的功能、使用方法、安装、配置等信息。
- README.md 文件必须包含以下内容：
  - 插件的名称、版本号、简介。
  - 插件的功能介绍。
  - 插件的安装方法。
  - 插件的配置方法。
  - 插件的使用方法。
  - 插件的示例代码。
  - 插件的单元测试代码。
  - 插件的相关链接。
- README.md 文件必须遵循 Markdown 语法。

ReadMi.md 示例：

````markdown
# 插件名称

## 安装

```bash
npm install 插件名称
```

## 导入

```javascript
const 插件名称 = require("插件名称");
```

方法名 | 太多的方法可以独立写 api 文档

```javascript
//调用xx 方法 参数可注释说明
插件名称.方法名();
```

## 开源协议

MIT | ISC | Apache-2.0 | GPL-3.0 | BSD-3-Clause
````

## 发布插件 [npm](./npm.md)

1. 前往[NPM](https://www.npmjs.com/)
2. 注册登录
3. 终端中登录 npm 账号：`npm login`
4. 注意：服务器地址不要使用镜像服务器
5. `nrm ls` 查看当前使用的镜像服务器，

   使用 `nrm use npm` 切换回 npm 官方源。

6. `npm publish` 发布插件到 npm 仓库。

   请切换到插件根目录，并且遵守目录结构。

7. `npm unpublish name --force` 删除发布的包 过期永远无法删除

   注意：只能删除 72 小时内发布的包 24 内不能再次发布

无法上传注意 package.json 文件中的 name 与插件名是否一致。

版本号是否正确 开源协议是否正确

入口文件是否填写正确，用户姓名是否填写

总之一般无法提交通常都是 package 规范
