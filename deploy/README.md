# AI摆烂助手 - Web 部署指南

## 快速启动

### 方法一：使用启动脚本（推荐）

1. 双击运行 `start.bat`
2. 浏览器访问 http://localhost:8080

### 方法二：手动启动

```bash
cd deploy
node server.js
```

## 部署到服务器

### 1. 上传文件

将 `build/web` 目录下的所有文件上传到服务器的 Web 目录。

### 2. 配置 Web 服务器

#### Nginx 配置示例

```nginx
server {
    listen 80;
    server_name your-domain.com;
    root /path/to/build/web;
    index index.html;

    # Gzip 压缩
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    # 静态资源缓存
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|otf)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # SPA 路由
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

#### Apache 配置示例

创建 `.htaccess` 文件：

```apache
RewriteEngine On
RewriteBase /
RewriteRule ^index\.html$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.html [L]

# 缓存静态资源
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
</IfModule>
```

### 3. HTTPS 配置

建议使用 Let's Encrypt 配置 HTTPS：

```bash
# 安装 certbot
sudo apt install certbot python3-certbot-nginx

# 获取证书
sudo certbot --nginx -d your-domain.com
```

## 免费托管选项

### GitHub Pages

1. 创建 GitHub 仓库
2. 上传 `build/web` 内容到 `gh-pages` 分支
3. 在仓库设置中启用 GitHub Pages

### Vercel

1. 安装 Vercel CLI：`npm i -g vercel`
2. 在项目目录运行：`vercel`
3. 按提示操作

### Netlify

1. 拖拽 `build/web` 文件夹到 Netlify
2. 或使用 Netlify CLI 部署

## 注意事项

- 确保服务器支持 SPA 路由（所有路由都返回 index.html）
- 建议启用 Gzip 压缩以提高加载速度
- 静态资源建议设置长期缓存
- 生产环境建议配置 HTTPS
