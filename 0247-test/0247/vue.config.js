module.exports = {
  css: {
    loaderOptions: {
      stylus: {
        'resolve url': true,
        'import': []
      }
    }
  },
  pluginOptions: {
    'cube-ui': {
      postCompile: false,
      theme: false
    }
  },
  chainWebpack:config=>{
    //删除编译后的预获取操作
    config.plugins.delete("prefetch")
  },

}
