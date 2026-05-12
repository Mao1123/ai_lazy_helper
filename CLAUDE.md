# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

**AI摆烂助手** - 一款轻松有趣的推荐小应用，根据当前时间、日期、季节智能推荐「吃什么」和「干什么」，搭配搞笑吐槽文案。

**项目位置**: `G:\00_Project_AI\ai_lazy_helper`
**设计文档**: `G:\00_Project_AI\DEV_DOC.md`

## 技术栈

- Flutter 3.41+ (Dart 3.11+)
- 状态管理: Provider
- 动画: flutter_animate
- 图标: font_awesome_flutter
- 网络请求: http
- 本地存储: shared_preferences
- 图片生成: screenshot
- 分享功能: share_plus
- 目标平台: Android / iOS / Web

## 常用命令

```bash
# 运行 Web 版本
flutter run -d chrome
flutter run -d edge

# 构建 Web
flutter build web --release

# 启动本地服务器（在 build/web 目录下）
node -e "const http=require('http'),fs=require('fs'),path=require('path');const server=http.createServer((req,res)=>{let fp=path.join(process.cwd(),req.url==='/'?'index.html':req.url);fs.readFile(fp,(err,content)=>{if(err){res.writeHead(404);res.end();return;}res.writeHead(200);res.end(content);});});server.listen(8080,()=>console.log('http://localhost:8080'));"

# 代码分析
flutter analyze

# 运行测试
flutter test
```

## 架构要点

### 推荐系统流程
1. `TimeLogic` 判断当前时间状态：时段（早/午/晚/深夜）、是否周末、季节、节假日
2. `RandomLogic` 根据时间状态从对应数据池中加权随机选取
3. 季节性数据会混入基础数据池，权重可调（`weightRatio`）
4. 节假日会额外混入节日专属文案

### 关键命名约束
- `AppTimeOfDay`：自定义时段枚举，因 `TimeOfDay` 与 Flutter 内置类冲突
- `Season`：季节枚举（spring/summer/autumn/winter）

### 数据层设计
- 食物、活动、吐槽文案均按「时段/场景」分组（如 `breakfastFoods`、`weekendActivities`）
- 电影、音乐、书籍各有独立数据文件（`movie_data.dart`、`music_data.dart`、`book_data.dart`），按类型分组
- 每个分组有独立的季节性扩展列表（如 `springFoods`、`summerActivities`）
- `RandomLogic._weightedPick()` 实现加权随机，将季节性数据混入基础池
- 情绪数据独立文件（`mood_data.dart`），按心情分组
- 电影/音乐/书籍通过 `moodMovieMap`、`timeMovieMap`、`seasonMovieMap` 等映射表实现多维度推荐

### 服务层
- `AiService`：AI 文案生成抽象类，支持 OpenAI 兼容 API
- `FavoriteService`：收藏本地存储，使用 SharedPreferences
- `ShareService`：海报生成和分享，使用 screenshot + share_plus

### 页面结构
- `HomePage`：首页，展示推荐、情绪选择、幸运值
- `FavoritesPage`：收藏列表，支持左滑删除
- `SettingsPage`：AI 配置页面

## 开发进度

### Phase 1 - MVP ✅ 已完成
- [x] 项目搭建
- [x] 首页 UI（奶油风卡片布局）
- [x] 随机推荐逻辑
- [x] 时间感知推荐（工作日/周末、时段）
- [x] 再抽一次功能

### Phase 2 - 体验优化 ✅ 已完成
- [x] 卡片刷新动画（AnimatedSwitcher + 淡入缩放）
- [x] 更多食物数据（60+ 项，含季节性食物）
- [x] 更多活动数据（40+ 项，含季节性活动）
- [x] 更多吐槽文案（120+ 条，含季节/节日文案）

### Phase 2.5 - 时间感知增强 ✅ 已完成
- [x] 季节感知：春夏秋冬不同推荐
- [x] 节假日检测：元旦、春节、情人节、劳动节、儿童节、中秋、国庆、万圣节、圣诞
- [x] 首页展示：日期、星期、季节标签、时段标签、节假日标签
- [x] 季节性吐槽文案

### Phase 3 - AI 增强 ✅ 已完成
- [x] 情绪模式：开心/emo/摆烂/发疯，影响推荐结果
- [x] 幸运值系统：每日固定幸运值（0-100），显示等级和建议
- [x] 接入 AI 生成文案：支持 OpenAI 兼容 API，设置页面配置

