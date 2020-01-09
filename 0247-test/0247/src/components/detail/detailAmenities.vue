<template>
  <div class="detailAmenities">
    <div class="center-box">
      <div class="big_box" :class="is_close?'close':''">
        <!-- 基础设施 -->
        <div class="base" v-show="baseFlag">
          <p class="title">便利设施</p>
          <div class="box base_box">
            <div v-for="(item,i) of baseData[0]" v-show="item==1" :key="i" class="item_box">
              <span class="item_box_p iconfont" :class="base_class[i]"></span>
              <p class="item_text">{{base_text[i]}}</p>
            </div>
          </div>
        </div>
        <!-- 配套设施 -->
        <div class="mating" v-show="matingFlag">
          <p class="title">配套设施</p>
          <div class="box base_box">
            <div v-for="(item,i) of matingData[0]" v-show="item==1" :key="i" class="item_box">
              <span class="item_box_p iconfont" :class="mating_class[i]"></span>
              <p class="item_text">{{mating_text[i]}}</p>
            </div>
          </div>
        </div>
        <!-- 儿童设施 -->
        <div class="child" v-show="childFlag">
          <p class="title">儿童设施</p>
          <div class="box base_box">
            <div v-for="(item,i) of childData[0]" v-show="item==1" :key="i" class="item_box">
              <span class="item_box_p iconfont" :class="child_class[i]"></span>
              <p class="item_text">{{child_text[i]}}</p>
            </div>
          </div>
        </div>
        <!-- 安全设施 -->
        <div class="safe" v-show="safeFlag">
          <p class="title">安全设施</p>
          <div class="box base_box">
            <div v-for="(item,i) of safeData[0]" v-show="item==1" :key="i" class="item_box">
              <span class="item_box_p iconfont" :class="safe_class[i]"></span>
              <p class="item_text">{{safe_text[i]}}</p>
            </div>
          </div>
        </div>
      </div>
      <p class="toggle-text" @click="toggleStatus">{{is_close?`查看全部${facilityNum}项`:'收起'}}</p>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    baseData:{type:Array},
    matingData:{type:Array},
    childData:{type:Array},
    safeData:{type:Array},
    baseFlag:{type:Boolean},
    matingFlag:{type:Boolean},
    childFlag:{type:Boolean},
    safeFlag:{type:Boolean},
    facilityNum:{type:Number}
  },
  data(){
    return{
      base_text:{wifi:'无线网络',kitchen:'厨房',shampoo:'洗发水',hair_dryer:'吹风机',articles_daily_use:'生活必需品',air_conditioner:'空调',heating:'暖气',tv:'电视',washer:'洗衣机',desk:'书桌/工作区域',coat_hanger:'衣架',iron:'熨斗'},//基础设施文字
      base_class:{wifi:'icon-wuxianwangluo',kitchen:'icon-daocha',shampoo:'icon-xifashui',hair_dryer:'icon-tubiaoCSban-',articles_daily_use:'icon-maojin',air_conditioner:'icon-snow',heating:'icon-nuanqi',tv:'icon-dianshi-',washer:'icon-xiyiji',desk:'icon-shuzhuo',coat_hanger:'icon-yijia',iron:'icon-ic_yun'},//基础设施class
      mating_text:{elevator:'电梯',own_int:'独立入口',free_parking_spot:'免费停车位'},//配套设施文字
      mating_class:{elevator:'icon-dianti',own_int:'icon-huabanfuben',free_parking_spot:'icon-tingchewei'},//配套设施class
      child_text:{bathtub:'浴缸'},//儿童设施文字
      child_class:{bathtub:'icon-yuganganzhuang'},//儿童设施class
      safe_text:{smoke_siren:'烟雾报警器',carbon_monoxide_siren:'一氧化碳报警器'},//安全设施文字
      safe_class:{smoke_siren:'icon-yanwubaojingqi',carbon_monoxide_siren:'icon-yanwubaojingqi1'},//安全设施class
      is_close:true
    }
  },
  methods:{
    toggleStatus(){
      this.is_close=!this.is_close;
    }
  },
}
</script>

<style scoped>
.detailAmenities{
  background:#fff;
  padding:16px 0;
  text-align: left !important;
  border-bottom:8px solid #f2f2f2;
} 
.close{
  height:98px;
  overflow:hidden;
}
.toggle-text{
  font-size:14px;
  color:#008489;
  font-weight:bold;
  cursor:pointer;
  margin-top:15px;
}
.title{
  font-size:14px;
  line-height: 18px;
  font-weight: bold;
  color:#484848;
  margin-bottom:16px;
}
.item_box{
  width:65px;
  text-align:center;
}
.item_text{
  margin-top:6px;
}
.box{
  display:flex;
  justify-content:start;
  flex-wrap:wrap;
}
.item_box .item_box_p{
  /* width:24px;
  height:24px; */
  text-align: center;
  font-size:30px;
  color:#484848;
}
.item_text{
  font-size:10px;
  line-height: 12px;
  margin-bottom:16px;
  font-weight:bold;
}
</style>