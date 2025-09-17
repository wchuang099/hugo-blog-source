---
title: "大漠插件"
date: 2025-09-17
categories: ["图色脚本","大漠插件"]
---



# Python调用大漠插件注意事项

**管理员权限**

- PyCharm 必须 **以管理员身份运行**（或者你用 `python.exe` 直接运行也要管理员权限）。

**Python 必须是 32 位版本**

- 大漠插件本身是 32 位的 COM 组件，所以只能在 **32 位 Python** 下调用。

 



# 注册方式

### **传统方式（注册调用）**

以前要调用大漠插件（dm.dll），需要先用 **regsvr32  dm.dll**来进行注册。这样做的实质是把COM 组件的信息写入 Windows 注册表，让系统知道 `dm.dll` 是一个 COM 对象，可以用 `CreateObject("dm.dmsoft")` 或者 `new ActiveXObject("dm.dmsoft")` 来创建。

缺点：

- 必须有管理员权限才能注册。
- 污染注册表，易被游戏检测

###  **无注册方式（DmReg.dll）**

从 **大漠插件 3.1235 版本**开始，可以用 **DmReg.dll**来绕过注册表，直接加载对应的`dm.dll`，也就是说你不需要再用`regsvr32`，只要在程序启动时调用 `DmReg.dll` 的接口就行。

DmReg.dll暴露了 **两个导出函数**：

- `SetDllPathA(const char* path, int mode)`
  - 参数 1：ASCII 字符串（插件所在路径，比如 `"C:\\dm"`）。
  - 参数 2：线程模型（0=STA，1=MTA）。
- `SetDllPathW(const wchar_t* path, int mode)`
  - 参数 1：Unicode 字符串（同上）。
  - 参数 2：线程模型（0=STA，1=MTA）。

调用这个函数后，dmreg.dll 会把路径下的 **dm.dll** 注册到内存中（只对当前进程生效），不依赖系统注册表。

```python
import ctypes
import os
from win32com.client import Dispatch

def 注册大漠(注册码='', 附加码=''):
    print('正在初始化')
    #  通过调用DmReg.dll注册大漠 这样不会把dm.dll写到系统中，从而实现免注册
    patch = ctypes.windll.LoadLibrary(os.path.dirname(__file__) + './DmReg.dll')
    patch.SetDllPathW(os.path.dirname(__file__) + './dm.dll', 0)
    dm_主对象 = Dispatch('dm.dmsoft')  # 创建对象
    ver = dm_主对象.ver()
    print('免注册调用初始化成功 版本号为:', ver)
    # 注册大漠VIP
    if ver != '':
        reg = dm_主对象.reg(注册码, 附加码)
        if reg == 1:
            print("大漠vip注册成功")
            return dm_主对象
        else:
            print(f"大漠注册失败,错误代码: {reg}")
```