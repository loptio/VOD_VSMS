<template>
  <div class="home">
    <!-- 欢迎横幅 -->
    <div class="welcome-banner">
      <h1>欢迎使用 VSMS 视频点播销售管理系统</h1>
      <p>高效管理您的视频点播业务，提供完整的电影、会员、销售数据管理解决方案</p>
    </div>

    <!-- 统计卡片 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card movies-card clickable-card" @click="navigateToMovies">
          <div class="stats-content">
            <div class="stats-icon">
              <el-icon><Film /></el-icon>
            </div>
            <div class="stats-info">
              <h3>{{ totalMovies }}</h3>
              <p>电影总数</p>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card members-card clickable-card" @click="navigateToMembers">
          <div class="stats-content">
            <div class="stats-icon">
              <el-icon><User /></el-icon>
            </div>
            <div class="stats-info">
              <h3>{{ totalMembers }}</h3>
              <p>会员总数</p>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card purchases-card clickable-card" @click="navigateToPurchases">
          <div class="stats-content">
            <div class="stats-icon">
              <el-icon><ShoppingCart /></el-icon>
            </div>
            <div class="stats-info">
              <h3>{{ totalPurchases }}</h3>
              <p>购买记录</p>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card downloads-card clickable-card" @click="navigateToDownloads">
          <div class="stats-content">
            <div class="stats-icon">
              <el-icon><Download /></el-icon>
            </div>
            <div class="stats-info">
              <h3>{{ totalDownloads }}</h3>
              <p>下载记录</p>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- SQL 查询工具 -->
    <el-row :gutter="20" class="sql-query-section">
      <el-col :span="24">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>SQL 查询工具</span>
            </div>
          </template>
          
          <!-- 预设查询按钮 -->
          <div class="preset-queries">
            <h4>预设查询</h4>
            <div class="query-buttons">
              <el-button 
                v-for="(query, index) in presetQueries" 
                :key="index"
                type="primary" 
                @click="loadPresetQuery(index)"
                class="query-btn"
                size="small"
              >
                {{ query.name }}
              </el-button>
            </div>
          </div>

          <!-- SQL 编辑器 -->
          <div class="sql-editor">
            <h4>SQL 查询语句</h4>
            <el-input
              v-model="sqlQuery"
              type="textarea"
              :rows="8"
              placeholder="请输入SQL查询语句..."
              class="sql-textarea"
            />
            <div class="editor-actions">
              <el-button type="primary" @click="executeQuery" :loading="queryLoading">
                <el-icon><CaretRight /></el-icon>
                执行查询
              </el-button>
              <el-button @click="clearQuery">
                <el-icon><Delete /></el-icon>
                清空
              </el-button>
            </div>
          </div>

          <!-- 查询结果 -->
          <div class="query-results" v-if="queryResults.length > 0 || queryError">
            <h4>查询结果</h4>
            
            <!-- 错误信息 -->
            <el-alert
              v-if="queryError"
              :title="queryError"
              type="error"
              show-icon
              :closable="false"
              class="error-alert"
            />
            
            <!-- 结果表格 -->
            <el-table 
              v-else
              :data="queryResults" 
              v-loading="queryLoading"
              border
              stripe
              class="results-table"
              max-height="400"
            >
              <el-table-column 
                v-for="column in tableColumns" 
                :key="column"
                :prop="column" 
                :label="column"
                min-width="120"
              />
            </el-table>
            
            <!-- 结果统计 -->
            <div v-if="queryResults.length > 0" class="result-stats">
              <el-tag type="info">共 {{ queryResults.length }} 条记录</el-tag>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { computed, onMounted, ref, reactive } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { CaretRight, Delete } from '@element-plus/icons-vue'
import api from '../utils/api'

