# npm

- [npm](#npm)
  - [安装](#安装)
  - [常用命令](#常用命令)
  - [代理配置](#代理配置)
  - [npx](#npx)

npm 是 Node.js 包管理工具，可以用来安装、管理和发布 Node.js 包。

## 安装

npm 可以通过 npm 包管理器安装|更新，可以直接在命令行中运行以下命令安装：

```bash
npm install -g npm
```

不能执行以上命令时，请先确保系统中已安装 Node.js。

## 常用命令

1. `npm init`：初始化一个新的 npm 项目。
2. `npm install`：安装依赖包。
3. `npm install -g`：全局安装依赖包。
4. `npm uninstall`：卸载依赖包。
5. `npm update`：更新依赖包。
6. `npm list`：查看已安装的依赖包。
7. `npm view`：查看包的详细信息。
8. `npm help`：查看 npm 命令的帮助信息。
9. `npm view vue versions` ：显示所有 vue 包的版本。

## 代理配置

普通配置

```bash
npm config set --global proxy http://server:port
npm config set --global https-proxy http://server:port
```

验证配置

```bash
npm config set proxy http://username:password@server:port
npm confit set https-proxy http://username:password@server:port
```

镜像源配置

```bash
npm config set registry http://registry.npm.taobao.org
```

查看配置

```bash
npm config list
```

移除代理

```bash
npm config delete proxy
npm config delete https-proxy
npm config delete registry
```

## npx

npx 是 npm 5.2.0 版本引入的命令，可以直接运行 npm 包指令，而不必全局安装一次。

快速切换源

```bash
# 查看源
npx nrm ls
# 切换源
npx nrm use taobao
# 增加源
npx nrm add <registry> <url> [home]
# 删除源
npx nrm del <registry>
# 测速
npx nrm test <registry>
```

切换 Node 版本

```bash
# 查看可用版本
npm view node versions

npx node@12 -v #v12.14.1
```

直接运行仓库代码

```bash
npx https://gist.github.com/zkat/4bc19503fe9e9309e2bfaa2c58074d32
```
