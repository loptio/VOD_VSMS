
// 全局错误处理
class ErrorHandler {
  static handleError(error, context = '') {
    // 忽略 ResizeObserver 错误（这是一个无害的浏览器警告）
    const errorMessage = error && error.message ? error.message : String(error);
    if (errorMessage && errorMessage.includes('ResizeObserver loop completed with undelivered notifications')) {
      return;
    }
    
    // 忽略 null 或 undefined 错误
    if (!error || error === null || error === undefined) {
      return;
    }
    
    // 在开发环境显示详细错误
    if (process.env.NODE_ENV === 'development') {
      console.error(`[${context}] 错误:`, error);
    }
    
    // 生产环境可以添加错误上报逻辑
    // 例如发送到错误监控服务
  }
  
  static handleApiError(error, context = 'API请求') {
    let message = '操作失败，请稍后重试';
    
    if (error.response) {
      // 服务器响应错误
      message = error.response.data?.message || `服务器错误 (${error.response.status})`;
    } else if (error.request) {
      // 网络错误
      message = '网络连接失败，请检查网络设置';
    }
    
    this.handleError(error, context);
    return message;
  }
}

export default ErrorHandler;