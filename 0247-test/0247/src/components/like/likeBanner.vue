<template>
    <div class="bannerShow" :data-bid="bid">
        <div class="bannerMap" :style="`width:${width*image.length}px;margin-left:-${page*width}px`">
            <div 
            @touchend="touchend" 
            @touchstart="touchstart" 
            @touchmove.prevent="touchmove"
            v-for="(key,i) of image" 
            :key="i" 
            class="img" 
            :style="`width:${width}px;background:url(${key}) no-repeat;`"
            ></div>
            <div class="pageNum">
                <span>{{pageNum}}</span>
                /
                <span>{{image.length-2}}</span>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props:{
        image:{type:Array},
        bid:{type:Number},
    },
    data(){
        return {
            width:0,
            nowMargin:0,
            now:0,
            to:0,
            page:1,
            pageNum:1,
        }
    },
    created(){
        
    },
    mounted(){
        let bannerShow=document.querySelector(`[data-bid='${this.bid}']`)
        this.width=parseFloat(window.getComputedStyle(bannerShow).width)
    },
    methods:{
        touchstart(e){
            var rid=document.querySelector(`[data-bid='${this.bid}']`)
            var banner=document.querySelector(`[data-bid='${this.bid}'] .bannerMap`)
            banner.classList.remove('move')
            var now=e.targetTouches[0].pageX
            this.now=now
            this.nowMargin=this.page*-this.width+'px'
        },
        //移动事件
        touchmove(e){
            var banner=document.querySelector(`[data-bid='${this.bid}'] .bannerMap`)
            var to=e.targetTouches[0].pageX
            this.to=to
            var margin=parseInt(banner.style.marginLeft)
            var now=-this.width*this.page+(this.to-this.now)
            banner.style.marginLeft=now+'px'
        },
        //结束触摸事件
        touchend(e){
            var banner=document.querySelector(`[data-bid='${this.bid}'] .bannerMap`)
            banner.classList.add('move')
            if(this.now-this.to>=70){
                if(this.to==0){return}
                //轮播图右移
                if(this.page<(this.image.length-1)){
                    this.page++;
                    if(this.page==this.image.length-1){
                        this.pageNum=1
                        setTimeout(()=>{
                            banner.classList.remove('move')
                            this.page=1
                        },200)
                    }else{
                        this.pageNum++
                    }
                }
            }else if(this.to-this.now>=70){
                //轮播图左移
                if(this.page>=1){
                    this.page--
                    if(this.page==0){
                        this.pageNum=this.image.length-2
                        setTimeout(()=>{
                            banner.classList.remove('move')
                            this.page=this.image.length-2
                        },200)
                    }else{
                        this.pageNum--
                    }
                }
            }
            this.now=0;this.to=0
            banner.style.marginLeft=this.nowMargin
        }
    }
}
</script>
<style scoped>
    .pageNum{
        position:absolute;
        bottom: 3px;
        right:3px;
        width:40px;
        height:20px;
        background:rgba(0,0,0,0.5);
        border-radius:10px;
        text-align:center;
        line-height:20px;
        color:white;
        font-size:14px
    }
    .bannerShow{
        width:100%;
        height:100%;
        overflow: hidden;
        position: relative;;
    }
    .bannerMap{
        height:100%;
        display: flex;
    }
    .bannerMap.move{
        transition:margin-left .2s linear;
    }
    .bannerMap>.img{
        height:100%;
        background-size:cover !important;
        background-position:center !important;
    }
</style>

