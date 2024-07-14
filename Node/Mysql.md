# Mysql

Mysql 数据库 相较于其他数据库，其优势在于其支持 ACID 原则，保证数据一致性。

并且是 Java 开发者最熟悉的数据库，可以方便地与 Java 进行集成。

## 安装

1. 进入[官网](https://dev.mysql.com/downloads/)
1. 点击 [MySQL Community Server](https://dev.mysql.com/downloads/mysql/)
   1. 选择最新版本 第二个选择 window 系统
   2. 下载时选择 msi 安装包(微软安装包)
1. 或者 （版本较低）[MySQL Installer for Windows](https://dev.mysql.com/downloads/installer/)
   1. 选择版本，默认预选了 window 下载安装
   2. 只有 x86 版本 故不推荐这种方式
1. 安装步骤
   1. 第一次选择 Typical 基本依赖 | 自选依赖 | 完整安装
   2. 完成后会弹窗新窗口，直接点下一步一次走出欢迎写
   3. 第二个为数据库安装目录，可自定义我推荐默认，系统数据库 C 盘没问题
   4. 接着配置 第一个选择框依次
      1. 开发模式「占用较低，很低效率」
      2. 生产环境 「中等占用，支持并发」
      3. 服务环境「高效占用，服务模式」
1. 连接配置
   1. Tcp | IP 必勾 否者无法连接 = 无法使用
   2. Port 为连接时端口
   3. X Protocol Port 相当于管理员模式 拥有底层权限
   4. Open Windows Firewall ports for network access | 打开防火墙端口不开放 = 无法连接
   5. 后面可无视，自定义名称，内存名称 显示高级和日志选项
1. 用户配置
   1. 第一二个输入框，为管理员账号密码|底层 api 账号密码
   2. 下面的是普通数据库访问账号配置
      1. 点击添加用户
      2. username：账户名
      3. Host：账号允许使用的主机
      4. Role: 角色，一般选择普通用户 里面自行翻译，配置权限的
      5. Password：密码 输入两次确认
      6. 点击确定，完成配置
1. Windows 服务
   1. 在服务中启动，不启用无法开机自动启
   2. 服务中的名称，可自定义
   3. 启动服务的账户
      1. [x]系统账户
      2. [] 自定义的账号，需按照您配置的账号密码登录
1. 服务权限
   1. 允许 MYsql 使用 windows 管理员权限 读写文件
   2. 使用 windows 基本用户的权限 读写文件
   3. 不，我会在服务器配置完成后管理权限。
1. 是否创建示例数据库
   1. 有俩种示例，自行选择，只是一个数据库 Demo
1. 安装视图
   1. 有很多只是让你看安装进度，还能知道你安装了那些依赖
   2. 点击 Execute 进行安装
1. 安装完成
   1. 复制日志
   2. 访问官网
   3. finish 完成安装

## [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

> [!TIP]
> 图形化数据库管理工具，可以用来管理数据库，创建表，创建视图，创建索引，执行 SQL 语句等，方便操作

1. [官网下载](https://dev.mysql.com/downloads/workbench/)
2. 选择 Windows 系统
3. 下载 msi 安装包
4. 安装
   1. 完整安装
   2. 自行选择所需依赖
5. 下一步，进行安装
6. 完成页面
   1. 左下角勾选后 安装完成启动
   2. finish 完成安装
