<template>
  <!-- 弹出层 -->
  <div class="popup">
    <!-- 点击图片弹出 -->
    <van-cell is-link @click="showPopup" >
      <img :style="{'display':isIndex?'none':'block'}" 
        :src="getInfo" :class="{'login':isLogin}">
        <!-- :src="isIndex?require('../../public/index/popup1.jpg'):isLogin==true?require('../../public/index/popup1.jpg'):getInfo" -->
        <!-- 如果登录状态，并且有头像 显示用户头像 -->
        <!-- 如果不是登录状态 显示默认头像 -->
        <!-- 如果登录状态，没有头像 显示默认头像 -->
        <!-- isLogin == false 默认 -->
        <!-- isLogin == true 用户头像 -->
        <!-- isLogin?getInfo:require('../../public/index/popup1.jpg') -->
    </van-cell>
    <!-- 弹出层样式 -->
    <van-popup  v-model="show" position="right" :style="{width:'75%',height: '100%'}">
      <div class="p-top">
        <button :disabled="Object.keys(this.$store.getters.getInfo).length>0" class="u_name" @click="login">{{Object.keys(this.$store.getters.getInfo).length>0?this.$store.getters.getInfo.u_name:'注销/登录'}}</button>
        <!-- //用户头像 -->
        <img :src="getInfo">
      </div>
      <div class="p-content">
        <div class="cont-one" :style="{'display':isIndex?'none':'flex'}">
          <img src="../../public/index/cont-four.jpg">
          <a href="javascript:;" @click="go">首页</a>
        </div>
        <div class="cont-one" :style="{'display':isLogin?'flex':'none'}">
          <img src="../../public/index/message.jpg">
          <a href="javascript:;" @click="toOrder">订单</a>
        </div>
        <div class="cont-one" :style="{'display':isLogin?'flex':'none'}">
          <img src="../../public/index/xin.jpg">
          <a href="javascript:;" @click="toLike">心愿单</a>
        </div>
        <div class="cont-one">
          <img src="../../public/index/cont-one.jpg">
          <a href="">下载 0247 APP</a>
        </div>
        <div class="cont-one">
          <img src="../../public/index/cont-two.jpg">
          <a href="javascript:;">语言与货币</a>
        </div>
        <div class="cont-one">
          <img src="../../public/index/cont-three.jpg">
          <a href="javascript:;">帮助</a>
        </div>
        <div class="cont-one" :style="{'display':isLogin?'flex':'none'}">
          <img src="../../public/index/bye.jpg">
          <a href="javascript:;" @click="bye">退出</a>
        </div>
      </div>
    </van-popup>
  </div>
</template>
<script>
export default {
  data() {
    return {
      show: false,
      statecode:"",
      isLogin:false
    }
  },
  props:['isIndex'],
  methods: {
    showPopup() {
      this.show = true;
    },
    //跳转到登录页
    login(){
      this.$router.push("/login")
    },
    //跳转到首页
    go(){
      this.$router.push("/");
    },
    // 跳转订单组件
    toOrder(){
      this.$store.commit('homePageChange',"tab3")
      this.$router.push('/')
    },
    // 跳转心愿组件
    toLike(){
      this.$store.commit('homePageChange',"tab2")
      this.$router.push('/')
    },
    //退出
    bye(){
      this.axios.get('index/logout').then(res=>{
          if(res.data.code==1){
              this.$store.commit('logOut');
              sessionStorage.setItem('userInfo',JSON.stringify({}));
          }
      })
    }
    
  },
  computed: {
    getInfo(){
      //未注册未登录
      if(Object.keys(this.$store.getters.getInfo).length==0){
        this.isLogin=false;
        return require('../../public/index/popup1.jpg');
        //已经登录，但用户没有选择头像
      }else if(Object.keys(this.$store.getters.getInfo).length>0 && this.$store.getters.getInfo.avatar==""){
        // console.log('已经登录,但没有头像')
        this.isLogin=false;
        return require('../../public/index/popup1.jpg');
      }else if(Object.keys(this.$store.getters.getInfo).length>0 && this.$store.getters.getInfo.avatar!=""){
        //用户已经自己选择头像并上传
        this.isLogin=true;
        return this.$store.getters.getInfo.avatar;
      }
    }
  },
}
</script>
<style scoped>
/* 弹出层 */
  .popup{
    background:transparent !important;
  }
  .van-cell{
    padding:0;
    background:rgba(255,255,255,0);
  }
  .van-cell:active {
    background:rgba(255,255,255,0);
  }
  /* 点击图片弹出 */
  .van-cell__value{
    display: flex;
    justify-content: flex-end;
  }

   .van-cell__value>div{
    width:80px;
    height:80px;
    position: relative;
    background:none;
    top:0;right:0;
    z-index:1000;
   }
    /*图片样式  */
  .van-cell__value>img{
    width:32px;
    height:32px;
    margin-right: 25px;
    margin-top: 24px;
    border-radius: 50%;
  }
  .van-cell__value>img.login{
    border:2px solid white !important;
    box-sizing: border-box !important;
  }
  /* 清楚默认的'>'符号 */
  .van-cell>.van-icon{
    display: none;
  }
  /* 弹出层 */
  .van-popup>.p-top{
    display: flex;
    justify-content: space-between;
  }
  /* 弹出层顶部的按钮及图片 */
  .van-popup>.p-top>button{
    padding:49px 0 53px 24px !important;
    color: #008489 !important;
    border: none;
    outline: none;
    background: none;
    font-size:16px;
    font-family: Circular, "PingFang-SC";
  }
  .van-popup>.p-top>img{
    width:48px;
    height:48px;
    margin-right: 24px !important;
    margin-top: 33px !important;
    border-radius: 50%;
  }
  /* 弹出层的菜单样式 */
  .cont-one{
    display: flex;
    justify-content:left;
    padding-bottom: 36px !important;
  }
  .cont-one>img{
    width:20px;
    height:20px;
    padding-left: 24px !important;
  }
  .cont-one>a{
    display: block;
    margin-left: 16px;
    color: #484848;
  }
</style>