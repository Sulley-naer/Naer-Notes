# markdown 便洁的笔记工具

## 基本语法

> [!CAUTION]
> 所有语法必须空格,不同语句必须空行

- 标题

```md
# 一级标题 同文件内只能有一个一级标题

## 二级标题 自动根据成绩自动生成跳转目录 可重复使用

### 三级标题 导航栏结构 归纳于前 二级标题下
```

- 列表

```md
<!-- 注意：空格 不能隔行 -->

1. 有序列表
2. 有序列表
3. 有序列表

<!-- 注意：空格 无序可以隔行 -->

- 无序列表
- 无序列表
```

- 字体

```md
<!-- 加粗 -->

**bold**

<!-- 斜体 -->

_italic_

<!-- 加粗+斜体 -->

**_bold+italic_**
```

- 链接

```md
<!-- 行内式 -->

[百度](https://www.baidu.com)

<!-- 参考式 -->

[GitHub][1]

[1]: https://github.com/ "GitHub"
```

- 图片

```md
<!-- 行内式 -->

![图片描述](图片链接)

<!-- 参考式 -->

![图片描述][1]

[1]: 图片链接 "图片标题"
```

- 代码块

````md
<!-- 行内式 -->

`print("hello world")`

<!-- 多行代码块 -->

> [!IMPORTANT]
> 必须标注语言类型

```python
def add(x, y):
    return x + y


print(add(1, 2))
```
````

- 表格

```md
| 表头 1 | 表头 2 | 表头 3 |
| ------ | ------ | ------ |
| 单元格 | 单元格 | 单元格 |
| 单元格 | 单元格 | 单元格 |
```

- 引用

````md
<!-- 单行引用 -->

> 这是一个单行引用

<!-- 多行引用 -->

> 这是一个多行引用
> 这是一个多行引用

<!-- 特殊引用 -->

> [!NOTE]
> 笔记引用

> [!TIP]
> 提示引用

> [!IMPORTANT]
> 重要引用

> [!CAUTION]
> 注意引用

> [!WARNING]
> 警告引用

<!-- 引用嵌套 -->

> 这是一个引用
>
> > 这是一个嵌套引用

<!-- 引用中有代码块 -->

> 这是一个引用
>
> ```python
> print("hello world")
> ```

<!-- 引用中有列表 -->

> 这是一个引用
>
> - 列表 1

<!-- 其余语法同理 -->
````

## 扩展语法

- 脚注

```md
<!-- 脚注 -->

这是一个脚注[^1]

[^1]: 脚注内容
```

- 目录

```md
<!-- 目录 -->

[TOC]
```

- 公式

```md
<!-- 行内式 -->

$E=mc^2$

<!-- 块级式 -->

$$
\begin{math}
a & b \\
c & d
\end{math}
$$
```

- 任务列表

```md
<!-- 任务列表 -->

- [x] 已完成任务
- [ ] 未完成任务
```

- 表情 :heart:[部分](https://www.cnblogs.com/wutongxue132/p/16684085.html) :broken_heart:[全部](https://gist.github.com/rxaviers/7360908) :joy:[编辑器预览型](https://www.emojiall.com/zh-hans/all-emojis?type=normal)

```md
<!-- 表情 -->

:joy:
```

- 更多

```md
# 标题<sup>上标</sup>

# 标题<sub>下标</sub>

<p>支持<bold>HTML</bold>语法</p>

<h1>视频和iframe嵌入</h1>
<video src="https://www.w3school.com.cn/i/movie.mp4" controls="controls" width="320" height="240">
```

- 点击后展开内容

```md
<details>
  <summary>点击查看详情</summary>
  <p>这里是详情内容</p>
</details>
```

- 目录结构

```md
<!-- 根据缩进控制结构 -->

- 标题 1
  - 标题 1.1
- 标题 2
  - 标题 2.1
  - 标题 2.2
```

- wiki 链接

> [!TIP]
> 当Md标题中有空格时候，使用 `-` 来拼接字符

```md
<!-- 跳转到wiki文档指定标题 -->

[[wiki]](wiki.md#标题-文字)
```

## [wiki](wiki.md#二级标题-文字说明) 学习跳转
