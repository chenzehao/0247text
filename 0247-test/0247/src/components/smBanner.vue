<template>
    <div :v-if="image.length>0" class="smBanner" :class="{'noSwitch':Switch}" :rid="rid">
        <div class="longMap" :style="`width:${width*(image.length)}px;margin-left:-${page*width}px`" @click="top=0">
            <div 
            @touchend="touchend" 
            @touchstart="touchstart" 
            @touchmove.prevent="touchmove"
            v-for="(key,i) of image" 
            :key="i" 
            class="img" 
            :style="`width:${width}px;background:url(${key}) no-repeat;`"
            ></div>
        </div>
        <div class="box" :style="`left:${(width-138.5)/2}px`">
            <div class="ballMap" :style="`width:${image.length*16}px`">
                <div v-for="(li,i) of smbtn" :key="i" class="ballsm" :data-i="i"></div>
            </div>
        </div>
        <div v-if="!Switch" class="pic" :style="{top,width:width+'px'}">
            <div class="top">
                <button @click="top=height+'px'">
                    <svg viewBox="0 0 12 12" role="img" aria-label="关闭" focusable="false" style="height: 12px; width: 12px; display: block; fill: currentcolor;"><path d="m11.5 10.5c.3.3.3.8 0 1.1s-.8.3-1.1 0l-4.4-4.5-4.5 4.5c-.3.3-.8.3-1.1 0s-.3-.8 0-1.1l4.5-4.5-4.4-4.5c-.3-.3-.3-.8 0-1.1s.8-.3 1.1 0l4.4 4.5 4.5-4.5c.3-.3.8-.3 1.1 0s .3.8 0 1.1l-4.5 4.5z" fill-rule="evenodd"></path></svg>
                </button>
                <p>房源图片 · {{image.length}} 张</p>
            </div>
            <div class="imgList">
                <ul :style="{height:(height-60)+'px'}">
                    <li v-for="(el,i) of image" :key="i">
                        <img :src="el">
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props:{
        Switch:false,
        image:{type:Array},
        smbtn:{type:Array},
        rid:{type:Number}
    },
    mounted(){
        var smBanner=document.querySelector(`[rid='${this.rid}']`)
        this.width=parseFloat(window.getComputedStyle(smBanner).width)
        this.changeBall()
        if(!this.Switch){
            this.banner()
        }
    },
    updated(){
        this.changeBall()
    },
    beforeDestroy(){
        if(!this.Switch){
            clearInterval(this.timer)
            this.timer=null
        }
    },
    data(){
        return {
            width:0,
            nowMargin:0,
            height:window.innerHeight,
            top:window.innerHeight+'px',
            page:1,
            now:0,
            to:0,
            timer:'',
        }
    },
    methods:{
        //轮播功能
        banner(){
            this.timer=setInterval(()=>{
                var smBanner=document.querySelector(`[rid='${this.rid}']`)
                var banner=document.querySelector(`[rid='${this.rid}'] .longMap`)
                banner.classList.add('move')
                if(this.page<(this.image.length-1)){
                    this.page++;
                    if(this.page==this.image.length-1){
                        setTimeout(()=>{
                            banner.classList.remove('move')
                            this.page=1
                        },200)
                    }
                }
            },3000)
        },
        //修改小球
        changeBall(){
            var ballMap=document.querySelector(`[rid='${this.rid}']>div:nth-child(2)>div`)
            var smbtn=document.querySelector(`[rid='${this.rid}']>div:nth-child(2)>.ballMap`).children
            for(var i=0;i<smbtn.length;i++){
                var a=smbtn[i].dataset.i
                if(this.page<4 || this.page-this.smbtn.length >5){
                    if(a==this.page-1){
                        smbtn[i].className='ballcheck'
                    }else if(a>6){
                        smbtn[i].className='ballsm'
                    }else{
                        smbtn[i].className='ballmid'
                    }
                }else if(this.page-(this.smbtn.length-2)>0){
                    if(a==this.page-1){
                        smbtn[i].className='ballcheck'
                    }else if(a<=this.smbtn.length-6){
                        smbtn[i].className='ballsm'
                    }else{
                        smbtn[i].className='ballmid'
                    }
                }else{
                    if(a==this.page-1){
                        smbtn[i].className='ballcheck'
                    }else if(a==this.page-2 || a==this.page-3 || a==this.page || a==this.page+1){
                        smbtn[i].className='ballmid'
                    }else{
                        smbtn[i].className='ballsm'
                    }
                    if(this.page<this.smbtn.length-1){
                        ballMap.style.marginLeft=`-${(this.page-4)*18}px`
                    }
                }
                if(this.page==1){
                    ballMap.style.marginLeft=0
                }else if(this.page==this.smbtn.length){
                    ballMap.style.marginLeft=`-${(this.page-6)*18}px`
                }
            }
        },
        //触摸事件
        touchstart(e){
            var rid=document.querySelector(`[rid='${this.rid}']`)
            if(!this.Switch){
                clearInterval(this.timer)
            }
            var banner=document.querySelector(`[rid='${this.rid}'] .longMap`)
            banner.classList.remove('move')
            var now=e.targetTouches[0].pageX
            this.now=now
            this.nowMargin=this.page*-this.width+'px'
        },
        //移动事件
        touchmove(e){
            var banner=document.querySelector(`[rid='${this.rid}'] .longMap`)
            var to=e.targetTouches[0].pageX
            this.to=to
            var margin=parseInt(banner.style.marginLeft)
            var now=-this.width*this.page+(this.to-this.now)
            banner.style.marginLeft=now+'px'
        },
        //结束触摸事件
        touchend(e){
            if(!this.Switch){
                this.banner()
            }
            var banner=document.querySelector(`[rid='${this.rid}'] .longMap`)
            banner.classList.add('move')
            if(this.now-this.to>=70){
                if(this.to==0){return}
                //轮播图右移
                if(this.page<(this.image.length-1)){
                    this.page++;
                    if(this.page==this.image.length-1){
                        setTimeout(()=>{
                            banner.classList.remove('move')
                            this.page=1
                        },200)
                    }
                    this.changeBall(this.rid)
                }
            }else if(this.to-this.now>=70){
                //轮播图左移
                if(this.page>=1){
                    this.page--
                    if(this.page==0){
                        setTimeout(()=>{
                            banner.classList.remove('move')
                            this.page=this.image.length-2
                        },200)
                    }
                    this.changeBall(this.rid)
                }
            }
            this.now=0;this.to=0
            banner.style.marginLeft=this.nowMargin
        }
    }
}
</script>
<style scoped>
    .pic{
        position: fixed;
        transition:top 1s;
        background: #fff;
        z-index: 1001;
    }
    .pic img{
        width:100%;
    }
    .pic>.top{
        height:60px;
    }
    .pic>.top>button{
        background: transparent;
        padding:24px;
        border:0;
        float: left;
    }
    .pic>.top>p{
        line-height: 60px;
        margin-right:60px;
        font-size:18px;
        color:#484848;
        font-weight:bold;
    }
    .pic>.imgList>ul{
        overflow-x: scroll;
        padding:0 24px;
    }
    .pic>.imgList>ul>li{
        margin-bottom:24px;
    }
    .smBanner{
        width:100%;
        height:240px;
        margin:0 auto;
        background:#ddd;
        border-radius:8px;
        position:relative;
        overflow: hidden;
    }
    .smBanner.noSwitch{
        width:99%;
        height:200px;
        border-radius: 0;
        border-top-left-radius:8px;
        border-top-right-radius:8px;
    }
    .longMap{
        display: flex;
        height:100%;
    }
    .longMap.move{
        transition:margin-left .2s linear;
    }
    .longMap>.img{
        height:100%;
        background-size:cover !important;
        background-position:center !important;
    }
    .box{
        width:138.5px;
        height:8px;
        padding:8px 0;
        position:absolute;
        bottom:0;
        overflow: hidden;
    }
    .box>.ballMap{
        height:8px;
        display:flex;
        justify-content: space-between;
        transition:margin-left .2s linear;
    }
    .box>.ballMap>div{
        border-radius: 50%;
        box-sizing:border-box;
        transition:all .2s linear;
    }
    .box>.ballMap>.ballcheck{
        background:white;
        width:8px;height:8px;
    }
    .box>.ballMap>.ballmid{
        background:rgba(255, 255, 255, 0.8);
        width:6px;height:6px;
        margin:1px;
    }
    .box>.ballMap>.ballsm{
        background:rgba(255, 255, 255, 0.8);
        width:4px;height:4px;
        margin:2px;
    }
</style>