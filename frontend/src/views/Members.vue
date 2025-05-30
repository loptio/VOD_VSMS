<template>
  <div class="members">
    <div class="page-header">
      <h2>会员管理</h2>
      <el-button type="primary" @click="showAddDialog = true">
        <el-icon><Plus /></el-icon>
        添加会员
      </el-button>
    </div>

    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-form :model="searchForm" inline>
        <el-form-item label="会员姓名">
          <el-input v-model="searchForm.name" placeholder="请输入会员姓名" clearable />
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="searchForm.email" placeholder="请输入邮箱" clearable />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="searchForm.status" placeholder="选择状态" clearable>
            <el-option
              v-for="status in memberStatuses"
              :key="status.status_name"
              :label="status.status_name"
              :value="status.status_name"
            />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="searchMembers">
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

    <!-- 会员列表 -->
    <el-card>
      <el-table :data="members" v-loading="loading" style="width: 100%">
        <el-table-column prop="member_id" label="ID" width="80" />
        <el-table-column prop="name" label="姓名" min-width="120" />
        <el-table-column prop="email" label="邮箱" min-width="200" />
        <el-table-column prop="phone" label="电话" width="150" />
        <el-table-column prop="balance" label="余额" width="100">
          <template #default="scope">
            ¥{{ scope.row.balance }}
          </template>
        </el-table-column>
        <el-table-column prop="status_display" label="状态" width="100">
          <template #default="scope">
            <el-tag
              :type="getStatusType(scope.row.status_display)"
              size="small"
            >
              {{ scope.row.status_display }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="registration_date" label="注册日期" width="120" />
        <el-table-column label="操作" width="300" fixed="right">
          <template #default="scope">
            <el-button size="small" @click="viewMember(scope.row)">
              <el-icon><View /></el-icon>
              查看
            </el-button>
            <el-button size="small" type="primary" @click="editMember(scope.row)">
              <el-icon><Edit /></el-icon>
              编辑
            </el-button>
            <el-button size="small" type="success" @click="addBalance(scope.row)">
              <el-icon><Money /></el-icon>
              充值
            </el-button>
            <el-button size="small" type="info" @click="viewDownloadHistory(scope.row)">
              <el-icon><Download /></el-icon>
              下载记录
            </el-button>
            <el-button size="small" type="danger" @click="deleteMember(scope.row)">
              <el-icon><Delete /></el-icon>
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 添加/编辑会员对话框 -->
    <el-dialog
      :title="isEditing ? '编辑会员' : '添加会员'"
      v-model="showAddDialog"
      width="500px"
      @close="resetForm"
    >
      <el-form :model="memberForm" :rules="memberRules" ref="memberFormRef" label-width="100px">
        <el-form-item label="会员姓名" prop="name">
          <el-input v-model="memberForm.name" placeholder="请输入会员姓名" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="memberForm.email" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="memberForm.phone" placeholder="请输入电话" />
        </el-form-item>
        <el-form-item label="余额" prop="balance">
          <el-input-number
            v-model="memberForm.balance"
            :min="0"
            :precision="2"
            placeholder="请输入余额"
          />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="memberForm.status" placeholder="选择状态">
            <el-option
              v-for="status in memberStatuses"
              :key="status.status_id"
              :label="status.status_name"
              :value="status.status_id"
            />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="showAddDialog = false">取消</el-button>
          <el-button type="primary" @click="saveMember" :loading="saving">
            {{ isEditing ? '更新' : '添加' }}
          </el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 查看会员详情对话框 -->
    <el-dialog title="会员详情" v-model="showViewDialog" width="600px">
      <div v-if="selectedMember" class="member-detail">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="会员ID">{{ selectedMember.member_id }}</el-descriptions-item>
          <el-descriptions-item label="姓名">{{ selectedMember.name }}</el-descriptions-item>
          <el-descriptions-item label="邮箱">{{ selectedMember.email }}</el-descriptions-item>
          <el-descriptions-item label="电话">{{ selectedMember.phone }}</el-descriptions-item>
          <el-descriptions-item label="余额">¥{{ selectedMember.balance }}</el-descriptions-item>
          <el-descriptions-item label="状态">
            <el-tag :type="getStatusType(selectedMember.status_display)" size="small">
              {{ selectedMember.status_display }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="注册日期">{{ selectedMember.registration_date }}</el-descriptions-item>
          <el-descriptions-item label="地址">{{ selectedMember.address_display || '未设置' }}</el-descriptions-item>
        </el-descriptions>
      </div>
    </el-dialog>

    <!-- 充值对话框 -->
    <el-dialog title="账户充值" v-model="showBalanceDialog" width="400px">
      <el-form :model="balanceForm" ref="balanceFormRef" label-width="100px">
        <el-form-item label="当前余额">
          <span>¥{{ selectedMember?.balance || 0 }}</span>
        </el-form-item>
        <el-form-item label="充值金额" prop="amount">
          <el-input-number
            v-model="balanceForm.amount"
            :min="0.01"
            :precision="2"
            placeholder="请输入充值金额"
            style="width: 100%"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="showBalanceDialog = false">取消</el-button>
          <el-button type="primary" @click="confirmAddBalance" :loading="saving">
            确认充值
          </el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 下载记录对话框 -->
    <el-dialog title="下载记录" v-model="showDownloadDialog" width="800px">
      <div v-if="downloadHistory.length">
        <el-table :data="downloadHistory" style="width: 100%">
          <el-table-column prop="movie_title" label="电影标题" min-width="200" />
          <el-table-column prop="download_timestamp" label="下载时间" width="180" />
          <el-table-column prop="amount" label="金额" width="100">
            <template #default="scope">
              ¥{{ scope.row.amount }}
            </template>
          </el-table-column>
        </el-table>
        <div class="download-summary">
          <p><strong>总下载次数：</strong>{{ downloadHistory.length }}</p>
          <p><strong>总消费金额：</strong>¥{{ totalSpent }}</p>
        </div>
      </div>
      <el-empty v-else description="暂无下载记录" />
    </el-dialog>
  </div>
</template>

<script>
import { ref, reactive, computed, onMounted } from 'vue'
import { useStore } from 'vuex'
import { ElMessage, ElMessageBox } from 'element-plus'
import api from '../utils/api'

export default {
  name: 'Members',
  setup() {
    const store = useStore()
    const loading = ref(false)
    const saving = ref(false)
    const showAddDialog = ref(false)
    const showViewDialog = ref(false)
    const showBalanceDialog = ref(false)
    const showDownloadDialog = ref(false)
    const isEditing = ref(false)
    const selectedMember = ref(null)
    const downloadHistory = ref([])
    const memberFormRef = ref(null)
    const balanceFormRef = ref(null)

    const members = computed(() => store.state.members)
    const memberStatuses = computed(() => store.state.memberStatuses)

    const searchForm = reactive({
      name: '',
      email: '',
      status: ''
    })

    const memberForm = reactive({
      member_id: null,
      name: '',
      email: '',
      phone: '',
      balance: 0,
      status: ''
    })

    const balanceForm = reactive({
      amount: 0
    })

    const memberRules = {
      name: [{ required: true, message: '请输入会员姓名', trigger: 'blur' }],
      email: [
        { required: true, message: '请输入邮箱', trigger: 'blur' },
        { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
      ],
      status: [{ required: true, message: '请选择状态', trigger: 'change' }]
    }

    const totalSpent = computed(() => {
      return downloadHistory.value.reduce((total, item) => total + parseFloat(item.amount), 0).toFixed(2)
    })

    const getStatusType = (status) => {
      const statusMap = {
        'Active': 'success',
        'Closed': 'warning',
        'Suspended': 'danger'
      }
      return statusMap[status] || 'info'
    }

    const searchMembers = async () => {
      try {
        loading.value = true
        const params = {}
        
        if (searchForm.name) params.name = searchForm.name
        if (searchForm.email) params.email = searchForm.email
        if (searchForm.status) params.status = searchForm.status
        
        const response = await api.get('/members/search/', { params })
        store.commit('SET_MEMBERS', response.data)
      } catch (error) {
        console.error('搜索会员失败:', error)
      } finally {
        loading.value = false
      }
    }

    const resetSearch = () => {
      Object.assign(searchForm, {
        name: '',
        email: '',
        status: ''
      })
      store.dispatch('fetchMembers')
    }

    const viewMember = (member) => {
      selectedMember.value = member
      showViewDialog.value = true
    }

    const editMember = (member) => {
      isEditing.value = true
      Object.assign(memberForm, {
        member_id: member.member_id,
        name: member.name,
        email: member.email,
        phone: member.phone || '',
        balance: member.balance,
        status: member.status || ''
      })
      showAddDialog.value = true
    }

    const addBalance = (member) => {
      selectedMember.value = member
      balanceForm.amount = 0
      showBalanceDialog.value = true
    }

    const confirmAddBalance = async () => {
      try {
        if (balanceForm.amount <= 0) {
          ElMessage.error('充值金额必须大于0')
          return
        }
        
        saving.value = true
        await api.post(`/members/${selectedMember.value.member_id}/add_balance/`, {
          amount: balanceForm.amount
        })
        
        ElMessage.success('充值成功')
        showBalanceDialog.value = false
        store.dispatch('fetchMembers')
      } catch (error) {
        console.error('充值失败:', error)
        ElMessage.error('充值失败')
      } finally {
        saving.value = false
      }
    }

    const viewDownloadHistory = async (member) => {
      try {
        selectedMember.value = member
        const response = await api.get(`/members/${member.member_id}/download_history/`)
        downloadHistory.value = response.data.downloads || []
        showDownloadDialog.value = true
      } catch (error) {
        console.error('获取下载记录失败:', error)
        ElMessage.error('获取下载记录失败')
      }
    }

    const deleteMember = async (member) => {
      try {
        await ElMessageBox.confirm(
          `确定要删除会员 "${member.name}" 吗？`,
          '确认删除',
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }
        )
        
        await store.dispatch('deleteMember', member.member_id)
        ElMessage.success('删除成功')
      } catch (error) {
        if (error !== 'cancel') {
          ElMessage.error('删除失败')
        }
      }
    }

    const saveMember = async () => {
      try {
        await memberFormRef.value.validate()
        saving.value = true
        
        // 准备发送的数据，移除不需要的字段
        const memberData = {
          name: memberForm.name,
          email: memberForm.email,
          phone: memberForm.phone || '',
          balance: parseFloat(memberForm.balance) || 0,
          status: parseInt(memberForm.status) || null
        }
        
        if (isEditing.value) {
          await store.dispatch('updateMember', {
            id: memberForm.member_id,
            memberData: memberData
          })
          ElMessage.success('更新成功')
        } else {
          await store.dispatch('createMember', memberData)
          ElMessage.success('添加成功')
        }
        
        showAddDialog.value = false
        resetForm()
      } catch (error) {
        console.error('保存会员失败:', error)
      } finally {
        saving.value = false
      }
    }

    const resetForm = () => {
      isEditing.value = false
      Object.assign(memberForm, {
        member_id: null,
        name: '',
        email: '',
        phone: '',
        balance: 0,
        status: ''
      })
      if (memberFormRef.value) {
        memberFormRef.value.resetFields()
      }
    }

    onMounted(async () => {
      await Promise.all([
        store.dispatch('fetchMembers'),
        store.dispatch('fetchMemberStatuses')
      ])
    })

    return {
      loading,
      saving,
      showAddDialog,
      showViewDialog,
      showBalanceDialog,
      showDownloadDialog,
      isEditing,
      selectedMember,
      downloadHistory,
      memberFormRef,
      balanceFormRef,
      members,
      memberStatuses,
      searchForm,
      memberForm,
      balanceForm,
      memberRules,
      totalSpent,
      getStatusType,
      searchMembers,
      resetSearch,
      viewMember,
      editMember,
      addBalance,
      confirmAddBalance,
      viewDownloadHistory,
      deleteMember,
      saveMember,
      resetForm
    }
  }
}
</script>

<style scoped>
.members {
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

.member-detail {
  max-height: 400px;
  overflow-y: auto;
}

.download-summary {
  margin-top: 20px;
  padding: 15px;
  background-color: #f5f7fa;
  border-radius: 4px;
}

.download-summary p {
  margin: 5px 0;
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