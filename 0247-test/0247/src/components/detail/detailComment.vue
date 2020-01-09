<template>
  <div class="detailComment">
    <div class="center-box">
      <div class="com-box" :class="is_close?'close':''">
        <!-- 评价界面顶部标题 -->
        <div class="title">
          <p>房客评价</p>
          <p>
            {{commentNum}}条
            <cube-rate class="star" v-model="commentScore"></cube-rate>
          </p>
        </div>
        <!-- 评价界面顶部每项分数 -->
        <div class="header">
          <div>
            <span>如实描述</span>
            <cube-rate class="star" v-model="rsms"></cube-rate>
          </div>
          <div>
            <span>沟通交流</span>
            <cube-rate class="star" v-model="gtjl"></cube-rate>
          </div>
          <div>
            <span>干净卫生</span>
            <cube-rate class="star" v-model="gjws"></cube-rate>
          </div>
          <div>
            <span>位置便利</span>
            <cube-rate class="star" v-model="wzbl"></cube-rate>
          </div>
          <div>
            <span>入住顺利</span>
            <cube-rate class="star" v-model="rzsl"></cube-rate>
          </div>
          <div>
            <span>高性价比</span>
            <cube-rate class="star" v-model="gxjb"></cube-rate>
          </div>
        </div>
        <!-- 评价列表 -->
        <div class="list">
          <!-- 列表中的一项 -->
          <div class="list_item" v-for="(item,index) of comments" :key="index">
            <!-- 头像/名称/评价日期 -->
            <div class="item_header">
              <!-- 头像 -->
              <div class="avatar">
                <img :src="item.avatar?item.avatar:require('../../../public/index/popup1.jpg')">
              </div>
              <!-- 名称/日期 -->
              <div class="other">
                <p class="o_name">{{item.u_name}}</p>
                <p class="o_date">{{item.com_date}}</p>
              </div>
            </div>
            <!-- 评价文字 -->
            <div class="content ellipsis" :data-id="index" @click="udp_text_sta($event,index)">{{item.com_desc}}</div>
          </div>
        </div>
      </div>
      <p class="toggle-text" @click="toggleStatus">{{is_close?`查看更多评价`:'收起评论'}}</p>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    commentNum:{type:Number},//评价数量
    commentScore:{type:Number},//评价分数
    rsms:{type:Number},//如实描述
    wzbl:{type:Number},//位置便利
    gtjl:{type:Number},//沟通交流
    rzsl:{type:Number},//入住顺利
    gjws:{type:Number},//干净卫生
    gxjb:{type:Number},//高性价比
    comments:{type:Array}//评价列表
  },
  data(){
    return{
      is_close:true,//标识是否折叠显示
      total_h:0,//标识评价列表总高度
      timer:null
    }
  },
  mounted(){
    this.timer=setTimeout(()=>{
      var title=document.querySelector('.detailComment>.center-box>.com-box>.title');
      var header=document.querySelector('.detailComment>.center-box>.com-box>.header');
      var item=document.querySelector(".detailComment>.center-box>.com-box>.list");
      var box=document.querySelector('.detailComment>.center-box>.close');
      if(item.children[0]!=undefined){
        var titleH=title.offsetHeight;
        var headerH=header.offsetHeight;
        var itemH=item.children[0].offsetHeight;
        this.total_h=titleH+headerH+itemH;
        box.style.height=this.total_h+'px';
        clearTimeout(this.timer)
        this.timer=null
      }
    },1000);
  },
  methods:{
    udp_text_sta(e,index){//修改文字是否省略状态
      e.target.classList.remove('ellipsis');
    },
    toggleStatus(){
      var box=document.querySelector('.detailComment>.center-box>.com-box');
      if(this.is_close){//说明已经折叠
        box.style.height="auto"
      }else{//没有折叠，变会原样
        box.style.height=this.total_h+'px';
      }
      this.is_close=!this.is_close;
    }
  }
}
</script>

<style scoped>
.detailComment{
  background:#fff;
  text-align:left;
  padding:16px 0;
  border-bottom:8px solid #f2f2f2;
}
.close{
  /* height:276px; */
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
  display:flex;
  justify-content:space-between;
  margin-bottom: 16px;
}
.title p{
  color:#484848;
  font-weight:bold;
}
.star{
  width:75px;
  pointer-events: none;
}
.header{
  display:flex;
  justify-content: space-between;
  flex-wrap:wrap;
}
.header>div{
  width:139px !important;
  box-sizing:border-box;
  margin-bottom:16px;
}
.header>div>span{
  padding-right:8px;
  font-size:14px;
  line-height:1.43;
  color:#484848;
}
.list_item{
  padding:16px 0;
  border-bottom:1px solid rgb(237, 237, 237);
}
.item_header{
  display:flex;
  justify-content:start;
  margin-bottom:16px;
}
.other{
  padding-top:4px;
  margin-left:12px;
}
.o_name{
  color:#484848;
  font-size:14px;
  font-weight:bold;
  line-height:1.43;
}
.o_date{
  color:#484848;
  font-size:12px;
  line-height:1.43;
}
.content {
  line-height: 22px;
}
.ellipsis{
  display: -webkit-box;
  overflow: hidden;
  max-height: 66px;
  text-overflow: ellipsis;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  word-break: break-all;
}
.item_header>.avatar{
  width:44px;
  height:44px;
  border-radius:50%;
  overflow:hidden;
}
.avatar img{
  width:100%;
  object-fit: cover;
}
</style>