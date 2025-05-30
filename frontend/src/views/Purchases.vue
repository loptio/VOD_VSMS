<template>
  <div class="purchases">
    <div class="page-header">
      <h2>购买历史</h2>
      <el-button type="primary" @click="showPurchaseDialog = true">
        <el-icon><Plus /></el-icon>
        新增购买
      </el-button>
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
        <el-form-item label="购买日期">
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
          <el-button type="primary" @click="searchPurchases">
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

    <!-- 购买记录列表 -->
    <el-card>
      <el-table :data="purchases" v-loading="loading" style="width: 100%">
        <el-table-column prop="purchase_id" label="购买ID" width="100" />
        <el-table-column prop="member_name" label="会员姓名" min-width="120" />
        <el-table-column prop="movie_title" label="电影标题" min-width="200" />
        <el-table-column prop="purchase_date" label="购买日期" width="120" />
        <el-table-column prop="amount" label="金额" width="100">
          <template #default="scope">
            ¥{{ scope.row.amount }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150" fixed="right">
          <template #default="scope">
            <el-button size="small" @click="viewPurchase(scope.row)">
              <el-icon><View /></el-icon>
              查看
            </el-button>
            <el-button size="small" type="danger" @click="deletePurchase(scope.row)">
              <el-icon><Delete /></el-icon>
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 移除分页组件 -->
    </el-card>

    <!-- 新增购买对话框 -->
    <el-dialog title="新增购买" v-model="showPurchaseDialog" width="500px" @close="resetPurchaseForm">
      <el-form :model="purchaseForm" :rules="purchaseRules" ref="purchaseFormRef" label-width="100px">
        <el-form-item label="选择会员" prop="member">
          <el-select
            v-model="purchaseForm.member"
            placeholder="请选择会员"
            filterable
            remote
            :remote-method="searchMembers"
            :loading="memberLoading"
            style="width: 100%"
          >
            <el-option
              v-for="member in memberOptions"
              :key="member.member_id"
              :label="`${member.name} (${member.phone})`"
              :value="member.member_id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="选择电影" prop="movie">
          <el-select
            v-model="purchaseForm.movie"
            placeholder="请选择电影"
            filterable
            remote
            :remote-method="searchMovies"
            :loading="movieLoading"
            style="width: 100%"
            @change="onMovieChange"
          >
            <el-option
              v-for="movie in movieOptions"
              :key="movie.movie_id"
              :label="`${movie.title} (¥${movie.charge_per_download})`"
              :value="movie.movie_id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="购买金额">
          <el-input-number
            v-model="purchaseForm.amount"
            :min="0"
            :precision="2"
            disabled
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="会员余额">
          <span :class="{ 'insufficient-balance': memberBalance < purchaseForm.amount }">
            ¥{{ memberBalance }}
            <el-tag v-if="memberBalance < purchaseForm.amount" type="danger" size="small">
              余额不足
            </el-tag>
          </span>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="showPurchaseDialog = false">取消</el-button>
          <el-button 
            type="primary" 
            @click="confirmPurchase" 
            :loading="saving"
            :disabled="memberBalance < purchaseForm.amount"
          >
            确认购买
          </el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 查看购买详情对话框 -->
    <el-dialog title="购买详情" v-model="showViewDialog" width="600px">
      <div v-if="selectedPurchase" class="purchase-detail">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="购买ID">{{ selectedPurchase.purchase_id }}</el-descriptions-item>
          <el-descriptions-item label="会员姓名">{{ selectedPurchase.member_name }}</el-descriptions-item>
          <el-descriptions-item label="电影标题">{{ selectedPurchase.movie_title }}</el-descriptions-item>
          <el-descriptions-item label="购买日期">{{ selectedPurchase.purchase_date }}</el-descriptions-item>
          <el-descriptions-item label="购买金额">¥{{ selectedPurchase.amount }}</el-descriptions-item>
        </el-descriptions>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { ref, reactive, computed, onMounted, watch } from 'vue'
import { useStore } from 'vuex'
import { ElMessage, ElMessageBox } from 'element-plus'
import api from '../utils/api'

export default {
  name: 'Purchases',
  setup() {
    const store = useStore()
    // 移除分页相关变量
    const loading = ref(false)
    const saving = ref(false)
    const memberLoading = ref(false)
    const movieLoading = ref(false)
    const showPurchaseDialog = ref(false)
    const showViewDialog = ref(false)
    const selectedPurchase = ref(null)
    const purchaseFormRef = ref(null)
    const memberOptions = ref([])
    const movieOptions = ref([])
    const memberBalance = ref(0)

    const purchases = computed(() => store.state.purchases)

    const searchForm = reactive({
      memberName: '',
      movieTitle: '',
      dateRange: null
    })

    const purchaseForm = reactive({
      member: null,
      movie: null,
      amount: 0
    })

    const purchaseRules = {
      member: [{ required: true, message: '请选择会员', trigger: 'change' }],
      movie: [{ required: true, message: '请选择电影', trigger: 'change' }]
    }

    const searchPurchases = async () => {
      try {
        loading.value = true
        const params = {}
        
        if (searchForm.memberName) params.member_name = searchForm.memberName
        if (searchForm.movieTitle) params.movie_title = searchForm.movieTitle
        if (searchForm.dateRange) {
          params.date_from = searchForm.dateRange[0]
          params.date_to = searchForm.dateRange[1]
        }
        
        const response = await api.get('/purchases/', { params })
        store.commit('SET_PURCHASES', response.data.results || response.data)
      } catch (error) {
        console.error('搜索购买记录失败:', error)
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
      searchPurchases()
    }

    const searchMembers = async (query) => {
      if (!query) {
        memberOptions.value = []
        return
      }
      
      try {
        memberLoading.value = true
        const response = await api.get('/members/search/', {
          params: { name: query }
        })
        memberOptions.value = response.data
      } catch (error) {
        console.error('搜索会员失败:', error)
      } finally {
        memberLoading.value = false
      }
    }

    const searchMovies = async (query) => {
      if (!query) {
        movieOptions.value = []
        return
      }
      
      try {
        movieLoading.value = true
        const response = await api.get('/movies/search/', {
          params: { title: query }
        })
        movieOptions.value = response.data
      } catch (error) {
        console.error('搜索电影失败:', error)
      } finally {
        movieLoading.value = false
      }
    }

    const onMovieChange = async () => {
      const selectedMovie = movieOptions.value.find(m => m.movie_id === purchaseForm.movie)
      if (selectedMovie) {
        purchaseForm.amount = selectedMovie.charge_per_download
      }
      
      // 获取会员余额
      if (purchaseForm.member) {
        try {
          const response = await api.get(`/members/${purchaseForm.member}/`)
          memberBalance.value = response.data.balance
        } catch (error) {
          console.error('获取会员余额失败:', error)
        }
      }
    }

    const confirmPurchase = async () => {
      try {
        await purchaseFormRef.value.validate()
        
        if (memberBalance.value < purchaseForm.amount) {
          ElMessage.error('会员余额不足')
          return
        }
        
        saving.value = true
        await api.post('/purchases/', purchaseForm)
        
        ElMessage.success('购买成功')
        showPurchaseDialog.value = false
        resetPurchaseForm()
        searchPurchases()
      } catch (error) {
        console.error('购买失败:', error)
        ElMessage.error('购买失败')
      } finally {
        saving.value = false
      }
    }

    const viewPurchase = (purchase) => {
      selectedPurchase.value = purchase
      showViewDialog.value = true
    }

    const deletePurchase = async (purchase) => {
      try {
        await ElMessageBox.confirm(
          `确定要删除购买记录 "${purchase.movie_title_display}" 吗？`,
          '确认删除',
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }
        )
        
        await api.delete(`/purchases/${purchase.purchase_id}/`)
        ElMessage.success('删除成功')
        searchPurchases()
      } catch (error) {
        if (error !== 'cancel') {
          ElMessage.error('删除失败')
        }
      }
    }

    const resetPurchaseForm = () => {
      Object.assign(purchaseForm, {
        member: null,
        movie: null,
        amount: 0
      })
      memberOptions.value = []
      movieOptions.value = []
      memberBalance.value = 0
      if (purchaseFormRef.value) {
        purchaseFormRef.value.resetFields()
      }
    }



    // 监听会员选择变化，获取余额
    watch(() => purchaseForm.member, async (newMemberId) => {
      if (newMemberId) {
        try {
          const response = await api.get(`/members/${newMemberId}/`)
          memberBalance.value = response.data.balance
        } catch (error) {
          console.error('获取会员余额失败:', error)
        }
      } else {
        memberBalance.value = 0
      }
    })

    onMounted(() => {
      searchPurchases()
    })

    return {
      loading,
      saving,
      memberLoading,
      movieLoading,
      showPurchaseDialog,
      showViewDialog,
      selectedPurchase,
      purchaseFormRef,
      memberOptions,
      movieOptions,
      memberBalance,
      purchases,
      searchForm,
      purchaseForm,
      purchaseRules,
      searchPurchases,
      resetSearch,
      searchMembers,
      searchMovies,
      onMovieChange,
      confirmPurchase,
      viewPurchase,
      deletePurchase,
      resetPurchaseForm
    }
  }
}
</script>

<style scoped>
.purchases {
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

.purchase-detail {
  max-height: 400px;
  overflow-y: auto;
}

.pagination-wrapper {
  margin-top: 20px;
  text-align: center;
}

.insufficient-balance {
  color: #f56c6c;
  font-weight: bold;
}

.dialog-footer {
  text-align: right;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .page-header {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .page-header .el-button {
    margin-top: 10px;
  }
}
</style>