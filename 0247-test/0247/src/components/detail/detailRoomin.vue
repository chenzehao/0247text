<template>
  <div class="detailRoomin">
    <div class="center-box">
      <p class="title">入住与退房时间</p>
      <!-- 入住和退房具体时间 -->
      <div>
        <!-- 入住或者退房有具体时间 -->
        <div v-if="room_in&&room_out">
          <!-- 入住 -->
          <span v-if="room_in">{{room_in}}入住，</span>
          <span v-else>入住时间灵活</span>
          <!-- 退房 -->
          <span v-if="room_out">{{room_out}}退房</span>
          <span v-else>退房时间灵活</span>
        </div>
        <!-- 入住或者退房没有具体时间 -->
        <div v-else>
          <span>入住、退房时间灵活</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    room_in:{type:String},
    room_out:{type:String}
  }
}
</script>

<style scoped>
.detailRoomin{
  background:#fff;
  text-align:left;
  padding:16px 0;
}
.title{
  font-size:14px;
  font-weight:bold;
  line-height:18px;
  margin-bottom:16px;
  color:#484848;
}
</style>