export default {
  name: 'Home',
  components: {
    CaretRight,
    Delete
  },
  setup() {
    const store = useStore()
    const router = useRouter()
    
    // 统计数据
    const totalMovies = computed(() => store.getters.getTotalMovies)
    const totalMembers = computed(() => store.getters.getTotalMembers)
    const totalPurchases = computed(() => store.getters.getTotalPurchases)
    const totalDownloads = computed(() => store.getters.getTotalDownloads)

    // SQL查询相关
    const sqlQuery = ref('')
    const queryResults = ref([])
    const tableColumns = ref([])
    const queryLoading = ref(false)
    const queryError = ref('')

    // 预设查询语句
    const presetQueries = reactive([
      {
        name: 'Benedict Cumberbatch 电影 (2005-2015)',
        sql: `SELECT m.title 
FROM movies m 
JOIN act_in ai ON m.movie_id = ai.movie_id 
WHERE ai.actor_name = 'Benedict Cumberbatch' 
AND YEAR(m.release_date) BETWEEN 2005 AND 2015 
ORDER BY m.release_date DESC;`
      },
      {
        name: 'John Smith 最喜欢的女演员',
        sql: `SELECT 
    ai.actor_name, 
    COUNT(d.download_id) as download_count 
FROM members m 
JOIN download d ON m.member_id = d.member_id 
JOIN act_in ai ON d.movie_id = ai.movie_id 
JOIN actors a ON ai.actor_name = a.actor_name AND ai.birth_date = a.birth_date 
WHERE m.name = 'John Smith' AND a.gender = 'Female' 
GROUP BY ai.actor_name 
ORDER BY download_count DESC 
LIMIT 1;`
      },
      {
        name: '去年下载频率最高的电影',
        sql: `SELECT m.title,count(d.download_id) as download_count 
FROM movies m 
JOIN download d ON m.movie_id = d.movie_id 
WHERE YEAR(d.download_timestamp) = 2023 
GROUP BY m.movie_id 
ORDER BY download_count DESC 
LIMIT 10;`
      },
      {
        name: '恐怖电影销售高峰月份',
        sql: `WITH monthly_sales AS ( 
    SELECT 
        YEAR(p.purchase_date) AS year, 
        MONTH(p.purchase_date) AS month, 
        SUM(p.amount) AS total_sales 
    FROM movies m 
    JOIN purchase p ON m.movie_id = p.movie_id 
    LEFT JOIN has_genre h ON m.movie_id = h.movie_id 
    WHERE h.genre_name = 'Horror' 
    GROUP BY year, month 
), 
ranked_sales AS ( 
    SELECT 
        year, 
        month, 
        total_sales, 
        RANK() OVER (PARTITION BY year ORDER BY total_sales DESC) as sales_rank 
    FROM monthly_sales 
) 
SELECT 
    year, 
    month, 
    total_sales 
FROM ranked_sales 
WHERE sales_rank = 1 
ORDER BY total_sales DESC;`
      },
      {
        name: '最佳客户排行榜',
        sql: `SELECT 
    m.name, 
    SUM(p.amount) as total_spent, 
    COUNT(p.purchase_id) as purchase_count 
FROM members m 
JOIN purchase p ON m.member_id = p.member_id 
GROUP BY m.member_id, m.name 
ORDER BY total_spent DESC 
LIMIT 10;`
      }
    ])

    // 加载预设查询
    const loadPresetQuery = (index) => {
      sqlQuery.value = presetQueries[index].sql
      queryError.value = ''
    }

    // 执行查询
    const executeQuery = async () => {
      if (!sqlQuery.value.trim()) {
        ElMessage.warning('请输入SQL查询语句')
        return
      }

      queryLoading.value = true
      queryError.value = ''
      queryResults.value = []
      tableColumns.value = []

      try {
        const response = await api.post('/sql-query/', {
          sql: sqlQuery.value
        })
        
        if (response.data && response.data.length > 0) {
          queryResults.value = response.data
          // 获取表格列名
          tableColumns.value = Object.keys(response.data[0])
          ElMessage.success('查询执行成功')
        } else {
          queryResults.value = []
          tableColumns.value = []
          ElMessage.info('查询结果为空')
        }
      } catch (error) {
        console.error('SQL查询失败:', error)
        queryError.value = error.response?.data?.error || '查询执行失败'
        ElMessage.error('查询执行失败')
      } finally {
        queryLoading.value = false
      }
    }

    // 清空查询
    const clearQuery = () => {
      sqlQuery.value = ''
      queryResults.value = []
      tableColumns.value = []
      queryError.value = ''
    }

    // 导航方法
    const navigateToMovies = () => {
      router.push('/movies')
    }

    const navigateToMembers = () => {
      router.push('/members')
    }

    const navigateToPurchases = () => {
      router.push('/purchases')
    }

    const navigateToDownloads = () => {
      router.push('/downloads')
    }

    onMounted(async () => {
      // 加载统计数据
      await Promise.all([
        store.dispatch('fetchMovies'),
        store.dispatch('fetchMembers'),
        store.dispatch('fetchPurchases'),
        store.dispatch('fetchDownloads')
      ])
    })

    return {
      totalMovies,
      totalMembers,
      totalPurchases,
      totalDownloads,
      sqlQuery,
      queryResults,
      tableColumns,
      queryLoading,
      queryError,
      presetQueries,
      loadPresetQuery,
      executeQuery,
      clearQuery,
      navigateToMovies,
      navigateToMembers,
      navigateToPurchases,
      navigateToDownloads
    }
  }
}
</script>

