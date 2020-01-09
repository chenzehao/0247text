<template>
  <div>
    <loading v-if="$store.getters.getLoading" :z-index="1000"></loading>
    <div class="room_detail">
      <div class="big_detail">
        <!-- 房间详情轮播图 -->
        <sm-banner :Switch="false" :image="image" :smbtn="image.slice(1,image.length-1)" :rid="1"></sm-banner>
        <!-- 房间详情头部信息 -->
        <!-- <detail-header :toDetail="data"></detail-header> -->
        <detail-header :isIndex="false" :toDetail="data"></detail-header>
        <!-- 小钟表 -->
        <detail-watch></detail-watch>
        <!-- 房间详情 -->
        <detail-room :toBedRoom="tobedRoom" :bedRooms="bedRooms"></detail-room>
        <!-- 关于房间 -->
        <detail-about :toAboutData="data[0]"></detail-about>
        <!-- 便利设施 -->
        <detail-amenities :baseData="base" :matingData="mating" :childData="child" :safeData="safe" :baseFlag="baseFlag" :matingFlag="matingFlag" :childFlag="childFlag" :safeFlag="safeFlag" :facilityNum="facilityNum"></detail-amenities>
        <!-- 房间评价 -->
        <detail-comment v-show="commentNumber>0" :commentNum="commentNumber" :commentScore="commentScore" :rsms="com_rsms" :wzbl="com_wzbl" :gtjl="com_gtjl" :rzsl="com_rzsl" :gjws="com_gjws" :gxjb="com_gxjb" :comments="comments"></detail-comment>
        <!-- 房间位置 -->
        <detail-location :accuracy="accuracy" :latitude="latitude" @openMap="openMap" :loca="loca" :loca_desc="loca_desc" :travel_info="travel_info"></detail-location>
        <!-- 房东 -->
        <detail-roomuser :userName="room_user_name" :avatar="room_user_avatar" :intro="room_user_intro" :isReg="room_user_is_reg"></detail-roomuser>
        <!-- 入住与退房时间 -->
        <detail-roomin :room_in="room_in" :room_out="room_out"></detail-roomin>
        <!-- 底部 -->
        <detail-foot @changeBill="changeBill" :commentNum="commentNumber" :commentScore="commentScore" :price="price" @fun="getFootMsg"></detail-foot>
        <!-- 日历 -->
        <!-- 增加接收日历子组件传来数据的函数 -->
        <rili class="rili" :rid="Number(rid)" :defineddate="room_defined_date" page="roomDetail" :style="`top:${top};width:${width}`" @fun="getRiliMsg" ></rili>
        <bill @openPeople="openPeople" @changeDate="getRiliMsg" v-if="data.length>0" :detail="data[0]" @closeBill="changeBill" class="bill" :style="`top:${billTop};width:${width}`"></bill>
        <peopleNum class="peopleNum" :style="`top:${peopleNum};left:${parseInt(width)*0.1}px`"></peopleNum>
      </div>
      <bigMap :accuracy="accuracy" :latitude="latitude" v-if="mapBtn" @closeMap="closeMap"></bigMap>
      <!-- 顶部小按钮 喜欢 -->
      <p class="like iconfont" :class="isLike==true?'icon-shixintaoxin':'icon-xihuan'" @click="cancel"></p>
      <!-- <p class="like iconfont icon-xihuan"></p> -->
      <!-- 顶部小按钮 返回 -->
      <p class="back iconfont icon-fanhui" @click="$router.back(-1)"></p>
      <!-- 顶部小按钮 用户 -->
      <popup class="login" :isIndex="false"></popup>
      <div v-if="data.length<=0">123</div>
    </div>
  </div>
