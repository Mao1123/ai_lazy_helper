# 微信公众号部署指南

## 方案一：GitHub Pages（免费）

### 1. 创建 GitHub 仓库
- 登录 GitHub，创建新仓库：`ai-lazy-helper`
- 设置为 Public

### 2. 推送代码
```bash
cd G:/00_Project_AI/ai_lazy_helper
git remote add origin https://github.com/YOUR_USERNAME/ai-lazy-helper.git
git push -u origin master
```

### 3. 启用 GitHub Pages
- 进入仓库 Settings → Pages
- Source 选择 "Deploy from a branch"
- Branch 选择 "master"，文件夹选择 "/docs"
- 保存后会得到 URL：https://YOUR_USERNAME.github.io/ai-lazy-helper/

### 4. 配置自定义域名（可选）
- 在 Pages 设置中填写自定义域名
- 在域名服务商处添加 CNAME 记录

## 方案二：Vercel（免费，推荐）

### 1. 注册 Vercel
- 访问 https://vercel.com
- 使用 GitHub 账号登录

### 2. 导入项目
- 点击 "New Project"
- 选择你的 GitHub 仓库
- 配置：
  - Framework Preset: Flutter
  - Build Command: flutter build web
  - Output Directory: build/web

### 3. 部署
- 点击 Deploy
- 得到 URL：https://ai-lazy-helper.vercel.app

## 方案三：Netlify（免费）

### 1. 注册 Netlify
- 访问 https://netlify.com
- 使用 GitHub 账号登录

### 2. 部署
- 点击 "New site from Git"
- 选择 GitHub 仓库
- 配置：
  - Build command: flutter build web
  - Publish directory: build/web

### 3. 得到 URL
- https://YOUR_SITE_NAME.netlify.app

## 微信公众号配置

### 1. 注册微信公众号
- 访问 https://mp.weixin.qq.com
- 注册订阅号或服务号

### 2. 配置菜单（服务号）
- 进入公众号后台
- 功能 → 自定义菜单
- 添加菜单项：
  - 菜单名称：开始摆烂
  - 菜单类型：跳转网页
  - 网页地址：你的部署 URL

### 3. 配置自动回复（订阅号）
- 功能 → 自动回复
- 添加关键词回复：
  - 关键词：摆烂、推荐、吃什么
  - 回复内容：欢迎使用 AI 摆烂助手！[点击这里开始](你的URL)

### 4. 生成二维码
- 公众号后台 → 公众号设置 → 二维码
- 下载二维码图片分享给用户

## 注意事项

1. **HTTPS 要求**：微信公众号要求使用 HTTPS
2. **域名备案**：如果使用自定义域名，需要备案
3. **JS 安全域名**：在公众号后台配置 JS 安全域名
4. **业务域名**：配置业务域名以避免跳转提示

## 测试流程

1. 部署完成后，先在浏览器中测试
2. 在微信中打开链接测试
3. 检查所有功能是否正常
4. 配置公众号菜单
5. 测试菜单跳转
