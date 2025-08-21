---
title: "Pandas基础"
date: 2025-08-18
lastmod: 2025-08-18T21:40:00+08:00
tags: ["Pandas"]
categories: ["数据分析", "python"]
description: "Pandas基础使用"
---



# 一、文件的读取和导入

## 数据读取 

```python
import pandas as pd
print(pd.__version__)  #查看版本
# 读取 csv
df_csv = pd.read_csv(r"data/my_csv.csv")  # 推荐使用相对路径
# 读取 txt
df_txt = pd.read_table(r"data/my_table.txt")
# 读取 excel
df_excel = pd.read_excel(r"data/my_excel.xlsx")
```
常用参数：

- header=None      第一行不作为列名
- index_col        指定某列作为索引
- usecols          指定读取的列
- parse_dates      指定需要转为时间的列
- nrows            指定读取的行数

指定分隔符 sep 

- sep=',' → 逗号分隔 
- sep='\t' → 制表符分隔（read_table 默认就是 \t） 
- sep='\s+' → 多个空格分隔 
- sep=';' → 分号分隔
> `read_csv()` 默认 `sep=','`，读取 csv 文件无需显式写 `sep=','`。
> `read_table()` 默认 `sep='\t'`，所以读取制表符 txt 文件可以直接用，不用改 sep。
> `read_excel` 不需要 `sep`，因为 Excel 文件本身有单元格结构，不是纯文本分隔的。

## 数据写入

常用：index=False 避免保存索引

```python
df_csv.to_csv(r"data/my_csv_saved.csv", index=False)
df_excel.to_excel(r"data/my_excel_saved.xlsx", index=False)
df_txt.to_csv(r"data/my_table_saved.txt", sep='\t', index=False)
```

如果想要把表格转换为 markdown 和 latex 语言，可以使用 to_markdown 和 to_latex 函数，此处需要安装 tabulate 包。

```python
df_csv.to_markdown()
df_csv.to_latex()
```

# 二、基本数据结构
## 1. Series
```python
s = pd.Series([100, 'a', {'dic1': 5}, 1],
              index=pd.Index(['id1', 20, 'third', 'id2'], name='my_idx'),
              dtype='object',
              name='my_name')
```

**常用属性**
- **s.values**
返回 Series 的 **数据值**（NumPy 数组形式）
例子输出：`array([100, 'a', {'dic1':5}, 1], dtype=object)`
- **s.index**
返回 Series 的 **索引**（Index 对象）
例子输出：`Index(['id1', 20, 'third', 'id2'], dtype='object', name='my_idx')`
可以用来访问或操作索引
- **s.dtype**
返回 Series **数据类型**
例子输出：`object`
因为这里混合了数字、字符串和字典，所以 dtype 是 `object`
- **s.name**
返回 Series 的 **名称**
例子输出：`'my_name'`
方便在 DataFrame 中作为列名使用
- **s.shape**
返回 Series 的 **形状**
例子输出：`(4,)` → 一维，有 4 个元素
- **s**['id1']
根据索引取单个值
输出：`100`

## 2. DataFrame
```
data = [[1, 'a', 1.2], [2, 'b', 2.2], [3, 'c', 3.2]]
df = pd.DataFrame(data, index=['row_0','row_1','row_2'],
                  columns=['col_0','col_1','col_2'])
或使用字典构造：
df = pd.DataFrame({'col_0':[1,2,3],
                   'col_1':list('abc'),
                   'col_2':[1.2,2.2,3.2]},
                  index=['row_0','row_1','row_2'])
```

### 常用属性

**df[['col_0','col_1']]**
 获取多列，返回新的 DataFrame

```
print(df[['col_0','col_1']])
# 输出示例：
#       col_0 col_1
# row_0      1     a
# row_1      2     b
# row_2      3     c
```

**df.values**
 返回 DataFrame 的数据值（NumPy 数组形式，不包含列名和索引）

```
print(df.values)
# 输出示例：
# [[1 'a' 1.2]
#  [2 'b' 2.2]
#  [3 'c' 3.2]]
```

**df.index**
 返回 DataFrame 的行索引（Index 对象）

