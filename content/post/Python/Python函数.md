---
title: "Python函数"
date: 2025-08-21
lastmod: 2025-08-21T22:30:00+08:00
tags: ["python", "python函数"]
categories: ["python基础"]
description: "Python函数"
---

# global语句
```python
name = {"name": "zhangsan"}

#修改全局
def func():
    global name
    name = {"name": "lisi"}  # 相当于重新赋值，需要 global
def foo():
    name["name"] = "lisi"  # 当只改内容，不换对象时， 不需要 global也可以修改全局

```
>如果只是改字典/列表的“内容”（如 d["key"] = value） →  不需要 global，函数可以直接修改全局的字典
>如果要重新赋值整个变量（如 name = {}） →  必须加 global name，否则 Python 会创建局部变量

# 装饰器

## 装饰器介绍

**本质**
  装饰器本质就是一个函数，返回一个新的函数。
  它的核心目的是：不改原函数代码，就能增加新功能
**代码对比**
  比喻：毛坯房vs精装房（装饰器==房子装修队）

**装饰器前（原函数）**

```python
def house():
print("一个空的毛坯房，只有墙和门")
```

**手动改造（麻烦）**

```python
def house():
    print("一个空的毛坯房，只有墙和门")
    print("装修队进场：铺地板、刷墙")
    print("家具进场：沙发、电视、冰箱")
#既破坏了原始函数，又不优雅。
```

**装饰器写法**

```python
def decorator_team(func):
    def decorated_house():
        func()
        print("装修队进场：铺地板、刷墙")
        print("家具进场：沙发、电视、冰箱")
    return decorated_house    # 返回精装房

#语法糖形式写法
@decorator_team  
def house():
    print("一个空的毛坯房，只有墙和门")
house()

#下面等价于语法糖写法：
def house():
    print("一个空的毛坯房，只有墙和门")
house = decorator_team(house)
    #开始装修！
    #装修队decorator_team给毛坯房house装修！
    #被装修的：house(原函数),
    #执行装修的：decorator_team(装饰器)
    #装修结果：decorated_house(新函数)
house()  # 谁在执行？
	#你拿到是house已经是精装房了！因为 house现在指向的是decorated_house


```



##  带参数的装饰器

装修风格可以不同，比如豪华版、简约版。
这时装饰器需要 **接受参数**：

```python
def decorator_team(style): #外层函数（接受参数）（豪华 / 简约 …）
    def wrapper(func):     #中层（接受被装饰的函数）
        def decorated_house():  #内层（包装函数，执行逻辑）
            func()
            print(f"装修队进场：{style} 风格装修")
            print("家具进场：沙发、电视、冰箱")
        return decorated_house
    return wrapper

@decorator_team("豪华")
def house():
    print("一个空的毛坯房，只有墙和门")

house()
```

## 多层装饰器

你可以叠加多个装修队：

```python
def add_floor(func):
    def wrapper():
        print("加一层楼！")
        func()
    return wrapper

def add_garden(func):
    def wrapper():
        func()
        print("再加个花园！")
    return wrapper

@add_garden
@add_floor
def house():
    print("一个空的毛坯房，只有墙和门")

house()
```

> 输出
>
> 加一层楼！
> 一个空的毛坯房，只有墙和门
> 再加个花园！

## 注册类装饰器

```python
import PySimpleGUI as sg

"""
服务注册中心，类似微服务console/Nacos概念
"""

tasks = {} # 登记本：家务任务 -> 执行函数
def assign(task_name):
    """注册装饰器：登记谁负责做哪件家务"""
    def decorator(func):
        tasks[task_name] = func
        print(f"[登记] 家务 '{task_name}' -> {func.__name__} 负责")
        return func
    return decorator

"""
服务提供者
"""
# -----------------------------
# 定义家务（函数定义时自动登记）
# -----------------------------
@assign("洗碗")
def zhangsan():
    sg.popup("Zhangsan 在洗碗~")

@assign("扫地")
def lisi():
    sg.popup("Lisi 在扫地~")

@assign("倒垃圾")
def wangwu():
    sg.popup("Wangwu 在倒垃圾~")

"""
服务消费者
"""
# -----------------------------
# GUI 部分
# -----------------------------
layout = [
    [sg.Text("请选择要执行的家务:")],
    [sg.Button(task) for task in tasks.keys()],
    [sg.Button("退出")]
]

window = sg.Window("家务执行器", layout)

while True:
    event, values = window.read()
    if event in (sg.WINDOW_CLOSED, "退出"):
        break
    if event in tasks:   # 服务发现
        tasks[event]()   # 服务消费

window.close()
```
