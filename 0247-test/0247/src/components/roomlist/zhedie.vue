<template>
  <div >
    <div :class="dis">
    <!-- 顶部按钮 -->
      <div class="top">
        <span @click="change('1')" class="button">{{num}}<img src="../../../public/index/downnormal.png" class="down"></span>
        <span @click="change('2')" class="button">{{numbers}}<img src="../../../public/index/downnormal.png" class="down"></span>
        <span @click="change('3')" class="button">{{price}}<img src="../../../public/index/downnormal.png" class="down"></span>
        <span @click="change('4')" class="button">{{select}}<img src="../../../public/index/downnormal.png" class="down"></span>
      </div>
      <div class="buttons">
        <button v-for="(btn,i) of buttons" :key="i">{{btn}}</button>
      </div>
    </div>
    <!-- 底部div -->
    <div class="contentall">
      <div class="content">
        <div class="absolute">
          <p v-if="(!start)||(!end)" class="title">选择日期</p>
          <p v-else class="title2">
              {{`${new Date(start.time).getMonth()+1}月${new Date(start.time).getDate()}日-${new Date(end.time).getMonth()+1}月${new Date(end.time).getDate()}日·${(new Date(end.time)-new Date(start.time))/86400000}晚`}}
              <button @click="clear" class="button1">清除</button>
          </p>
          <ul class="weekday">
              <li>日</li>
              <li>一</li>
              <li>二</li>
              <li>三</li>
              <li>四</li>
              <li>五</li>
              <li>六</li>
          </ul>
        </div>
        <div class="rili">
          <rili :defineddate="``" :page="`roomlist`" @fun1="getMsg"></rili>
        </div>
        <preserve @closeZD="turnoff"></preserve>
      </div>
      <div class="content">
        <people-num></people-num>
        <preserve @closeZD="turnoff"></preserve>
      </div>
      <div class="content">
        <price-range></price-range>
        <preserve @closeZD="turnoff"></preserve>
      </div>
      <div class="content">
        <filtrate></filtrate>
        <preserve @closeZD="turnoff"></preserve>
      </div>
    </div>
    <div :class="block"></div>
    <div :class="blockall" @click="turnoff"></div>
  </div>
</template>

<script>
// 引入人数组件
import peopleNum from '../screen/peopleNum.vue'
// 引入筛选组件
import filtrate from '../screen/filtrate.vue'
// 引入价格区间组件
import priceRange from '../screen/priceRange.vue'
// 引入日历组件
import Rili from '../screen/Rili.vue'
// 引入保存按钮组件
import preserve from '../screen/preserve.vue'

