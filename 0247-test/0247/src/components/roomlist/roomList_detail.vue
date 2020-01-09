<template>
  <div class="roomList_detail">
    <!-- 房源优势 -->
    <div class="room-super">
      <!-- 评价 -->
      <div class="content comment" v-if="toDetail.comment">{{getCommentScore(toDetail.comment).toFixed(1)}}分·{{toDetail.comment.length}}条评价</div><!--房间详情页-->
      <div class="content comment" v-else>新房源</div>
      <!-- 是否是独立房间 -->
      <div class="content indie">{{toDetail.is_independent==1?'独立房间':'整套房子/公寓'}}</div>
      <!-- 房间普通优势 -->
      <div class="content normal" v-for="(item,i) of roomNormal" :key="i">{{item}}</div>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    toDetail:{type:Object},
    normal:{type:String}
  },
  data(){
    return{
      roomNormal:[]
    }
  },
  methods:{
    getCommentScore(scores){//计算评价的分数//是一个数组
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
  mounted(){
    this.roomNormal=this.normal.split('|');
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
/* 房源优势 */
.room-super{
  display:flex;
  justify-content:start;
  flex-wrap:wrap;
}
.normal{
  display:flex;
  justify-content:start;
  flex-wrap:wrap;
}
.room-super .content{
  font-size:12px;
  font-weight:bold;
  padding:6px 10px;
  border-radius:3px;
  background:#f2f2f2;
  line-height:16px;
  margin:0 8px 8px 0;
  color:#484848;
}
.room-super>.content.comment{
  background:#EAF7EA;
  color:#296E00;
}
.room-super>.content.indie{
  background:#f7f3ea;
  color:#8A2400;
}
</style>