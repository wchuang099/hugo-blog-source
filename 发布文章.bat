@echo off
chcp 65001
REM 自动部署 Hugo 博客到 GitHub Pages

REM 删除旧的 public 文件夹
rmdir /s /q public

REM 重新生成 Hugo 静态文件
hugo

REM 进入 public 文件夹
cd public

REM 初始化 Git 仓库并创建 main 分支
git init
git checkout -b main
git remote add origin https://github.com/wchuang099/wchuang099.github.io.git

REM 提交并推送
git add .
git commit -m "自动部署：%date% %time%"
git push -f origin main

REM 完成提示
echo ✅ 博客已成功部署！
pause
