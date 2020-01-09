<template>
  <div class="detailWatch">
    <div class="center-box">
      <p class="image"></p>
      <p class="text">在 8 天内完成预订，锁定限时好价</p>
    </div>
  </div>
</template>

<style scoped>
.detailWatch{
  background:#fff;
  padding:16px 0;
  border-bottom:1px solid #f2f2f2;
}
.detailWatch .center-box{
  padding:8px;
  display:flex;
  justify-content: start;
  background:rgb(247, 243, 234);
  border-radius:3px;
}
.detailWatch .image{
  width:24px;
  height:24px;
  background:url(../../../public/image/detail/watch.gif);
  background-size:100%;
}
.detailWatch .text{
  font-size:12px;
  line-height:24px;
  margin-left:8px;
  font-weight:bold;
  color:#484848;
}
</style>