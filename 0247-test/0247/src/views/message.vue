<template>
  <div >
      <div class="messagetop">
          <span>收件箱</span><span>您有1条消息未读</span>
      </div>
      <div class="messagebox">
          <div class="greenpoint"></div>
          <div class="messageimgdiv">
            <img src="../../public/index/banner/banner1.png" alt="" class="messageimg"> 
          </div>
          <div class="message">
            <div class="first_line">
              <span>Simon</span>
              <span>2017/8/6<img src="../../public/image/message/go.png" class="back"></span>
            </div>
            <div class="msgs">
              <span class="msg">亲，欢迎来到三亚，我和太太平时在123333</span>
              <span class="msgtime">行程已完成</span>
            </div>
          </div> 
      </div>  
  </div>
</template>

<script>
export default {

}
</script>

<style scoped>
*{margin: 0;padding: 0;box-sizing: border-box;}
.messagetop{
  position: fixed;
  width: 150px;
  display: flex;
  justify-content: left;
  flex-wrap: wrap;
  top:8%;
  left: 8%;
  letter-spacing:1px; 
}
.messagetop>span:nth-child(1){
  font-size: 30px;
  font-weight: bold;
  margin-bottom: 12%;
}
.messagetop>span:nth-child(2){
  font-size: 17px;
}
.messageimgdiv{
  padding-left: 3%;
}
.messagebox{
  position: fixed;
  top:25%;
  left: 2%;
  display: flex;
  margin-bottom: 5%;
  width:100%;
}
.greenpoint{
  margin-top:20px;
  height: 8px;
  width: 8px;
  border: 0px solid #008489;
  border-radius: 50%;
  background:#008489;
}
.messageimg{
  display: block;
  border-radius: 50%;
  height: 50px;
  width: 50px;
}
.message{
  margin-top: -1%;
  padding-left:3%;
  width:75%;
  text-align: left;
}
.first_line{
  display: flex;
  justify-content: space-between;
  margin-bottom: 1%;
}
.first_line>span:nth-child(1){
  font-weight: bold;
}
.first_line>span:nth-child(2){
  font-size: 13px;
  color: #484848;
}
.back{
  margin-left: 4px;
  height:10px;
}
.msgs{
 color: #828282;
 font-size: 15px;
 line-height: 24px;
 letter-spacing: 1px;
}
.msg{
  display: -webkit-box;
  -webkit-line-clamp: 1;
  overflow: hidden;
  -webkit-box-orient: vertical;
}
</style>