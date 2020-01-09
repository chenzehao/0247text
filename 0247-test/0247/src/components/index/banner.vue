<template>
    <div class="banner">
        <img class="logo" src="../../../public/index/logo.png" alt="">
        <div class="longBanner" :style="`margin-left:-${page*width}px;width:${(list.length+2)*width}px`">
            <div class="bn-details" :style="`width:${width}px`"  @touchend="touchend" @touchstart="touchstart" @touchmove.prevent="touchmove">
                <img :src="list[list.length-1].image_path" alt="">
                <div class="banner-title">
                    <p class="sm-title">{{list[list.length-1].small_title}}</p>
                    <p class="big-title">{{list[list.length-1].big_title}}</p>
                </div>
            </div>
            <div class="bn-details" :style="`width:${width}px`" v-for="(key,i) of list" :key="i" @touchend="touchend" @touchstart="touchstart" @touchmove.prevent="touchmove">
                <img :src="key.image_path" alt="">
                <div class="banner-title">
                    <p class="sm-title">{{key.small_title}}</p>
                    <p class="big-title">{{key.big_title}}</p>
                </div>
            </div>
            <div class="bn-details" :style="`width:${width}px`"  @touchend="touchend" @touchstart="touchstart" @touchmove.prevent="touchmove">
                <img :src="list[0].image_path" alt="">
                <div class="banner-title">
                    <p class="sm-title">{{list[0].small_title}}</p>
                    <p class="big-title">{{list[0].big_title}}</p>
                </div>
            </div>
        </div>
        <div class="smBall">
            <div v-for="(key,i) of list" :key="i" :data-page="i" class="ball">
                <div class="whiteBall"></div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props:['width'],
    data(){
        return {
            list:[
                {image_path:'/index/banner/banner1.png',big_title:'奇遇澳洲',small_title:'纵情纯净大自然'},
                {image_path:'/index/banner/banner2.png',big_title:'南方房源推荐',small_title:'温暖难过,活力过冬'},
                {image_path:'/index/banner/banner3.png',big_title:'冬日闲暇好去处',small_title:'周末特惠房源推荐'},
                {image_path:'/index/banner/banner4.png',big_title:'国内新年目的地',small_title:'跳上高铁去旅行'},
                {image_path:'/index/banner/banner5.png',big_title:'免前落地签指南',small_title:'拿起护照说走就走'},
                ],
            now:0,
            to:0,
            page:1,
            nowMargin:0,
            smBall:0,
            timer:0,
        }
    },
    created(){
        // 开始过渡
        this.$store.commit('loadingChange',true)
        this.axios.get('index/carousel').then((result)=>{
            if(result.data.code==1){
                this.list=result.data.data
                setTimeout(()=>{
                    // 过渡结束
                    this.$store.commit('loadingChange',false)
                },500)
            }
        })
    },
    mounted(){
        this.showBall()
        this.banner()
    },
    updated(){
        this.showBall()
        this.banner()
    },
    beforeDestroy() {
        clearInterval(this.timer);        
        this.timer = null;
    },
    methods:{
        // 根据小球颜色修改轮播图
        banner(){
            //获取当前小球
            clearInterval(this.timer)
            this.timer=setInterval(()=>{
                var banner=document.getElementsByClassName('longBanner')[0]
                var ball=document.querySelector('.ball.show')
                banner.classList.add('move')
                if(ball!=undefined){
                    ball.children[0].style.width=this.smBall+'px'
                    this.smBall+=0.15
                    if(this.smBall>=15){
                        this.smBall=0;
                        clearInterval(this.timer)
                        ball.children[0].style.width='0px'
                        this.page++
                        if(this.page<(this.list.length+1)){
                            this.nowMargin=parseInt(this.nowMargin)+375+'px'
                        }else{
                            setTimeout(()=>{
                                banner.classList.remove('move')
                                this.page=1
                            },200)
                        }
                    }
                }
            },50)
        },
        // 小球长度调整函数
        showBall(){
            var showBall=document.querySelectorAll('[data-page]')
            if(this.page==0 || this.page==6){return}
            for(var i=0;i<this.list.length;i++){
                if(showBall[i].dataset.page==this.page-1){
                    showBall[i].classList.add('show')
                }else{
                    showBall[i].classList.remove('show')
                    showBall[i].children[0].style.width='0px'
                }
            }
        },
        //触摸事件
        touchstart(e){
            clearInterval(this.timer)
            var banner=document.getElementsByClassName('longBanner')[0]
            banner.classList.remove('move')
            var now=e.targetTouches[0].pageX
            this.now=now
            this.nowMargin=this.page*-this.width+'px'
        },
        //移动事件
        touchmove(e){
            document.addEventListener('touchmove',this.moveChange,false)
            var banner=document.getElementsByClassName('longBanner')[0]
            var to=e.targetTouches[0].pageX
            this.to=to
            var margin=parseInt(banner.style.marginLeft)
            var now=-this.width*this.page+(this.to-this.now)
            if(this.now>this.to){
                banner.style.marginLeft=now+'px'
            }else{
                banner.style.marginLeft=now+'px'
            }
        },
        //结束触摸事件
        touchend(e){
            this.banner()
            var banner=document.getElementsByClassName('longBanner')[0]
            banner.classList.add('move')
            if(this.now-this.to>=100){
                if(this.to==0){return}
                if(this.page<(this.list.length+1)){
                    this.page++;
                    if(this.page==6){
                        setTimeout(()=>{
                            banner.classList.remove('move')
                            this.page=1
                        },200)
                    }
                    this.smBall=0
                }
            }else if(this.to-this.now>=100){
                if(this.page>=1){
                    this.page--
                    if(this.page==0){
                        setTimeout(()=>{
                            banner.classList.remove('move')
                            this.page=5
                        },200)
                    }
                    this.smBall=0
                }
            }
            this.now=0;this.to=0
            banner.style.marginLeft=this.nowMargin
        }
    }
}
</script>
<style scoped>
    .banner{
        background:#fff;
        height:183px;
        width:100%;
        overflow: hidden;
        position:relative;
    }
    .banner>.longBanner{
        height:100%;
        display:flex;
    }
    .longBanner.move{
        transition:margin-left .2s linear;
    }
    .bn-details{
        width:375.2px;
        position: relative;
    }
    .banner img{
        width:100%;height:100%;
    }
    .banner img.logo{
        width:30px;height:50px;
        position:absolute;
        top:10px;
        left:20px;
        z-index:100;
    }
    .banner .banner-title{
        position:absolute;
        text-align: left;
        top:80px;
        left:24px;
        width:50%;
        height:40%;
        z-index: 200;
        color:#fff;
        font-family: Circular, "PingFang-SC";
        font-weight:800;
    }
    .banner-title .big-title{
        font-size:22px;
        margin-top:5px;
    }
    .banner-title .sm-title{
        font-size:10px;
    }
    /* 小球提示栏 */
    .smBall{
        width:45px;
        height:4px;
        position:absolute;
        bottom:40px;
        left:24px;
        display:flex;
        justify-content: space-between;
    }
    .ball{
        width:4px;height:4px;
        border-radius: 50%;
        background:rgba(196, 196, 196, 0.5);
    }
    .ball.show{
        width:15px;
        border-radius:4px;
        overflow: hidden;
    }
    .whiteBall{
        height:4px;
        width:0;
        background:#fff;
        /* transition:all .05s linear; */
    }
</style>


