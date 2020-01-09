<template>
  <div class="codepage">
    <div class="code">
      <!-- 后退按钮 -->
      <div class="code-top">
        <button @click="goDefault">
          <svg viewBox="0 0 18 18" role="img" aria-label=" " focusable="false" style="height: 16px; width: 16px; display: block; fill: currentcolor;">
            <path d="m13.7 16.29a1 1 0 1 1 -1.42 1.41l-8-8a1 1 0 0 1 0-1.41l8-8a1 1 0 1 1 1.42 1.41l-7.29 7.29z" fill-rule="evenodd">
            </path>
          </svg>
        </button>
      </div>
      <!-- 页面文字 -->
      <div class="code-center">
          <strong>输入6位验证码</strong>
          <p>已将验证码发送至{{phone}}</p> 
        <div class="box">
          <!-- input循环 -->
          <div class="notecode">
            <input v-for="(c,index) in inputList" :key="index" class="inputs"
            type="number" v-model="inputList[index]"
            ref="input" 
            @keydown.delete="e=>{onKeydown(e.target.value, index)}" 
            @input="e => {onInput(e.target.value, index)}"  
            maxlength="1" 
            @focus="onFocus"
            :disabled="loading"/>
          </div>
        </div>
        <button class="btn" @click="ltimer" :disabled="isDisabled">{{date}}</button>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data(){
    return{
      inputList:['','','','','',''], //input长度
      loading:false,                 //是否可点击
      msg:''
    }
  },
  computed: {
    //计算inputList的长度
    ctSize(){
      return this.inputList.length;
    },

    cIndex(){
      let i = this.inputList .findIndex(item=>item==='');
      i = (i+this.ctSize)% this.ctSize;
      return i;
    },
    //获取最后一个input
    lastCode(){
      return this.inputList[this.ctSize-1];
    }
  },
  watch: {
    cIndex(){
      this.resetCaret();
    },
    //当最后一个input输入完毕之后，失去焦点。发送请求判断用户验证码是否输入正确
    lastCode(val){
      if(val){
        this.$refs.input[this.ctSize - 1].blur(); //最后一个input输入之后失去焦点
        this.sendCaptcha();                       //发送请求函数
      }
    }
  },
  mounted(){
    // 第一个input自动获取焦点
    this.resetCaret();
  },
  props:{
    phone:{type:String},
    num:{type:Number},
    date:{type:String},
    isDisabled:{type:Boolean}
  },
  beforeDestroy() {
    if(this.timer) {
        clearInterval(this.timer);
    }
  },
  methods:{
    // 回退按钮  ======回退到输入手机号
    goDefault(){
      this.$emit("goDefault")
    },
    ltimer(){
        this.$parent.timer();
    },
    onInput(val,index){
      this.msg="";
      val = val.replace(/\s/g, '');    //将\s替换为''
      if(val.length > 1) {
        let i = index;
        for (i = index; i < this.ctSize && i - index < val.length; i++) {
          this.inputList[i] = val[i];
        }
        this.resetCaret();
      }
    },
    // 重置光标位置。
    resetCaret() {
      this.$refs.input[this.ctSize-1].focus();
    },
    onFocus() {
      // 监听 focus 事件，将光标重定位到“第一个空白符的位置”。
      //findIndex()函数是查找目标元素，找到就返回元素的【位置】，找不到就返回-1。
      let index = this.inputList.findIndex(item => item === '');
      index = (index + this.ctSize) % this.ctSize;
      this.$refs.input[index].focus();
    },
    onKeydown(val, index) {
      //如果当前的input值为空
      if (val === '') {
        // 删除上一个input里的值，并对其focus。
        if (index > 0) {
          this.inputList[index - 1] = '';
          this.$refs.input[index - 1].focus();
        }
      }
    },
    sendCaptcha() {
      var str=this.inputList.join('');
      this.axios.get('/send/verify',{
        params:{
          phone:this.phone,
          code:str
        }
      }).then(result=>{
        if(result.data.code==1){//验证码正确
          var user=result.data.data[0]
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
          this.$store.commit('homePageChange','tab4');
          this.$router.push('/')

        }else if(result.data.code==-2){//验证码错误
          this.$toast('验证码输入错误');
          this.reset();
        }
      })
    },
    // 重置。验证码错误时触发。直接调用即可
    reset() {
      this.inputList = this.inputList.map(item => '');
      this.resetCaret();
    }
  },
  //获得焦点定义
  directives:{
    focus: {
      // 指令的定义
      inserted: function (el) {
      el.focus()
      }

    }
  }
}
</script>
<style scoped>
  .codelogin{
  width:100%;
  height:100%;
}
.code{
  padding: 16px 24px  !important;
  color:#484848;
}
/* 后退按钮 */
.code>.code-top{
  display: flex;
  justify-content: left;
  margin-bottom: 24px;
}
.code>.code-top>button{
  background: none;
  border:0;
  outline: none;
  padding:0;
}
.code>.code-top>button>svg{
  height: 16px;
  width: 16px; 
  display: block; 
  fill: currentcolor;
}
/* 页面中间 */
.code>.code-center{
  display: flex;
  justify-content: left;
  flex-wrap: wrap;
}
/* 页面文字 */
.code>.code-center>strong{
  font-size: 25px;
  font-weight: 700 !important;
  margin-bottom: 10px;
}
.code>.code-center>p{
    font-size: 15px;
    margin-bottom: 24px;
}

.box{
  width:100%;
  height:46px !important;
  display: flex;
  justify-content: space-around;
  margin-bottom: 24px;
} 
.code>.code-center>.box>.notecode{
  width:100%;
  height:100%;
}
.code>.code-center>.box>.notecode>input{
  height: 28px !important;
  width: 20px !important;
  padding:8px 10px;
  margin-right:10px;
  border-radius: 3px !important;
  border: 1px solid rgb(235, 235, 235) !important;
  outline: none;
  -webkit-appearance: none !important;
  background-color: rgb(255, 255, 255) !important;
  text-align: center !important;
  vertical-align: middle !important;
} 
.code>.code-center>.box>.notecode>input:focus{
  border: 1px solid rgb(0, 132, 137) !important;
}
.code>.code-center>.btn{
  background: none;
  border:none;
  outline: none;
  color:rgb(0, 132, 137);
  font-size:16px;
  font-weight: bold;
}
</style>