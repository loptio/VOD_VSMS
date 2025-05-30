<template>
  <div class="movies">
    <div class="page-header">
      <h2>电影管理</h2>
      <el-button type="primary" @click="showAddDialog = true">
        <el-icon><Plus /></el-icon>
        添加电影
      </el-button>
    </div>

    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-form :model="searchForm" inline>
        <el-form-item label="电影标题">
          <el-input v-model="searchForm.title" placeholder="请输入电影标题" clearable />
        </el-form-item>
        <el-form-item label="类型">
          <el-select v-model="searchForm.genre" placeholder="选择类型" clearable>
            <el-option
              v-for="genre in genres"
              :key="genre.genre_name"
              :label="genre.genre_name"
              :value="genre.genre_name"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="演员">
          <el-input v-model="searchForm.actor" placeholder="请输入演员姓名" clearable />
        </el-form-item>
        <el-form-item label="导演">
          <el-input v-model="searchForm.director" placeholder="请输入导演姓名" clearable />
        </el-form-item>
        <el-form-item label="发行年份">
          <el-date-picker
            v-model="searchForm.yearRange"
            type="yearrange"
            range-separator="至"
            start-placeholder="开始年份"
            end-placeholder="结束年份"
            format="YYYY"
            value-format="YYYY"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="searchMovies">
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

    <!-- 电影列表 -->
    <el-card>
      <el-table :data="movies" v-loading="loading" style="width: 100%">
        <el-table-column prop="movie_id" label="ID" width="80" />
        <el-table-column prop="title" label="标题" min-width="200" />
        <el-table-column prop="release_date" label="发行日期" width="120" />
        <el-table-column prop="charge_per_download" label="价格" width="100">
          <template #default="scope">
            ¥{{ scope.row.charge_per_download }}
          </template>
        </el-table-column>
        <el-table-column prop="company_name_display" label="制作公司" width="150" />
        <el-table-column label="类型" width="150">
          <template #default="scope">
            <el-tag
              v-for="genre in scope.row.genres"
              :key="genre"
              size="small"
              style="margin-right: 5px;"
            >
              {{ genre }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="scope">
            <el-button size="small" @click="viewMovie(scope.row)">
              <el-icon><View /></el-icon>
              查看
            </el-button>
            <el-button size="small" type="primary" @click="editMovie(scope.row)">
              <el-icon><Edit /></el-icon>
              编辑
            </el-button>
            <el-button size="small" type="danger" @click="deleteMovie(scope.row)">
              <el-icon><Delete /></el-icon>
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 添加/编辑电影对话框 -->
    <el-dialog
      :title="isEditing ? '编辑电影' : '添加电影'"
      v-model="showAddDialog"
      width="600px"
      @close="resetForm"
    >
      <el-form :model="movieForm" :rules="movieRules" ref="movieFormRef" label-width="100px">
        <el-form-item label="电影标题" prop="title">
          <el-input v-model="movieForm.title" placeholder="请输入电影标题" />
        </el-form-item>
        <el-form-item label="发行日期" prop="release_date">
          <el-date-picker
            v-model="movieForm.release_date"
            type="date"
            placeholder="选择发行日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
          />
        </el-form-item>
        <el-form-item label="下载价格" prop="charge_per_download">
          <el-input-number
            v-model="movieForm.charge_per_download"
            :min="0"
            :precision="2"
            placeholder="请输入价格"
          />
        </el-form-item>
        <el-form-item label="制作公司" prop="company_name">
          <el-select v-model="movieForm.company_name" placeholder="选择制作公司">
            <el-option
              v-for="company in companies"
              :key="company.company_name"
              :label="company.company_name"
              :value="company.company_name"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="电影类型">
          <el-select v-model="movieForm.genres" multiple placeholder="选择电影类型">
            <el-option
              v-for="genre in genres"
              :key="genre.genre_name"
              :label="genre.genre_name"
              :value="genre.genre_name"
            />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="showAddDialog = false">取消</el-button>
          <el-button type="primary" @click="saveMovie" :loading="saving">
            {{ isEditing ? '更新' : '添加' }}
          </el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 查看电影详情对话框 -->
    <el-dialog title="电影详情" v-model="showViewDialog" width="700px">
      <div v-if="selectedMovie" class="movie-detail">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="电影ID">{{ selectedMovie.movie_id }}</el-descriptions-item>
          <el-descriptions-item label="标题">{{ selectedMovie.title }}</el-descriptions-item>
          <el-descriptions-item label="发行日期">{{ selectedMovie.release_date }}</el-descriptions-item>
          <el-descriptions-item label="价格">¥{{ selectedMovie.charge_per_download }}</el-descriptions-item>
          <el-descriptions-item label="制作公司">{{ selectedMovie.company_name_display }}</el-descriptions-item>
          <el-descriptions-item label="类型">
            <el-tag
              v-for="genre in selectedMovie.genres"
              :key="genre"
              size="small"
              style="margin-right: 5px;"
            >
              {{ genre }}
            </el-tag>
          </el-descriptions-item>
        </el-descriptions>
        
        <div v-if="selectedMovie.actors && selectedMovie.actors.length" class="actors-section">
          <h4>演员信息</h4>
          <el-table :data="selectedMovie.actors" size="small">
            <el-table-column prop="actor_name" label="演员姓名" />
            <el-table-column prop="birth_date" label="出生日期" />
            <el-table-column prop="role" label="角色" />
          </el-table>
        </div>
        
        <div v-if="selectedMovie.directors && selectedMovie.directors.length" class="directors-section">
          <h4>导演信息</h4>
          <el-table :data="selectedMovie.directors" size="small">
            <el-table-column prop="director_name" label="导演姓名" />
            <el-table-column prop="birth_date" label="出生日期" />
          </el-table>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { ref, reactive, computed, onMounted } from 'vue'
import { useStore } from 'vuex'
import { ElMessage, ElMessageBox } from 'element-plus'
import api from '../utils/api'

export default {
  name: 'Movies',
  setup() {
    const store = useStore()
    const loading = ref(false)
    const saving = ref(false)
    const showAddDialog = ref(false)
    const showViewDialog = ref(false)
    const isEditing = ref(false)
    const selectedMovie = ref(null)
    const movieFormRef = ref(null)

    const movies = computed(() => store.state.movies)
    const genres = computed(() => store.state.genres)
    const companies = computed(() => store.state.companies)

    const searchForm = reactive({
      title: '',
      genre: '',
      actor: '',
      director: '',
      yearRange: null
    })

    const movieForm = reactive({
      title: '',
      release_date: '',
      charge_per_download: 0,
      company_name: '',
      genres: []
    })

    const movieRules = {
      title: [{ required: true, message: '请输入电影标题', trigger: 'blur' }],
      charge_per_download: [{ required: true, message: '请输入下载价格', trigger: 'blur' }]
    }

    const searchMovies = async () => {
      try {
        loading.value = true
        const params = {}
        
        if (searchForm.title) params.title = searchForm.title
        if (searchForm.genre) params.genre = searchForm.genre
        if (searchForm.actor) params.actor = searchForm.actor
        if (searchForm.director) params.director = searchForm.director
        if (searchForm.yearRange) {
          params.year_from = searchForm.yearRange[0]
          params.year_to = searchForm.yearRange[1]
        }
        
        const response = await api.get('/movies/search/', { params })
        store.commit('SET_MOVIES', response.data)
      } catch (error) {
        console.error('搜索电影失败:', error)
      } finally {
        loading.value = false
      }
    }

    const resetSearch = () => {
      Object.assign(searchForm, {
        title: '',
        genre: '',
        actor: '',
        director: '',
        yearRange: null
      })
      store.dispatch('fetchMovies')
    }

    const viewMovie = (movie) => {
      selectedMovie.value = movie
      showViewDialog.value = true
    }

    const editMovie = (movie) => {
      isEditing.value = true
      Object.assign(movieForm, {
        movie_id: movie.movie_id,
        title: movie.title,
        release_date: movie.release_date,
        charge_per_download: movie.charge_per_download,
        company_name: movie.company_name,
        genres: movie.genres || []
      })
      showAddDialog.value = true
    }

    const deleteMovie = async (movie) => {
      try {
        await ElMessageBox.confirm(
          `确定要删除电影 "${movie.title}" 吗？`,
          '确认删除',
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }
        )
        
        await store.dispatch('deleteMovie', movie.movie_id)
        ElMessage.success('删除成功')
      } catch (error) {
        if (error !== 'cancel') {
          ElMessage.error('删除失败')
        }
      }
    }

    const saveMovie = async () => {
      try {
        await movieFormRef.value.validate()
        saving.value = true
        
        if (isEditing.value) {
          await store.dispatch('updateMovie', {
            id: movieForm.movie_id,
            movieData: movieForm
          })
          ElMessage.success('更新成功')
        } else {
          await store.dispatch('createMovie', movieForm)
          ElMessage.success('添加成功')
        }
        
        showAddDialog.value = false
        resetForm()
      } catch (error) {
        console.error('保存电影失败:', error)
      } finally {
        saving.value = false
      }
    }

    const resetForm = () => {
      isEditing.value = false
      Object.assign(movieForm, {
        title: '',
        release_date: '',
        charge_per_download: 0,
        company_name: '',
        genres: []
      })
      if (movieFormRef.value) {
        movieFormRef.value.resetFields()
      }
    }

    onMounted(async () => {
      await Promise.all([
        store.dispatch('fetchMovies'),
        store.dispatch('fetchGenres'),
        store.dispatch('fetchCompanies')
      ])
    })

    return {
      loading,
      saving,
      showAddDialog,
      showViewDialog,
      isEditing,
      selectedMovie,
      movieFormRef,
      movies,
      genres,
      companies,
      searchForm,
      movieForm,
      movieRules,
      searchMovies,
      resetSearch,
      viewMovie,
      editMovie,
      deleteMovie,
      saveMovie,
      resetForm
    }
  }
}
</script>

<style scoped>
.movies {
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

.movie-detail {
  max-height: 500px;
  overflow-y: auto;
}

.actors-section,
.directors-section {
  margin-top: 20px;
}

.actors-section h4,
.directors-section h4 {
  margin-bottom: 10px;
  color: #2c3e50;
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