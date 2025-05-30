# VSMS 電影管理系統 - Docker 部署

需要先安裝Docker Desktop和Docker Compose。
並確保正常運行。
否則docker肯定跑不起來。

## 系統要求
- Docker 20.10+
- Docker Compose 2.0+
- 2GB RAM, 1GB 儲存空間

## 環境驗證
```bash
# 檢查 Docker 版本
docker --version
# 檢查 Docker Compose 版本
docker-compose --version
# 確認 Docker 服務是否在運行
docker info
```

## 快速部署

### 1. 啟動
```bash
docker-compose up --build -d
```
安裝成功就可以去 docker desktop 上查看是不是在默認的port上運行？
點擊frontend路徑下顯示的port，就可以看到前端頁面了。 *** 需要點擊local到連結 ***

  App running at:
  - Local:   http://localhost:8082/  
  - Network: http://192.168.0.169:8082/


## 訪問地址
- 前端: http://localhost:8081 
- 後端API: http://localhost:8000/api
- 資料庫: localhost:3306

## 常用命令
```bash
# 查看狀態
docker-compose ps

# 停止服務
docker-compose down

### 監控和日誌
```bash
# 設置日誌輪轉
docker-compose logs --tail=1000 backend > /var/log/vsms/backend.log

# 監控容器健康狀態
watch 'docker-compose ps'
```

---

## 📚 相關文檔

- **本地開發環境**: 參考 `readme.md`
- **API文檔**: 訪問 `http://localhost:8000/api/docs/`

---

**💡 提示**: 如遇到問題，請先查看容器日誌 `docker-compose logs -f`，大多數問題都能從日誌中找到原因。

## 技術支援

如果遇到問題，請：
1. 查看本文檔的故障排除部分
2. 檢查服務日誌：`docker-compose logs -f`
3. 確認 Docker 和 Docker Compose 版本
4. 聯繫專案維護者