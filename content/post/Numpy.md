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
```python
np.array([1, 2, 3])                  # 普通数组
np.zeros((2, 3))                      # 全0
np.ones((3, 3))                       # 全1
np.full((2, 2), 7)                    # 全部填充7
np.eye(3)                             # 单位矩阵
np.arange(0, 10, 2)                   # 0到10步长2
np.linspace(0, 1, 5)                  # 等间距5个数
```
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

