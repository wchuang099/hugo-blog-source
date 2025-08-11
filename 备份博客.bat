@echo off
chcp 65001
REM === Hugo 博客源码备份脚本 ===
REM === 将源码（含文章、主题等）备份到 GitHub ===

REM 添加所有更改并提交
git add .
git commit -m "备份博客源码：%date% %time%"

REM 设置远程仓库（如果已存在则不重复设置）
git remote remove origin
git remote add origin https://github.com/wchuang099/hugo-blog-source.git
git branch -M main

REM 先拉取远程最新代码并合并
git pull origin main --no-rebase --no-edit

REM 推送到远程仓库
git push -u origin main

echo ✅ 博客源码备份完成！
pause
