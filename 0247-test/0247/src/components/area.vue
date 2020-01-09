<template>
  <div class="all">
    <!-- 顶部文字 -->
    <div class="toptext">
      <span>冬季特惠房源</span><br>
      <span>特惠房源低至7折</span>
    </div>
    <!-- 顶部按钮 -->
    <cube-scroll-nav-bar
      :current="current"
      :labels="labels"
      @change="changeHandler"
      id="d1"
      v-model="current"
    />
    <!-- 底部详情 -->
    <mt-tab-container class="container" v-model="current">
      <mt-tab-container-item v-for="(diqu,y) of labels" :key="y" :id="diqu">
        <div id="container">
          <!-- 详情循环 -->
          <div class="details" v-for="(lis,i) of list" :key="i" @click="gotodetails(lis.rid)">
            <!-- 图片 -->
            <div>
              <img :src="imgurl[i][0]" class="details_img" />
            </div>
            <!-- 小标题 -->
            <span class="details_s_title">{{lis.describ}}</span>
            <!-- 长标题 -->
            <span class="details_l_title">{{lis.big_title}}</span>
            <div class="details_prices">
              <!-- 价格 -->
              <span class="details_price">￥{{lis.price.toFixed(2)}}</span>
              <span class="details_price1">￥{{lis.price.toFixed(2)}}</span>每晚
            </div>
            <!-- 评价 -->
            <div class="details_assess">
              <!-- 星星评价 -->
              <div class="details_assess_star">
                <cube-rate v-model="value[i]"></cube-rate>
              </div>
              <!-- 评价详情 -->
              <span class="details_assess_list">{{lis.counts}}</span>
            </div>
          </div>
        </div>
        <!-- 加载更多 -->
        <a @click="more1" :class="more">{{loadmore}}</a>
      </mt-tab-container-item>
    </mt-tab-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loadmore:"",
      more:"more",
      price1: 0,
      value: [],
      imgurl: {},
      data: {},
      list: [],
      current: "北京",
      labels: ["北京","上海", "成都",  "西安",  "杭州","重庆", "厦门","苏州"]
    };
  },
  // 提前加载第一页数据
  mounted() {
    this.changeHandler(this.current)
  },
  methods: {
    // 加载更多房源
    more1() {
      this.$router.push("/roomList/" + this.current);
    },
    // 点击详情页
    gotodetails(rid) {
      this.$router.push("/roomDetail/" + rid);
    },
    // 上方按钮
    changeHandler(cur) {
      this.current = cur;
      this.room(cur);
    },
    // axios请求数据并保存
    room(i) {
      var url = `/index/room/${i}`;
      this.axios.get(url).then(res => {
        if (res.data.code == -1) {
          this.more="more more_none"
          this.$toast(`没有${i}地区民宿`);
          this.loadmore="请更换地区"
          this.list = "";
        } else {
          this.more="more";
          this.loadmore=`显示更多${this.current}的房源`;
          var lists = res.data.data;
          this.list = lists;
          for (var u = 0; u <= 3; u++) {
            // 图片数组
            this.imgurl[u] = this.list[u].image_list.split(",");
            // 评价星星数量接口
            this.value[u]=this.list[u].comment
          }
        }
      });
    }
  }
};
</script>
<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
/* 整体 */
.all::before{
  content: "";
  display:block;
  clear: both;
}
.all{
  margin-top: 60px;
}
/* 顶部文字div */
.toptext{
  text-align: left;
  margin-left:6%;
  font-size: 18px;
  color: #484848;
   -webkit-font-smoothing:antialiased;
  -webkit-tap-highlight-color:rgba(196, 196, 196, 0.2);
}
/* 顶部大文字 */
.toptext span:first-of-type{
  font-weight: 700;
  line-height: 26px;
  display: block;
}
/* 顶部小蚊子 */
.toptext span:nth-of-type(2){
  display: block;
  font-size: 13px;
  line-height: 19px;
  margin-top: -20px;
  margin-bottom: 3%;
}
.toptext::before{
  content: "";
  display:block;
  clear: both;
}
/* 按钮下图片整体div */
#container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  margin-right: 6%;
  margin-top: 2%;
  margin-left: 6%;
}
/* 展示详情小div */
.details {
  text-align: left;
  margin-top: 2px;
  height: 200px;
  width: 160px;
  overflow: hidden;
  margin-bottom: 4%; 
}
/* 展示详情图片 */
.details_img {
  height: 106px;
  width: 159px;
}
/* 展示详情小标题 第一行 */
.details_s_title {
  margin-top:5px;
  margin-bottom: 1px;
  line-height: 13px;
  max-height: 13px;
  text-overflow: ellipsis;
  font-weight: 700;
  font-size: 8px !important;
  color: #441a05;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  overflow: hidden;
  -webkit-box-orient: vertical;
  word-break: break-all;
  -webkit-tap-highlight-color: rgba(196, 196, 196, 0.2);
}
/* 展示详情长标题 第二三行 */
.details_l_title {
  max-height: 38px;
  text-overflow: ellipsis;
  margin-bottom: 2px;
  font-weight: bold;
  color: #484848;
  font-size: 14px;
  font-family: "幼圆";
  line-height: 18px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  overflow: hidden;
  -webkit-box-orient: vertical;
  text-indent: 2px;
  -webkit-font-smoothing: antialiased;
}
/* 展示详情价格div */
.details_prices {
  display: -webkit-box;
  overflow: hidden;
  max-height: 22px;
  text-overflow: ellipsis;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  color: #484848;
  font-size: 10px;
  line-height: 16px;
  height: 16px;
  margin-bottom: 0;
}
/* 当时价格 */
.details_price {
  line-height: 15px;
  font-weight: 800;
  display: inline-block;
}
/* 原本价格 */
.details_price1 {
  text-decoration: line-through;
}
/* 评价整体div */
.details_assess {
  margin-top: 2.5%;
  font-size: 12px;
  display: flex;
  color: #484848 !important;
  font-weight: bold !important;
}
/* 评价星星 */
.details_assess_star {
  height: 20px;
  pointer-events: none;
  width: 55px;
}
/* 评价数量 */
.details_assess_list {
  margin-left: 4%;
  vertical-align: top;
  -webkit-tap-highlight-color: rgba(196, 196, 196, 0.2);
}
/* 加载更多默认样式 */
.more {
  width: 85%;
  height: 36px;
  line-height: 34px;
  display: block;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 600;
  border: 1px solid;
  margin: 0 auto;
  border-color: #008489;
  color: #008489;
}
/* 加载更多不可用样式 */
.more_none{
  pointer-events: none;
  border-color: #c4c4c4 !important;
  color: #c4c4c4 !important;
  margin-top: 30px;
}
</style>
<style>
.cube-rate-item {
  /* margin-top: 100px; */
  margin-right: 1px;
}
.cube-rate-item_active .cube-rate-item-def {
  margin-right: 1px !important;
  background-image: url("../../public/index/sy.png") !important;
}
.cube-rate-item-def {
  margin-right: 1px;
  background-image: url("../../public/index/sg.png") !important;
}
/* 整体div样式 */
.cube-scroll-nav-bar {
  position: relative;
  display: flex;
  color: #2a9f93;
  background-color: white;
  margin-right: 5%;
  margin-left: 5%;
}
.cube-scroll-nav-bar_horizontal {
  align-items: center;
}
.cube-scroll-wrapper {
  flex: 1;
  text-align: center;
}
.cube-scroll-content {
  display: inline-block;
  vertical-align: top;
}

.cube-scroll-nav-bar-items {
  color: #484848;
  white-space: nowrap;
}
.cube-scroll-nav-bar_vertical {
  height: 100%;
  justify-content: center;
  text-align: center;
}
/* 内部div样式 */
.cube-scroll-nav-bar-item {
  display: block;
  border: 1px solid #d8d8d8;
  border-radius: 4px;
  margin-right: 10px;
  width: 40px;
  height: 20px;
  margin-bottom: 10px;
  padding-top: 13px;
  box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.15);
}
.cube-scroll-nav-bar-item span {
  font-weight: bold;
  font-size: 14px;
}
.cube-scroll-nav-bar-items {
  font-size: 14px;
  font-weight: bold !important;
}
/* 内部文字 */
.cube-scroll-nav-bar-item {
  display: inline-block;
  vertical-align: top;
  padding: 16px 15px 11px 15px;
}
/* 激活样式 */
.cube-scroll-nav-bar-item_active {
  color: white;
  background-color: #2a9f93;
}
</style>