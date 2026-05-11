const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = process.env.PORT || 8080;
const BUILD_DIR = path.join(__dirname, '..', 'build', 'web');

// MIME 类型映射
const MIME_TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.otf': 'font/otf',
  '.wasm': 'application/wasm',
};

// 获取 MIME 类型
function getMimeType(filePath) {
  const ext = path.extname(filePath).toLowerCase();
  return MIME_TYPES[ext] || 'application/octet-stream';
}

// 处理请求
function handleRequest(req, res) {
  let filePath = path.join(BUILD_DIR, req.url === '/' ? 'index.html' : req.url);

  // 安全检查：防止目录遍历
  if (!filePath.startsWith(BUILD_DIR)) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }

  // 检查文件是否存在
  fs.access(filePath, fs.constants.F_OK, (err) => {
    if (err) {
      // 如果文件不存在，返回 index.html（SPA 路由）
      filePath = path.join(BUILD_DIR, 'index.html');
    }

    // 读取文件
    fs.readFile(filePath, (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Internal Server Error');
        return;
      }

      // 设置响应头
      const mimeType = getMimeType(filePath);
      res.writeHead(200, {
        'Content-Type': mimeType,
        'Cache-Control': mimeType.includes('html') ? 'no-cache' : 'public, max-age=31536000',
        'Access-Control-Allow-Origin': '*',
      });

      res.end(data);
    });
  });
}

// 创建服务器
const server = http.createServer(handleRequest);

// 启动服务器
server.listen(PORT, () => {
  console.log(`
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║   🎉 AI摆烂助手 Web 服务器已启动！                         ║
║                                                           ║
║   访问地址: http://localhost:${PORT}                        ║
║                                                           ║
║   按 Ctrl+C 停止服务器                                    ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
  `);
});

// 优雅退出
process.on('SIGINT', () => {
  console.log('\n正在停止服务器...');
  server.close(() => {
    console.log('服务器已停止');
    process.exit(0);
  });
});
