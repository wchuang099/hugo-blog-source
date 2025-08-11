---
title: "hugo使用"
date: 2025-08-06
lastmod: 2025-08-07T10:30:00+08:00
tags: ["docker", "linux"]
categories: ["Linux"]
description: "在 Linux 上安装 Docker 的详细教程"
---

```
https://www.elegantcrazy.com/posts/blog/build-blog-with-github-pages-hugo-and-papermod/
https://jimmysong.io/book/hugo-handbook/introduction/quick-start/ 
```

# 1.安装 Git

Hugo 项目通常需要 Git 进行版本控制和主题管理

```
https://git-scm.com/downloads/win
```

# 2.创建仓库

在Github创建仓库，仓库名填写**[用户名].github.io**`，注意`[用户名]部分必须是Github用户名，否则Github Pages不会正常工作。

```
新建两个仓库
wchuang099.github.io   #博客仓库
hugo-blog-source       #备份博客源文件
```

# 3.安装 Hugo

下载安装包，hugo免安装，解压添加环境变量即可

```shell
# 注意 hugo和主题都找最新版的下载即可，老版本会有兼容的问题
https://github.com/gohugoio/hugo/releases/download/v0.148.2/hugo_extended_0.148.2_windows-amd64.zip
hugo version
```



## 生成项目

```
hugo new site hugo-blog
cd hugo-blog
```

> 这将创建标准的项目目录结构，包括：
> •	archetypes/ - 内容模板
> •	assets/ - 资源文件
> •	content/ - 内容源文件
> •	data/ - 数据文件
> •	layouts/ - 布局模板
> •	static/ - 静态文件
> •	themes/ - 主题
> •	hugo.toml – 配置文件，旧版本文件为config.toml



## 下载主题

```
#可以去官网找自己喜欢的主题 https://themes.gohugo.io/
https://github.com/CaiJimmy/hugo-theme-stack/archive/refs/tags/v3.30.0.zip
解压到themes\目录下
```

## 启动主题

``````json
复制样例文件hugo-blog\themes\hugo-theme-stack\exampleSite找到content和hugo.yaml复制到hugo-blog目录下
hugo-blog\content\post\rich-content   #删除此目录，引用的一些国外网站会导致超时启动不了
hugo-blog\hugo.toml
#hugo.yaml可以修改下，符合自己的风格
参考https://github.com/wchuang099/hugo-blog-source/blob/main/hugo.yaml)
``````



## 新建文章

在网站中添加第一篇文章：

``````
hugo new content post/myFirstBlog/index.md
``````


新创建的内容文件位于 content/posts/my-first-post.md

```python
+++
date = '2025-08-04T19:05:29+08:00'
draft = true
title = 'My First Post'
+++
```

注意`draft`的值是`true`，表示当前文档是草稿。默认情况下，Hugo在编译网站时不会发布草稿。

## 开发与测试
1. 启动开发服务器

```shell
  hugo server -D
```

  > -D 标志表示构建草稿内容。服务器会：
  > •	在本地构建网站并提供服务（通常在 http://localhost:1313）
  > •	监控项目目录中的文件变化
  > •	检测到变化时自动重建并实时刷新浏览器（LiveReload）

## 发布站点

1. 准备发布
    将草稿状态设置为 false或者直接删掉，默认false
    将元数据调整如下，更符合自己的主题
```shell
---
title: "hugo使用"
date: 2025-08-06
lastmod: 2025-08-07T10:30:00+08:00
tags: ["hugo"]
categories: ["博客"]
description: "如何使用hugo"
---
```
2. 生成静态文件,运行构建命令：

```shell
hugo
```
> 这会在项目根目录下的 public 目录中生成完整的静态网站，包括：
> •	HTML 文件
> •	CSS 和 JavaScript 文件
> •	图像等静态资源
>
> 3. 重要注意事项
>    •	Hugo 不会自动清空 public 目录
>    •	构建时会覆盖现有文件，但不会删除旧文件
>    •	根据需要手动清理该目录以避免文件残留
>    •	默认情况下不包含草稿、未来或过期内容
>    调试工具
>    •	使用 hugo server --debug 获取详细日志
>    •	使用 hugo config 查看完整站点配置
>    •	使用 hugo list drafts 查看所有草稿文件

# 4.在Github Pages上部署网站



进入 public 目录（Hugo 生成的页面）

```shell
git config --global https.proxy http://127.0.0.1:15715
git config --global http.proxy http://127.0.0.1:15715
cd public
git init
git remote add origin https://github.com/wchuang099/wchuang099.github.io.git
git add .
git commit -m "deploy"
git branch -M main
git push -f origin main
```

过几分钟访问即可：wchuang099.github.io

更新流程
每次你写完文章或改完配置，只需要将以下保存bat执行：

```shell
@echo off
chcp 65001

REM 切换到博客源码目录
cd /d D:\PyProject\hugo-blog-source

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
```

# 5备份网站

为了**备份你的博客原始文件（包括 Markdown 笔记、配置文件、主题等）**，建议再建一个 **源码仓库**。

✅ 推荐的结构：两个 Git 仓库

| 用途     | 内容               | GitHub 仓库                  |
| -------- | ------------------ | ---------------------------- |
| 部署用   | `public/` 静态页面 | `yourusername.github.io`     |
| 源码备份 | 所有博客源文件     | `hugo-blog-source` |

```
添加 .gitignore 文件，避免上传 public/ 内容
在博客根目录下创建 .gitignore 文件，内容如下：
public/
resources/
*.DS_Store
*.log
.hugo_build.lock
desktop.ini
.idea

第一次提交
cd hugo-blog   # 你博客项目的根目录
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/wchuang099/hugo-blog-source.git
git push -u origin main

```

自动发布备份脚本

```
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

```

