import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import zhCn from 'element-plus/dist/locale/zh-cn.mjs'
import ErrorHandler from './utils/errorHandler'

const app = createApp(App)

// 全局错误处理
app.config.errorHandler = (err, instance, info) => {
  ErrorHandler.handleError(err, info)
}

// 捕获未处理的Promise错误
window.addEventListener('unhandledrejection', event => {
  ErrorHandler.handleError(event.reason, 'Unhandled Promise Rejection')
})

// 捕获全局错误
window.addEventListener('error', event => {
  // 特殊处理 ResizeObserver 错误
  if (event.message && event.message.includes('ResizeObserver loop completed with undelivered notifications')) {
    event.preventDefault();
    return;
  }
  ErrorHandler.handleError(event.error, 'Global Error')
})

// 直接捕获 ResizeObserver 错误
const originalResizeObserver = window.ResizeObserver;
if (originalResizeObserver) {
  window.ResizeObserver = class extends originalResizeObserver {
    constructor(callback) {
      super((entries, observer) => {
        try {
          callback(entries, observer);
        } catch (error) {
          if (error.message && error.message.includes('ResizeObserver loop completed with undelivered notifications')) {
            // 忽略这个错误
            return;
          }
          throw error;
        }
      });
    }
  };
}

// 注册所有图标
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}

app.use(store)
   .use(router)
   .use(ElementPlus, {
     locale: zhCn
   })
   .mount('#app')