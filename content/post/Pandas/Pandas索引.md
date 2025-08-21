---
title: "Pandas索引"
date: 2025-08-18
lastmod: 2025-08-18T22:40:00+08:00
tags: ["Pandas"]
categories: ["数据分析", "python"]
description: "Pandas索引"
---
# Pandas 索引器与多级索引笔记

---

## 一、索引器（Indexers）

Pandas 提供了多种方式来访问数据：

- **loc** ：基于标签（label）索引
- **iloc** ：基于整数位置（position）索引
- **at** ：快速标签访问单个标量
- **iat** ：快速位置访问单个标量

示例

```python
import pandas as pd

df = pd.DataFrame({
    "A": [1, 2, 3],
    "B": [4, 5, 6]
}, index=["x", "y", "z"])

print(df.loc["x", "A"])   # 标签索引 → 1
print(df.iloc[0, 0])      # 位置索引 → 1
print(df.at["y", "B"])    # 快速标签取值 → 5
print(df.iat[2, 1])       # 快速位置取值 → 6
```

## 二、单级索引（普通 Index）

- `df.index` ：索引对象

- `df.columns` ：列索引

- `df.reset_index()` ：恢复为普通列

- `df.set_index("col")` ：设置某列为索引

```python
df = pd.DataFrame({
"id": [101, 102, 103],
"name": ["Tom", "Jerry", "Anna"]
})
df2 = df.set_index("id")

print(df2)
print(df2.index)   # Index([101, 102, 103], dtype="int64")
```

  

## 三、多级索引（MultiIndex）

多级索引（层次化索引）用于表示分层的数据结构，可以应用于 **行** 或 **列**。

### 1. 创建多级索引

```
arrays = [
    ["a", "a", "b", "b"],
    [1, 2, 1, 2]
]
index = pd.MultiIndex.from_arrays(arrays, names=("level1", "level2"))

df = pd.DataFrame({"value": [10, 20, 30, 40]}, index=index)
print(df)
```

输出

```
level1 level2   value
a      1          10
       2          20
b      1          30
       2          40
```

### 2. 多级索引取值

```
print(df.loc["a"])        # 取 level1 = "a"
print(df.loc[("b", 1)])   # 取 level1="b" 且 level2=1
print(df.loc[("a", slice(None))])  # 取 level1="a" 所有值
```

## 四、多级索引常用操作

- **查看层级名称**

  ```
  print(df.index.names)   # ['level1', 'level2']
  ```

- **交换层级顺序**

  ```
  print(df.swaplevel())
  ```

- **按索引排序**

  ```
  print(df.sort_index(level=0))  # 按第0层排序
  ```

- **恢复普通列**

  ```
  print(df.reset_index())
  ```

📌 **总结：**

- `loc / iloc / at / iat` → 数据访问方式
- 单级索引适合一维标签，`set_index` / `reset_index` 转换灵活
- 多级索引能表示层级关系，常见于透视表、分组结果
- 常用操作有 `swaplevel`、`sort_index`、`reset_index`