### Phase 4 - 扩展 ✅ 已完成
- [x] 收藏系统：收藏喜欢的推荐，本地持久化存储
- [x] 分享海报：生成精美图片，支持分享到社交媒体
- [x] 微信小程序：扩展指南文档（docs/wechat_mini_program.md）

### Phase 5 - 内容丰富 ✅ 已完成
- [x] 电影推荐：7 类电影（喜剧/治愈/动作/科幻/恐怖/爱情/悬疑），每类 18 项
- [x] 音乐推荐：6 类音乐（流行/治愈/摇滚/民谣/电子/古典），每类 18 项
- [x] 书籍推荐：6 类书籍（文学/治愈/科幻/心理/历史/工具），每类 18 项
- [x] 收藏页面支持新类型图标和配色
- [x] 食物数据扩充：早餐/午餐/晚餐等分类增至 20+ 项
- [x] 活动数据扩充：工作日/周末/深夜等分类增至 18+ 项

### Phase 6 - 部署与发布 ✅ 已完成
- [x] GitHub Pages 自动部署：推送到 master 自动构建发布
- [x] 部署地址：https://mao1123.github.io/ai_lazy_helper/
- [x] 微信公众号配置：关键词回复和被关注回复
- [x] 二维码生成：deploy/qrcode.png
- [x] 部署指南文档：deploy/deploy_guide.md

## UI 设计规范

### 配色方案（奶油风）
| 用途 | 色值 |
|------|------|
| 主色 | `#FFD6A5` |
| 背景色 | `#FFF6EA` |
| 卡片色 | `#FFFFFF` |
| 文字主色 | `#333333` |
| 文字副色 | `#888888` |
| 强调色 | `#FF8C42` |

## Git 提交规范

```
feat: 新功能
fix: 修复 bug
style: UI/样式调整
refactor: 重构
docs: 文档更新
```

## 注意事项

- `TimeOfDay` 与 Flutter 内置类冲突，使用 `AppTimeOfDay` 替代
- Web 预览需要用 HTTP 服务器，不能直接打开 HTML 文件
- Python 在本机有问题，使用 Node.js 启动本地服务器

## 部署配置

### GitHub Pages（已上线）
- 自动部署：推送到 master 分支自动触发
- 部署地址：https://mao1123.github.io/ai_lazy_helper/
- 配置文件：`.github/workflows/deploy.yml`
- 部署分支：gh-pages

### Vercel（备选）
- 配置文件：`vercel.json`
- 自动部署：连接 GitHub 仓库后自动触发

### 微信公众号
- 关键词回复：摆烂、推荐、吃什么、干什么
- 被关注回复：欢迎语 + 功能介绍
- 二维码：deploy/qrcode.png

## Git 提交历史

```
44db1d1 fix: 修复 Flutter 版本号为 3.41.8
ee877bb Create static.yml
10fb36c fix: 更新 GitHub Actions 部署到 gh-pages 分支
e2f9ecc feat: 添加 GitHub Pages 自动部署配置
85594c2 docs: 更新 CLAUDE.md 记录数据扩充完成
f9c5ea5 feat: 扩充推荐数据，每个分类增至 15-20 项
bafaa50 feat: Phase 5 - 内容丰富（电影/音乐/书籍推荐）
da17f8f feat: Web 部署配置
0a226f6 style: UI 细节优化
```

## 当前状态

**所有 Phase 已完成**，项目功能完整：
- ✅ 核心推荐系统（时间感知 + 季节 + 节假日）
- ✅ 情绪模式和幸运值系统
- ✅ AI 文案生成（可选）
- ✅ 收藏和分享功能
- ✅ 微信小程序扩展指南
- ✅ 内容丰富：电影/音乐/书籍推荐
- ✅ 数据丰富：每个分类 15-20 项，总数据量 500+
- ✅ GitHub Pages 部署上线
- ✅ 微信公众号配置完成

**在线访问**：
- Web 地址：https://mao1123.github.io/ai_lazy_helper/
- 微信公众号：关注后发送关键词即可使用

**下一步建议**：
- 测试各平台兼容性（Android/iOS/Web）
- 优化 UI 细节和动画效果
- 准备发布到应用商店
- 推广微信公众号
