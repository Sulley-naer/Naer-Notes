# 连接数据库，并且执行 SQL 语句 [文档](https://sidorares.github.io/node-mysql2/zh-CN/docs)

1. 安装 mysql 模块

> [!IMPORTANT]
> mysql 低于 8.41 版本安装下面

```bash
npm install mysql
# Ts
npm install @types/mysql
```

> [!IMPORTANT]
> mysql 8.4 版本以上安装

```bash
npm install mysql2
# Ts
npm install @types/mysql2
# 现在似乎没有types包
```

> [!TIP]
> 问题[原因](https://www.tubring.cn/articles/fix-php-mysql-84-mysql_native_password-not-loaded)：mysql 的账户密码验证发生了变化，8.4 版本以上版本的 mysql 要求必须**强制**使用 `caching_sha2_password` 加密方式，而之前的版本可修改使用 `mysql_native_password` 加密方式。 mysql 的模块使用的是 8.4 之前的加密方式，而 mysql2 的模块使用的是 8.4 之后的加密方式。

顺带提一下账户相关：终端可在 window 菜单找到 command Line

```bash
#查看所有用户
select Host,user from mysql.user;
# 查询账户的端口 名称 密码 权限 条件就是是否为密码加密方式为 mysql_native_password
SELECT user, host, plugin from mysql.user WHERE plugin='mysql_native_password';

# 修改密码
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'new_password';

# 刷新权限
FLUSH PRIVILEGES;

# 修改账号host
update mysql.user set host ='%' where user='user1';
```

## 连接数据库

```javascript
const mysql = require("mysql2/promise");
const express = require("express");
const app = express();

const connection = await mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "test",
});

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});

//自行调用测试
app.post("/api/all", async (req, res) => {
  const sql = "SELECT * FROM users";
  const [rows, fields] = await connection.execute(sql);
  res.json(rows);
});
```
