<template>
    <div class="order">
        <div class="title">订单</div>
        <div v-show="Login">
            <div class="orderBox">
                <div class="smTitle" :class="{active:active=='all'}" @click="Cactive('all')">全部订单</div>
                <div class="smTitle" :class="{active:active=='valid'}" @click="Cactive('valid')">有效订单</div>
                <div class="smTitle" :class="{active:active=='noPay'}" @click="Cactive('noPay')">待支付订单</div>
            </div>
            <div class="orderDetail">
                <div v-if="active=='all'" class="detail">
                    <div v-show="alllist.length>0" class="eachRoom" v-for="(key,i) in alllist" :key="i">
                        <div class="leftBox">
                            <div class="eachTitle">{{key.room[0].describ}}</div>
                            <div class="eachDate">{{key.o_date | getTimeSTR}} · {{key.o_days}}晚</div>
                            <div class="eachPrice">{{key.o_date | isFinish}} · ￥{{key.o_price}}.00</div>
                        </div>
                        <div class="rightBox">
                            <img :src="key.room[0].image_list | getFirstImage" alt="">
                        </div>
                        <div class="pay" v-if="key.isPay==0">
                            <div class="btnBox cancel" @click="cancel(key.oid)">取消订单</div>
                            <div class="btnBox" @click="payNow(key.oid)">立即支付</div>
                        </div>
                    </div>
                    <div class="noList" v-show="alllist.length==0">您当前没有订单，尽享你的旅程吧</div>
                </div>
                <div v-else-if="active=='valid'" class="detail">
                    <div v-show="validlist.length>0" class="eachRoom" v-for="(key,i) in validlist" :key="i">
                        <div class="leftBox">
                            <div class="eachTitle">{{key.room[0].describ}}</div>
                            <div class="eachDate">{{key.o_date | getTimeSTR}} · {{key.o_days}}晚</div>
                            <div class="eachPrice">{{key.o_date | isFinish}} · ￥{{key.o_price}}.00</div>
                        </div>
                        <div class="rightBox">
                            <img :src="key.room[0].image_list | getFirstImage" alt="">
                        </div>
                    </div>
                    <div class="noList" v-show="validlist.length==0">您当前没有「有效」订单，尽享你的旅程吧</div>
                </div>
                <div v-else class="detail">
                    <div v-show="noPaylist.length>0" class="eachRoom no" v-for="(key,i) in noPaylist" :key="i">
                        <div class="leftBox">
                            <div class="eachTitle">{{key.room[0].describ}}</div>
                            <div class="eachDate">{{key.o_date | getTimeSTR}} · {{key.o_days}}晚</div>
                            <div class="eachPrice">{{key.o_date | isFinish}} · ￥{{key.o_price}}.00</div>
                        </div>
                        <div class="rightBox">
                            <img :src="key.room[0].image_list | getFirstImage" alt="">
                        </div>
                        <div class="pay">
                            <div class="btnBox cancel" @click="cancel(key.oid)">取消订单</div>
                            <div class="btnBox" @click="payNow(key.oid)">立即支付</div>
                        </div>
                    </div>
                    <div class="noList" v-show="noPaylist.length==0">您当前没有「未支付」订单，尽享你的旅程吧</div>
                </div>
            </div>
        </div>
        <div v-show="!Login" class="noLog">
            <div class="message">您还未登录!</div>
            <div class="toLogin" @click="toLogin">去登录</div>
        </div>
    </div>
</template>
<script>
export default {
    data(){
        return{
            Login:false,
            active:'all',
            alllist:[],
            validlist:[],
            noPaylist:[],
        }
    },
    created(){
        this.active=this.$store.getters.getOrder
        this.Cactive(this.active)
        this.Login=Object.keys(this.$store.getters.getInfo).length>0?true:false
    },
    updated(){
        this.Login=Object.keys(this.$store.getters.getInfo).length>0?true:false
    },
    methods:{
        cancel(oid){
            this.axios.get('/index/orderDel',{params:{oid:oid}}).then(res=>{
                if(res.data.code==1){
                    this.Cactive(this.active)
                    this.$store.commit('delSearch')
                    this.$toast({
                        message:'取消成功',
                        duration:1000
                    })
                }
            })
        },
        payNow(oid){
            this.$router.push('/pay/'+oid)
        },
        Cactive(val){
            this.active=val
            if(val=='all'){
                this.axios.get('/index/orderList',{params:{status:2}})
                .then(res=>{
                    if(res.data.code==1){
                        this.alllist=res.data.data
                    }else{
                        this.alllist=[]
                    }
                })
            }else if(val=='valid'){
                this.axios.get('/index/orderList',{params:{status:1}})
                .then(res=>{
                    if(res.data.code==1){
                        this.validlist=res.data.data
                    }else{
                        this.validlist=[]
                    }
                })
            }else{
                this.axios.get('/index/orderList',{params:{status:0}})
                .then(res=>{
                    if(res.data.code==1){
                        this.noPaylist=res.data.data
                    }else{
                        this.noPaylist=[]
                    }
                })
            }
        },
        toLogin(){
            this.$router.push('/login')
        }
    },
}
</script>
<style scoped>
    .pay{
        margin-left:50%;
        width:50%;
        text-align:right;
        display:flex;
        justify-content: space-between;
    }
    .pay>.btnBox{
        width:70px;
        height:25px;
        border:1px solid #008489;
        border-radius: 5px;
        color:#008489;
        font-size:13px;
        text-align:center;
        line-height: 25px;
    }
    .pay>.btnBox.cancel{
        color:#777;
        border:1px solid #777;
    }
    .message{
        text-align:left;
        font-size:18px;
    }
    .toLogin{
        color:white;
        background:#008489;
        width:40%;
        height:50px;
        margin: 30px 0;
        border-radius: 5px;
        font-size:20px;
        line-height:50px;
        font-weight:500;
    }
    .noList{
        padding-top:30px;
    }
    .order{
        position:relative;
        width:90%;
        margin:20px auto;
        padding-bottom:30px;
    }
    .back{
        width:32px;
        height:32px;
        font-size:24px;
        color:#484848;
        line-height:32px;
        border-radius:50%;
        left:24px;
        top:24px;
        margin-left:-5px;
    }
    .title{
        color:#484848;
        text-align:left;
        font-size:28px;
        font-weight:bold;
        padding:25px 0;
    }
    .orderBox{
        width:100%;
        display:flex;
    }
    .orderBox>.smTitle{
        margin-right:20px;
        font-size:14px;
        height:30px;
        color:#484848;
    }
    .orderBox>.smTitle.active{
        color:#008489;
        border: 0 !important;
        border-bottom:2px solid #008489 !important;
    }
    .detail{
        width:100%;
    }
    .detail>.eachRoom{
        width:100%;
        /* height:160px; */
        display:flex;
        margin:10px 0;
        border-bottom:1px solid #dddddd;
        /* box-sizing: border-box; */
        padding:20px 0;
        flex-wrap: wrap;
    }
    .detail>.eachRoom.no{
        height:160px;
        flex-wrap: wrap;
    }
    .eachRoom>div:not(:last-child){
        width:50%;
    }
    .eachRoom>.rightBox{
        width:50%;
        text-align:right;
        height:100px;
    }
    .rightBox>img{
        width:50%;
    }
    .leftBox>.eachTitle{
        font-weight:bold;
        color:#444;
        width:100%;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
    }
    .leftBox>div:not(:first-child){
        padding-top:5px;
        font-size:14px;
        text-align:left;
    }

</style>