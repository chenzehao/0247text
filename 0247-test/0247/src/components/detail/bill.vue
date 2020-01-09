<template>
  <div class="billpage" v-if="detail">
    <div class="top">
      <div @click="openit">
        <img src="../../../public/image/detail/close.png" class="goback">
      </div>
      <div class="toptext">完成预订</div>
    </div>
    <div class="billBody" :style="`height:${height}`">
      <div class="roomdetail zuoyou">
        <div class="textdetail">
          <span>{{detail.describ}}</span>
          <div class="price">
            <span>￥{{detail.price}}</span>
            <span>￥{{parseInt(detail.price/0.9)}}</span>
            <span>每晚</span>
          </div>
          <div><img src="../../../public/image/detail/star.png">({{comment}})</div>
        </div>
        <div>
          <img :src="image" class="pic">
        </div>
      </div>
      <div class="sale zuoyou">
        <img src="../../../public/image/detail/check.png" style="width:10px;">
        <span>冬季特惠9折</span>
        <img src="../../../public/image/detail/what.png" style="width:10px;">
      </div>
      <div class="roomtime zuoyou">
          <div class="time">
            <div>入住日期</div>
            <div>退房日期</div>
            <div>房客人数</div>
          </div>
          <div class="time timetitle">
            <div @click="changeDate">{{start}}</div>
            <div @click="changeDate">{{end}}</div>
            <div @click="changePeople">{{peopleNum}}位</div>
          </div>
        </div>
        <div class="select zuoyou">
          此次出行是商务差旅
          <kaiguan style="margin-top:16px;"></kaiguan>
        </div>
      <div class="bill zuoyou" style="margin-top:20px;">
        <div style="display:flex;line-height:15px;">费用和税收明细
          <div>
            <img src="../../../public/image/detail/tanhao.png" style="width:14px;margin-left:4px;">
          </div>
        </div>
        <div class="priceday"><span>￥{{detail.price}}.00×{{days}}晚</span><span>￥{{detail.price*days}}</span></div>
        <div class="priceday"><span>冬季特惠9折</span><span>-￥{{parseInt(detail.price*days*0.1)}}</span></div>
        <div class="priceday"><span>清洁费</span><span>￥{{parseInt(detail.price*days*0.1)}}</span></div>
        <div class="priceday"><span>服务费：减免￥22</span><span>￥0</span></div>
        <div class="priceday allprice"><span>总额<span>(已省￥{{parseInt(detail.price*days*0.1)}}+22)</span></span><span>￥{{parseInt(detail.price*days)-22}}</span></div>
      </div>
      <div class="yaoqing zuoyou">
          <div><img src="../../../public/image/detail/pockage.png" style="width:30px;"></div>
          <span>预定成功后可邀请好友助力旅行基金，最高可返￥200</span>
          <div><img src="../../../public/image/detail/what.png" style="width:10px;"></div>
      </div>
    </div>
    <div class="buttonbut">
      <button class="cfbutton" @click="reserve">申请预订</button>
    </div>
  </div>
</template>

<script>
import kaiguan from './button'
export default {
  props:{
    detail:{type:Object}
  },
  data(){
    return{
      peopleBtn:false,
      height:'',
      comment:0,
      image:'',
      start:'',
      end:'',
      peopleNum:1,
      price:0,
      days:0,
    }
  },
  created(){
    // 获取高度
    this.height=window.innerHeight+'px'
    // 判断是否有评价
    this.comment=this.detail.comment?this.detail.comment.length:0
    // 切割图片数组
    var arr=this.detail.image_list.split(',')
    this.image=arr[0]
    // vuex获取入住退房日期
    if(this.$store.getters.getsel.date!=''){
      this.date()
    }
    // vuex获取入住人数
    // 获取人数
    var sel=this.$store.getters.getsel
    this.peopleNum=sel.man+sel.child+sel.little
    if(this.peopleNum==0){
      this.peopleNum=1
    }
    this.days=this.$store.getters.getsel.days
  },
  components:{
    kaiguan
  },
  methods:{
    reserve(){
      var isLog=Object.keys(this.$store.getters.getInfo).length>0
      if(!isLog){
        this.$router.push('/login')
      }else{
        var sel=this.$store.getters.getsel
        var obj={
          uid:this.$store.getters.getInfo.uid,
          o_date:sel.date,
          o_days:sel.days,
          o_time:new Date().getTime(),
          o_price:parseInt(this.detail.price*this.days)-22,
          rid:this.detail.rid
        }
        this.axios.get('/index/addOrder',{params:obj}).then(res=>{
          if(res.data.code==1){
            this.$store.commit('delSearch')
            this.$router.push('/pay/'+res.data.orderId)
          }else{
            this.$toast({
              message:'错误',
              duration:1000
            })
          }
        })
      }
    },
    changePeople(){
      if(this.peopleBtn){
        this.$emit('openPeople',window.innerHeight+'px')
        this.peopleBtn=false
      }else{
        this.$emit('openPeople',window.innerHeight/2+'px')
        this.peopleBtn=true
      }
    },
    openit(){
      this.$emit('closeBill',window.innerHeight+'px')
    },
    changeDate(){
      this.$emit('changeDate',"0px")
    },
    date(){
      // 获取日期
      var date=this.$store.getters.getsel.date.split(',')
      var start=new Date(parseInt(date[0]))
      var end=new Date(parseInt(date[date.length-1]))
      this.start=start.getMonth()+1+'月'+start.getDate()+'日'
      this.end=end.getMonth()+1+'月'+end.getDate()+'日'
      // 获取天数
      // this.days=this.$store.getters.getsel.days
      this.days=(end-start)/86400000;
    }
  },
  computed:{
    getDate(){
      return this.$store.getters.getsel.date
    },
    getMan(){
      return this.$store.getters.getsel.man
    },
    getChild(){
      return this.$store.getters.getsel.child
    },
    getLittle(){
      return this.$store.getters.getsel.little
    }
  },
  watch:{
    getDate(val){
      if(val!=''){
        this.date()
      }
    },
    getMan(val){
      // 获取人数
      var sel=this.$store.getters.getsel
      this.peopleNum=sel.man+sel.child+sel.little
      if(this.peopleNum==0){
        this.peopleNum=1
      }
    },
    getChild(val){
      // 获取人数
      var sel=this.$store.getters.getsel
      this.peopleNum=sel.man+sel.child+sel.little
      if(this.peopleNum==0){
        this.peopleNum=1
      }
    },
    getLittle(val){
      // 获取人数
      var sel=this.$store.getters.getsel
      this.peopleNum=sel.man+sel.child+sel.little
      if(this.peopleNum==0){
        this.peopleNum=1
      }
    },
  }
}
</script>

