import Vue from 'vue'
import './cube-ui'
import App from './App.vue'
import router from './router'
import store from './store'
import filters from './filters/index'; 
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key]);
});
// roomDetail iconfont
import '../public/css/iconfont.css'

//引入bus
import bus from "./bus"
Vue.prototype.bus=bus;

// BaiduMap
import BaiduMap from 'vue-baidu-map'
Vue.use(BaiduMap,{
  ak:'sRVM2um5hSNP4HABdVjDT90mHLYTm5n0'
})

import Router from 'vue-router'
const routerPush = Router.prototype.push
Router.prototype.push = function push(location) {
  return routerPush.call(this, location).catch(error=> error)
}


//引入 axios 并 配置baseURL
import axios from 'axios'
import {baseURL} from "../babel.config.js"

axios.defaults.baseURL='http://127.0.0.1:8088'
Vue.prototype.axios=axios

//引入Vant
import Vant from 'vant';
import 'vant/lib/index.css';
Vue.use(Vant);

//引入cube-ui
import mintUi from 'mint-ui'
import "mint-ui/lib/style.css"
Vue.use(mintUi)

//配置发送请求保存session信息
axios.defaults.withCredentials=true;
Vue.config.productionTip = false

//引入vuex
import Vuex from 'vuex'
Vue.use(Vuex)



new Vue({
  router,
  store,
  filters,
  render: h => h(App),
}).$mount('#app')


