<template>
  <div class="detailRoomuser">
    <div class="center-box">
      <div class="user-box">
        <!-- 标题 -->
        <p class="title">房东</p>
        <!-- 房东信息 -->
        <div class="info">
          <div class="left">
            <img :src="avatar?avatar:require('../../../public/index/popup1.jpg')">
          </div>
          <div class="right">
            <p class="name">{{userName}}</p>
            <p class="com">{{isReg==1?'已验证':'未验证'}}</p>
          </div>
        </div>
        <!-- 自我介绍 -->
        <div class="intro ellipsis">
          <!-- {{intro}} -->
          <p @click="toggle" v-for="(item,index) of intro" :key="index">{{item}}</p>
        </div>
      </div>
      <p class="toggle-text">联系房东</p>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    userName:{type:String},
    avatar:{type:String},
    intro:{type:Array},
    isReg:{type:Number}
  },
  methods:{
    toggle(e){
      e.target.parentNode.classList.remove('ellipsis')
    }
  }
}
</script>

<style scoped>
.detailRoomuser{
  background:#fff;
  text-align:left;
  padding:16px 0;
  border-bottom:8px solid #f2f2f2;
}
.title{
  font-size:14px;
  font-weight:bold;
  line-height:18px;
  margin-bottom:16px;
  color:#484848;
}
.info{
  display:flex;
  justify-content:start;
  margin-bottom:16px;
}
.info>.left{
  width:44px;
  height:44px;
  border-radius:50%;
  overflow:hidden;
}
.info>.left>img{
  width:100%;
  object-fit:cover;
}
.right{
  margin-left:12px;
  padding-top:4px;
}
.name{
  font-size:14px;
  line-height:18px;
  font-weight:bold;
}
.com{
  font-size:12px;
  line-height:16px;
  margin-top:2px;
}
.intro{
  color:#484848;
  font-size:14px;
  line-height:1.43;
}
.ellipsis{
  display: -webkit-box;
  overflow: hidden;
  max-height: 80px;
  text-overflow: ellipsis;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  /* word-break: break-all; */
}
.toggle-text{
  font-size:14px;
  color:#008489;
  font-weight:bold;
  cursor:pointer;
  margin-top:15px;
}
</style>