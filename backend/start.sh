#!/bin/bash
echo "开始迁移数据库..."
python manage.py migrate
echo "启动Django服务器..."
python manage.py runserver 0.0.0.0:8000