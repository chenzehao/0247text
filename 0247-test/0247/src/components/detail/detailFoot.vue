<template>
  <div class="detailFoot">
    <div class="center-box">
      <div class="left">
        <div class="l-top">
          <span class="price">¥{{price}}</span>
          <span class="unit">&nbsp;每晚</span>
        </div>
        <div class="l-bottom">
          <p>
            <cube-rate class="star" v-model="commentScore"></cube-rate>
            {{commentNum}}条
          </p>
        </div>
      </div>
      <div class="right">
        <!-- 增加向父元素发送数据的函数 -->
        <a href="javascript:;" @click="sendMsg(dayy)">{{dayy?'查看可定日期':"预定"}}</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    commentNum:{type:Number},
    commentScore:{type:Number},
    price:{type:Number}
  },
  data(){
    return{
      dayy:true
    }
  },
  methods:{
    // 发送数据的函数
    sendMsg(flag){
      if(flag){
        this.$emit("fun","0px")
      }else{
        this.$emit('changeBill','0px')
      }
    },
  },
  created(){
    if(this.$store.getters.getsel.days>0){
      this.dayy=false
    }else{
      this.dayy=true
    }
  },
  computed:{
    getdays(){
      return this.$store.getters.getsel.days
    }
  },
  watch:{
    getdays(val){
      if(val>0){
        this.dayy=false
      }else{
        this.dayy=true
      }
    }
  }

}
</script>

<style scoped>
.detailFoot{
  position:fixed;
  bottom:0;
  width:100%;
  background:#fff;
  border-top:2px solid #f2f2f2;
  height:48px;
  padding:16px 0;
}
.detailFoot .center-box{
  display:flex;
  justify-content:space-between;
}
.price{
  font-size:22px;
  line-height:22px;
  color:#484848;
  font-weight:bold;
}
.unit{
  font-size:12px;
  line-height:22px;
  color:#484848;
}
.star{
  margin-top:2px;
  width:50px;
  pointer-events: none;
}
.l-bottom>p{
  font-size:12px;
  line-height:16px;
  font-weight:bold;
  color:#484848;
}
.right>a{
  display:inline-block;
  width:160px;
  height:48px;
  text-align:center;
  font-size:16px;
  background:rgb(255, 90, 95);
  line-height:48px;
  border-radius:4px;
  color:#fff;
  font-weight:bold;
}
</style>