export default {
  mounted(){
    window.addEventListener('scroll', this.handleScroll)
    this.huoqu()
    this.changes()
  },
  destroyed () {
    window.removeEventListener('scroll', this.handleScroll)
  },
  components:{
      'price-range':priceRange,
      "rili":Rili,
      "preserve":preserve,
      "people-num":peopleNum,
      "filtrate":filtrate
  },
  data(){
    return{
      dis:"dis",
      blockall:"black",
      block:"white",
      num:"日期",
      numbers:"人数",
      price:"价格",
      select:"筛选",
      active:true,
      oldscroll:0,
      start:0,
      end:0,
      data:[], 
      buttons:[
        "整套房源","0247PLUS","价格从高到低","价格从低到高"
      ],
    }
  },
  computed:{
      getdate(){
          return this.$store.getters.getsel.date
      },
      getman(){
          return this.$store.getters.getsel.man
      },
      getchild(){
          return this.$store.getters.getsel.child
      },
      getlittle(){
          return this.$store.getters.getsel.little
      },
      getminp(){
          return this.$store.getters.getsel.minPrice
      },
      getmaxp(){
          return this.$store.getters.getsel.maxPrice
      },
      getrt0(){
          return this.$store.getters.getsel.roomType[0]
      },
      getrt1(){
          return this.$store.getters.getsel.roomType[1]
      },
      getbed(){
          return this.$store.getters.getsel.count.bed
      },
      getbedroom(){
          return this.$store.getters.getsel.count.bedroom
      },
      gettoliet(){
          return this.$store.getters.getsel.count.toliet
      },
  },
  watch:{
    getdate(val){
        this.changes()
    },
    getman(val){
        this.changes()
    },
    getchild(val){
        this.changes()
    },
    getlittle(val){
        this.changes()
    },
    getminp(val){
        this.changes()
    },
    getmaxp(val){
        this.changes()
    },
    getrt0(val){
        this.changes()
    },
    getrt1(val){
        this.changes()
    },
    getbed(val){
        this.changes()
    },
    getbedroom(val){
        this.changes()
    },
    gettoliet(val){
        this.changes()
    },
  },
  methods:{
    huoqu(){
      this.firstload1=this.$store.getters.getsel
    },
    changes(){
      var sel1=this.$store.getters.getsel
      function spanselect(l){return document.querySelector(".top>span:nth-of-type("+l+")")}
      // 修改天数样式
      if(sel1.days!=0){
        spanselect(1).className="button button_active"
        this.num=sel1.days+"晚"
      }else{
        spanselect(1).className="button"
        this.num="日期"
        }
      // 修改人数样式
      if(sel1.man!=0 || sel1.child!=0 || sel1.little!=0){
        spanselect(2).className="button button_active"
        var people=sel1.man+sel1.child+sel1.little
        this.numbers=people+"人"
      }else{
        spanselect(2).className="button"
        this.numbers="人数"
        }
      // 修改价格样式
      if(sel1.minPrice>0 && sel1.maxPrice==5000){
        spanselect(3).className="button button_active"
        this.price=this.$store.getters.getsel.minPrice+"++"
      }else if(sel1.minPrice==0 && sel1.maxPrice<5000){
        spanselect(3).className="button button_active"
        this.price=this.$store.getters.getsel.maxPrice+"--"
      }else if(sel1.minPrice>0 && sel1.maxPrice<5000){
        spanselect(3).className="button button_active"
        this.price=this.$store.getters.getsel.minPrice+"++"
      }else{
        spanselect(3).className="button"
        this.price="价格"
        }
      // 修改筛选样式
      var counts=0
      var rt=sel1.roomType[0]+sel1.roomType[1]
      var count=sel1.count.bed+sel1.count.bedroom+sel1.count.toliet
      if(rt!=0){
        counts++
      }
      if(count!=0){
        counts++
      }
      if(counts!=0){
        spanselect(4).className="button button_active"
        this.select="筛选-"+counts
      }else{
        spanselect(4).className="button"
        this.select="筛选"
        }
    },
     handleScroll () {
            var scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTopvar 
            if(scrollTop>70){
              this.dis="dis dis_none"
              setTimeout(()=>{
                if(scrollTop==window.scrollY){
                    this.oldscroll= scrollTop
                  }
              },)
              if(this.oldscroll<scrollTop){
                this.dis="dis dis_none"
              }else if(this.oldscroll>scrollTop){
                this.dis="dis"
              }
            } 
        },
    // 全部关闭
    turnoff(){
      var body=document.querySelector('body')
      var divselects=document.querySelectorAll(`.top span`)
      var imgselects=document.querySelectorAll(`.top>span>img`)
      var divselect=document.querySelectorAll(`.contentall>div`)
      // 循环改变所有项目为未激活状态
      for(var i=0;i<4;i++){
        divselect[i].className="content"
        divselects[i].className="button"
        imgselects[i].src=require("../../../public/index/downnormal.png")
      }
      body.style=""
      this.block="white"
      this.blockall="black"
      this.active=true
      this.changes()
    },
    // 点击按钮改变style
    change(i){
      var body=document.querySelector('body')
      var divselect=document.querySelector(`.contentall>div:nth-of-type(${i})`)
      var spanselect=document.querySelector(`.top span:nth-of-type(${i})`)
      var imgselect=document.querySelector(`.top span:nth-of-type(${i}) img`)
      if(this.active){
        this.active=false;
        // 白色遮盖层
        this.block="white white_active"
        // 黑色遮盖层
        this.blockall="black black_active"
        // 循环改变所有小箭头和文字颜色
        for(var y=1;y<=4;y++){
          var divselects=document.querySelector(`.top span:nth-of-type(${y})`)
          var imgselects=document.querySelector(`.top span:nth-of-type(${y}) img`)
          divselects.className="button button_dis"
          imgselects.src=require("../../../public/index/downdis.png")
        } 
        // 给body加上fixed属性
        body.style="height: 100%; position: fixed; width: 100%; overflow: hidden;"
        spanselect.className="button button_active"
        divselect.className="content_active content"+i
        imgselect.src=require("../../../public/index/downactive.png")
      }else if(divselect.className=="content_active content"+i){ //如果进来的是带有激活状态的div则关闭所有激活状态
        this.turnoff()
      }
    },
    getMsg(data){
      [this.start,this.end,this.days,this.data]=data     
    },
    clear(){
      this.data.forEach(el=>{
        el.dates.forEach(el1=>{
          el1.isstart=false;
          el1.isend=false
          el1.isselected=false
        })
      })
      this.start=null
      this.end=null
      this.bus.$emit("clearsomething");
    }
  }
}
</script>

