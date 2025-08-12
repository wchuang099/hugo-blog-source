@echo off
chcp 65001

REM 切换到博客源码目录
cd /d C:\Users\wchuang\hugo-blog
REM 删除旧 public
rmdir /s /q public

REM 生成静态文件
hugo

REM 进入 public
cd public

REM 确保 Git 仓库存在
if not exist ".git" (
    git init
    git checkout -b main
    git remote add origin https://github.com/wchuang099/wchuang099.github.io.git
) else (
    git remote set-url origin https://github.com/wchuang099/wchuang099.github.io.git
)

REM 提交并推送
git add .
git commit -m "自动部署：%date% %time%"
git push -f origin main

echo ✅ 博客已成功部署！
pause
