<template>
    <div class="father">
        <loading v-show="$store.getters.getLoading" :zIndex="100"></loading>
        <div v-show="!$store.getters.getLoading">
            <!-- 面板 -->
            <mt-tab-container v-model="active">
                <mt-tab-container-item id="tab1">
                    <index-page :width="width"></index-page>
                </mt-tab-container-item>
                <mt-tab-container-item id="tab2">
                    <like-page v-if="active=='tab2'"></like-page>
                </mt-tab-container-item>
                <mt-tab-container-item id="tab3">
                    <Order v-if="active=='tab3'"></Order>
                </mt-tab-container-item>
                <mt-tab-container-item id="tab4">
                    <my-login v-if="active=='tab4' && Object.keys(userInfo).length==0"></my-login>
                    <login-success v-else></login-success>
                </mt-tab-container-item>
            </mt-tab-container>
        </div>
        <!-- 导航条 -->
            <mt-tabbar fixed v-model="active">
                <mt-tab-item id="tab1">
                    <img v-if="active=='tab1'" src="../../public/home/home_check.png" alt="">
                    <img v-else src="../../public/home/home.png" alt="">
                    <p>首页</p>
                </mt-tab-item>
                <mt-tab-item id="tab2">
                    <img v-if="active=='tab2'" src="../../public/home/xin_check.png" alt="">
                    <img v-else src="../../public/home/xin.png" alt="">
                    <p>心愿</p>
                </mt-tab-item>
                <mt-tab-item id="tab3">
                    <img v-if="active=='tab3'" src="../../public/home/dingdan_check.png" alt="">
                    <img v-else src="../../public/home/dingdan.png" alt="">
                    <p>订单</p>
                </mt-tab-item>
                <mt-tab-item id="tab4">
                    <img v-if="active=='tab4'" src="../../public/home/me_check.png" alt="">
                    <img v-else src="../../public/home/me.png" alt="">
                    <p>我</p>
                </mt-tab-item>
            </mt-tabbar>
    </div>
</template>
<script>
import index from './Index.vue'
import likePage from './like.vue'
import message from './message.vue'
import MyLogin from './MyLogin.vue'
import LoginSuccess from '../components/login/LoginSuccess.vue'
import loading from '../components/loading.vue'
import Order from './Order.vue'
export default {
    components:{
        "index-page":index,
        "like-page":likePage,
        "message":message,
        "my-login":MyLogin,
        "login-success":LoginSuccess,
        "loading":loading,
        "Order":Order
    },
    created(){
        var active=this.$store.getters.getHomepage
        this.active=active
    },
    data(){
        return{
            active:'tab1',
            userInfo:{},
            loading:false,
            width:0,
        }
    },
    mounted(){
        var father=document.querySelector('.father')
        this.width=parseFloat(window.getComputedStyle(father).width)
        this.userInfo=this.$store.getters.getInfo
    },
    computed:{
        getActive(){
            return this.$store.getters.getHomepage
        },
        getLoading(){
            return this.$store.getters.getLoading
        }
    },
    watch:{
        active(){
            this.$store.commit('homePageChange',this.active)
        },
        getActive(val){
            this.active=val
        },
        getLoading(val){
            this.loading=val
        }
    }
}
</script>
<style>
    .mint-tab-item{
        color:#484848 !important;
    }
    .mint-tabbar > .mint-tab-item.is-selected{
        background:white !important;
        color:#008483 !important; 
        border-top:1px solid #d9d9d9;
        padding-top:-3px !important;
    }
    .mint-tabbar{
        z-index: 500 !important;
    }
</style>


