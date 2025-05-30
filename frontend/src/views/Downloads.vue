<template>
  <div class="downloads">
    <div class="page-header">
      <h2>下载历史</h2>
    </div>

    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-form :model="searchForm" inline>
        <el-form-item label="会员姓名">
          <el-input v-model="searchForm.memberName" placeholder="请输入会员姓名" clearable />
        </el-form-item>
        <el-form-item label="电影标题">
          <el-input v-model="searchForm.movieTitle" placeholder="请输入电影标题" clearable />
        </el-form-item>
        <el-form-item label="下载日期">
          <el-date-picker
            v-model="searchForm.dateRange"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="searchDownloads">
            <el-icon><Search /></el-icon>
            搜索
          </el-button>
          <el-button @click="resetSearch">
            <el-icon><Refresh /></el-icon>
            重置
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 统计信息 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :span="12">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-number">{{ totalDownloads }}</div>
            <div class="stat-label">总下载次数</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-number">{{ activeMembers }}</div>
            <div class="stat-label">活跃会员数</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 下载记录列表 -->
    <el-card>
      <el-table :data="downloads" v-loading="loading" style="width: 100%">
        <el-table-column prop="download_id" label="下载ID" width="100" />
        <el-table-column prop="member_name" label="会员姓名" min-width="120" />
        <el-table-column prop="movie_title" label="电影标题" min-width="200" />
        <el-table-column prop="download_timestamp" label="下载时间" width="180">
          <template #default="scope">
            {{ formatDateTime(scope.row.download_timestamp) }}
          </template>
        </el-table-column>
        <el-table-column prop="purchase_id" label="购买ID" width="100" />
        <el-table-column label="操作" width="100" fixed="right">
          <template #default="scope">
            <el-button size="small" @click="viewDownload(scope.row)">
              <el-icon><View /></el-icon>
              查看
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 移除分页组件 -->
    </el-card>

    <!-- 查看下载详情对话框 -->
    <el-dialog title="下载详情" v-model="showViewDialog" width="600px">
      <div v-if="selectedDownload" class="download-detail">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="下载ID">{{ selectedDownload.download_id }}</el-descriptions-item>
          <el-descriptions-item label="会员姓名">{{ selectedDownload.member_name }}</el-descriptions-item>
          <el-descriptions-item label="电影标题">{{ selectedDownload.movie_title }}</el-descriptions-item>
          <el-descriptions-item label="下载时间">{{ formatDateTime(selectedDownload.download_timestamp) }}</el-descriptions-item>
          <el-descriptions-item label="购买ID">{{ selectedDownload.purchase_id || '无' }}</el-descriptions-item>
        </el-descriptions>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { ref, reactive, computed, onMounted } from 'vue'
import { useStore } from 'vuex'
import { ElMessage } from 'element-plus'
import api from '../utils/api'

export default {
  name: 'Downloads',
  setup() {
    const store = useStore()
    // 移除下载记录页面的分页功能，包括分页组件、相关变量和方法
    const loading = ref(false)
    const showViewDialog = ref(false)
    const selectedDownload = ref(null)

    const downloads = computed(() => store.state.downloads)

    const searchForm = reactive({
      memberName: '',
      movieTitle: '',
      dateRange: null
    })

    // 统计信息
    const totalDownloads = computed(() => downloads.value.length)
    const activeMembers = computed(() => {
      const memberNames = new Set(downloads.value.map(d => d.member_name).filter(name => name))
      return memberNames.size
    })

    const formatDateTime = (timestamp) => {
      if (!timestamp) return ''
      const date = new Date(timestamp)
      return date.toLocaleString('zh-CN', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      })
    }

    const searchDownloads = async () => {
      try {
        loading.value = true
        const params = {}
        
        if (searchForm.memberName) params.member_name = searchForm.memberName
        if (searchForm.movieTitle) params.movie_title = searchForm.movieTitle
        if (searchForm.dateRange) {
          params.date_from = searchForm.dateRange[0]
          params.date_to = searchForm.dateRange[1]
        }
        
        const response = await api.get('/downloads/', { params })
        store.commit('SET_DOWNLOADS', response.data.results || response.data)
      } catch (error) {
        console.error('搜索下载记录失败:', error)
        ElMessage.error('搜索下载记录失败')
      } finally {
        loading.value = false
      }
    }

    const resetSearch = () => {
      Object.assign(searchForm, {
        memberName: '',
        movieTitle: '',
        dateRange: null
      })
      searchDownloads()
    }

    const viewDownload = (download) => {
      selectedDownload.value = download
      showViewDialog.value = true
    }

    // 移除分页相关方法

    onMounted(() => {
      searchDownloads()
    })

    return {
      loading,
      showViewDialog,
      selectedDownload,
      downloads,
      searchForm,
      totalDownloads,
      activeMembers,
      formatDateTime,
      searchDownloads,
      resetSearch,
      viewDownload
    }
  }
}
</script>

<style scoped>
.downloads {
  max-width: 1200px;
  margin: 0 auto;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.page-header h2 {
  margin: 0;
  color: #2c3e50;
}

.search-card {
  margin-bottom: 20px;
}

.stats-row {
  margin-bottom: 20px;
}

.stat-card {
  text-align: center;
}

.stat-content {
  padding: 10px;
}

.stat-number {
  font-size: 24px;
  font-weight: bold;
  color: #409eff;
  margin-bottom: 5px;
}

.stat-label {
  font-size: 14px;
  color: #666;
}

.download-detail {
  max-height: 400px;
  overflow-y: auto;
}

.pagination-wrapper {
  margin-top: 20px;
  text-align: center;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .page-header {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .stats-row .el-col {
    margin-bottom: 10px;
  }
}
</style>