<style scoped>
.home {
  max-width: 1200px;
  margin: 0 auto;
}

.welcome-banner {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 40px;
  border-radius: 12px;
  text-align: center;
  margin-bottom: 30px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.welcome-banner h1 {
  font-size: 2.5em;
  margin-bottom: 15px;
  font-weight: 300;
}

.welcome-banner p {
  font-size: 1.2em;
  opacity: 0.9;
  max-width: 600px;
  margin: 0 auto;
}

.stats-row {
  margin-bottom: 30px;
}

.stats-card {
  border: none;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.stats-card:hover {
  transform: translateY(-5px);
}

.clickable-card {
  cursor: pointer;
}

.clickable-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

.stats-content {
  display: flex;
  align-items: center;
  padding: 10px;
}

.stats-icon {
  font-size: 3em;
  margin-right: 20px;
  opacity: 0.8;
}

.movies-card .stats-icon {
  color: #409eff;
}

.members-card .stats-icon {
  color: #67c23a;
}

.purchases-card .stats-icon {
  color: #e6a23c;
}

.downloads-card .stats-icon {
  color: #f56c6c;
}

.stats-info h3 {
  font-size: 2.5em;
  margin: 0;
  font-weight: bold;
  color: #2c3e50;
}

.stats-info p {
  margin: 5px 0 0 0;
  color: #7f8c8d;
  font-size: 1.1em;
}

.sql-query-section {
  margin-bottom: 30px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.preset-queries {
  margin-bottom: 25px;
}

.preset-queries h4 {
  color: #606266;
  margin-bottom: 15px;
  font-size: 16px;
  font-weight: 600;
}

.query-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.query-btn {
  margin-bottom: 10px;
}

.sql-editor {
  margin-bottom: 25px;
}

.sql-editor h4 {
  color: #606266;
  margin-bottom: 15px;
  font-size: 16px;
  font-weight: 600;
}

.sql-textarea {
  margin-bottom: 15px;
}

.sql-textarea :deep(.el-textarea__inner) {
  font-family: 'Courier New', monospace;
  font-size: 14px;
  line-height: 1.5;
}

.editor-actions {
  display: flex;
  gap: 10px;
}

.query-results {
  margin-top: 25px;
}

.query-results h4 {
  color: #606266;
  margin-bottom: 15px;
  font-size: 16px;
  font-weight: 600;
}

.error-alert {
  margin-bottom: 20px;
}

.results-table {
  margin-bottom: 15px;
}

.result-stats {
  text-align: right;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .welcome-banner {
    padding: 20px;
  }
  
  .welcome-banner h1 {
    font-size: 2em;
  }
  
  .welcome-banner p {
    font-size: 1em;
  }
  
  .stats-content {
    flex-direction: column;
    text-align: center;
  }
  
  .stats-icon {
    margin-right: 0;
    margin-bottom: 10px;
  }
  
  .quick-action-buttons {
    grid-template-columns: 1fr;
  }
}
</style>