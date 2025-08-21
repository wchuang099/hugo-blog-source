---
title: "Jupyter使用"
date: 2025-08-11
tags: ["Jupyter"]
categories: ["python", "数据分析"]
description: "Jupyter使用入门教程"
---

Jupyter 是一个交互式的计算环境，主要用于写、运行和展示代码（Python、R、Julia 等），非常适合做数据分析、可视化、机器学习实验或者写教程笔记。  

# 安装 Jupyter

Jupyter 需要 Python 环境

```python
pip install notebook
pip install jupyterlab-language-pack-zh-CN
jupyter notebook   #进入你想工作的文件夹，然后启动。
jupyter lab #这是另一种启动方式,jupyterlab是jupyter notebook的下一代产品，集成了更多功能
```
>浏览器会自动打开 `http://localhost:8888`
>如果浏览器没自动打开，会在终端看到一个链接，复制到浏览器即可。
>启动后在Settings--Language-Chinese (Simplified, China)-中文(简体,中国)，进行切换显示语言。
# 基本使用
## 创建新 Notebook
在网页右上角选择 New → Python 3（或其它语言）
会出现一个 .ipynb 文件，分为 Cell（单元格）

单元格类型
```python
Code：写代码并运行（Shift + Enter 执行）
Markdown：写文字说明（支持标题、公式、图片）
Raw：原始文本，不执行
```

  

## 常用快捷键（命令模式下）
```shell
Esc 进入命令模式，Enter 进入编辑模式
A 在上方插入单元格
B 在下方插入单元格
DD 删除单元格
M 把单元格改为 Markdown
Y 把单元格改为 Code
Shift + Enter 运行并跳到下一格

在 Jupyter Notebook 里，打开帮助文档的快捷键是：
按 Shift + Tab，把光标放到函数或对象名后面，按一次 Shift + Tab 会弹出简要帮助提示（参数说明）。
连续按 Shift + Tab 两次或三次，会展开更详细的文档窗口。


```

##  进阶技巧

- **可视化示例**

```python
import matplotlib.pyplot as plt
x = [1, 2, 3, 4]
y = [1, 4, 9, 16]
plt.plot(x, y)
plt.show()

```

# Jupyter + Pandas 数据分析入门示例
- 安装必要的库

  ```
  pip install pandas matplotlib
  ```

- 代码示例

```shell
import pandas as pd
import matplotlib.pyplot as plt


# 让图表直接显示在 Notebook 中
%matplotlib inline  

# 设置中文字体
plt.rcParams["font.family"] = ["Microsoft YaHei"]
plt.rcParams["axes.unicode_minus"] = False

# ===== 1. 创建模拟账单数据 =====
data = {
    "日期": ["2025-08-01", "2025-08-01", "2025-08-02", "2025-08-02", "2025-08-03"],
    "分类": ["餐饮", "交通", "餐饮", "购物", "交通"],
    "金额": [35.5, 12.0, 58.0, 200.0, 18.0],
    "备注": ["早餐", "地铁", "午餐", "超市", "公交"]
}

df = pd.DataFrame(data)
df["日期"] = pd.to_datetime(df["日期"])

print("=== 原始数据 ===")
print(df)

print("\n=== 餐饮类消费 ===")
print(df[df["分类"] == "餐饮"])

category_sum = df.groupby("分类")["金额"].sum().reset_index()
print("\n=== 按分类汇总 ===")
print(category_sum)

plt.figure(figsize=(5, 5))
plt.pie(category_sum["金额"], labels=category_sum["分类"], autopct="%.1f%%")
plt.title("各类消费占比")
plt.show()

daily_sum = df.groupby("日期")["金额"].sum().reset_index()
plt.figure(figsize=(6, 4))
plt.plot(daily_sum["日期"], daily_sum["金额"], marker="o")
plt.title("每日总消费趋势")
plt.xlabel("日期")
plt.ylabel("金额 (元)")
plt.grid(True)
plt.show()

```

