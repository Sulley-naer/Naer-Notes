# 数据结构

1. 每种数据结构是什么
2. 任何添加数据
3. 如何删除数据

## 栈

先进先出，后进后出，栈顶出入，进入叫压，出去叫弹。

ABCD 依次进入，完成之后 A 在站地，D 在栈顶，只有等 D 完成后等 CB，才能轮到 A 出栈，

<img alt="recording.gif" height="200" src="./images/Idea/data Structure-1723969174858.gif"/>

<img alt="recording.gif" height="200" src="./images/Idea/data Structure-1723969253112.gif"/>

## 队列

数据从后端进入队列叫：入队列 、从前端离开队列叫：出队列。先进先出，后进后出

<img alt="入队列" height="200" src="./images/Idea/data Structure-1723969522273.gif"/>

<img alt="出队列" height="200" src="./images/Idea/data Structure-1723969557583.gif"/>

## 组数

ArrayList 用的组数，并带有自动扩容。

查询速度快：查询可通过索引定位，查询速度容易数据耗时相同

删除效率低：移除原始数据，同时将后面数据前移

添加效率低：添加数据，同时后面数据后移

![array-view](./images/Idea/data Structure-1723970072430.png)

## 链表

数链接起来存储的方式 `LinkedLIst` 用的双向链表

<img alt="链表" height="200" src="./images/Idea/data Structure-1723970261252.png" width=""/>

![链表存储方式](./images/Idea/data Structure-1723970549516.png)

非连续数据导致查询慢，它需要从 head 挨个去看记录的地址，直到地址找到对应数据。

增删改会非常快，它不需要每次往后推移，在链表中间修改为新的地址值，增加删除则修改新地址的左右俩边的地址为他即可。

<img alt="增" height="200" src="./images/Idea/data Structure-1723971045901.png"/>

<img alt="删" height="200" src="./images/Idea/data Structure-1723971230698.png"/>

双向链表具备优化性，可判断数据距离头和尾谁近，就用谁来进行查询

<img alt="拓展链表" height="200" src="./images/Idea/data Structure-1723971376093.png"/>

## 二叉树

<img alt="binaryTree" height="200" src="./images/Idea/data Structure-1724059870944.png"/>

<img alt="binaryTreeMore" height="200" src="./images/Idea/data Structure-1724060019656.png"/>

## 二叉查找树

<img alt="binaryLookupTree" height="200" src="./images/Idea/data Structure-1724060192660.png"/>

<img alt="characteristics" height="200" src="./images/Idea/data Structure-1724060293556.png"/>

<img alt="recording.gif" height="200" src="./images/Idea/data Structure-1724060488437.gif"/>

<img alt="search.gif" height="200" src="./images/Idea/data Structure-1724060744014.gif"/>

遍历方式：

<img alt="oneway" height="200" src="./images/Idea/data Structure-1724060866686.png"/>

<img alt="twoWay" height="200" src="./images/Idea/data Structure-1724060987742.png"/>

<img alt="threeWay" height="200" src="./images/Idea/data Structure-1724061102437.png"/>

<img alt="fourWay" height="200" src="./images/Idea/data Structure-1724061153018.png"/>

记忆技巧：

<img alt="memories" height="200" src="./images/Idea/data Structure-1724061291605.png"/>

弊端：全是大于就会导致于链表相似。

<img alt="bad" height="200" src="./images/Idea/data Structure-1724061595445.png"/>

## 平衡二叉树

<img alt="demo" height="200" src="./images/Idea/data Structure-1724061935776.png"/>

<img alt="demo" height="200" src="./images/Idea/data Structure-1724061965389.png"/>

实现方式：

左旋

<img alt="left" height="200" src="./images/Idea/data Structure-1724062525478.png"/>

<img alt="way" height="200" src="./images/Idea/data Structure-1724062583756.png"/>

<img alt="recording.gif" height="200" src="./images/Idea/data Structure-1724062742911.gif"/>

<img alt="after" height="200" src="./images/Idea/data Structure-1724062875977.png"/>

<img alt="demo.gif" height="200" src="./images/Idea/data Structure-1724062996986.gif"/>

右旋

<img alt="example.gif" height="200" src="./images/Idea/data Structure-1724063153684.gif"/>

<img alt="example.gif" height="200" src="./images/Idea/data Structure-1724063261936.gif"/>

<img alt="demo.gif" height="200" src="./images/Idea/data Structure-1724063407890.gif"/>

出现情况

<img alt="example" height="200" src="./images/Idea/data Structure-1724063621755.png"/>

<img alt="example.gif" height="200" src="./images/Idea/data Structure-1724063904500.gif"/>

<br>

<img alt="example.gif" height="200" src="./images/Idea/data Structure-1724064028211.gif"/>

<img alt="example.gif" height="200" src="./images/Idea/data Structure-1724064124559.gif"/>

## 红黑树

数据结构（红黑树）红黑规则：

1. 每一个节点或是红色的，或者是黑色的
2. 根节点必须是黑色
3. 如果一个节点没有子节点或者父节点，则该节点相应的指针属性值为 Nil，这些 Nil 视为叶节点，每个叶节点(Nil)是黑色的
4. 如果某一个节点是红色，那么它的子节点必须是黑色(不能出现两个红色节点相连的情况)
5. 对每一个节点，从该节点到其所有后代叶节点的简单路径上，均包含相同数目的黑色节点;
6. 后代节点叶片：子级 Nil 叶片。简单路径：一条路走不回头。 **增删改查性能都强**

<img alt="illustrate" height="200" src="./images/Idea/data Structure-1724064734773.png"/>

<img alt="demo" height="200" src="./images/Idea/data Structure-1724065043290.png"/>

<img alt="demo" height="200" src="./images/Idea/data Structure-1724065064734.png"/>

<img alt="example.gif" height="200" src="./images/Idea/data Structure-1724065724469.gif"/>

规则处理方式：

<img alt="ruler" height="200" src="./images/Idea/data Structure-1724065853383.png"/>

## 总结

1. 二叉树是基础的数据存储方式
2. 二叉查找数是为了解决二叉树数据混乱的问题
3. 平衡二叉树是解决二叉树数据偏斜
4. 红黑数测底解决了二叉树系列的所有问题，省去了频繁旋转的性能。
