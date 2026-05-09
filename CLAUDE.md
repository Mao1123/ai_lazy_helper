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
- 每个分组有独立的季节性扩展列表（如 `springFoods`、`summerActivities`）
- `RandomLogic._weightedPick()` 实现加权随机，将季节性数据混入基础池

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

### Phase 3 - AI 增强 🚧 待开发
- [ ] 接入 AI 生成吐槽文案
- [ ] 情绪模式（开心/emo/摆烂/发疯）
- [ ] 幸运值系统

### Phase 4 - 扩展 🚧 待开发
- [ ] 微信小程序 (mpflutter)
- [ ] 收藏系统
- [ ] 分享海报

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
