import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Movies from '../views/Movies.vue'
import Members from '../views/Members.vue'
import Purchases from '../views/Purchases.vue'
import Downloads from '../views/Downloads.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/movies',
    name: 'Movies',
    component: Movies
  },
  {
    path: '/members',
    name: 'Members',
    component: Members
  },
  {
    path: '/purchases',
    name: 'Purchases',
    component: Purchases
  },
  {
    path: '/downloads',
    name: 'Downloads',
    component: Downloads
  },

]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router