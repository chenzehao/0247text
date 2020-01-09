<template>
<!-- 登录页 -->
<div>
  <!-- <notecode @goDefault="goDefault" v-if="isNote==1" :phone="phone" @timer="timer" :date="codeText"></notecode> -->
  <notecode @goDefault="goDefault" v-if="isNote==1" :phone="phone" @ltimer="timer" :date="codeText" :isDisabled="isDisabled"></notecode>
  <user  @changeStatus="changeStatus" v-else-if='isNote==2'></user>
  <div v-else class="loginpage">
    <div class="login">
      <!--  页面顶部 -->
      <div class="login-top">
        <button @click="prev">
          <svg viewBox="0 0 12 12" role="img" style="height: 16px; width: 16px; display: block; fill: currentcolor;">
            <path d="m11.5 10.5c.3.3.3.8 0 1.1s-.8.3-1.1 0l-4.4-4.5-4.5 4.5c-.3.3-.8.3-1.1 0s-.3-.8 0-1.1l4.5-4.5-4.4-4.5c-.3-.3-.3-.8 0-1.1s.8-.3 1.1 0l4.4 4.5 4.5-4.5c.3-.3.8-.3 1.1 0s .3.8 0 1.1l-4.5 4.5z" fill-rule="evenodd"></path>
          </svg>
        </button>
      </div>
      <!-- 页面中部 -->
      <div class="login-center">
        <strong>手机动态密码登录</strong><br>
        <span>未注册的手机号验证后将自动创建新账号</span>
        <div class="phone-number">
          <!-- 国家地区代码 -->
          <div>
            <select id="phone-number" class="show">
              <option v-if="!circumactive">+86</option>
              <option v-else>+{{circumactive.split("+")[1].slice(0,-1)}}</option>
            </select>
            <label for="phone-number">
              <svg viewBox="0 0 18 18" role="presentation" aria-hidden="true" focusable="false" style="height: 16px; width: 16px; display: block; fill: rgb(72, 72, 72);">
                <path d="m16.29 4.3a1 1 0 1 1 1.41 1.42l-8 8a1 1 0 0 1 -1.41 0l-8-8a1 1 0 1 1 1.41-1.42l7.29 7.29z" fill-rule="evenodd">
                </path>
              </svg>
            </label>
            <select v-model="circumactive" class="hide">
              <option v-for="(el,i) of circums" :key="i">{{el.name}}</option>
            </select>
          </div>
          <!-- 手机号 -->
          <input type="text" placeholder="手机号" v-model="phone">
        </div>
        <!-- 发送验证码 -->
        <button @click="getYzm" :style="{background:phone =='' ||isDisabled==true ?'rgba(0, 132, 137, 0.3)' : '#008489'}" :disabled="isDisabled">{{codeText}}</button>
      </div>
      <!-- 页面底部 -->
      <div class="login-foot">
        <span>使用其他方式</span>
        <div class="foot-bottom">
          <button @click="onclick">
            <svg viewBox="0 0 24 24" role="presentation" aria-hidden="true" focusable="false" style="height: 1em; width: 1em; display:iline-block; fill: rgb(0, 132, 137);">
              <path d="m22.5 4h-21c-.83 0-1.5.67-1.5 1.51v12.99c0 .83.67 1.5 1.5 1.5h20.99a1.5 1.5 0 0 0 1.51-1.51v-12.98c0-.84-.67-1.51-1.5-1.51zm.5 14.2-6.14-7.91 6.14-4.66v12.58zm-.83-13.2-9.69 7.36c-.26.2-.72.2-.98 0l-9.67-7.36h20.35zm-21.17.63 6.14 4.67-6.14 7.88zm.63 13.37 6.3-8.1 2.97 2.26c.62.47 1.57.47 2.19 0l2.97-2.26 6.29 8.1z" fill-rule="evenodd"></path>
            </svg>账号密码登录
          </button>
          <button>
            <svg viewBox="0 0 32 32" role="presentation" aria-hidden="true" focusable="false" style="height: 1em; width: 1em; display:iline-block; fill: rgb(213, 43, 42);">
              <path d="m30.85 14.19c-.15.61-.85.98-1.46.77-.64-.22-.97-.86-.76-1.5.67-2.14.27-4.05-1.21-5.7-1.37-1.56-3.5-2.17-5.47-1.78-.64.15-1.25-.28-1.37-.89-.15-.64.27-1.29.88-1.41 2.77-.61 5.68.31 7.72 2.51 1.97 2.24 2.55 5.33 1.67 8zm-4.77-5.18c-.95-1.11-2.4-1.53-3.74-1.25-.52.12-.88.61-.79 1.2.12.58.64.92 1.22.8.7-.15 1.31.06 1.82.61.49.58.61 1.23.39 1.9-.15.58.15 1.13.67 1.29a1.02 1.02 0 0 0 1.25-.67c.46-1.44.18-2.73-.82-3.86zm-9.33 13.42c-1 2.33-3.95 3.62-6.5 2.79-2.43-.77-3.53-3.22-2.43-5.42 1.06-2.11 3.8-3.31 6.2-2.69 2.52.64 3.74 3 2.73 5.33zm-5.13-1.81c-.82-.34-1.79 0-2.28.77s-.24 1.68.52 2.05 1.85 0 2.34-.77c.49-.83.24-1.72-.58-2.05zm1.94-.8c-.76-.34-1.37.8-.64 1.07.33.15.64.06.88-.31.15-.34.09-.64-.24-.77zm-.03 6.83c-5.08.52-9.45-1.78-9.79-5.18-.34-3.34 3.49-6.47 8.57-6.99 5.1-.49 9.45 1.84 9.78 5.18.34 3.34-3.55 6.5-8.57 6.99zm10.12-11.14c-.18-.03-.3-.09-.39-.13-.15-.09-.27-.28-.12-.64.52-1.32.55-2.36.03-3.06-1.06-1.44-3.68-1.38-6.81-.06l-.24.09c-.34.12-.67.03-.52-.43.52-1.66.4-2.85-.3-3.62-.89-.86-2.28-.89-4.23-.12-3.92 1.56-10.43 7.35-10.43 12.75 0 1.63.64 3.1 1.91 4.35 2.53 2.57 6.66 3.86 10.95 3.86 3.98 0 7.75-1.23 10.09-2.94 2.31-1.72 3.77-3.86 3.77-5.82 0-2.12-1.67-3.59-3.71-4.23z" fill-rule="evenodd">
              </path>
            </svg>微博
          </button>  
        </div>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import User from '../components/login/User.vue'
