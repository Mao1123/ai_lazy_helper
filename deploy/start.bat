@echo off
echo.
echo ========================================
echo   AI摆烂助手 Web 服务器启动脚本
echo ========================================
echo.

cd /d "%~dp0"

echo 正在启动服务器...
echo.

node server.js

pause
