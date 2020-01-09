<template>
  <div :class="buttonkaiguan" @click="change">
    <span class="dashSpan"></span>
 </div>
</template>

<script>
export default {
  data(){
    return{
      buttonkaiguan:"dashDiv"
    }
  },
  methods:{
    change(){
      if(this.buttonkaiguan=="dashDiv"){
        this.buttonkaiguan="dashDivSelectd"
      }else{
        this.buttonkaiguan="dashDiv"
      }
    }
  }
}
</script>

<style scoped>
 .dashDiv{
    float: right;
    border-radius: 1.8667rem;
    border: 0.03rem solid #cbcbcb;
    background-color: #cbcbcb;
    width: 45px;
    height: 28px;
    margin-top: 0.5rem;
    margin-right: 0.4rem;
    box-sizing: border-box;
    transition: .5s;

}
.dashDiv .dashSpan{
    border-radius: 50%;
    border: 0.03rem solid #cbcbcb;
    background-color: #FFFFFF;
    float: left;
    margin-left: 0.04rem;
    margin-top: 0.019rem;
    width: 26px;
    height: 26px;
    box-sizing: border-box;
}
/*开通状态*/
.dashDivSelectd{
    background-color: #008489;
    transition: .5s;
    border-radius: 1.8667rem;
    border: 0.03rem solid #FFFFFF;
    width: 45px;
    height: 28px;
    margin-top: 0.5rem;
    margin-right: 0.4rem;
    float: right;
    box-sizing: border-box;

}

.dashDivSelectd .dashSpan{
    border-radius: 50%;
    border: 0.03rem solid #FFFFFF;
    background-color: #FFFFFF;
    float: right;
    margin-right: 0.04rem;
    margin-top: 0.019rem;
    width: 26px;
    height: 26px;
    box-sizing: border-box;
}
</style>