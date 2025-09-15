---
title: "幽灵键鼠"
date: 2025-08-24
categories: ["图色脚本","幽灵键鼠"]
---

```python
import ghostbox as gb
import time

# 打开设备
#按索引打开设备，返回 1 = 成功。index 即设备编号/ID（0 开始）
# if gb.opendevice(0) != 1:
#     raise Exception("幽灵键鼠设备打开失败")

#按 VID/PID 打开设备
if gb.opendevicebyid(20872,6145) == 1:
    print("设备已连接，型号:", gb.getmodel())
else:
    print("设备打开失败，请检查 ID 或设备连接")

# 移动鼠标到指定位置
x, y = 200, 200
gb.movemouseto(x, y)
print(f"鼠标移动到: ({x},{y})")

# 稍等几秒，观察效果
time.sleep(2)

# 结束
if hasattr(gb, "closedevice"):
    gb.closedevice()
```
