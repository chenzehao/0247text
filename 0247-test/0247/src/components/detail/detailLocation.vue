<template>
  <div class="detailLocation">
    <!-- 顶部房源位置 -->
    <div class="location">
      <div class="center-box">
        <!-- 左侧部分 -->
        <div class="box-left">
          <p class="loca_title">房源位置</p><!--标题-->
          <p class="loca_con">{{loca}}</p><!--内容-->
        </div>
        <!-- 右侧部分 -->
        <div class="box-right" @click="openMap">
          <img :src="require('../../../public/image/detail/map.png')">
        </div>
      </div>
      <Map @openBtn="openMap" :accuracy="accuracy" :latitude="latitude"></Map>
      <!-- accuracy:'',//精度
      latitude:'',//纬度 -->
    </div>
    <!-- 房间周边细节 -->
    <div class="circum">
      <div class="center-box">
        <div class="circum-box" :class="isClose?'close':''">
          <!-- 周边环境 -->
          <div class="environment">
            <p class="cir_title">周边环境</p><!--周边环境标题-->
            <p class="cir_con" v-for="(item,index) of loca_desc" :key="index">
              {{item}}
            </p><!--周边环境内容-->
          </div>
          <!-- 出行信息 -->
          <div class="trip">
            <p class="trip_title">出行信息</p><!--周边环境标题-->
            <p class="trip_con" v-for="(item,index) of travel_info" :key="index">
              {{item}}
            </p><!--周边环境内容-->
          </div>
        </div>
        <!-- 收起/查看全部内容 -->
        <p class="toggle-text" @click="toggleClass">{{isClose?'查看全部内容':'收起'}}</p>
      </div>
    </div>
  </div>
</template>

<script>
import Map from './Map.vue'
export default {
  components:{
    Map
  },
  props:{
    loca:{type:String},
    loca_desc:{type:Array},
    travel_info:{type:Array},
    accuracy:{type:String},
    latitude:{type:String}
    // accuracy:'',//精度
    //   latitude:'',//纬度
  },
  data(){
    return{
      isClose:true
    }
  },
  methods:{
    toggleClass(){
      this.isClose=!this.isClose;
    },
    openMap(){
      this.$emit('openMap',true)
    }
  }
}
</script>

<style scoped>
.detailLocation{
  background:#fff;
  text-align:left;
  padding:16px 0;
  border-bottom:8px solid #f2f2f2;
}
.location{
  padding:16px 0;
  border-bottom:1px solid #f2f2f2;
}
.location>.center-box{
  display:flex;
  justify-content:space-between;
}
.loca_title,.cir_title,.trip_title{
  font-size:14px;
  font-weight:bold;
  line-height:18px;
  margin-bottom:16px;
  color:#484848;
}
.trip_title{
  margin:16px 0;
}
.loca_con{
  font-size:16px;
  line-height:22px;
  color:#484848;
}
.circum{
  padding:16px 0;
}
.close{
  height:95px;
  overflow:hidden;
}
.toggle-text{
  font-size:14px;
  color:#008489;
  font-weight:bold;
  cursor:pointer;
  margin-top:15px;
}
.cir_con,.trip_con{
  font-size:16px;
  line-height:22px;
}
</style>