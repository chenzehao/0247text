<template>
  <div v-if="toDetail.length>0" class="detail-header">
    <div class="center-box">
      <!-- 小标题 -->
      <p class="describ">{{data.describ}}·{{data.bedroom_num}}室{{data.bed_num}}床{{data.toilet_num}}卫·最多住{{data.person_num}}人</p>
      <!-- 主标题 -->
      <p class="big-title">{{data.big_title}}</p>
      <!-- 房源优势 -->
      <div class="room-super">
        <!-- 评价 -->
        <div class="content comment" v-if="toDetail.length>0">{{getCommentScore(toDetail).toFixed(1)}}分·{{toDetail.length}}条评价</div>
        <div class="content comment" v-else>新房源</div>
        <!-- 是否是独立房间 -->
        <div class="content indie">{{data.is_independent==1?'独立房间':'整套房子/公寓'}}</div>
        <!-- 房间普通优势 -->
        <div class="content normal" v-for="(item,i) of normal" :key="i">{{item}}</div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props:{
    toDetail:{
      type:Array
    }
  },
  data(){
    return{
      normal:[],//房间的普通优势
      data:{}//请求过来的数据
    }
  },
  methods:{
    getCommentScore(scores){//计算评价的分数
      // 总的分数/长度
      var avg=0;
      var scoreSum=0;
      for(var item of scores){
        var oneRoom=0;
        oneRoom+=parseFloat(item.truthfully_described);
        oneRoom+=parseFloat(item.location_convenient);
        oneRoom+=parseFloat(item.communication);
        oneRoom+=parseFloat(item.move_in);
        oneRoom+=parseFloat(item.clean);
        oneRoom+=parseFloat(item.cost_performance);
        scoreSum+=(oneRoom/6);//每个房间的平均分
      }
      return scoreSum/scores.length;//总的平均分
    }
  },
  beforeUpdate(){
    this.data=this.toDetail[0];//赋值给当前组件中的自定义内容
    this.normal=this.toDetail[0].room_advantage.split('|');//截取房间普通优势
  }
}
</script>

<style scoped>
.detail-header{
  background:#fff;
  padding:16px 0;
  box-sizing:content-box;
  border-bottom:1px solid #f2f2f2;
}
/* .detail-header .center-box{
  width:87%;
  margin:auto;
} */
/* 小标题 */
.center-box .describ{
  color:#a02f18;
  font-size:12px;
}
/* 主标题 */
.center-box .big-title{
  font-weight: bold;
  font-size:18px;
  color:#484848;
  margin-bottom:8px;
}
/* 房源优势 */
.center-box .room-super{
  display:flex;
  justify-content:start;
  flex-wrap:wrap;
}
.center-box .normal{
  display:flex;
  justify-content:start;
  flex-wrap:wrap;
}
.center-box .room-super .content{
  font-size:12px;
  font-weight:bold;
  padding:6px 10px;
  border-radius:3px;
  background:#f2f2f2;
  line-height:16px;
  margin:0 8px 8px 0;
  color:#484848;
}
.center-box .room-super>.content.comment{
  background:#EAF7EA;
  color:#296E00;
}
.center-box .room-super>.content.indie{
  background:#f7f3ea;
  color:#8A2400;
}
</style>