# Mysql 基础语法

> [!CAUTION]
> 使用对应代码,请确保在对应数据库运行 use 对应的数据库
>
> mysql 数据库为系统数据库,可进行用户创建,权限管理,删除 修改 用户
>
> 代码正确依旧报错请检查用户权限
>
> 无法连接用户请确保是否已经被占用
>
> `declare`关键词出现的代码都是在存储过程或函数中使用的
>
> 不想创建可以直接 set 创建变量使用

- [Mysql 基础语法](#mysql-基础语法)
  - [数据库](#数据库)
  - [表格](#表格)
  - [修改表格](#修改表格)
  - [约束](#约束)
  - [增加数据](#增加数据)
  - [删除数据](#删除数据)
  - [修改](#修改)
  - [查询](#查询)
    - [查询数据](#查询数据)
    - [模糊查询\&正则查询](#模糊查询正则查询)
    - [聚合函数](#聚合函数)
    - [连接查询](#连接查询)
    - [子查询](#子查询)
    - [排序和限制](#排序和限制)
    - [聚合和分组](#聚合和分组)
  - [高级语句](#高级语句)
    - [事务](#事务)
    - [视图](#视图)
    - [触发器](#触发器)
    - [存储过程|函数](#存储过程函数)
  - [SQL 函数](#sql-函数)
    - [循环函数](#循环函数)
    - [自定义函数](#自定义函数)
    - [判断函数](#判断函数)
  - [逻辑类代码](#逻辑类代码)
    - [变量](#变量)
    - [游标](#游标)
    - [异常处理](#异常处理)
    - [条件语句](#条件语句)
    - [循环语句](#循环语句)
  - [Mysql Manger Code](#mysql-manger-code)
    - [索引的创建和管理](#索引的创建和管理)
    - [用户管理](#用户管理)
    - [权限管理](#权限管理)
      - [根用户 管理员权限丢失 方案](#根用户-管理员权限丢失-方案)
    - [全文搜索](#全文搜索)
  - [存储引擎（Storage Engines）](#存储引擎storage-engines)
  - [分区表（Partitioning）](#分区表partitioning)
  - [字符集和校对规则（Character Sets and Collations）](#字符集和校对规则character-sets-and-collations)
  - [备份和恢复](#备份和恢复)
  - [Mysql config](#mysql-config)
    - [MySQL 配置文件内容](#mysql-配置文件内容)

## 数据库

> [!TIP]
> 数据库（Database）是按照数据结构来组织、存储和管理数据的仓库。数据库系统是建立在关系模型理论基础上的，它是建立在关系模型理论基础上的数据库管理系统。关系模型是一种用来组织数据的方法，它将数据存储在表中，每张表由若干个字段和若干行组成，每行记录都与其他行记录有某种联系。关系模型的优点是简单、直观、易于理解和实现。关系模型的缺点是不适合大数据量的存储和处理。

```sql
-- 创建数据库
CREATE DATABASE my_database -- 数据库名称

-- API
DEFAULT CHARACTER SET utf8mb4 -- 设置默认字符集为 utf8mb4
DEFAULT COLLATE utf8mb4_general_ci -- 设置默认校对规则为 utf8mb4_general_ci
DEFAULT ENCRYPTION 'N' -- 设置加密选项，'Y' 为启用，'N' 为禁用
DEFAULT DATA DIRECTORY = '/var/lib/mysql/data' -- 设置数据文件的存放路径
DEFAULT INDEX DIRECTORY = '/var/lib/mysql/index' -- 设置索引文件的存放路径
DEFAULT TABLESPACE my_tablespace -- 设置表空间名称
DEFAULT TRANSACTIONAL = 1 -- 设置是否启用事务支持，0 为禁用，1 为启用
DEFAULT WITH SYSTEM VERSIONING -- 设置是否启用系统版本控制
DEFAULT CONNECTION = 'mysql://user:password@localhost/my_database' -- 设置连接字符串
DEFAULT MAX_SIZE = 1073741824 -- 设置数据库最大大小（以字节为单位）
DEFAULT LOGFILE GROUP my_logfile_group -- 设置日志文件组
DEFAULT UNDOFILE GROUP my_undofile_group; -- 设置撤消文件组
```

## 表格

> [!TIP]
> 表格（Table）是数据库中存储数据的集合。表格由若干列（Column）和若干行（Row）组成，每行记录都与其他行记录有某种联系。表格的结构由字段（Field）和数据类型（Data Type）组成，字段是表格的属性，数据类型是字段存储的数据类型。

```sql

CREATE TABLE 表格名 (
    列名 数据类型 [约束条件] [COMMENT '列注释'],
    ...
)
ENGINE = 存储引擎
-- 指定存储引擎，例如 InnoDB、MyISAM 等。
DEFAULT CHARACTER SET = 字符集
-- 设置表的默认字符集，例如 utf8mb4。
DEFAULT COLLATE = 校对规则
-- 设置表的默认校对规则，例如 utf8mb4_general_ci。
COMMENT = '表注释'
-- 表的注释说明。
AUTO_INCREMENT = 自增起始值
-- 设置自增列的起始值。

-- demo
CREATE TABLE my_table (
    id INT NOT NULL AUTO_INCREMENT COMMENT '主键',
    name VARCHAR(255) NOT NULL COMMENT '姓名',
    age INT NOT NULL COMMENT '年龄',
    PRIMARY KEY (id)
)
```

<details>
  <summary>More</summary>

```sql
AVG_ROW_LENGTH = 平均行长度
-- 表的平均行长度。
CHECKSUM = {0 | 1}
-- 是否启用表的校验和（0 为禁用，1 为启用）。
COMPRESSION = {'ZLIB' | 'LZ4' | 'NONE'}
-- 设置表的数据压缩方式（'ZLIB'、'LZ4' 或 'NONE'）。
CONNECTION = '连接字符串'
-- 用于连接其他表的字符串。
DATA DIRECTORY = '数据文件路径'
-- 设置表的数据文件存放路径。
DELAY_KEY_WRITE = {0 | 1}
-- 是否延迟写入键缓存（0 为禁用，1 为启用）。
ENCRYPTION = {'Y' | 'N'}
-- 是否启用表的数据加密（'Y' 为启用，'N' 为禁用）。
INDEX DIRECTORY = '索引文件路径'
-- 设置表的索引文件存放路径。
INSERT_METHOD = {NO | FIRST | LAST}
-- 设置 MERGE 表的插入方法（NO、FIRST 或 LAST）。
KEY_BLOCK_SIZE = 块大小
-- 设置索引块大小（单位：字节）。
MAX_ROWS = 最大行数
-- 设置表的最大行数。
MIN_ROWS = 最小行数
-- 设置表的最小行数。
PACK_KEYS = {0 | 1 | DEFAULT}
-- 是否压缩键（0 为禁用，1 为启用，DEFAULT 为默认）。
ROW_FORMAT = {'DEFAULT' | 'DYNAMIC' | 'FIXED' | 'COMPRESSED' | 'REDUNDANT' | 'COMPACT'}
-- 设置表的行格式。
TABLESPACE = 表空间名
-- 设置表空间名称。
UNION = (表格列表)
-- 设置 MERGE 表的合并表列表。
```

</details>

<details>
  <summary>说明</summary>

```md
ENGINE：用于指定表的存储引擎，例如 InnoDB、MyISAM 等。InnoDB 支持事务和外键，MyISAM 则不支持事务但通常更快。

DEFAULT CHARACTER SET：指定表的默认字符集，例如 utf8mb4，它支持所有 Unicode 字符。

DEFAULT COLLATE：指定表的默认校对规则，例如 utf8mb4_general_ci，它定义了字符串比较和排序的规则。

COMMENT：为表添加描述性注释，便于理解表的用途。

AUTO_INCREMENT：为自增列设置起始值，通常用于主键列，确保每次插入数据时该列自动递增。

AVG_ROW_LENGTH：指定表的平均行长度，有助于数据库管理系统优化存储和访问策略。

CHECKSUM：启用或禁用表的校验和，0 为禁用，1 为启用。启用校验和可以帮助检测表的损坏，但会增加存储开销。

COMPRESSION：设置表的数据压缩方式。可选值有 'ZLIB'、'LZ4' 或 'NONE'。压缩数据可以节省存储空间，但会增加 CPU 开销。

CONNECTION：用于连接其他表的字符串，一般用于分布式数据库中的表连接。

DATA DIRECTORY：指定表的数据文件存放路径，可以将表的数据文件存放在不同的物理磁盘上以提高性能。

DELAY_KEY_WRITE：是否延迟写入键缓存，0 为禁用，1 为启用。启用该选项可以在写入密集型操作中提高性能，但可能增加数据丢失的风险。

ENCRYPTION：是否启用表的数据加密，'Y' 为启用，'N' 为禁用。加密表数据可以提高安全性，但会增加 CPU 开销。

INDEX DIRECTORY：指定表的索引文件存放路径，与数据文件分开存放可以提高访问性能。

INSERT_METHOD：指定 MERGE 表的插入方法。NO 表示不允许插入，FIRST 表示插入到第一个表，LAST 表示插入到最后一个表。

KEY_BLOCK_SIZE：设置索引块的大小，单位为字节。调整该值可以优化索引性能。

MAX_ROWS：指定表的最大行数。该设置用于数据库管理系统在分配存储时进行优化。

MIN_ROWS：指定表的最小行数。该设置用于数据库管理系统在分配存储时进行优化。

PACK_KEYS：指定是否压缩键。0 为不压缩，1 为压缩，DEFAULT 为系统默认设置。压缩键可以节省存储空间，但会增加 CPU 开销。

ROW_FORMAT：设置表的行格式。可选值有 'DEFAULT'、'DYNAMIC'、'FIXED'、'COMPRESSED'、'REDUNDANT'、'COMPACT'。不同的行格式有不同的存储和性能特性。

TABLESPACE：指定表空间名称。表空间用于将数据库对象（如表、索引）组织在一起，可以优化存储和管理。

UNION：指定 MERGE 表的合并表列表。MERGE 表是一种特殊类型的表，它将多个 MyISAM 表的内容合并为一个表。
```

</details>

## 修改表格

> [!TIP]
> 修改表格（Alter Table）是修改已存在的表格的结构、数据类型、约束条件、索引、默认值等。

```sql
-- 修改表的语法
ALTER TABLE 表格名
    操作1,
    操作2,
    ...;

-- 修改表注释
ALTER TABLE 表格名 COMMENT = '新表注释';

-- 修改列的语法
ALTER TABLE 表格名
    MODIFY COLUMN 列名 数据类型 [约束条件] [COMMENT '列注释'];

-- 添加新列
ALTER TABLE 表格名
    ADD COLUMN 列名 数据类型 [约束条件] [COMMENT '列注释'];

-- 修改列为自增列
ALTER TABLE 表格名
    MODIFY COLUMN 列名 INT AUTO_INCREMENT;

-- 修改列的自增起始值
ALTER TABLE 表格名
    ALTER COLUMN 列名 AUTO_INCREMENT = 起始值;

-- 删除列
ALTER TABLE 表格名
    DROP COLUMN 列名;

-- 重命名列
ALTER TABLE 表格名
    RENAME COLUMN 旧列名 TO 新列名;

-- 修改列为主键
ALTER TABLE 表格名
    ADD PRIMARY KEY (列名);

-- 删除主键
ALTER TABLE 表格名
    DROP PRIMARY KEY;

-- 添加唯一键
ALTER TABLE 表格名
    ADD UNIQUE (列名);

-- 删除唯一键
ALTER TABLE 表格名
    DROP INDEX 索引名;

-- 添加索引
ALTER TABLE 表格名
    ADD INDEX 索引名 (列名);

-- 删除索引
ALTER TABLE 表格名
    DROP INDEX 索引名;

-- 添加外键
ALTER TABLE 表格名
    ADD CONSTRAINT 外键名 FOREIGN KEY (列名) REFERENCES 参照表(参照列);

-- 删除外键
ALTER TABLE 表格名
    DROP FOREIGN KEY 外键名;

```

<details>
  <summary>More</summary>

```sql
-- 修改存储引擎
ALTER TABLE 表格名
    ENGINE = 新存储引擎;

-- 修改字符集
ALTER TABLE 表格名
    CONVERT TO CHARACTER SET 新字符集 COLLATE 新校对规则;
```

</details>

## 约束

```sql
-- 主键约束
ALTER TABLE 表格名
    ADD PRIMARY KEY (列名);

-- 唯一约束
ALTER TABLE 表格名
    ADD UNIQUE (列名);

-- 非空约束
ALTER TABLE 表格名
    MODIFY COLUMN 列名 数据类型 NOT NULL;

-- 唯一索引
ALTER TABLE 表格名
    ADD UNIQUE INDEX 索引名 (列名);

-- 外键约束
ALTER TABLE 表格名
    ADD CONSTRAINT 外键名 FOREIGN KEY (列名) REFERENCES 参照表(参照列);

-- 自动递增
ALTER TABLE 表格名
    MODIFY COLUMN 列名 INT AUTO_INCREMENT;

-- check 约束
ALTER TABLE 表格名
    ADD CONSTRAINT 约束名 CHECK (表达式);
--表达式：列值必须满足的条件，如 age > 0。sex = '男' or sex = '女'。
```

<details>
  <summary>说明</summary>

```md
主键约束：主键约束用于保证每行记录都有一个唯一标识符，该标识符在表中必须唯一。主键约束可以是单列或多列。

唯一约束：唯一约束用于保证列中的值在表中唯一。

非空约束：非空约束用于保证列中的值不能为空。

唯一索引：唯一索引用于创建唯一索引，索引列中的值必须唯一。

外键约束：外键约束用于保证两个表的数据一致性。

自动递增：自动递增用于为整数类型字段自动生成唯一的 ID 值。

check 约束：check 约束用于限制列中的值的范围。
```

</details>

## 增加数据

> [!TIP]
> 增加数据（Insert）是向表格中插入新的数据。

```sql
-- 插入数据
INSERT INTO 表格名 (列1, 列2,...)
    VALUES (值1, 值2, ...);


-- 插入多条数据
INSERT INTO 表格名 (列1, 列2,...)
    VALUES (值1, 值2, ...),
          (值1, 值2, ...),
          ...;

-- 插入默认值
INSERT INTO 表格名 (列1, 列2,...)
    VALUES (默认值, 值2, ...);

-- 插入自增值
INSERT INTO 表格名 (列1, 列2,...)
    VALUES (NULL, 值2, ...);

-- 插入当前时间
INSERT INTO 表格名 (列1, 列2,...)
    VALUES (NOW(), 值2, ...);

-- 插入序列值
INSERT INTO 表格名 (列1, 列2,...)
    VALUES (NEXTVAL('序列名'), 值2, ...);

-- 插入子查询
INSERT INTO 表格名 (列1, 列2,...)
    SELECT 列1, 列2, ... FROM 子查询;

-- 插入多个子查询
INSERT INTO 表格名 (列1, 列2,...)
    SELECT 列1, 列2, ... FROM 子查询1
    UNION ALL
    SELECT 列1, 列2, ... FROM 子查询2;

-- 插入数据并返回 ID
INSERT INTO 表格名 (列1, 列2,...)
    VALUES (值1, 值2, ...)
    RETURNING ID;
```

## 删除数据

> [!TIP]
> 删除数据（Delete）是从表格中删除数据。

```sql
-- 删除数据
DELETE FROM 表格名;

-- 删除指定条件的数据
DELETE FROM 表格名
    WHERE 条件;

-- 删除表格
DROP TABLE 表格名;

-- 删除数据库
DROP DATABASE 数据库名;

-- 删除数据并返回受影响的行数
DELETE FROM 表格名
    WHERE 条件
    RETURNING 受影响的行数;
```

<details>
  <summary>说明</summary>

```md
# 条件

条件用于指定数据，可以是表达式、列名、常量等。

sno =100：删除 sno 值为 100 的行或者指定的列数据。

指定行列删除，无法直接使用删除语句，逻辑用修改为 NULL 值实现删除。
```

</details>

## 修改

> [!TIP]
> 修改（Update）是更新表格中的数据。

```sql
-- 更新数据
UPDATE 表格名
    SET 列1 = 值1, 列2 = 值2, ...
    WHERE 条件;


-- 更新多条数据
UPDATE 表格名
    SET 列1 = 值1, 列2 = 值2, ...
    WHERE 条件1
    AND 条件2;

-- 更新子查询
UPDATE 表格名
    SET 列1 = 子查询
    WHERE 条件;

-- 更新数据并返回受影响的行数
UPDATE 表格名
    SET 列1 = 值1, 列2 = 值2, ...
    WHERE 条件
    RETURNING 受影响的行数;
```

<details>
  <summary>说明</summary>

```md
# 条件

更新是用于指定数据，可以是表达式、列名、常量等。

通常使用 WHERE 子句指定更新的条件，WHERE 子句可以指定多个条件，用 AND 连接。

sno =100：更新 sno 值为 100 的行或者指定的列数据。
```

</details>

## 查询

### 查询数据

> [!TIP]
> 查询数据（Select）是从表格中查询数据。

```sql
-- 查询所有列的数据
SELECT * FROM 表格名;

-- 查询特定列的数据
SELECT 列1, 列2 FROM 表格名;

-- 查询特定条件的数据
SELECT * FROM 表格名 WHERE 条件;

-- 查询特定条件的特定列数据
SELECT 列1, 列2 FROM 表格名 WHERE 条件;

-- 查询特定条件的特定列数据并排序
SELECT 列1, 列2 FROM 表格名 WHERE 条件 ORDER BY 列1 ASC|DESC;

-- 查询特定条件的特定列数据并限制返回行数
SELECT 列1, 列2 FROM 表格名 WHERE 条件 LIMIT 数量;

-- 查询特定条件的特定列数据并偏移
SELECT 列1, 列2 FROM 表格名 WHERE 条件 LIMIT 数量 OFFSET 偏移量;

-- 查询特定条件的特定列数据并分组
SELECT 列1, 列2 FROM 表格名 WHERE 条件 GROUP BY 列1;

-- 查询特定条件的特定列数据并分组后过滤
SELECT 列1, 列2 FROM 表格名 WHERE 条件 GROUP BY 列1 HAVING 条件;

-- 指定列去除重复数据 Keyworld: DISTINCT 过滤 重复 过滤去重
SELECT DISTINCT 列1, 列2 FROM 表格名;

-- 查询列不能重复，并且查询出现次数 ，并定义别名和排序
select DISTINCT 列名,count(必须为分组列) as 别名 from 表格 group by 分组列 order by count --自定义排序列名 desc 降序 默认升序: asc;

```

### 模糊查询&正则查询

> [!TIP]
> 模糊查询（Like）是通过模糊匹配的方式查询数据。

<details>
  <summary style="font-size:17px;font-weight:bold;">查询语法</summary>

1. 通配符 `Like` `not Like`
   1. `/`: 转义字符，解决关键字被识别。
   2. `%`：表示任意数量的字符（包括零个字符）。
   3. `_`：表示一个单一字符。
2. MySQL 内置函数检索

   1. LOCATE()函数

      1. `SELECT locate('a', 'banana')`; 返回 2 因为 a 出现了 2 次
      2. `SELECT locate('a', 'banana', 3);` 返回 4 因为 从第三位置开始寻找，先在 4 的位置上出现
      3. `SELECT locate('z', 'banana');` 没有找到返回 0
      4. `SELECT locate(NULL , 'banana');` NULL 作为参数，返回 NULL
      5. `SELECT locate('a' , NULL );` NULL 同理

      6. ```sql
          -- 实现了`%网%` 返回值>0 标识存在 模板字符串``里面表示列
          SELECT * from app_info where LOCATE('网', `appName`) > 0;
         ```

      7. ```sql
          -- 这样就能实现 _ 占位符，从第二位开始匹配
          SELECT * from app_info where LOCATE('网', `appName`, 2) > 0;
         ```

   2.POSITION()方法

   1. ```sql
         -- 与LOCATE 一样 只是个别名而已 但是不能指定起始位置
        SELECT POSITION('a' in 'banana');
        -- 模板字符串``里面表示列
        SELECT * from app_info where POSITION( '网' IN `appName`);
      ```

   2.INSTR()方法

   1. ```sql
         -- POSITION 一样 对调的参数顺序
        SELECT INSTR('banana', 'a');
        -- 模板字符串``里面表示列
        SELECT * from app_info where INSTR(`appName`, '网');
      ```

3. 正则 `REGEXP` `not REGEXP`

   1. | 类型     | 作用                                                                             |
      | -------- | -------------------------------------------------------------------------------- |
      | （^）    | 匹配字符串的开始位置，如“^a”表示以字母 a 开头的字符串。                          |
      | （$）    | 匹配字符串的结束位置，如“X^”表示以字母 X 结尾的字符串。                          |
      | （.）    | 这个字符就是英文下的点，它匹配**任何一个字符**，包括回车、换行等。 通配符 \_     |
      | （\*）   | 星号匹配 0 个或多个字符，在它之前必须有内容。通配符 % 后续字符等于之前的字符     |
      | （+）    | 加号匹配 1 个或多个字符，星号允许出现 0 次，加号必须出现一次。a+ 后面至少一个 a  |
      | {n}      | 匹配指定 n 个 ab{3} abbb 有 3 个 (ab){3} ababab .{3} 任意字符出现三次            |
      | {n,}     | 匹配不少于 n 个 字面意思，跟上面语法相同                                         |
      | {n,m}    | 匹配 n-m 个 字面意思，语法相同                                                   |
      | a?       | ?为断言匹配，自动填充，结果可为 `[字符]`或者 a`[字符]` 它可存在，可不存在 量子态 |
      | (ab)?a   | 断言匹配，结果可为 aba 或者 c 和上面的用法称为**量词**                           |
      | .\*?b    | .是如何字符，\*让第二字符必须和.的相同，?让\*的匹配可有可无，最后一位强制 b      |
      | a+?      | a+ 特性为后面字符必须有一个 a，要么单 a 要么出至少有 2 个 a。 非贪婪量词         |
      | （?!）   | a(?!b) 匹配到 a，只要 a 后面不紧跟着 b 零宽度负向前瞻                            |
      | （?=）   | a(?=b) 结果可为 a 或者 a 后面紧跟着 b 的字符 零宽度正向前瞻                      |
      | （?<!）  | b(?<!a) 与(?!)相同，只不过是前面不能有字符 a 零宽度负向回顾                      |
      | （?<=）  | b(?<!a) 与(?=)相同，只不过是前面有 字符 a 零宽度正向回顾                         |
      | 考验成果 | `select * from student where sname regexp '^张.*?$'`                             |

   2. `'字符'` ：相当于 '%字符%'
   3. `|`：表示或 匹配多数据
   4. `.+`：**当前字段** `.` 匹配任意字符 `+` 包括空格、换行符等。
   5. `[]`：**当前字段** 匹配指定范围内的字符。`[a-z]` `[1-9]` `[a-zA-Z0-9]` 高版本不区分大小写。
   6. `[^]`：匹配不在指定范围内的字符。 无法使用 可在表达式前添加 `NOT`
      1. `[5|6|7|8|9]` : 不代表或 它识别为 | 为字符了。`^[5|6|7]` 才能表达 或
      2. `[5|6|7]$` 匹配以 5、6、7 结尾的字符串。
   7. 字节匹配
      1. `^.{10}$` 匹配 10 个字节的字符串。 `[a-z{10}$]` 英文 10 字节
         1. UTF8 编码下，一个中文字符占 3 个字节。 GBK 2 个字节。
         2. 英文字符占 1 个字节。 GBK 1 个字节。
         3. 数字占 1 个字节。 GBK 1 个字节。
      2. `BINARY ^'[A-Z]{10}$'` 匹配大写字母 10 个字节的字符串。
      3. `^.{10}|` 匹配 10 个字节的字符串或以 | 结尾的字符串。
   8. `^[0-9.]{6}$` 匹配 6 位数字或小数点的字符串。| 版本号
      1. `^1[0-9.]{5}$` 以 1 开头 数字 或者 . 是 5 字节的 字符串。
      2. `^1[0-9.]{4}7$` 首为 1 末为 7 ……
      3. `{4,6}$` 匹配 4-6 字节的字符串。
      4. `^(.{1}|.{7})$` 匹配 为 1 或 7 字节的单个字符
   9. `^[^ -~]` 首字中文。`[^]` 为非字符。`-~` 从空格到~ ASCII 所有字符。
   10. `^([a-z]|[0-9]|[A-Z])+$` 匹配不包含空格、换行符、中文的字符串。
   11. `\\d+` 匹配数字。
   12. `\\D+` 匹配非数字。
   13. `\\w+` 匹配单词字符。
   14. `\\W+` 匹配非单词字符。
   15. `\\s+` 匹配空白字符。
   16. `\\S+` 匹配非空白字符。
   17. `\\b` 匹配单词边界。
   18. `\\B` 匹配非单词边界。
   19. `^` 表示行的开始
   20. `.`匹配任何单个字符(除了换行符)
   21. `$` 表示行的结束
   22. `[]` 表示范围！一个字符为你的表达式内
   23. `\\.` 特殊符号须转义！`[,]` 范围内可不用转义
   24. `()` 正则表达式结果分组

       1. ```javascript
          const regex = /\d+(\.\d+)?/; // 匹配整数或浮点数
          const str = "The price is $123.45.";
          const result = regex.exec(str);

          if (result) {
            console.log("匹配到的完整字符串：", result[0]); // 123.45
            console.log("匹配到的第一个分组（小数部分）：", result[1]); // .45
          } else {
            console.log("未匹配到");
          }
          ```

   25. `\X` 特殊匹配：完整的 Unicode 字符 特殊语言才能使用 | python

4. 字符类匹配(posix)
   | 字符类 | 作用 |
   | ------- | ------- |
   | [[:digit:]] | 含有数字的 |
   | [:alnum:] | 匹配字面和数字字符。(等同于[A~Za~z0~9]) |
   | [:alpha:] | 匹配字母字符。(等同于[A~Za~z]) |
   | [:blank:] | 匹配空格或制表符(同[\\\t]) |
   | [:cntrl:] | 匹配控制字符(ASCII0 到 37 和 127) |
   | [:digit:] | 匹配十进制数字。(等同于[0-9]) |
   | [:graph:] | 匹配 ASCII 码值范围 33~126 的字符。与[:print:]相似，但不包括空格字符 |
   | [:print:] | 任何可打印字符 |
   | [:lower:] | 匹配小写字母，等同于[a-z] |
   | [:upper:] | 匹配大写字母，等同于[A-Z] |
   | [:space:] | 匹配空白字符（同[\\f\\n\\r\\t\\v]）|
   | [:xdigit:] | 匹配十六进制数字。等同于[0-9A-Fa-f] |
5. [:<:]和[:>:]
   1. [:<:]匹配词的开始,[:>:]匹配词的结束，`^%`是行的开始结束。
   2. `regexp '^a';` 匹配行以 a 开头的 `[[:<:]]a` 也能匹配行开头 a 的 不写单词结束
   3. `[[:<:]]word[[:>:]]` 匹配单词 为 word 的 HTML 单词空格区分 双击字符选中的

</details>

基础用法

```sql
-- _ 占位单字符,% 任意字符
SELECT 列名 FROM 表格名 WHERE 列名 LIKE '模式';
```

[参考文献](https://blog.csdn.net/qq_39390545/article/details/106414765)

### 聚合函数

> [!TIP]
> 聚合函数（Aggregate Function）是对数据进行汇总、统计等操作。

```sql
-- 查询所有列的数据
SELECT * FROM 表格名;

-- 查询特定列的数据
SELECT 列1, 列2 FROM 表格名;

-- 查询特定条件的数据
SELECT * FROM 表格名 WHERE 条件;

-- 查询特定条件的特定列数据
SELECT 列1, 列2 FROM 表格名 WHERE 条件;

-- 查询特定条件的特定列数据并排序
SELECT 列1, 列2 FROM 表格名 WHERE 条件 ORDER BY 列1 ASC|DESC;

-- 查询特定条件的特定列数据并限制返回行数
SELECT 列1, 列2 FROM 表格名 WHERE 条件 LIMIT 数量;

-- 查询特定条件的特定列数据并偏移
SELECT 列1, 列2 FROM 表格名 WHERE 条件 LIMIT 数量 OFFSET 偏移量;

-- 查询特定条件的特定列数据并分组
SELECT 列1, 列2 FROM 表格名 WHERE 条件 GROUP BY 列1;

-- 查询特定条件的特定列数据并分组后过滤
SELECT 列1, 列2 FROM 表格名 WHERE 条件 GROUP BY 列1 HAVING 条件;
```

### 连接查询

> [!TIP]
> 连接查询（Join Query）是将两个或多个表中的数据结合起来查询。

```sql
-- 内连接
SELECT 表1.列1, 表2.列2 FROM 表1 INNER JOIN 表2 ON 表1.关联列 = 表2.关联列;

-- 左连接
SELECT 表1.列1, 表2.列2 FROM 表1 LEFT JOIN 表2 ON 表1.关联列 = 表2.关联列;

-- 右连接
SELECT 表1.列1, 表2.列2 FROM 表1 RIGHT JOIN 表2 ON 表1.关联列 = 表2.关联列;
```

### 子查询

> [!TIP]
> 子查询（Subquery）是嵌套在其他查询中的查询。

```sql
-- 标量子查询
SELECT 列1, (SELECT 列2 FROM 表2 WHERE 表2.关联列 = 表1.关联列) AS 列2 FROM 表1;

-- 表子查询
SELECT 列1, 列2 FROM (SELECT 列1, 列2 FROM 表1 WHERE 条件) AS 子查询表;

-- EXISTS 子查询
SELECT 列1 FROM 表1 WHERE EXISTS (SELECT * FROM 表2 WHERE 表2.关联列 = 表1.关联列);

-- NOT EXISTS 子查询
SELECT 列1 FROM 表1 WHERE NOT EXISTS (SELECT * FROM 表2 WHERE 表2.关联列 = 表1.关联列);
```

### 排序和限制

> [!TIP]
> 排序和限制（Sort and Limit）是对查询结果进行排序和限制。

```sql
-- 按特定列升序排序
SELECT 列1, 列2 FROM 表格名 ORDER BY 列1 ASC;

-- 按特定列降序排序
SELECT 列1, 列2 FROM 表格名 ORDER BY 列1 DESC;

-- 限制返回行数
SELECT 列1, 列2 FROM 表格名 LIMIT 数量;

-- 限制返回行数并偏移
SELECT 列1, 列2 FROM 表格名 LIMIT 数量 OFFSET 偏移量;
```

<details>
  <summary>说明</summary>

```md
排序可以让查询结果按照指定列进行排序，ASC 表示升序，DESC 表示降序。

LIMIT 数量：限制返回的行数。

OFFSET 偏移量：指定偏移量，用于分页。
```

</details>

### 聚合和分组

> [!TIP]
> 聚合和分组（Aggregate and Group）是对查询结果进行聚合和分组, 并可以过滤分组结果。

```sql
-- 按特定列分组
SELECT 列1, COUNT(*) FROM 表格名 GROUP BY 列1;

-- 按特定列分组并计算总和
SELECT 列1, SUM(列2) FROM 表格名 GROUP BY 列1;

-- 按特定列分组并过滤结果
SELECT 列1, COUNT(*) FROM 表格名 GROUP BY 列1 HAVING 条件;
```

<details>
  <summary>说明</summary>

```md
分组可以让查询结果按照指定列进行分组，并对分组结果进行聚合操作。

让查询根据组别进行过滤，可以使用 HAVING 子句。

COUNT(\*)：计算分组的行数。

SUM(列 2)：计算指定列的总和。

AVG(列 2)：计算指定列的平均值。

MAX(列 2)：计算指定列的最大值。

MIN(列 2)：计算指定列的最小值。

GROUP BY 列 1：指定按哪列进行分组。

比如学生成绩表，有多学科名字有很多重复的情况，就可以通过 GROUP BY 学科名进行分组，然后计算每个学科的平均分。

having 条件：过滤分组结果，可以指定条件，比如分数大于 60 的人数。
```

</details>

## 高级语句

> [!NOTE]
> 高级语句，是指一些复杂的语句，如事务、触发器、视图、存储过程等。

### 事务

> [!TIP]
> 事务（Transaction）是一组数据库操作，要么全部成功，要么全部失败。

- 开始与提交

```sql
-- 开始事务
START TRANSACTION;

-- 提交事务
COMMIT;

```

- 回滚

```sql
-- 回滚事务
ROLLBACK;
```

- 设置事务隔离级别

```sql
-- 设置事务隔离级别为读未提交
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- 设置事务隔离级别为读已提交
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- 设置事务隔离级别为可重复读
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- 设置事务隔离级别为串行化
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

- 保存点（Savepoints）

```sql
-- 设置保存点
SAVEPOINT 保存点名称;

-- 回滚到保存点
ROLLBACK TO SAVEPOINT 保存点名称;

-- 释放保存点
RELEASE SAVEPOINT 保存点名称;
```

- 示例

```sql
-- 开始事务
START TRANSACTION;

-- 执行 SQL 语句
INSERT INTO 表格名 (列1, 列2) VALUES (值1, 值2);

-- 提交事务
COMMIT;

-- 回滚事务
START TRANSACTION;
UPDATE 表格名 SET 列1 = 新值 WHERE 条件;
ROLLBACK;
```

### 视图

> [!TIP]
> 视图（View）是一种虚拟表，其内容由一个或多个实际的表（或视图）组成。

- 创建视图

```sql
-- 创建视图
CREATE VIEW 视图名 AS
SELECT 列1, 列2, ...
FROM 表格名
WHERE 条件;

```

- 修改视图

  由于 MySQL 不支持修改视图，所以只能删除视图，然后再创建新的视图。

- 删除视图

```sql
-- 删除视图
DROP VIEW 视图名;
```

- 示例

```sql
-- 创建视图
CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;

-- 删除视图
DROP VIEW view_name;
```

### 触发器

> [!TIP]
> 触发器（Trigger）是一种特殊的存储过程，它在特定事件发生时自动执行。

- 创建触发器

```sql
-- 创建触发器
CREATE TRIGGER 触发器名
BEFORE|AFTER INSERT|UPDATE|DELETE ON 表格名
FOR EACH ROW
BEGIN
    -- 触发器执行的 SQL 语句
    ...
END;
```

- 修改
  MySQL 不支持直接修改触发器的操作，一般需要先删除旧触发器，然后重新创建。

- 删除触发器

```sql
-- 删除触发器
DROP TRIGGER 触发器名;
```

- 示例

```sql
-- 创建触发器
CREATE TRIGGER trigger_name
BEFORE INSERT ON table_name
FOR EACH ROW
BEGIN
    -- 触发器执行的 SQL 语句
    INSERT INTO log_table (action, timestamp) VALUES ('Insert occurred', NOW());
END;

-- 删除触发器
DROP TRIGGER trigger_name;
```

### 存储过程|函数

> [!TIP]
> 存储过程（Stored Procedure）是一组预编译的 SQL 语句，存储在数据库中，可以被调用执行。

- 创建存储过程

```sql
-- 创建存储过程
CREATE PROCEDURE 存储过程名 (参数列表)
BEGIN
    -- 存储过程执行的 SQL 语句
    ...
END;
```

- 修改存储过程
  由于 MySQL 不支持直接修改存储过程，所以只能删除存储过程，然后再创建新的存储过程。

- 删除存储过程

```sql
-- 删除存储过程
DROP PROCEDURE 存储过程名;
```

- 示例

```sql
-- 创建存储过程
CREATE PROCEDURE sp_get_customer_orders (IN customer_id INT)
BEGIN
    SELECT * FROM orders WHERE customer_id = customer_id;
END;

-- 删除存储过程
DROP PROCEDURE sp_get_customer_orders;
```

## SQL 函数

> [!TIP]
> SQL 函数（SQL Function）是一种 SQL 语句，它接受零个或多个参数，并返回一个值。

- 内置函数

```sql
-- 字符串函数
SELECT LENGTH('字符串');   -- 字符串长度
SELECT UPPER('字符串');   -- 转大写
SELECT LOWER('字符串');   -- 转小写
SELECT SUBSTRING('字符串', 开始位置, 长度); -- 截取字符串
SELECT TRIM('字符串');   -- 去除前后空格
SELECT LTRIM('字符串');  -- 去除左边空格
SELECT RTRIM('字符串');  -- 去除右边空格
SELECT REPLACE('字符串', '旧值', '新值'); -- 替换字符串
SELECT LPAD('字符串', 总长度, '填充字符'); -- 左填充
SELECT RPAD('字符串', 总长度, '填充字符'); -- 右填充
SELECT MD5('字符串');    -- MD5 加密
SELECT SHA1('字符串');   -- SHA1 加密


-- 数学函数
SELECT (列 * 2) --直接计算
SELECT ABS(数字);      -- 绝对值
SELECT CEIL(数字);      -- 向上取整
SELECT FLOOR(数字);     -- 向下取整
SELECT ROUND(数字, 保留位数); -- 四舍五入
SELECT RAND();          -- 随机数
SELECT SQRT(数字);      -- 平方根
SELECT MOD(数字1, 数字2); -- 取模
SELECT PI();            -- 圆周率
SELECT EXP(数字);       -- e 的指数
SELECT LN(数字);        -- 自然对数
SELECT LOG(数字);       -- 常用对数
SELECT POWER(数字1, 数字2); -- 幂运算
SELECT SIN(数字);       -- 正弦
SELECT COS(数字);       -- 余弦
SELECT TAN(数字);       -- 正切
SELECT ASIN(数字);      -- 反正弦
SELECT ACOS(数字);      -- 反余弦
SELECT ATAN(数字);      -- 反正切
SELECT DEGREES(弧度);   -- 角度转弧度
SELECT RADIANS(角度);   -- 弧度转角度


-- 日期和时间函数
SELECT NOW();           -- 当前日期和时间
SELECT CURDATE();       -- 当前日期
SELECT CURTIME();       -- 当前时间
SELECT DATE_FORMAT(日期, 格式); -- 格式化日期
SELECT TIMESTAMPDIFF(时间单位, 日期1, 日期2); -- 计算时间差
SELECT TIMESTAMPADD(时间单位, 数量, 日期); -- 计算日期
SELECT DATEDIFF(日期1, 日期2); -- 计算日期差
SELECT DATE_ADD(日期, INTERVAL 数量 TIMEUNIT); -- 计算日期
SELECT DATE_SUB(日期, INTERVAL 数量 TIMEUNIT); -- 计算日期
SELECT TIME_TO_SEC(时间); -- 时间转秒
SELECT SEC_TO_TIME(秒); -- 秒转时间
SELECT STR_TO_DATE(日期字符串, 格式); -- 字符串转日期
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s'); -- 格式化当前日期和时间
SELECT DAYNAME(日期);   -- 星期几
SELECT DAYOFMONTH(日期); -- 月份中的第几天
SELECT DAYOFWEEK(日期);  -- 星期中的第几天
SELECT DAYOFYEAR(日期);  -- 年份中的第几天
SELECT MONTH(日期);     -- 月份
SELECT MONTHNAME(日期);  -- 月份的名称
SELECT QUARTER(日期);   -- 季度
SELECT WEEK(日期);      -- 周
SELECT YEAR(日期);      -- 年
SELECT HOUR(时间);      -- 小时
SELECT MINUTE(时间);    -- 分钟
SELECT SECOND(时间);    -- 秒
SELECT MICROSECOND(时间); -- 微秒


-- 其他函数
SELECT DATABASE();      -- 当前数据库名
SELECT USER();          -- 当前用户
SELECT VERSION();       -- 数据库版本
SELECT IF(条件, 真值, 假值); -- 条件判断
SELECT IFNULL(值, 空值); -- 空值判断
SELECT COALESCE(值1, 值2, ...); -- 空值判断
SELECT CASE 表达式 WHEN 值1 THEN 结果1 WHEN 值2 THEN 结果2 ... ELSE 其他结果 END; -- 多分支判断
SELECT COUNT(值);      -- 计数
SELECT SUM(值);        -- 求和
SELECT AVG(值);        -- 平均值
SELECT MAX(值);        -- 最大值
SELECT MIN(值);        -- 最小值
SELECT GREATEST(值1, 值2, ...); -- 最大值
SELECT LEAST(值1, 值2, ...); -- 最小值
```

### 循环函数

> [!TIP]
> 循环函数（Loop Function）是一种 SQL 语句，它接受一个或多个参数，并对参数进行循环操作。

- 循环函数

```sql
-- 循环函数
SELECT 列1, 列2, ...
FROM 表格名
WHERE 列 IN (循环函数(参数1, 参数2, ...));
```

- 示例

```sql
-- 循环函数
SELECT column1, column2
FROM table_name
WHERE column1 IN (SELECT column1 FROM table_name WHERE column2 = 'value1');
```

### 自定义函数

> [!TIP]
> 自定义函数（Custom Function）是一种 SQL 语句，它接受零个或多个参数，并返回一个值。

- 创建自定义函数

```sql
-- 创建自定义函数
CREATE FUNCTION 函数名 (参数列表)
RETURNS 返回类型
BEGIN
    -- 函数执行的 SQL 语句
    ...
END;
```

- 修改自定义函数
  由于 MySQL 不支持直接修改自定义函数，所以只能删除自定义函数，然后再创建新的自定义函数。

- 删除自定义函数

```sql
-- 删除自定义函数
DROP FUNCTION 函数名;
```

- 示例

```sql
-- 创建自定义函数
CREATE FUNCTION get_customer_orders (customer_id INT)
RETURNS INT
BEGIN
    DECLARE result INT;
    SELECT COUNT(*) INTO result FROM orders WHERE customer_id = customer_id;
    RETURN result;
END;


-- 删除自定义函数
DROP FUNCTION get_customer_orders;
```

### 判断函数

> [!TIP]
> 判断函数（Judgement Function）是一种 SQL 语句，它接受零个或多个参数，并返回一个布尔值。

- 判断函数

```sql
-- 判断函数
SELECT 函数名(参数1, 参数2, ...);
```

- 示例

```sql
-- 判断函数
SELECT IF(1=1, 'true', 'false'); -- 返回 true
SELECT IFNULL(NULL, 'null'); -- 返回 null
SELECT COALESCE(NULL, 'null', 'not null'); -- 返回 not null
```

## 逻辑类代码

> [!NOTE]
> 逻辑类代码，是指一些逻辑运算符、条件语句、循环语句等。

### 变量

> [!TIP]
> 变量（Variable）是一种存储数据的容器。

```sql
set @名称 = 值;
SET @variable_name = value; -- 设置变量
SELECT @variable_name;

```

### 游标

> [!TIP]
> MySQL 支持游标用于处理查询结果集的逐行处理，常用于存储过程中：

<details>
  <summary style="font-size: 18px; font-weight: bold;">游标用处</summary>

<br>

游标的主要用途是处理从数据库查询中返回的多行数据。它允许你逐行处理结果集，每次只处理一行数据，这在需要对每行数据进行复杂处理时非常有用。

<h3>游标的常见用法</h3>

1. **逐行处理数据**：适用于需要对每行数据进行复杂逻辑处理的情况。
2. **批量操作**：可以在循环中进行批量的插入、更新或删除操作。
3. **复杂计算**：可以在循环中进行复杂的计算和数据处理。

<h3>示例说明</h3>

假设你有一个包含学生信息的表 student，并且你需要对每个学生的姓名进行某种处理，游标可以帮助你逐行读取并处理这些数据。

<h3>使用游标的注意事项</h4>

1. 性能问题：游标逐行处理数据，相比批量处理效率较低。如果可以使用批量处理，尽量避免使用游标。

2. 资源管理：确保在使用完游标后关闭它，以避免资源泄漏。

3. 复杂逻辑：游标适用于需要逐行处理复杂逻辑的情况，简单的操作可以直接使用 SQL 语句完成。

</details>

```sql
-- DECLARE 方法只能在存储过程中的变量声明中 Set 为普通变量声明

-- 声明游标，命名为 cursor_name，用于执行 SELECT_statement 查询
DECLARE cursor_name CURSOR FOR SELECT_statement;

-- 打开游标，准备开始处理查询结果集
OPEN cursor_name;

-- 将游标指向的当前行数据存储到变量中
FETCH cursor_name INTO variables;

-- 关闭游标，释放资源
CLOSE cursor_name;

```

- 示例

```sql
-- 创建存储过程
delimiter //

create procedure st()
begin
    # 声明变量
    declare i int default 0;       -- 控制循环的变量
    declare name varchar(50);      -- 存储查询结果的变量
    declare done int default 0;    -- 标志变量，表示游标是否读取完数据

    # 声明游标
    declare cur cursor for select sname from student;  -- 创建游标，查询student表中的sname列

    # 定义退出条件
    declare continue handler for not found set done = 1;  -- 当游标读取完数据时，将done设置为1

    # 打开游标
    open cur;  -- 打开游标

    # 循环读取数据
    fetch_loop: loop  -- 开始一个循环，名称为fetch_loop
    fetch cur into name;  -- 从游标中获取一行数据，存储到name变量中
    if done then  -- 如果done为1，表示没有更多数据
        leave fetch_loop;  -- 退出循环
    end if;
    select name;  -- 显示当前name的值
    end loop fetch_loop;  -- 结束循环

    # 关闭游标
    close cur;  -- 关闭游标
end //

delimiter ;
```

<details>
  <summary>示例说明</summary>

关键点

1. `declare cur cursor for select sname from student;`：定义游标，指定查询语句。
2. `declare continue handler for not found set done = 1;`：定义当没有更多数据时的处理方法，将 done 设置为 1。
3. `open cur`;：打开游标。
4. `fetch_loop: loop ... end loop fetch_loop;` 定义循环，从游标中获取数据。
5. `fetch cur into name;`：从游标中读取一行数据
6. `if done then leave fetch_loop; end if;`：检查 done 变量，如果为 1，则退出循环。
7. `close cur;`：关闭游标。

</details>

### 异常处理

> [!TIP]
> 异常处理（Exception Handling）是一种程序结构，用于处理程序运行过程中出现的异常。

```sql
-- 异常处理
BEGIN TRY
    -- 可能出现异常的代码
EXCEPTION
    -- 异常处理代码
END TRY;
```

### 条件语句

> [!TIP]
> 条件语句（Conditional Statement）是一种程序结构，用于根据条件执行不同的代码。

```sql
-- 条件语句
IF 条件1 THEN
    -- 条件1成立时执行的代码
ELSEIF 条件2 THEN
    -- 条件2成立时执行的代码
ELSE
    -- 其他条件执行的代码
END IF;
```

### 循环语句

> [!TIP]
> 循环语句（Loop Statement）是一种程序结构，用于重复执行代码。

- while 循环

```sql
-- WHILE 循环
SET @counter = 0;
WHILE @counter < 10 DO
    -- 执行的语句
    SET @counter = @counter + 1;
END WHILE;
```

- REPEAT-UNTIL 循环

```sql
-- REPEAT-UNTIL 循环
SET @counter = 0;
REPEAT
    -- 执行的语句
    SET @counter = @counter + 1;
UNTIL @counter >= 10 END REPEAT;
```

- LOOP 循环

```sql
-- LOOP 循环
SET @counter = 0;
loop_label: LOOP
    -- 执行的语句
    SET @counter = @counter + 1;
    IF @counter >= 10 THEN
        LEAVE loop_label;
    END IF;
END LOOP;
```

- ITERATE 和 LEAVE

> [!NOTE]
> 在循环中使用 ITERATE 和 LEAVE 控制循环流程：

```sql
SET @counter = 0;
loop_label: LOOP
    SET @counter = @counter + 1;
    IF @counter < 5 THEN
        ITERATE loop_label; -- 跳过剩余循环体并进入下一次迭代
    END IF;
    -- 执行的语句
    IF @counter >= 10 THEN
        LEAVE loop_label; -- 退出循环
    END IF;
END LOOP;
```

- 示例

```sql
-- 使用 WHILE 循环计算总和
DELIMITER //
CREATE PROCEDURE calculate_sum()
BEGIN
    DECLARE total INT DEFAULT 0;
    DECLARE counter INT DEFAULT 1;

    WHILE counter <= 10 DO
        SET total = total + counter;
        SET counter = counter + 1;
    END WHILE;

    SELECT total;
END //
DELIMITER ;

-- 调用存储过程
CALL calculate_sum();

-- 删除存储过程
DROP PROCEDURE calculate_sum;
```

## Mysql Manger Code

> [!TIP]
> 控制自身数据库的 MySQL Manager 代码，如创建数据库、删除数据库、创建表、删除表等。

### 索引的创建和管理

> [!TIP]
> 索引（Index）是一种数据结构，它帮助数据库系统快速找到数据。

1. 创建索引

```sql
CREATE INDEX 索引名 ON 表格名 (列名);
-- 唯一索引
CREATE UNIQUE INDEX 索引名 ON 表格名 (列名);
```

- 删除索引

```sql
-- 删除索引
DROP INDEX 索引名 ON 表格名;
```

- 查看索引

```sql
-- 查看表的索引
SHOW INDEX FROM 表格名;
```

- 示例

```sql
-- 创建普通索引
CREATE INDEX idx_name ON users (last_name);

-- 创建唯一索引
CREATE UNIQUE INDEX idx_email ON users (email);

-- 删除索引
DROP INDEX idx_name ON users;

-- 查看表的索引
SHOW INDEX FROM users;
```

### 用户管理

> [!TIP]
> 用户管理（User Management）是指管理数据库用户，包括创建、删除、修改用户信息等。

- 创建用户

```sql
-- 创建用户
CREATE USER '账号'@'主机' IDENTIFIED BY '密码';
```

- 删除用户

```sql
-- 删除用户
DROP USER '账号'@'主机';
```

- 修改用户

```sql
-- 修改用户
ALTER USER '账号'@'主机' IDENTIFIED BY '新密码';
-- 修改用户 Host
ALTER USER '账号'@'主机' IDENTIFIED BY '新密码' HOST '192.168.1.1';
```

- 查看用户

```sql
-- 查看所有用户
SELECT Host,User FROM mysql.user;
```

- 授权和权限管理

```sql
-- 授权
GRANT 权限列表 ON 数据库名.表格名 TO '账号'@'主机';

-- 撤销权限
REVOKE 权限列表 ON 数据库名.表格名 FROM '账号'@'主机';

-- 一键超级权限
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- Host 就是允许登录的地址，默认 localhost 通配符是 %
-- 一键所有用户全主机允许登录。
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'your_password' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- 修改用户密码
ALTER USER '账号'@'主机' IDENTIFIED BY '新密码';

-- 也可以直接用select update delete insert等语句来处理
update mysql.user set host ='%' where user='user1';

-- 修改用户密码
ALTER USER '账号'@'主机' IDENTIFIED BY '新密码';

-- 查看所有用户 主要需查看就是 host 字段 其他均为权限信息 unlock 是锁定信息
select Host,user from mysql.user;

-- 刷新权限
FLUSH PRIVILEGES;
```

无法使用[错误解决](#根用户-管理员权限丢失-方案)

- 示例

```sql
-- 创建用户
CREATE USER '张三'@'localhost' IDENTIFIED BY '密码123';

-- 删除用户
DROP USER '张三'@'localhost';

-- 授权
GRANT SELECT, INSERT ON db1.table1 TO '张三'@'localhost';

-- 撤销权限
REVOKE INSERT ON db1.table1 FROM '张三'@'localhost';

-- 修改用户密码
ALTER USER '张三'@'localhost' IDENTIFIED BY '新密码456';

-- 修改用户 Host
ALTER USER '张三'@'localhost' IDENTIFIED BY '新密码456' HOST '192.168.1.1';

-- 查看所有用户 主要需查看就是 host 字段 其他均为权限信息
select Host,user from mysql.user;
```

### 权限管理

> [!TIP]
> 权限管理（Permission Management）是指管理数据库用户的权限，包括查看权限、修改权限等。

- 授权

```sql
-- 授权给用户所有数据库所有表的所有权限
GRANT ALL PRIVILEGES ON *.* TO '账号'@'主机';

-- 授权给用户特定数据库所有表的所有权限
GRANT ALL PRIVILEGES ON 数据库名.* TO '账号'@'主机';

-- 授权给用户特定数据库特定表的特定权限
GRANT 权限列表 ON 数据库名.表格名 TO '账号'@'主机';
```

- 无法使用

#### 根用户 管理员权限丢失 [方案](https://blog.csdn.net/hualidezhen/article/details/116998498)

```sql
-- 回复根用户 权限 使用 workbench 登录mysql 输入以下命令
use mysql;
select * from user; -- 在 DataGrip 查询窗口自行将所有 N 的改为 Y 选择一个单元格改为Y 复制格子，多选N的，直接粘贴快速修改
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;

-- 注意一定不要给 account_locked 给 Y ,它是区分账户是否锁定的
SELECT user, host, account_locked FROM mysql.user WHERE user = 'root'; -- 查看是否被锁定
ALTER USER 'root'@'localhost' ACCOUNT UNLOCK; -- 已经被锁用另一个账户解开。
```

- 撤销权限

```sql
-- 撤销用户所有权限
REVOKE ALL PRIVILEGES ON *.* FROM '账号'@'主机';

-- 撤销用户特定数据库所有权限
REVOKE ALL PRIVILEGES ON 数据库名.* FROM '账号'@'主机';

-- 撤销用户特定数据库特定表的特定权限
REVOKE 权限列表 ON 数据库名.表格名 FROM '账号'@'主机';

```

- 修改用户密码

```sql
-- 修改用户密码
ALTER USER '账号'@'主机' IDENTIFIED BY '新密码';
```

- 示例

```sql
-- 授权给用户所有数据库所有表的所有权限
GRANT ALL PRIVILEGES ON *.* TO '张三'@'localhost';

-- 授权给用户特定数据库所有表的所有权限
GRANT ALL PRIVILEGES ON db1.* TO '张三'@'localhost';

-- 授权给用户特定数据库特定表的特定权限
GRANT SELECT, INSERT ON db1.table1 TO '张三'@'localhost';

-- 撤销用户所有权限
REVOKE ALL PRIVILEGES ON *.* FROM '张三'@'localhost';

-- 撤销用户特定数据库所有权限
REVOKE ALL PRIVILEGES ON db1.* FROM '张三'@'localhost';

-- 撤销用户特定数据库特定表的特定权限
REVOKE INSERT ON db1.table1 FROM '张三'@'localhost';

-- 修改用户密码
ALTER USER '张三'@'localhost' IDENTIFIED BY '新密码456';

-- 修改用户 host
ALTER USER '张三'@'localhost' IDENTIFIED BY '新密码456' HOST '192.168.1.1';
```

### 全文搜索

> [!TIP]
> 全文搜索（Full-Text Search）是一种数据库技术，它允许用户通过搜索引擎快速检索文本。

- 创建全文索引

```sql
CREATE FULLTEXT INDEX 索引名 ON 表格名 (列名);
```

- 使用全文搜索

```sql
SELECT * FROM 表格名 WHERE MATCH(列名) AGAINST('搜索词' IN NATURAL LANGUAGE MODE);
```

- 删除全文搜索

```sql
DROP INDEX 索引名 ON 表格名;
```

- 示例

```sql
-- 创建全文索引
CREATE FULLTEXT INDEX idx_content ON articles (content);

-- 使用全文搜索
SELECT * FROM articles WHERE MATCH(content) AGAINST('mysql' IN NATURAL LANGUAGE MODE);

-- 删除全文搜索
DROP INDEX idx_content ON articles;
```

## 存储引擎（Storage Engines）

> [!TIP]
> MySQL 支持多种存储引擎，每种存储引擎都有其特点和适用场景。

1. InnoDB：
   - 支持事务、行级锁和外键约束。
   - 适合于事务处理和高并发读写操作的应用。
2. MyISAM：
   - 支持表级锁。
   - 不支持事务和行级锁，但有较快的读取速度和全文搜索功能。
   - 适合于读密集型应用，如数据仓库和日志分析。
3. MEMORY（或 HEAP）：
   - 将表数据存储在内存中，速度快，但数据不持久化。
   - 适合于临时表和数据集合操作。
4. Archive：
   - 用于归档数据，支持压缩和加密。
   - 适合于存储大量历史数据，如日志和备份。
5. CSV：
   - 将数据以 CSV 格式存储在文件中。
   - 适合于导入和导出数据。
6. Federated：
   - 用于联合多个 MySQL 服务器，实现跨数据库查询。
   - 适合于跨越多个 MySQL 服务器的数据集成。

```sql
-- 创建表格时指定存储引擎
CREATE TABLE 表格名 (
    列1 数据类型,
    列2 数据类型,
    ...
) ENGINE=存储引擎;

```

## 分区表（Partitioning）

> [!TIP]
> 分区表（Partitioning）是一种 MySQL 数据库技术，它允许将大型表分解为多个小表，以便更好地管理和查询数据。

```sql
-- 创建分区表
CREATE TABLE 表格名 (
    列1 数据类型,
    列2 数据类型,
    ...
) PARTITION BY 分区类型 (分区列)(
    PARTITION 分区名1 VALUES LESS THAN (分区值1),
    PARTITION 分区名2 VALUES LESS THAN (分区值2),
    ...
);
```

- 分区类型

  - RANGE：基于范围的分区，根据分区列的值将数据划分为多个范围。
  - LIST：基于列表的分区，根据分区列的值将数据划分为多个子集。
  - HASH：基于哈希的分区，根据分区列的值计算哈希值，将数据划分为多个子集。

- 示例

```sql
-- 创建分区表
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_total DECIMAL(10,2)
) PARTITION BY RANGE (order_date) (
    PARTITION p1 VALUES LESS THAN ('2021-01-01'),
    PARTITION p2 VALUES LESS THAN ('2021-06-01'),
    PARTITION p3 VALUES LESS THAN ('2021-12-31')
);

```

## 字符集和校对规则（Character Sets and Collations）

> [!TIP]
> 字符集和校对规则（Character Sets and Collations）是 MySQL 数据库的基础设施，用于定义字符集和排序规则。

- 字符集

  - 字符集（Character Set）：
    - 它是一组字符的集合，它规定了字符的编码、顺序、大小写等属性。
    - MySQL 支持多种字符集，如 utf8、gbk、latin1 等。
  - 选择字符集：
    - 创建数据库时，使用 DEFAULT CHARACTER SET 选项指定默认字符集。
    - 创建表时，使用 CHARACTER SET 选项指定表的字符集。

- 校对规则

  - 校对规则（Collation）：
    - 它是用来比较和排序字符的规则。
    - MySQL 支持多种校对规则，如 utf8_general_ci、gbk_chinese_ci、latin1_swedish_ci 等。
  - 选择校对规则：
    - 创建数据库时，使用 DEFAULT COLLATE 选项指定默认校对规则。
    - 创建表时，使用 COLLATE 选项指定表的校对规则。

```sql
-- 创建数据库时指定默认字符集和校对规则
CREATE DATABASE 数据库名 DEFAULT CHARACTER SET 字符集 DEFAULT COLLATE 校对规则;

-- 创建表时指定字符集和校对规则
CREATE TABLE 表格名 (
    列1 数据类型 CHARACTER SET 字符集 COLLATE 校对规则,
    列2 数据类型 CHARACTER SET 字符集 COLLATE 校对规则,
    ...
);

```

- 示例

```sql
-- 创建数据库时指定默认字符集和校对规则
CREATE DATABASE mydb DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;

-- 创建表时指定字符集和校对规则
CREATE TABLE users (
    id INT,
    name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
    email VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
    ...
);

```

## 备份和恢复

> [!TIP]
> 备份和恢复（Backup and Recovery）是 MySQL 数据库的重要组成部分，它用于备份数据和恢复数据。

- 备份

  - 备份数据：
    - 使用 mysqldump 命令备份数据。
    - 使用 mysqlhotcopy 命令备份数据。
  - 备份日志：
    - 使用 mysqlbinlog 命令备份日志。
  - 备份配置：
    - 使用 mydumper 或 myloader 工具备份配置。

- 恢复

  - 恢复数据：
    - 使用 mysqldump 命令恢复数据。
    - 使用 mysqlhotcopy 命令恢复数据。
  - 恢复日志：
    - 使用 mysqlbinlog 命令恢复日志。
  - 恢复配置：
    - 使用 mydumper 或 myloader 工具恢复配置。

```sql
-- 备份数据
mysqldump -u 用户名 -p 数据库名 > 备份文件名.sql


-- 备份日志
mysqlbinlog -u 用户名 -p --start-datetime='2021-01-01 00:00:00' --stop-datetime='2021-01-01 23:59:59' > 日志文件名.bin


-- 备份配置
mydumper -h 主机 -u 用户名 -p 数据库名 -B 备份目录 -c 备份配置

```

- 示例

```sql
-- 备份数据
mysqldump -u root -p mydb > backup.sql

-- 备份日志
mysqlbinlog -u root -p --start-datetime='2021-01-01 00:00:00' --stop-datetime='2021-01-01 23:59:59' > backup.bin


-- 备份配置
mydumper -h 127.0.0.1 -u root -p mydb -B /tmp/backup -c /etc/mydumper.conf

```

## Mysql config

> [!TIP]
> MySQL 配置（MySQL Configuration）是 MySQL 数据库的重要组成部分，它用于设置数据库参数。

-- 查看配置文件路径

```sql
select @@datadir
```

- 在返回路径的父级 找到 my.ini 文件 配置 mysql

### MySQL 配置文件内容

```bash
[client]
port=3306

[mysql]
no-beep

[mysqld]
#服务端口号 默认3306
port = 3306
#mysql安装根目录
basedir = /usr/local/mysql
#mysql数据文件所在位置
datadir = /usr/local/mysql/data
#密码认证插件
default_authentication_plugin=caching_sha2_password
#默认存储引擎
default-storage-engine=INNODB
#开启严格模式
sql-mode="STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
#用文件记录日志
log-output=FILE
#关闭日志输出
general-log=0
#日志文件名称
general_log_file="DESKTOP-HB42AU2.log"
开启慢查询日志
slow_query_log = 1
#慢查询日志文件名称
slow_query_log_file = slow.log
#大于多少秒的执行SQL被记录在慢查询日志
long_query_time=10
#错误日志名称
log-error="DESKTOP-HB42AU2.err"
#数据库ID
server-id=1
#把表名转换为小写
lower_case_table_names=1
#导入导出数据的目录地址
sercure-file-priv= "/usr/local/mysql/uploads"
#最大连接数
max_connections=151
table_open_cache=2000
tmp_table_size=16M
#线程数量
thread_cache_size=10
myisam_max_sort_file_size=100G
myisam_sort_buffer_size=8M
key_buffer_size=8M
read_buffer_size=0
read_rnd_buffer_size=256K
sort_buffer_size=256K
```