</template>
<script>
import {getRoomDetail} from '../assets/apis/roomDetail'
import detailHeader from '../components/detail/detailHeader'
import detailWatch from '../components/detail/detailWatch'
import detailRoom from '../components/detail/detailRoom'
import detailAbout from '../components/detail/detailAbout'
import detailAmenities from '../components/detail/detailAmenities'
import detailComment from '../components/detail/detailComment'
import detailLocation from '../components/detail/detailLocation'
import detailRoomuser from '../components/detail/detailRoomuser'
import detailRoomin from '../components/detail/detailRoomin'
import detailFoot from '../components/detail/detailFoot'
import popup from '../components/Popup.vue'
import smBanner from '../components/smBanner'
import loading from '../components/loading.vue'
import rili from '../components/screen/Rili'
import bigMap from '../components/detail/bigMap.vue'
import bill from '../components/detail/bill.vue'
import peopleNum from '../components/screen/peopleNum.vue'
export default {
  data(){
    return{
      rid:1,
      data:[],
      image:[],
      tobedRoom:[],
      bedRooms:[],
      base:[],//房间基础设施
      mating:[],//房间配套设施
      child:[],//房间儿童设施
      safe:[],//房间安全设施
      baseFlag:true,//基础设施标识
      matingFlag:true,//配套设施标识
      childFlag:true,//儿童设施标识
      safeFlag:true,//安全设施标识
      facilityNum:0,//设施数量
      commentNumber:0,//每个房间评价数量
      commentScore:0,//每个房间评价分数
      comments:[],//评价列表
      com_rsms:0,//如实描述
      com_wzbl:0,//位置便利
      com_gtjl:0,//沟通交流
      com_rzsl:0,//入住顺利
      com_gjws:0,//干净卫生
      com_gxjb:0,//高性价比
      loca:'',//房间地理位置
      loca_desc:[],//房间周边描述
      travel_info:[],//房间出行信息
      accuracy:'',//精度
      latitude:'',//纬度
      room_user_name:'',//房东名称
      room_user_avatar:'',//房东头像
      room_user_intro:[],//房东自我介绍
      room_user_is_reg:0,//房东是否验证
      room_in:'',//入住时间
      room_out:'',//退房时间
      price:0,//房间价格
      isLike:false,//标识此房间是否添加到喜欢列表中
      width:'',
      height:window.innerHeight+'px',
      top:this.height+'px',
      mapBtn:false,
      billTop:window.innerHeight+'px',
      peopleNum:window.innerHeight+'px',
      room_defined_date:"",  //已订日期
      historySearch:[],
      isInside:false,
    }
  },
  created(){
    this.width=window.innerWidth+'px'//获取屏幕高度
    this.height=window.innerHeight//获取屏幕高度
    this.top=this.height+'px'//获取top值
    this.rid=this.$route.path.split('/')[2]
    //保存在本地浏览器
    if(localStorage.getItem("keyHistory")!=null){
      this.historySearch=JSON.parse(localStorage.getItem("keyHistory"));
    }
    if(this.historySearch.length>0){
      for(var i=0;i<this.historySearch.length;i++){
        if(this.rid==this.historySearch[i]){
          this.isInside=true;
          this.historySearch.splice(i,1);
          this.historySearch.unshift(this.rid);
          localStorage.setItem("keyHistory",JSON.stringify(this.historySearch));
        }
      }
      if(!this.isInside){
        this.historySearch.unshift(this.rid);
        localStorage.setItem("keyHistory",JSON.stringify(this.historySearch));
      }
    }else{
      this.historySearch.unshift(this.rid);
      localStorage.setItem("keyHistory",JSON.stringify(this.historySearch));
    }

    // 过渡效果开始
    this.$store.commit('loadingChange',true)
    getRoomDetail(this.rid).then(result=>{//请求房间详情
      this.data=result.data;
      this.room_defined_date=this.data[0].room_defined_date;
      // console.log(this.data)
      // console.log(this.data);
      this.isLike=this.data[0].isLike;
      // 操作轮播图
      this.carousel(result);
      // 操作卧室
      this.bedRoom();
      // 操作设施
      this.amenities();
      // 操作评价相关数据
      this.comment();
      // 操作房间周边相关数据
      this.circum();
      // 操作房东相关数据
      this.room_user();
      //操作房间入住退房时间相关数据
      this.room_time();
      //操作房间底部相关数据
      this.room_foot();
      // 过渡效果结束
      // setTimeout(()=>{
          this.$store.commit('loadingChange',false)
      // },1000)
    })
  },
  methods:{
    // 打开peopleNum组件
    openPeople(val){
      this.peopleNum=val
    },
    // 打开bill组件
    changeBill(val){
      this.billTop=val
    },
    // 关闭Map组件
    closeMap(val){
      this.mapBtn=val
    },
    // 打开Map组件
    openMap(val){
      this.mapBtn=val
    },
    // 接收底部子组件传来的参数
    getFootMsg(data){
      this.top=data;
    },
    // 接收日历子组件传来的参数
    getRiliMsg(data){
      // console.log(1)
      this.top=data;
    },
    carousel(result){//操作轮播图相关数据
      var img=result.data[0].image_list.split(',')
      img.unshift(img[img.length-1])
      img.push(img[1])
      this.image=img;
    },
    bedRoom(){//操作卧室相关数据
      if(this.tobedRoom.length<4){
        this.tobedRoom.push(this.data[0].romm_one)
        this.tobedRoom.push(this.data[0].romm_two)
        this.tobedRoom.push(this.data[0].romm_three)
        this.tobedRoom.push(this.data[0].romm_public)
      }
      // 操作每个卧室，绘制图片
      for(var i=0;i<this.tobedRoom.length;i++){//遍历得到床的数量和名称
        this.bedRooms[i]={
          number:parseFloat(this.tobedRoom[i].slice(0,1)),
          name:this.tobedRoom[i].slice(-3)
        }
      }
    },
    amenities(){//操作设施相关数据
      this.base=this.data[0].base;
      this.mating=this.data[0].mating;
      this.child=this.data[0].child;
      this.safe=this.data[0].safe;

      var baseI=0;var baseLength=0;//基础设施标识
      for(var key in this.base[0]){
        baseI++;
        if(this.base[0][key]==0) baseLength++;
        else this.facilityNum++;
      }
      if(baseI==baseLength) this.baseFlag=false;

      var matingI=0;var matingLength=0;//配套设施标识
      for(var key in this.mating[0]){
        matingI++;
        if(this.mating[0][key]==0) matingLength++;
        else this.facilityNum++;
      }
      if(matingI==matingLength) this.matingFlag=false;

      var childI=0; var childLength=0;//儿童设施标识
      for(var key in this.child[0]){
        childI++;
        if(this.child[0][key]==0) childLength++;
        else this.facilityNum++;
      }
      if(childI==childLength) this.childFlag=false;

      var safeI=0;var safeLength=0;//安全设施标识
      for(var key in this.safe[0]){
        safeI++;
        if(this.safe[0][key]==0) safeLength++;
        else this.facilityNum++;
      }
      if(safeI==safeLength) this.safeFlag=false;
    },
    comment(){//操作评价相关数据
      if(this.data[0].comment){
        this.commentNumber=this.data[0].comment.length;
        this.commentScore=this.data[0].commentScore;
        this.comments=this.data[0].comment;
        
        for(var key in this.data[0].comment){
          var item=this.data[0].comment[key];
          this.com_rsms+=parseFloat(item.truthfully_described);//如实描述
          this.com_wzbl+=parseFloat(item.location_convenient);//位置便利
          this.com_gtjl+=parseFloat(item.communication);//沟通交流
          this.com_rzsl+=parseFloat(item.move_in);//入住顺利
          this.com_gjws+=parseFloat(item.clean);//干净卫生
          this.com_gxjb+=parseFloat(item.cost_performance);//高性价比
        }
        this.com_rsms=this.com_rsms/this.data[0].comment.length;
        this.com_wzbl=this.com_wzbl/this.data[0].comment.length;
        this.com_gtjl=this.com_gtjl/this.data[0].comment.length;
        this.com_rzsl=this.com_rzsl/this.data[0].comment.length;
        this.com_gjws=this.com_gjws/this.data[0].comment.length;
        this.com_gxjb=this.com_gxjb/this.data[0].comment.length;
      }
    },
    circum(){//操作房间周边相关数据
      this.loca=this.data[0].room_location;
      this.loca_desc=this.data[0].romm_location_desc.split('|');
      this.travel_info=this.data[0].travel_info.split('|');
  //     accuracy varchar(128), #房源精度
  // latitude varchar(128), #房源纬度
      this.latitude=this.data[0].latitude;//房源纬度
      this.accuracy=this.data[0].accuracy;//房源精度
    },
    room_user(){//操作房东相关数据
      this.room_user_name=this.data[0].user_name;//房东名称
      this.room_user_avatar=this.data[0].avatar;//房东头像
      this.room_user_intro=this.data[0].intro.split("|");
      this.room_user_is_reg=this.data[0].is_reg;//房东是否验证
    },
    room_time(){//操作房间入住退房时间相关数据
      this.room_in=this.data[0].room_in;
      this.room_out=this.data[0].room_out;
    },
    room_foot(){//操作房间底部相关数据
      this.price=this.data[0].price
    },
    cancel(){//取消或者添加喜欢列表
      var userinfo=this.$store.getters.getInfo
      if(!userinfo.uid){
        this.$toast({
          message:"未登录",
          duration:1000
        })
      }else{
        if(this.isLike){
          this.$messagebox.confirm("是否取消喜欢").then(res=>{
            this.isLike=false;
            this.axios.get('like/like_del',{params:{rid:this.data[0].rid}}).then(res=>{
              if(res.data.code==1){
                // this.$emit('closeThis',this.rid)
                setTimeout(()=>{
                  this.$toast({
                    message:'删除成功',
                    duration:1000
                  })
                },400)
              }else{
                this.isLike=true;
              }
            })
          }).catch(err=>this.$toast({
            message:"取消成功",
            duration:1000    
          }))
        }else{
          this.isLike=true;
          this.axios.get('like/like_add',{params:{
            rid:this.data[0].rid
          }}).then(res=>{
            this.$toast({
                message:'添加成功',
                duration:1000
            })
          })
        }
      }
    }
  },
  mounted(){
    window.scrollTo(0,0)
  },
  components:{smBanner,detailHeader,detailWatch,detailRoom,detailAbout,detailAmenities,detailComment,detailLocation,detailRoomuser,detailRoomin,detailFoot,popup,loading,rili,bigMap,bill,peopleNum}
}

</script>
<style scoped>
.room_detail{
  background:#f2f2f2;
  margin-bottom:82px;
  position: relative;
}
.login{
  position: absolute;
  top:0;right:0;
}
.back,.like{
  width:32px;
  height:32px;
  background-color:rgba(0,0,0,.3);
  color:#fff;
  line-height:32px;
  border-radius:50%;
  position:absolute;
}
.back{
  left:24px;
  top:24px;
}
.like{
  top:24px;
  right:75px;
}
.icon-shixintaoxin{
  color:#e00;
}
/* 日历的样式 */
.rili{
  position:fixed;
  background:#fff;
  z-index: 1002;
  transition:top 0.2s linear;
}
.bill{
  position:fixed;
  background:#fff;
  z-index: 1001;
  transition:top 0.2s linear;
}
.peopleNum{
  position:fixed;
  background:#fff;
  z-index:1002;
  transition:top 0.3s linear;
  width:80%;
  border-radius: 30px;
  border:2px solid #ddd;
}
</style>