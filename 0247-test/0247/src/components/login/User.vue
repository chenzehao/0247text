<template>
  <div class="userlogin">
    <div class="user">
      <!-- 后退按钮 -->
      <div class="user-top">
        <button @click="changeStatus">
          <svg viewBox="0 0 18 18" role="img" aria-label=" " focusable="false" style="height: 16px; width: 16px; display: block; fill: currentcolor;">
            <path d="m13.7 16.29a1 1 0 1 1 -1.42 1.41l-8-8a1 1 0 0 1 0-1.41l8-8a1 1 0 1 1 1.42 1.41l-7.29 7.29z" fill-rule="evenodd">
            </path>
          </svg>
        </button>
      </div>
      <div class="user-center">
        <strong>账号密码登录</strong>
        <input type="text" class="emoph" placeholder="邮箱地址/手机号码" v-model="emailorphone">
        <!-- 密码的显示与隐藏 -->
        <div class="cipher">
          <input  :type="pwdType" placeholder="密码" maxlength="18" v-model="userPassword">
          <img :src="seen?openeye:cloeye" class="eye" @click="changeType()">
        </div>
        <!-- 复选框 -->
        <div class="checkd">
          <label for="">
            <input type="checkbox" checked="checked">
            <span>记住我</span>
          </label>
          <button class="gologin">忘记密码？</button>
        </div>
      </div>
      <!-- 登录按钮 -->
      <div class="user-foot" >
        <button :style="{background:userPassword ==''?'rgba(0, 132, 137, 0.3)' : '#008489'}" @click="gologin">立即登录</button>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data(){
    return{
      seen: "",
      pwdType:"password", 
      openeye: require("../../../public/index/see0.svg"),//看见密码时小眼睛的显示图片
      cloeye:require("../../../public/index/see1.svg"), //看得见密码时小眼睛的显示图片
      emailorphone:"",
      userPassword:""
    }
  },
  methods:{
    changeStatus(){
      this.$emit("changeStatus")
    },
    changeType() {
        this.pwdType = this.pwdType === 'password' ? 'text' : 'password';
        this.seen = !this.seen;//小眼睛的变化
    },
    gologin(){
      let reg=/^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
      let reg1= /^1[3-9][0-9]{9}$/;
      if(this.emailorphone==''){
        this.$toast('请输入手机号或邮箱');
      }else if(!reg.test(this.emailorphone)&&!reg1.test(this.emailorphone)){
        this.$toast("请输入正确的邮箱或手机号")
      }else{
        var url = "index/login";
        var obj;
        if(reg1.test(this.emailorphone)){
          obj = {phone:this.emailorphone,pass:this.userPassword};
        }else{
          obj = {email:this.emailorphone,pass:this.userPassword}
        }
        this.axios.get(url,{params:obj}).then(res=>{
          if(res.data.code==-1){
            this.$toast({
                message:'用户名或密码错误',
                duration:1000
            })
          }else{
            var user=res.data.data[0]  
            this.$store.commit('userChange',{
              uid:user.uid,
              u_name:user.u_name,
              avatar:user.avatar,
              email:user.email,
              intro:user.intro,
              phone:user.phone,
              sex:user.sex,
              age:user.age,
              home:user.home,
              city:user.city,
              education:user.education,
              industry:user.industry
            })
            var str=JSON.stringify(user)
            sessionStorage.setItem('userInfo',str)
            this.$store.commit('homePageChange','tab1')
            this.$router.push('/')
          }
        });
      }
    }
  }
}
</script>
<style stoped>
.userlogin{
  width:100%;
  height:100%;
}
.user{
  padding: 16px 24px  !important;
  color:#484848;
}
/* 后退按钮 */
.user>.user-top{
  display: flex;
  justify-content: left;
  margin-bottom: 24px;
}
.user>.user-top>button{
  background: none;
  border:0;
  outline: none;
  padding:0;
}
.user>.user-top>button>svg{
  height: 16px;
  width: 16px; 
  display: block; 
  fill: currentcolor;
}
.user>.user-center{
  display: flex;
  flex-wrap: wrap;
}
.user>.user-center>strong{
  font-size: 25px;
  margin-bottom: 24px;
}
.user>.user-center input{
  width:100%;
  margin-bottom:16px;
  border:0;
  text-indent: 5px;
  padding:11px ;
  font-size: 19px !important;
  border-width: 1px !important;
  border-style: solid !important;
  border-color: rgb(235, 235, 235) !important;
}
.active{
  border:1px solid rgb(0, 132, 137) !important;
}
.user>.user-center>.cipher{
  width:100%;
  position: relative;
}
.user>.user-center>.cipher>input{
  width:93%;
}
.user>.user-center>.cipher>img{
    height: 1em;
    width: 1em;
    fill: currentcolor;
    box-sizing: border-box;
    position: absolute;
    right: 13px;
    top: 13px;
}
.user>.user-center>.checkd{
  width:100%;
  margin-bottom:8px;
  display: flex;
  justify-content: space-between;
}
/* 复选框 */
input[type="checkbox"]{
  width:12px !important;
  height:12px !important;
  display: inline-block;
  line-height: 12px;
  position: relative;
  margin-right:10px;
}
input[type="checkbox"]::before{
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    background: #fff;
    box-shadow: 0 0 2px 2px #008489 !important;
    width: 100%;
    height: 100%;
    border: 0;
}
input[type="checkbox"]:checked::before{
    content: "\2713";
    background-color: #008489;
    box-shadow: 0 0 2px 2px #008489 !important;
    margin-right: 10px;
    position: absolute;
    top: 0;
    left: 0;
    width:100%;
    border: 0;
    color:#fff;
    font-size: 10px;
    font-weight: bold;
    text-indent: 0;
}
/* 忘记密码 */
.user>.user-center>.checkd>button{
  color: #008489 !important;
  border:0;
  outline: none;
  background: none;
  font-weight: bold;
}
/* 登录按钮 */
.user>.user-foot{
  display: flex;
  margin-top:24px;
}
.user>.user-foot>button{
  width:100%;
  color:#fff;
  font-size: 19px;
  border-color: transparent !important;
  padding:10px 22px !important;
  
}
</style>