<style scoped>
*{padding: 0;margin: 0;box-sizing: border-box}
/* 按钮div */
.top{
  z-index: inherit;
  height:26px;
  line-height: 1.43;
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color:#484848;
  text-align: center;
  margin-top: 0px;
  font-weight: bold;
  background:#fff;
}
.dis{
  margin-top:0;
  overflow: hidden;
  height:80px;
  transition: margin .2s linear;
  box-shadow: 0px 17px 16px rgba(0, 0, 0, 0.1);
}
.dis_none{
  overflow: hidden;
  margin-top:-80px;
  transition: margin .2s linear;
}
.buttons{
  padding: 20px;
  width: 100%;
  height:60px;
  background-color:white;
  overflow-x: auto;
  overflow-y: hidden;
  white-space: nowrap;
  padding:16px 24px;
  transition:-ms-transform 0.5s ease 0s, -webkit-transform 0.5s ease 0s, transform 0.5s ease 0s !important;
  transition-property: -ms-transform, -webkit-transform, transform !important;
  transition-duration: 0.5s, 0.5s, 0.5s !important;
  transition-timing-function: ease, ease, ease !important;
  transition-delay: 0s, 0s, 0s !important;
}
.buttons>button{
  padding-left: 10px;
  padding-right: 10px;
  background:#fff;
  text-align: center;
  display: inline-block;
  font-size: 12px;
  line-height: 24px;
  color: rgb(118, 118, 118) !important;
  margin-right: 16px;
  border-width: 0.5px;
  border-style: solid;
  border-color: rgb(118, 118, 118) !important;
  border-radius: 30px;
  overflow: visible;
  touch-action: manipulation;
}
/* 按钮统一样式 */
.button{
  margin-top:8px;
  margin-bottom: 2%;
  padding-left:6%;
  padding-right:6%;
  display: flex;
  justify-content: space-between;
  font-weight: bold;
}
/* 按钮激活样式 */
.button_active{
  color:#008489 !important;
}
/* 按钮未激活样式 */
.button_dis{
  color: rgb(216, 216, 216) !important;
}
/* 向下按钮样式 */
.down{
  margin-top: 2%;
  height: 13px;
}
/* 折叠div隐藏样式 */
.content{
  width:100%;
  height: 0px;
  opacity: 0;
  visibility: hidden;
}
/* 日历样式 */
.rili{
  height:400px;
  /* overflow-x:scroll; */
  overflow-y:scroll;
}
/* 折叠div激活统一样式 */
.content_active{
  margin-top:-40px;
  position:relative;
  box-sizing:border-box;
  padding-top:24px;
  background:white !important;
  width: 100%;
  opacity: 1;
  z-index:3;
  overflow: hidden;
  margin-top: -45px;
}
/* div1激活样式 */
.content1{
  height:480px;
  transition: height .2s linear;
}
/* div2激活样式 */
.content2{
    height:300px;
  transition: height .2s linear;
}
/* div3激活样式 */
.content3{
    height:230px;
  transition: height .2s linear;
}
/* div4激活样式 */
.content4{
    height:500px;
  transition: height .2s linear;
}
/* 白色遮盖层 */
.white{
  position: fixed !important;
  display: none;
  width:100%;
  height:76px;
  top:0;
  background-color: white;
  opacity: 0.66;
  z-index:1000;
}
/* 白色遮盖层激活 */
.white_active{
  display: block !important;
}
/* 黑色遮盖层 */
.black{
  position: fixed !important;
  display: none;
  width:100%;
  height:70%;
  bottom: 0;
  background-color:black;
  opacity: 0.88;
  z-index:1;
}
/* 黑色遮盖层激活 */
.black_active{
  display: block !important;
}
.title,.title2{
  height:40px;
  text-align: center;
}
.title2{
  color:#008489;
}
.weekday{
  display: flex;
  justify-content: space-around;
  list-style: none;
  font-size:14px;
  padding-bottom:8px;
  border-bottom:1px solid rgb(221,221,221);
}
.button1{
  border:0;
  background: transparent;
  margin:0;
  margin-left:50px;
}
.absolute{
  position: absolute;
  width:100%;
  height:60px;
  background: #fff;
}
</style>