import Notecode from '../components/login/Notecode.vue'
export default {
  data(){
    return{
      circumactive:"(+86)",
      circums:[
        {name:"+86",value:'+86'},
        {name:"刚果(+242)",value:'+242'},
        {name:"刚果民主共和国 (+243)",value:'+243'},
        {name:"中国香港 (+852)",value:'+852'},
        {name:"科索沃 (+383)",value:'+383'},
      ],
      phone:"",
      // num:5,
      num:60,
      codeText:'发送验证码',
      isNote:0,
      isDisabled: false, //控制按钮是否可以点击（false:可以点击，true:不可点击）
    }
  },
  components:{
    'user':User,
    'notecode':Notecode
  },
  created() {
    let that=this;
    //如果等于null则是每次只要用户访问过此页面，就会留下记录
    if(window.sessionStorage.getItem("noTime")==null){
    }else{
      //如果用户在验证码倒计时没结束之前退出页面，倒计时会继续执行
      that.loading=true;
      // console.log("time"+window.sessionStorage.getItem("noTime"))
      that.num=Number(window.sessionStorage .getItem("noTime"))
      that.timer();
    }
  },
  methods: {
    // 账号密码登录========组件切换事件
  changeStatus(){
   this.isNote=0;
  },
  // 验证码回退=========组件切换事件
  goDefault(){
    this.isNote = 0;
  },
    //关闭当前页面，返回上一页
  prev(){
    this.$router.go(-1);
  },
  changecircum(e){
    e.preventDefault();
    // console.log(e.target.value)
    this.circumactive = event.target.value;
    // console.log(this.circumactive)
  },
	  //发送验证码
    getYzm() {
      let reg = /^1[3-9][0-9]{9}$/;
      let loginpage=document.getElementsByClassName("loginpage")[0];
      let codepage=document.querySelector(".codepage");
      // console.log(notecode)
      // console.log(loginpage)
      if(this.phone == '') {//验证当用户输入的手机号为空或者不正确时不能进行获取验证码
        this.$toast('手机号不能为空'); 
      }else if(!reg.test(this.phone)){
        this.$toast("请输入正确的手机号");
      }else{
        this.sendMsg();
        this.timer();
        this.isNote=1;
      }
    },
    // 请求发送验证码接口
    sendMsg(){
      this.axios.get('/send/send',{
        params:{
          phone:this.phone
        }
      })
    },
    // 倒计时
    timer() {//验证码倒计时
      // window.sessionStorage .setItem("noTime",num);
      let time = setInterval(()=> {
        if(this.num==0) {
          //如果等于0，则清空页面记录
          window.sessionStorage.removeItem("noTime");
          this.isDisabled = false;
          this.codeText = "重发验证码";
          clearInterval(time);
          this.num=60;
        } else {
          window.sessionStorage.setItem("noTime",this.num);
          this.isDisabled = true;
          this.codeText = this.num + "秒后重新发送";
          this.num--; 
          // console.log(this.num);
           
        }
      }, 1000);
    },
    //切换到账号登录页面
    onclick(){
      this.isNote = 2;
      var loginpage=document.getElementsByClassName("loginpage");
    }
  }
  }
