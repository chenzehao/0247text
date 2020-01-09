<template>
  <div class="detailAbout">
    <div v-if="toAboutData" class='center-box'>
      <!-- 文字盒子 -->
      <div :class="isClose?'close':''">
        <!-- 关于此房源 -->
        <div v-if="toAboutData.room_outline">
          <!-- 关于此房源标题 -->
          <p class="room_title">关于此房源</p>
          <!-- 关于此房源内容 -->
          <!-- <p class="room_content">{{toAboutData.room_outline}}</p> -->
          <p class="room_content">
            <p class="room_contents" v-for="(item,index) of outline" :key="index">{{item}}</p>
          </p>
        </div>
        <!-- 房源细节 -->
        <div v-if="toAboutData.room_detail">
          <!-- 房源细节标题 -->
          <p class="room_title">房源细节</p>
          <!-- 房源细节内容 -->
          <!-- <p class="room_content">{{toAboutData.room_detail}}</p> -->
          <p class="room_content">
            <p class="room_contents" v-for="(item,index) of detail" :key="index">{{item}}</p>
          </p>
        </div>
      </div>
      <!-- 收起/查看全部内容 -->
      <p class="toggle-text" @click="toggleClass">{{isClose?'查看全部内容':'收起'}}</p>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    toAboutData:{type:Object}
  },
  data(){
    return{
      outline:[],//概要
      detail:[],//细节
      isClose:true//控制文字是否折叠
    }
  },
  methods:{
    toggleClass(){
      this.isClose=!this.isClose;
    }
  },
  beforeUpdate(){
    this.outline=this.toAboutData.room_outline.split('|');//房源概要
    this.detail=this.toAboutData.room_detail.split('|');//房源细节
  }
}
</script>

<style scoped>
.detailAbout{
  background:#fff;
  padding:16px 0;
  text-align:left !important;
  border-bottom:1px solid #f2f2f2;
}
.room_title{
  color:#484848;
  font-size:14px;
  font-weight:bold;
  /* margin-bottom:16px; */
  margin:16px 0;
}
.room_contents{
  font-size:14px;
  line-height:1.43;
  color:#484848;
}
.close{
  height:145px;
  overflow: hidden;
}
.toggle-text{
  font-size:14px;
  color:#008489;
  font-weight:bold;
  cursor:pointer;
  margin-top:15px;
}
/* .text-close{
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
} */
</style>