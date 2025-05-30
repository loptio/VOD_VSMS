import { createStore } from 'vuex'
import api from '../utils/api'

export default createStore({
  state: {
    movies: [],
    members: [],
    purchases: [],
    downloads: [],
    genres: [],
    companies: [],
    memberStatuses: [],
    loading: false,
    error: null
  },
  
  mutations: {
    SET_LOADING(state, loading) {
      state.loading = loading
    },
    
    SET_ERROR(state, error) {
      state.error = error
    },
    
    SET_MOVIES(state, movies) {
      state.movies = movies
    },
    
    SET_MEMBERS(state, members) {
      state.members = members
    },
    
    SET_PURCHASES(state, purchases) {
      state.purchases = purchases
    },
    
    SET_DOWNLOADS(state, downloads) {
      state.downloads = downloads
    },
    
    SET_GENRES(state, genres) {
      state.genres = genres
    },
    
    SET_COMPANIES(state, companies) {
      state.companies = companies
    },
    
    SET_MEMBER_STATUSES(state, statuses) {
      state.memberStatuses = statuses
    },
    
    ADD_MOVIE(state, movie) {
      state.movies.push(movie)
    },
    
    UPDATE_MOVIE(state, updatedMovie) {
      const index = state.movies.findIndex(m => m.movie_id === updatedMovie.movie_id)
      if (index !== -1) {
        state.movies.splice(index, 1, updatedMovie)
      }
    },
    
    DELETE_MOVIE(state, movieId) {
      state.movies = state.movies.filter(m => m.movie_id !== movieId)
    },
    
    ADD_MEMBER(state, member) {
      state.members.push(member)
    },
    
    UPDATE_MEMBER(state, updatedMember) {
      const index = state.members.findIndex(m => m.member_id === updatedMember.member_id)
      if (index !== -1) {
        state.members.splice(index, 1, updatedMember)
      }
    },
    
    DELETE_MEMBER(state, memberId) {
      state.members = state.members.filter(m => m.member_id !== memberId)
    },
    
    ADD_PURCHASE(state, purchase) {
      state.purchases.push(purchase)
    }
  },
  
  actions: {
    async fetchMovies({ commit }) {
      try {
        commit('SET_LOADING', true)
        const response = await api.get('/movies/')
        commit('SET_MOVIES', response.data.results || response.data)
        commit('SET_ERROR', null)
      } catch (error) {
        commit('SET_ERROR', error.message)
        console.error('获取电影列表失败:', error)
      } finally {
        commit('SET_LOADING', false)
      }
    },
    
    async fetchMembers({ commit }) {
      try {
        commit('SET_LOADING', true)
        const response = await api.get('/members/')
        commit('SET_MEMBERS', response.data.results || response.data)
        commit('SET_ERROR', null)
      } catch (error) {
        commit('SET_ERROR', error.message)
        console.error('获取会员列表失败:', error)
      } finally {
        commit('SET_LOADING', false)
      }
    },
    
    async fetchPurchases({ commit }) {
      try {
        commit('SET_LOADING', true)
        const response = await api.get('/purchases/')
        commit('SET_PURCHASES', response.data.results || response.data)
        commit('SET_ERROR', null)
      } catch (error) {
        commit('SET_ERROR', error.message)
        console.error('获取购买记录失败:', error)
      } finally {
        commit('SET_LOADING', false)
      }
    },
    
    async fetchDownloads({ commit }) {
      try {
        commit('SET_LOADING', true)
        const response = await api.get('/downloads/')
        commit('SET_DOWNLOADS', response.data.results || response.data)
        commit('SET_ERROR', null)
      } catch (error) {
        commit('SET_ERROR', error.message)
        console.error('获取下载记录失败:', error)
      } finally {
        commit('SET_LOADING', false)
      }
    },
    
    async fetchGenres({ commit }) {
      try {
        const response = await api.get('/genres/')
        commit('SET_GENRES', response.data.results || response.data)
      } catch (error) {
        console.error('获取电影类型失败:', error)
      }
    },
    
    async fetchCompanies({ commit }) {
      try {
        const response = await api.get('/companies/')
        commit('SET_COMPANIES', response.data.results || response.data)
      } catch (error) {
        console.error('获取公司列表失败:', error)
      }
    },
    
    async fetchMemberStatuses({ commit }) {
      try {
        const response = await api.get('/member-status/')
        commit('SET_MEMBER_STATUSES', response.data.results || response.data)
      } catch (error) {
        console.error('获取会员状态失败:', error)
      }
    },
    
    async createMovie({ commit }, movieData) {
      try {
        const response = await api.post('/movies/', movieData)
        commit('ADD_MOVIE', response.data)
        return response.data
      } catch (error) {
        console.error('创建电影失败:', error)
        throw error
      }
    },
    
    async updateMovie({ commit }, { id, movieData }) {
      try {
        const response = await api.put(`/movies/${id}/`, movieData)
        commit('UPDATE_MOVIE', response.data)
        return response.data
      } catch (error) {
        console.error('更新电影失败:', error)
        throw error
      }
    },
    
    async deleteMovie({ commit }, movieId) {
      try {
        await api.delete(`/movies/${movieId}/`)
        commit('DELETE_MOVIE', movieId)
      } catch (error) {
        console.error('删除电影失败:', error)
        throw error
      }
    },
    
    async createMember({ commit }, memberData) {
      try {
        const response = await api.post('/members/', memberData)
        commit('ADD_MEMBER', response.data)
        return response.data
      } catch (error) {
        console.error('创建会员失败:', error)
        throw error
      }
    },
    
    async updateMember({ commit }, { id, memberData }) {
      try {
        const response = await api.put(`/members/${id}/`, memberData)
        commit('UPDATE_MEMBER', response.data)
        return response.data
      } catch (error) {
        console.error('更新会员失败:', error)
        throw error
      }
    },
    
    async deleteMember({ commit }, memberId) {
      try {
        await api.delete(`/members/${memberId}/`)
        commit('DELETE_MEMBER', memberId)
      } catch (error) {
        console.error('删除会员失败:', error)
        throw error
      }
    },
    
    async createPurchase({ commit }, purchaseData) {
      try {
        const response = await api.post('/purchases/', purchaseData)
        commit('ADD_PURCHASE', response.data)
        return response.data
      } catch (error) {
        console.error('创建购买记录失败:', error)
        throw error
      }
    }
  },
  
  getters: {
    getMovieById: (state) => (id) => {
      return state.movies.find(movie => movie.movie_id === id)
    },
    
    getMemberById: (state) => (id) => {
      return state.members.find(member => member.member_id === id)
    },
    
    getActiveMembers: (state) => {
      return state.members.filter(member => member.status === 1)
    },
    
    getTotalMovies: (state) => {
      return state.movies.length
    },
    
    getTotalMembers: (state) => {
      return state.members.length
    },
    
    getTotalPurchases: (state) => {
      return state.purchases.length
    },
    
    getTotalDownloads: (state) => {
      return state.downloads.length
    }
  }
})