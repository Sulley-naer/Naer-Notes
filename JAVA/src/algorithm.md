# 算法

## 顺序查找、基本查找

> 循环数组直到发现对象，没有则继续循环到最后，

```java
public static boolean BasicSearch(int[] list, int target) {
    for (int i = 0; i < list.length; i++) {
        ArrayList<Integer> dx = new ArrayList<>();//?可能重复出现，统计出现次数
        if (list[i] == target) {
            dx.add(i);
            return true;
        }
    }
    //return dx;
    return false;
}
```

## 二分查找、折半查找

> [!TIP]
> 数据具有规律性，每次查找都会，排除一半查找范围，比如 a-z d 开头直接去大概范围内

[1,2,3,4,5,6,7,8,9] `target:7`

`max：length`
`min: 0`

第一次直接 max/2 判断值。5 小于目标，目标肯定在右边部分。

接着循环 max 次，每次循环判断，组数 min 的值，不对就根据中间值缩小范围

```java
public static int binarySearch(int[] list, int target) {
    int min = 0, max = list.length;
    //循环条件是防止找不到数据，无限循环下去。
    while (min <= max) {
        int mid = (min + max) / 2;
        if (list[mid] == target) {
            return mid;
        } else if (list[mid] > target) {
            max = mid - 1;
        } else if (list[mid] < target) {
            min = mid + 1;
        }
    }
}

;
```

## 分块查找

> [!TIP}
> 数据看似无顺序，但是实际有顺序，将数组拆成块来查看,会随着块增长最大值
>
> 记录每一块的最大值，和相应范围根据块快速查找。

代码懒得写了，用类的记录块最大、起始位置、结束位置、块长度公式是**数据长度开根号**

数据小于最大值就去对应区块查找，如何增长问题可以通过，块内增加偏移量变量

外面循环查找一次，内部偏移量增长一次，返回对象往后偏移，实现自动切换。

无序分快查找可通过，类中记录最小值和最大值，根据他们进行查询

`int[] r = {16,5,9,12,21,18,32,23,37,26,45,34,50,48,61,52,73,66};`

## 冒泡排序

> [!TIP]
> 最基础的排序，当作性能单位，左右比较，0>1 1>2 ……

```java
public static void main(String[] args) {
    int[] arr = {10, 30, 50, 8, 9, 65};

    for (int i = 0; i < arr.length; i++) {
        for (int j = 0; j < arr.length - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

    for (int i = 0; i < arr.length; i++) {
        System.out.println(arr[i]);
    }
}
```

## 选择排序

> 跟冒泡相反，挨个值比较，性能时间无差距,零比较后续所有值，0 > 1 0 > 2 ……

```java
public static void main(String[] args) {
    int[] arr = {10, 30, 50, 8, 9, 65};


}
```

## 插入排序『最佳排序』

> 插入排序是将数组拆分两种情况，有序和无序，再将有序部分保留。
>
> 后面对无序部分的数据，对有序部分比较，放置正确位置。
>
> 性能优化非常强，是依次递增试的增长。

```java
public static void main(String[] args) {
    int[] arr = {3, 44, 38, 5, 47, 15, 36, 26, 27, 2, 46, 4, 19, 50, 48};
    int start = -1;
    //!计算有序部分
    for (int i = 1; i < arr.length; i++) {
        if (arr[i] > arr[i - 1]) {
            start = i;
        } else {
            break;
        }
    }

    for (int i = start; i < arr.length; i++) {
        int j = i;
        //!判断当前位置的值，是否小于有序部分，有则交换位置，一开始就不满足条件，不会执行任何代码。
        while (j > 0 && arr[j] < arr[j - 1]) {
            //? 38<44 就进行交换，再进行自减
            //?自减完成会再次进行判断，38<3 满足责继续，直到第一位。
            int temp = arr[j];
            arr[j] = arr[j - 1];
            arr[j - 1] = temp;
            j--;
            //!自减的目的就是为了，指到交换之后的当前位置的数据，再它新位置的前面一个人再次进行判断。
        }
    }
}
```

## 递归算法『常用算法』

> 递归是指方法自己调用自己，递归一定要有出口，会导致内存溢出
>
> 相比较其他算法，它跟容易使用，只需要知道出口和规则，就能使用
>
> 注意！递归的性能比循环差很多！递归适合解决循环无法表达的功能。

- 计算 1 ~ 100 之间的合

```java
public static void main(String[] args) {
    int sum = 0;
    sum = Recursion(0, 100, sum);
    System.out.println(sum);
}

public static int Recursion(int start, int end, int sum) {
    start++;
    sum += start;
    if (start == end) {
        //System.out.println(sum);
        return sum;
    } else {
        return Recursion(start, end, sum);
    }
}
```

- 阶层