<style scoped>
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  color: #484848;
  overflow-x: hidden;
  overflow-y: auto;
  text-align: left;
}
.zuoyou{
  margin-left:7%;
  margin-right:7%;
}
.billpage{
  background:#fff;
  position: relative;
  width: 100%;
  padding-bottom:70px;
}
.top{
  background: #fff;
  width: 100%;
  top:0;
  position: absolute;
  background: #fff;
  z-index: 10;
}
.goback{
  position: absolute;
  margin-top: 18px;
  top: 8%;
  left: 8%;
  height: 12px;
  width: 12px;
}
.toptext{
  background: #fff;
  text-align: center;
  line-height: 60px;
  font-size: 18px;
  font-weight: bold;
}
.roomdetail{
  display: flex;
  justify-content:space-between;
  padding-top: 70px;
  text-align: left;
  margin-bottom:10px;
}
.textdetail{
  line-height: 25px;
}
.textdetail>span:nth-child(1){
  font-size: 12px;
}
.price{
  color: black;
  margin-top: 2px;
}
.price>span:nth-child(1){
    font-weight: bold;
}
.price>span:nth-child(2){
  font-size: 12px;
  font-weight: bold;
  text-decoration: line-through;
}
.price>span:nth-child(3){
  font-size: 10px;
  font-weight: bold;
}
.textdetail>div>img{
  height:10px;
  width:10px;
}

.textdetail>div:nth-child(3){
  font-size: 10px;
}
.pic{
  width:100px;
}
.sale{
  position: relative;
  font-size: 10px;
  line-height: 40px;
  border-top: 1px solid #F2F2F2;
  border-bottom: 1px solid #F2F2F2;
  margin-bottom: 15px;
}
.sale>img:nth-child(1){
  position: absolute;
  top:15px;
  left:0;
}
.sale>span{
  margin-left: 14px;
}
.sale>img:nth-child(3){
  position: absolute;
  right:0;
  top:15px;
}
.roomtime{
  border-bottom: 1px solid#F2F2F2;
  padding-bottom: 15px;
}
.time{
  line-height: 25px;
  font-size: 12px;
  display: flex;
  justify-content: space-between;

}
.timetitle>div{
  font-size: 16px;
  color:#008489;
}
.timetitle>div:nth-child(2){
  margin-left:-43px;
}
.select{
  line-height: 60px;
  border-bottom: 1px solid#F2F2F2;
}
.bill>div:nth-child(1){
  font-size: 10px;
}
.bill>div:nth-child(3)>span:nth-child(2){
  color:#008489;
}
.priceday{
  margin-top:18px;
  display: flex;
  justify-content: space-between;
}
.allprice{
  padding-top:20px;
  padding-bottom:20px;
  border-top: 1px solid #F2F2F2;
  border-bottom:1px solid #F2F2F2;
}
.allprice>span>span{
  color: #008489
}
.buttonbut{
  background: #fff;
  height: 70px;
  border-top:1px solid #F2F2F2;
  position: absolute;
  bottom: 70px;
  width: 100%;
  z-index:100;
}
.cfbutton{
  margin:0 auto;
  margin-top:10px;
  font-size: 14px;
  color: white;
  line-height: 40px;
  display: block;
  width:320px;
  border: 1px solid #fb5f63;
  border-radius: 4px;
  text-align: center;
  background:#fb5f63;
}
.yaoqing{
  background: #f2f2f2;
  display: flex;
  justify-content: space-between;
  margin-bottom:80px;
  border-radius: 4px;
  padding-top:20px;
  padding-left: 15px;
  padding-bottom: 20px;
  padding-right:15px;
}
.yaoqing>span{
  margin-left: -35px;
  font-size: 14px;
  width:70%;
  display: -webkit-box;
  overflow:hidden;
  text-overflow: ellipsis;
  -webkit-line-clamp:2;
  -webkit-box-orient: vertical;
}
</style>