</script>
<style scoped>
  *{
    margin: 0;padding:0;
  }
  .login{
    padding: 16px 24px;
    color:#484848;
  }
  /* 页面顶部 */
  .login>.login-top{
    display: flex;
    justify-content: left;
    margin-bottom: 24px;
  }
  .login>.login-top>button{
    background: none;
    border:0;
    outline: none;
  }
  .login>.login-top>button>svg{
    height: 16px;
    width: 16px; 
    display: block; 
    fill: currentcolor;
  }
  /* 页面中部 */
  .login>.login-center{
    display: flex;
    justify-content: left;
    flex-wrap: wrap;
  }
  .login>.login-center>strong{
    font-size: 25px;
    margin-bottom: 8px;
  }
  .login>.login-center>span{
    font-size: 15px;
  }
  .login>.login-center>.phone-number{
    display: flex;
    justify-content: space-between;
    margin-top:24px;
    margin-bottom: 16px;
    border-radius: 2px;
  }
  /* 国家地区代码 */
  .login>.login-center>.phone-number>div{
    width: 38%;
    position: relative;
    margin-right: 20px;
    border: 1px solid  rgb(235, 235, 235);
  }
  .login>.login-center>.phone-number>div>select{
    height: 49px ;
    width:100% ; 
    padding: 8px 10px;
    -webkit-appearance: none;
    text-indent: 5px;
    font-size: 19px;
    border:0;
    outline: none;
    /* position:absolute; */
  }
  .login>.login-center>.phone-number>div>select.hide{
    position:absolute;
    top:0;
    left:0;
    /* visibility: hidden; */
    opacity: 0;
  }
  .login>.login-center>.phone-number>div>label{
    position: absolute;
    right: 16px ;
    top: 16px;
  }
  /* 手机号 */
  .login>.login-center>.phone-number>input{
    width: 57% ;
    padding-left: 8px ;
    padding-right: 8px;
    text-indent: 5px;
    font-size: 19px ;
    border: 1px solid rgb(235, 235, 235) ;
  }
  /* 发送验证码 */
  .login>.login-center>button{
    width:100%;
    color:#fff;
    font-size: 19px;
    background: rgba(0, 132, 137, 0.3);
    border-color: transparent ;
    padding:10px 22px ;
  }
  /* 页面底部 */
  .login>.login-foot{
    margin-top:24px;
    position: fixed ;
    bottom: 24px ;
    left: 0px ;
    right: 0px ;
  }
  .login>.login-foot>span{
    margin-bottom: 16px;
    color:#484848;
    font-size:15px;
    text-align: center;
  }
  .login>.login-foot>.foot-bottom{
    display: flex;
    justify-content: space-between;
    margin:16px 40px 0 40px ;
  }
  .login>.login-foot>.foot-bottom>button{
    width:45%;
    font-size:15px;
    font-weight: bold;
    border:0;
    outline: none;
    background: #fff;
  }
  .login>.login-foot>.foot-bottom>button>svg{
    margin-right:8px;
  }
  /* .codepage{
    display: none;
  } */
</style>