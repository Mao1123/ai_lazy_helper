# 微信小程序扩展指南

## 概述

本项目使用 mpflutter 框架扩展到微信小程序。mpflutter 是一个让 Flutter 代码运行在微信小程序上的框架。

## 前置条件

1. 安装 Node.js (v16+)
2. 安装微信开发者工具
3. 注册微信小程序账号并获取 AppID

## 安装步骤

### 1. 安装 mpflutter CLI

```bash
npm install -g @mpflutter/cli
```

### 2. 创建 mpflutter 项目

```bash
mpcli create ai_lazy_helper_mp
```

### 3. 迁移代码

由于 mpflutter 不支持所有 Flutter 特性，需要进行以下适配：

#### 支持的组件
- MaterialApp → MPApp
- Scaffold → MPScaffold
- ListView → MPListView
- Container → MPContainer
- Text → MPText
- Icon → MPIcon

#### 不支持的特性
- 部分动画效果（flutter_animate 需要替代方案）
- 某些第三方包需要 mpflutter 兼容版本
- Platform-specific 代码需要移除

### 4. 数据层复用

以下代码可以直接复用：
- `lib/data/` - 所有数据文件
- `lib/models/` - 所有模型文件
- `lib/utils/` - 工具类（需要微调）

### 5. UI 层适配

需要重写以下文件：
- `lib/pages/home_page.dart` - 使用 mpflutter 组件
- `lib/widgets/result_card.dart` - 使用 mpflutter 组件
- `lib/theme/app_theme.dart` - 适配 mpflutter 主题

### 6. 本地存储

微信小程序使用 `wx.setStorageSync` 替代 `shared_preferences`：

```dart
// mpflutter 版本
import 'package:mpflutter/wechat/storage.dart';

class StorageService {
  static Future<void> setString(String key, String value) async {
    wx.setStorageSync(key, value);
  }

  static Future<String?> getString(String key) async {
    return wx.getStorageSync(key);
  }
}
```

### 7. 构建和预览

```bash
# 构建小程序
mpcli build

# 在微信开发者工具中预览
# 打开微信开发者工具，导入 dist/wx 目录
```

## 注意事项

1. **API 差异**：微信小程序有自己的 API，需要使用 mpflutter 提供的桥接
2. **样式限制**：某些 CSS 特性在小程序中不支持
3. **包大小限制**：小程序主包限制 2MB，需要分包加载
4. **审核要求**：发布前需要通过微信审核

## 推荐方案

考虑到迁移成本，推荐以下方案：

### 方案一：渐进式迁移
1. 先将核心逻辑（数据、模型、工具类）抽取为独立 package
2. 创建 mpflutter 项目，引用核心 package
3. 逐步适配 UI 层

### 方案二：使用 uni-app
如果 mpflutter 兼容性问题较多，可以考虑使用 uni-app 重写前端，复用后端逻辑。

### 方案三：Web 嵌入
将 Flutter Web 版本嵌入微信公众号，通过 JSSDK 调用微信能力。

## 参考文档

- [mpflutter 官方文档](https://mpflutter.com)
- [微信小程序开发文档](https://developers.weixin.qq.com/miniprogram/dev/)
- [Flutter to mpflutter 迁移指南](https://mpflutter.com/docs/guides/migration)
