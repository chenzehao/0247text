<template>
    <div class="payPage">
        <p class="back iconfont icon-fanhui" @click="$router.back(-1)"></p>
        <div class="title">结算</div>
        <div class="detail">订单号:{{oid}}</div>
        <div class="isPay">{{isPay?'已支付':'未支付'}}</div>
        <div v-if="!isPay" class="erVma" @click="changeEr">
            <img :src="img" alt="">
        </div>
        <div class="payFinish" @click="finish">已完成支付</div>
    </div>
</template>
<script>
export default {
    data(){
        return {
            oid:0,
            isPay:false,
            imgBox:[
                '/pay/erVma/chenqiuyu.jpg',
                '/pay/erVma/chenzehao.jpg',
                '/pay/erVma/langjie.png',
                "/pay/erVma/liuyingchun.png",
                '/pay/erVma/zhouhechong.png',
                '/pay/erVma/qinyujie.jpg',
                '/pay/erVma/wangyiwei.jpg'
            ],
            page:0,
            img:'/pay/erVma/chenqiuyu.jpg'
        }
    },
    created(){
        this.oid=this.$route.path.split('/')[2]
        this.axios.get('/index/getOrderStatus',{params:{
            oid:this.oid
        }}).then(res=>{
            if(res.data.code==1){
                this.isPay=res.data.data[0].isPay
            }else{
                console.log('err')
            }
        })
    },
    methods:{
        changeEr(){
            this.page++
            if(this.page>6){
                this.page=0
            }
            this.img=this.imgBox[this.page]
        },
        finish(){
            this.axios.get('/index/orderStatus',{params:{oid:this.oid}}).then(res=>{
                if(res.data.code==1){
                    this.$toast({
                        message:'支付成功',
                        duration:1000
                    })
                    setTimeout(()=>{
                        this.$store.commit('orderChange','all')
                        this.$store.commit('homePageChange','tab3')
                        this.$router.push('/')
                    })
                }
            })
        }
    }
}
</script>
<style scoped>
    .back{
        width:24px;
        height:24px;
        padding-bottom:20px;
    }
    .payPage{
        text-align:left;
        width:90%;
        padding-top:30px;
        margin:0 auto;
    }
    .payPage>.title{
        font-size:24px;
        font-weight:bold;
        padding-bottom:30px;
    }
    .erVma{
        width:60%;
        height:200px;
        margin:0 auto;
        padding-top:50px;
    }
    .erVma>img{
        width:200px;
    }
    .payFinish{
        width:50%;
        height:40px;
        text-align:center;
        line-height:40px;
        border-radius: 5px;
        margin:0 auto;
        margin-top:20px;
        color:white;
        background:#008489;
    }
</style>