> 方法内再次调用自己的时候，参数必须要更靠近出口。

```java
/*
 * 阶层:
 * 5! = 5*4
 * 4! = 4*3
 * 3! = 3*2
 * 2! = 2*1
 * 1! = 1
 * */
public static int getFactorialRecursion(int number) {
    if (number == 1) {
        //!出口
        return 1;
    }

    return number * getFactorialRecursion(number - 1);
    //!栈执行时候看参数返回值，到出口1返回值 2 * 1 它再返回 3 * 2 然后再 4 * 6
    //!它拥有了值才能进行运算，出口前的所有都在等待返回值，有了返回值再进行运算返回，直到最后一层。
}
```

- 递归

```java
//!最快理解示例，递归一定要有规则，某个值增长，直到出口位置，根据出口内容返回计算。
public static int get(int month) {
    //!设置一二月固定值，固定值是出口！
    if (month == 1 || month == 2) {
        return 1;
    }
    //?一直堆栈直到叠倒 1 和 2 有出口返回值的时候，再一层层返回值计算。
    return get(month - 1) + get(month - 2);
}
```

- 反向递归

猴子第十天吃了桃子，剩余了一个，每天固定吃一个，后面每天吃前天的一半，第一天吃的一个。

```java
public static int getSum(int day) {
    if (day > 10) {
        return -1;
    } else if (day == 10) {
        return 1;
    }
    //?规律：每天吃前一天的一半，固定一个
    return (getSum(day + 1) + 1) * 2;
}
```

- 斐波那契

爬楼梯一共 100 阶梯，使用递归计算，一共有多少种爬法

```java
public static void UpTheLadder(int n) {
    //?规律：一次 爬一阶 或 爬二阶梯
    if (n == 1) {
        return 1;
    } else if (n == 2) {
        return 2;
    }
    //!将每次爬一阶的爬法和二阶的合并，就知道总次数了
    return UpTheLadder(n - 1) + UpTheLadder(n - 2);
}

```

## 快速排序

> 递归和排序结合使用的算法，性能并不占优势使用循环是最佳方案，但是它非常快！
> 栈一直运行，循环是内存要更新 index
>
> 找到之后交换 start 和 end 指向的元素，并循环这一过程，直到 start 和 end
> 处于同一个位置，该位置是基准数在数组中应存入的位置，再让基准数归位。
>
> 归位后的效果：基准数左边的，比基准数小，基准数右边的，比基准数大

双指针数组拆分左右二部分，再选择其中一个数作为基数，再根据基数去判断

右指针一直找到小于基数的数据记录位置，左指针找大于的数据，再进行交换。

执行完成一次后当前数据的正确位置就完成了，而其他数据需要通过递归。

```java
public static void quickSort(int[] arr, int left, int right) {
    int start = left;
    int end = right;

    int base = arr[left];

    if (start >= end) {
        return;
    }

    //寻找自己应该放在什么位置。
    while (start != end) {
        while (end > start && arr[end] >= base) {
            end--;
        }

        while (end > start && arr[start] <= base) {
            start++;
        }
        //交换错误位置的数据
        int temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
    }
    //将自己存入正确位置。
    int temp = arr[left];
    arr[left] = arr[start];
    arr[start] = temp;

    //当前数据左边的数据都进行一次排序
    quickSort(arr, left, start - 1);
    //右边数据同样进行一次排序。
    quickSort(arr, start + 1, right);
    //!start是当前数据的位置，将当前数据位置前面的所有数据都进行排序 0~5 0~4 0~3 ……
    //!再对右边数据进行排序，1~6 2~6 3~6 ……
}
```

## 概率算法

TxT文件中事先准备好一些学生信息，每个学生的信息独占一行。

要求1：每次被点到的学生，再次被点到的概率在原先的基础上降低一半。

举例：80个学生，点名5次，每次都点到小A，概率变化情况如下：

第一次每人概率：1.25%。
第二次小A概率：：0.625%。其他学生概率：1.2579%
第三次小A概率：0.3125%。其他学生概率：1.261867%
第四次小A概率：0.15625%。其他学生概率：1.2638449%
第五次小A概率：0.078125%。其他学生概率：1.26483386%
提示：本题的核心就是带权重的随机

> [!TIP]
> 核心难点就是控制随机性，化繁为简的思想，能有效增加解题时间。

### 解题思路

> 依次类推，默认概率 1.25，就让每一个对象，设定一个数值范围。
> 在后续修改时，同步修改范围，其他对象同理，增加概率=增加范围。

钦逸抒-女-21 {0~0.1} 
屈燕妮-女-24 {0.1~0.2}
阴诗雁-女-25
伯荷燕-女-24
欧文新-男-20
董泽欧-男-18
滕星磊-男-18
阚晴岚-女-22
傅彬远-男-19
左花依-女-24
