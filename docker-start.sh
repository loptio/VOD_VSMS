#!/bin/bash

# VSMS Docker启动脚本
echo "正在启动VSMS系统..."

# 检查Docker是否安装
if ! command -v docker &> /dev/null; then
    echo "错误: Docker未安装，请先安装Docker"
    exit 1
fi

# 检查Docker Compose是否安装
if ! command -v docker-compose &> /dev/null; then
    echo "错误: Docker Compose未安装，请先安装Docker Compose"
    exit 1
fi

# 检查.env文件是否存在
if [ ! -f ".env" ]; then
    echo "错误: .env文件不存在，请确保.env文件在项目根目录"
    exit 1
fi

# 停止并删除现有容器（如果存在）
echo "清理现有容器..."
docker-compose down

# 构建并启动服务
echo "构建并启动服务..."
docker-compose up --build -d

# 等待服务启动
echo "等待服务启动..."
sleep 10

# 检查服务状态
echo "检查服务状态..."
docker-compose ps

echo ""
echo "=== VSMS系统启动完成 ==="
echo "前端地址: http://localhost:8081"
echo "后端API: http://localhost:8000/api"
echo "MySQL端口: 3306"
echo ""
echo "使用以下命令查看日志:"
echo "  docker-compose logs -f"
echo ""
echo "使用以下命令停止服务:"
echo "  docker-compose down"
echo ""