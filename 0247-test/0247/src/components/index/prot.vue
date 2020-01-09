<template>
  <div class="prot">
    <div class="prot-title">
      <span>0247旅行保障</span>
    </div>
    <div class="prot-body">
      <div class="prot-body-one">
        <img src="../../../public/index/home.png">
        <div class="prot-txt">
          <strong>安心房源保障</strong>人工审核所有中国房源页面信息，入住更放心
        </div>
      </div>
      <div class="prot-body-one">
        <img src="../../../public/index/phone.png">
        <div class="prot-txt">
          <strong>专业中文客服</strong>(86)400-841-8888、(86)010-8783-3463,24小时服务
        </div>
      </div>
      <div class="prot-body-one">
        <img src="../../../public/index/anquan.png">
        <div class="prot-txt">
          <strong>旅行安全保障</strong>多重风险控制设计，全方位保障您的行程安全
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {

}
</script>
<style stoped>
.prot{
  margin:48px 24px;
}
.prot>.prot-title{
  margin-bottom: 16px;
  font-size: 18px !important;
  font-weight: 700 !important;
  line-height: 26px !important;
  text-align: left;
}
.prot>.prot-body{
  box-shadow: 0px 1px 8px rgba(0, 0, 0, 0.1) !important;
  border-radius: 3px !important;
  padding: 24px !important;
}
.prot-body-one{
  display: flex;
  justify-content: space-between;
  height: 40px;
  margin-bottom: 24px !important;
}
.prot-body-one>img{
  width: 32px !important;
  height: 32px !important;
  margin-right: 20px !important;
}
.prot-body-one>.prot-txt{
  font-size:14px !important;
  text-align: left;
}
.prot-body-one>.prot-txt>p{
  margin: 0;
}
</style>