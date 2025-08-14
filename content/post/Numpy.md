---
title: "Numpy"
date: 2025-08-06
lastmod: 2025-08-12T23:30:00+08:00
tags: ["Numpy"]
categories: ["数据分析", "python"]
description: "Numpy详细教程"
---
数据分析：是把隐藏在一些看似杂乱无章的数据背后的信息提炼出来，总结出所研究对象的内在规律
数据分析三剑客：**Numpy,Pandas,Matplotlib**

Numpy是Python语言的一个扩展程序库，支持大量的维度数组与矩阵运算，此外也针对数组运算提供大量的数学函数库。
NumPy 核心功能：

> - NumPy 的核心是 ndarray（多维数组对象），它相比 Python 的 list 有几个优势：
> - 存储更紧凑（同类型数据，连续内存）
> - 运算速度快（底层 C 实现）
> - 支持广播机制（不同形状数组自动匹配运算）
> - 提供大量数学函数和线性代数工具
>


# 安装导入
```python
pip install numpy
import numpy as np
print(np.__version__)
```

# 创建数组

## 一维数组（1D Array）

- 就像一个**数字列表**，只有一个维度。
- 结构类似 Python 里的列表 `[1, 2, 3, 4]`。
- 表示一条“**线**”上的数据。

```python
arr_1d = np.array([10, 20, 30, 40])
print(arr_1d)
# 输出: [10 20 30 40]
print(arr_1d.shape)
# 输出: (4,)  表示长度是4的一维数组 
```
## 二维数组（2D Array）

- 类似于一个表格（矩阵），有“行”和“列”两个维度。

- 结构类似 Python 里的嵌套列表 [[1, 2], [3, 4]]。

- 表示“**矩阵**”或“**二维平面**”上的数据。

```shell
arr_2d = np.array([[1, 2, 3],
[4, 5, 6]])
print(arr_2d)
# 输出:# [[1 2 3]
#  [4 5 6]]
print(arr_2d.shape)
# 输出: (2, 3)  表示2行3列的二维数组
```

##   三维数组（3D Array）

- 形状是 `(层数, 行数, 列数)`，就是**多张二维矩阵叠加**在一起。
- 类似于一个“**数据立方体**”。
- 常用于表示彩色图片（宽×高×RGB三通道）、视频帧序列，或者多组二维数据集合。
```python
import numpy as np

arr_3d = np.array([
    [[1, 2, 3],    # 第1层，第一行
     [4, 5, 6]],   # 第1层，第二行

    [[7, 8, 9],    # 第2层，第一行
     [10, 11, 12]] # 第2层，第二行
])

print(arr_3d)
# 输出：
# [[[ 1  2  3]
#   [ 4  5  6]]
#
#  [[ 7  8  9]
#   [10 11 12]]]
print(arr_3d.shape)
# 输出：(2, 2, 3)
# 表示2层，每层2行3列
```
| 维度 | 用途举例                 | 视觉形象     |
| ---- | ------------------------ | ------------ |
| 1维  | 数组、向量               | 线           |
| 2维  | 矩阵、表格               | 面           |
| 3维  | 立体数据（视频、彩色图） | 体（立方体） |

更多维度就是在三维基础上继续“叠加”更多维度，但在实际应用中，超过 5~10 维的数组就非常少见了，太高维的数组很难直观理解和处理。



> 注意:
> numpy默认ndarray的所有元素的类型是相同的
> 如果传进来的列表中包含不同的类型，则统一为同一类型，优先级:str>fioat>int
>
> arr_2d = np.array([[1,2.1,3],[4,5,"six"]])
> print(arr_ad)
> #([['1', '2.1', '3'],
> #['4', '5', 'six']], dtype='<U32')



# 数组属性
```python
arr.shape      # 形状
arr.ndim       # 维度
arr.size       # 元素总数
arr.dtype      # 数据类型
```
# 数组运算
```python
a + b          # 加
a - b          # 减
a * b          # 元素相乘
a / b          # 元素相除
np.dot(a, b)   # 矩阵乘法
np.sum(a)      # 求和
np.mean(a)     # 均值
np.max(a)      # 最大值
np.min(a)      # 最小值
np.sqrt(a)     # 平方根
```
# 索引与切片
```python
a[0, 2]        # 第1行第3列
a[:, 0]        # 第一列
a[1, :]        # 第二行
a[0:2, 1:3]    # 子数组切片
a[a > 5]       # 布尔索引
```
# 形状变换
```python
a.reshape(2, 3)  # 改形状
a.flatten()      # 拉平成一维
a.T              # 转置
```
# 拼接与分割
```python
np.concatenate([a, b], axis=0) # 行拼接
np.concatenate([a, b], axis=1) # 列拼接
np.split(a, 2, axis=0)         # 按行分割
```
# 随机数
```python
np.random.rand(2, 3)      # 0-1均匀分布
np.random.randn(2, 3)     # 标准正态分布
np.random.randint(0, 10, (2, 3)) # 整数
np.random.seed(42)        # 固定随机数种子
```

