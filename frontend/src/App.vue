<template>
  <div id="app">
    <el-container class="layout-container">
      <!-- 顶部导航栏 -->
      <el-header class="header">
        <div class="header-content">
          <div class="logo">
            <el-icon><VideoPlay /></el-icon>
            <span>VSMS 视频点播销售管理系统</span>
          </div>
          <el-menu
            :default-active="activeIndex"
            class="header-menu"
            mode="horizontal"
            @select="handleSelect"
          >
            <el-menu-item index="/">
              <el-icon><House /></el-icon>
              <span>首页</span>
            </el-menu-item>
            <el-menu-item index="/movies">
              <el-icon><Film /></el-icon>
              <span>电影管理</span>
            </el-menu-item>
            <el-menu-item index="/members">
              <el-icon><User /></el-icon>
              <span>会员管理</span>
            </el-menu-item>
            <el-menu-item index="/purchases">
              <el-icon><ShoppingCart /></el-icon>
              <span>购买记录</span>
            </el-menu-item>
            <el-menu-item index="/downloads">
              <el-icon><Download /></el-icon>
              <span>下载记录</span>
            </el-menu-item>

          </el-menu>
        </div>
      </el-header>

      <!-- 主要内容区域 -->
      <el-main class="main-content">
        <router-view />
      </el-main>

      <!-- 底部 -->
      <el-footer class="footer">
        <div class="footer-content">
          <p>&copy; 2024 VSMS 视频点播销售管理系统. All rights reserved.</p>
        </div>
      </el-footer>
    </el-container>
  </div>
</template>

<script>
import { computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'

export default {
  name: 'App',
  setup() {
    const router = useRouter()
    const route = useRoute()

    const activeIndex = computed(() => route.path)

    const handleSelect = (key) => {
      router.push(key)
    }

    return {
      activeIndex,
      handleSelect
    }
  }
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

#app {
  font-family: 'Helvetica Neue', Helvetica, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', '微软雅黑', Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  height: 100vh;
}

.layout-container {
  height: 100vh;
}

.header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 0;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 100%;
  padding: 0 20px;
}

.logo {
  display: flex;
  align-items: center;
  font-size: 20px;
  font-weight: bold;
  color: white;
}

.logo .el-icon {
  margin-right: 10px;
  font-size: 24px;
}

.header-menu {
  background: transparent;
  border-bottom: none;
}

.header-menu .el-menu-item {
  color: white;
  border-bottom: 2px solid transparent;
}

.header-menu .el-menu-item:hover,
.header-menu .el-menu-item.is-active {
  background: rgba(255, 255, 255, 0.1);
  border-bottom-color: white;
  color: white;
}

.main-content {
  background: #f5f7fa;
  padding: 20px;
  overflow-y: auto;
}

.footer {
  background: #2c3e50;
  color: white;
  text-align: center;
  padding: 0;
  height: 60px;
}

.footer-content {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    padding: 10px;
  }
  
  .logo {
    margin-bottom: 10px;
  }
  
  .header-menu {
    width: 100%;
  }
  
  .main-content {
    padding: 10px;
  }
}
</style>