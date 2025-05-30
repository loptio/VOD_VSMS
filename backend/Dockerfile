FROM python:3.9-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    pkg-config \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 复制requirements文件
COPY requirements.txt .

# 安装Python依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目文件
COPY ./backend .

# 设置Django配置文件环境变量
ENV DJANGO_SETTINGS_MODULE=vsms_project.settings_docker

# 暴露端口
EXPOSE 8000

# 复制启动脚本
COPY ./backend/start.sh /app/start.sh
RUN chmod +x /app/start.sh

# 启动命令
CMD ["/bin/bash", "/app/start.sh"]