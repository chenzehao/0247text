import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  //变量
  state:{
    userInfo:{},  //用户信息
    // 检索条件
    sel:{
      search:'',
      date:'',  //日期
      days:0,  //几晚
      data:[],  //日历的所有数据
      man:1, //成年人
      child:0, //小孩
      little:0, //婴儿
      minPrice:0, //最小价格
      maxPrice:5000,  //最大价格
      roomType:[false,false], //房间类型
      count:{
        bed:0,  //床数量
        bedroom:0,  //卧室数量
        toliet:0  //卫生间数量
      }
    },
    // roomList搜索到的结果
    roomlist:[],
    roomlistLoading:false,
    // home的显示状态
    homePage:'tab1',
    orderPage:'all'
  },
  mutations: {
    // 修改order状态
    orderChange(state,val){
      state.orderPage=val
    },
    // 修改loading状态
    loadingChange(state,bool){
      state.roomlistLoading=bool
    },
    // 登陆成功·添加用户信息
    userChange(state,get){
      // 创建一个新的对象，将get对象复制到新对象中
      let data = Object.assign({},get);
      // 将state.userInfo指向新对象的引用地址--如果不改变引用地址，里面的值监听不到
      state.userInfo=data; 
    },
    // 退出登录
    logOut(state){
      state.userInfo={}
    },
    // 查询地点修改
    searchChange(state,city){
      state.sel.search=city
    },
    // 人数修改
    peopleChange(state,get){
      if(get.where=='man' && get.way=='sub'){
        state.sel.man--
      }else if(get.where=='man' && get.way=='add'){
        state.sel.man++
      }else if(get.where=='child' && get.way=='sub'){
        state.sel.child--
      }else if(get.where=='child' && get.way=='add'){
        state.sel.child++
      }else if(get.where=='little' && get.way=='sub'){
        state.sel.little--
      }else if(get.where=='little' && get.way=='add'){
        state.sel.little++
      }else{
        return
      }
    },
    // 价格修改
    priceChange(state,get){
      state.sel.minPrice=get.minPrice
      state.sel.maxPrice=get.maxPrice
    },
    // 房间类型修改
    roomChange(state,rType){
      state.sel.roomType=rType
    },
    // 房间布局数量修改
    bedChange(state,get){
      if(get.where=='bed' && get.way=='sub'){
        state.sel.count.bed--
      }else if(get.where=='bed' && get.way=='add'){
        state.sel.count.bed++
      }else if(get.where=='bedroom' && get.way=='sub'){
        state.sel.count.bedroom--
      }else if(get.where=='bedroom' && get.way=='add'){
        state.sel.count.bedroom++
      }else if(get.where=='toliet' && get.way=='sub'){
        state.sel.count.toliet--
      }else if(get.where=='toliet' && get.way=='add'){
        state.sel.count.toliet++
      }else{
        return
      }
    },
    // 修改roomlist方法
    roomListChange(state,get){
      state.roomlist=get
    },
    // 除search外 都重置方法
    delSearch(state){
      var sel=state.sel
      sel.date='';
      sel.data=[];  //日历的所有数据
      sel.days=0;
      sel.man=0;
      sel.child=0;
      sel.little=0;
      sel.minPrice=0;
      sel.maxPrice=5000;
      sel.roomType=[false,false]
      sel.count={
        bed:0,
        bedroom:0,
        toliet:0,
      }
    },
    // 修改日期
    dateChange(state,date){
      state.sel.date=date
    },
    //修改几晚
    daysChange(state,days){
      state.sel.days=days
    },
    // 修改日历的所有数据
    dataChange(state,data){
      state.sel.data=data
    },
    // 修改HomePage
    homePageChange(state,active){
      state.homePage=active
    }
  },
  getters: {
    // 获取orderPage
    getOrder(state){return state.orderPage},
    // 获取HomePage
    getHomepage(state){return state.homePage},
    // 获取用户信息
    getInfo(state){return state.userInfo},
    // 获取检索条件
    getsel(state){return state.sel},
    // 获取roomlist
    getRoomlist(state){return state.roomlist},
    // 获取loading状态
    getLoading(state){return state.roomlistLoading}
  },
  modules: {
  }
})