```
print(df.index)
# 输出示例：
# Index(['row_0','row_1','row_2'], dtype='object')
```

**df.dtypes**
 返回每列的数据类型（Series）

```
print(df.dtypes)
# 输出示例：
# col_0      int64
# col_1     object
# col_2    float64
# dtype: object
```

**df.shape**
 返回 DataFrame 形状 (行数, 列数)

```
print(df.shape)
# 输出示例：
# (3, 3)
```

**df.T**
 DataFrame 转置，行列互换

```
print(df.T)
# 输出示例：
       row_0 row_1 row_2
col_0      1     2     3
col_1      a     b     c
col_2    1.2   2.2   3.2
```

# 三、常用基本函数

创建 DataFrame：学生成绩数据

```python
data = {
'name': ['张三', '李四', '王五', '赵六', '陈七', '张三', '孙八', '周九'],
'class': ['A班', 'B班', 'A班', 'B班', 'A班', 'A班', 'B班', 'A班'],
'gender': ['男', '男', '女', '男', '女', '男', '女', '男'],
'math': [85, 92, 78, 96, 88, 85, 73, 90],
'english': [80, 85, 90, 75, 82, 80, 88, 86],
'science': [np.nan, 88, 85, 92, 78, 95, 80, 84],
'city': ['北京', '上海', '广州', '深圳', '北京', '北京', '杭州', '深圳']
}
df = pd.DataFrame(data)
```

## 1.汇总函数（快速查看数据）

```python
head(n) - 查看前 n 行
print(df.head(3))
tail(n) - 查看后 n 行
print(df.tail(2))
info() - 查看数据结构（列名、非空值、类型）
df.info()
describe() - 数值列的统计摘要
print(df.describe())
```



## 2、特征统计函数（对数值列操作）

```
选择数值列
numeric_cols = ['math', 'english', 'science']
sum: 求和
print(df[numeric_cols].sum())
mean: 平均值
print(df[numeric_cols].mean())
median: 中位数
print(df[numeric_cols].median())
var: 方差
print(df[numeric_cols].var())
std: 标准差
print(df[numeric_cols].std())
max/min: 最大最小值
print(df[numeric_cols].max())
print(df[numeric_cols].min())
quantile: 分位数
print("quantile(0.25):\n", df[numeric_cols].quantile(0.25))
count: 非空值数量（注意：science 少一个）
print("count:\n", df[numeric_cols].count())
idxmax: 最大值的索引位置
print("idxmax (math 最高分是谁?):\n", df['math'].idxmax())
```



## 3、唯一值函数（处理分类 / 文本列）

```
unique: 返回唯一值（去重）
print(df['gender'].unique())
nunique: 唯一值个数
print(df['class'].nunique())
value_counts: 各值出现次数
print(df['gender'].value_counts())
duplicated: 返回每行是否是重复行
print(df.duplicated(subset=['name']))
drop_duplicates: 删除重复行
df_no_dup = df.drop_duplicates(subset=['name'], keep='first')
print(df_no_dup[['name', 'math']])
subset = ['name']表示按姓名去重，keep = 'first'保留第一次出现的
```



## 4、替换函数（replace）

方法1：单值替换

```
df['gender'] = df['gender'].replace('男', 'Male')
print("性别替换为英文:\n", df[['name', 'gender']])
```

方法2：字典替换

```
df['class'] = df['class'].replace({'A班': 'Class A', 'B班': 'Class B'})
print("班级替换:\n", df[['name', 'class']].head(3))
```

方法3：用 np.nan 替换异常值

```
df['math'] = df['math'].replace(96, np.nan)
print("数学96替换为NaN:\n", df[['name', 'math']].head(4))
```



## 5、排序函数（Sorting）

