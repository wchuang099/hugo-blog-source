@echo off
chcp 65001
REM === Hugo 博客源码备份脚本 ===
REM === 将源码（含文章、主题等）备份到 GitHub ===

REM 提交并推送源码到 hugo-blog 仓库
git add .
git commit -m "备份博客源码：%date% %time%"
git remote remove origin
git remote add origin https://github.com/wchuang099/hugo-blog-source.git
git branch -M main
git push -u origin main

echo ✅ 博客源码备份完成！
pause
