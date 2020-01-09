<template>
    <div class="search-inside">
      <!-- 上方搜索框 -->
      <div class="search-bar" >
				<!-- 搜索文字和小图标 -->
        <div class="search-text" >
            <div class="search-img" @click="goback">
              <img src="../../../public/index/back.png" alt="">
            </div>
              <input class="search-input" @focus="focus" type="text" :value="this.$store.getters.getsel.search">
        </div>
      </div>
      <div class="popup">
        <popup></popup>
      </div>
      <div><selector></selector></div>
    </div>
</template>
<script>
// 引入折叠div
import select from './zhedie'
import popup from '../Popup'
export default {
  components:{
    "Popup":popup,
    "selector":select
  },
  data(){
      return {
        isOff:false, //设置取消开关
      }
  },
  methods:{
      goback(){
        this.$router.go(-1)
      },
      focus(){
          this.$emit('foc',this.isOff);
      }
  }
}
</script>
<style scoped>
*{margin: 0;padding: 0; box-sizing: border-box;}
.search-inside{
  width:100%;
  height:70px;
  position:fixed;
  left:0px;
  top:0px;
  padding-top:76px;
  background:#fff;
  z-index:10;
  box-shadow: 0px 3px 18px rgba(0, 0, 0, 0.1);
}
.search-bar{
    width:100%;
    background:#fff;
  position:fixed;
  top:0;
  left:0;
  padding:16px 80px 10px 24px;
}
/*搜索框*/
.search-text{
    box-shadow: rgba(0,0,0,0.01) 0px 1px 2px,rgba(0,0,0,0.12) 0px 3px 18px;
    border:none;
    border-radius:3px;
    font-size: 14px;
    height:48px;
    line-height:48px;
    position: relative !important;
    padding-left: 48px;
    padding-right: 24px;
    color:rgb(72,72,72);
}
.search-img{
    width: 7%;
    height: 7%;
    position:absolute;
    top:8%;
    left:5%;
}
.user-img{
  width:32px;
  height: 32px;
  position: absolute;
  top:18%;
  right: -20%;
}
.user-img img{
  width: 100%;
}
.search-img img{
    width: 100%;

}
.popup{
  position: absolute;
  top:0;
  right:0;
}
.search-input{
	width:100%;
    font-size: 16px;
    font-weight: bold;
    border:0;
}
.search-input:focus{
    outline: none;
}
.search-cancel{
	border:0;
    outline: none;
    background: none;
}
/*取消按钮*/
.search-cancel{
    width:72px;
    height: 48px;
    position: absolute;
    top:16px;
    right:8px;
    line-height: 48px;
	font-size: 14px;
    color: #484848;
    padding:0;
}
.off{
    display: none;
}

</style>