```python
sort_values()：按值排序
df_sorted = df.sort_values(by='math', ascending=False)
print(df_sorted[['name', 'math']])
# 输出：赵六96 → 周九90 → 李四92 → ...

print("\n2. 按多个列排序：先按班级，再按数学成绩降序：")
df_sorted2 = df.sort_values(by=['class', 'math'], ascending=[True, False])
print(df_sorted2[['name', 'class', 'math']])
# 先排A班，数学高的在前；再排B班

print("\n3. 按姓名字符串排序（升序）：")
df_sorted_name = df.sort_values(by='name', ascending=True)
print(df_sorted_name[['name', 'math']])
中文按拼音排序：陈七 → 李四 → 孙八 → 王五 → 张三 → 赵六 → 周九2.sort_index()：按索引排序  # 打乱索引示例


df_shuffled = df.sample(frac=1)  # 随机打乱行
print("\n打乱后：")
print(df_shuffled[['name', 'math']])

print("\n按索引排序恢复：")
df_restored = df_shuffled.sort_index()
print(df_restored[['name', 'math']])
适用于索引有序但被打乱的情况
```



## 6、apply方法（数据转换利器）

apply可以对行、列、元素应用自定义函数。
1).对某一列使用apply

```
示例：判断数学是否优秀
def is_good_math(score):
return '优秀' if score >= 90 else '良好'
df['math_level'] = df['math'].apply(is_good_math)
print(df[['name', 'math', 'math_level']])
示例：字符串处理（城市加“市”）
df['city_full'] = df['city'].apply(lambda x: x + "市")
print(df[['city', 'city_full']])
```

2).对多列使用

```
apply（axis = 1表示按行）
示例1：计算总分（跳过NaN）
def calculate_total(row):
return row['math'] + row['english'] + (row['science'] if pd.notna(row['science']) else 0)
df['total'] = df.apply(calculate_total, axis=1)
print("\n6. 每人总分：")
print(df[['name', 'math', 'english', 'science', 'total']])
```

示例2：计算总分后，生成评语

```
def get_comment(row):
if row['total'] > 250:
return "优秀"
elif row['total'] > 230:
return "良好"
else:
return "加油"
df['comment'] = df.apply(get_comment, axis=1)
print("\n7. 添加评语：")
print(df[['name', 'total', 'comment']])
```

3).对整个Series或DataFrame使用apply

```
对多列同时 apply（比如标准化）
print("\n8. 数学成绩标准化（减均值除标准差）：")
mean = df['math'].mean()
std = df['math'].std()
df['math_std'] = df['math'].apply(lambda x: (x - mean) / std)
print(df[['name', 'math', 'math_std']].round(2))
```



# 四、窗口函数（Window Functions）

Pandas 提供了 3 种窗口类型，常用于时间序列或顺序数据。我们先构造一个时间序列数据来演示：

```python
#创建时间序列数据：某产品每日销量
dates = pd.date_range('2025-01-01', periods=10)
sales = [100, 120, 110, 130, 140, 135, 150, 160, 155, 170]
df_ts = pd.DataFrame({'date': dates, 'sales': sales})
df_ts.set_index('date', inplace=True)
print("时间序列数据:")
print(df_ts)
```



## 滑动窗口

   rolling()（最常用）计算固定窗口大小的统计值，如“过去3天的平均销量”。

```python
# 3日移动平均
df_ts['ma_3'] = df_ts['sales'].rolling(window=3).mean()
print("\n1. 3日移动平均:")
print(df_ts[['sales', 'ma_3']])
输出： sales ma_3
2025-01-01 100 NaN
2025-01-02 120 NaN
2025-01-03 110 110.000000
2025-01-04 130 120.000000
...
前两行是 NaN，因为不够3个数据
```

  

## 扩张窗口

   expanding()

```python
#从开始到当前的所有数据进行计算，如“累计平均”。
#累计平均销量
df_ts['expanding_mean'] = df_ts['sales'].expanding().mean()
print("\n2. 累计平均:")
print(df_ts[['sales', 'expanding_mean']])
#越往后，窗口越大，结果越稳定
```

  

## 指数加权窗口：

   ewm()（Exponentially Weighted）越近的数据权重越高，适合趋势预测。
```
#指数加权移动平均（EWMA）
df_ts['ewm_mean'] = df_ts['sales'].ewm(alpha=0.3).mean()
print("\n3. 指数加权平均 (alpha=0.3):")
print(df_ts[['sales', 'ewm_mean']])
alpha 越大，越重视近期数据
```

​    

  
