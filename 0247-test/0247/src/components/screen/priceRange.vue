<template>
    <div class="Price">
        <div class="title">
            <span>价格范围 ·￥</span>
            <span>{{$store.getters.getsel.minPrice}}</span> - 
            <span>{{$store.getters.getsel.maxPrice}}</span>
        </div>
        <!-- 柱状图 -->
        <div class="barChart">
            <div class="bar" v-for="(key,i) in barBox" :key="i"
            :data-i="i" 
            :style="`height:${66/100*(key/6)}px;margin-top:${66-66/100*(key/6)}px`"></div>
        </div>
        <!-- 滑动栏 -->
        <div class="slideBox">
            <div class="slider" 
            :style="`${width-minleft-maxRight}px;margin-left:${minleft}px;margin-right:${maxRight}px`"></div>
            <div 
            @touchstart="start" 
            @touchmove="move($event,'min')" 
            @touchend="end($event,'min')" 
            class="btn" :style="`left:${minleft}px`"></div>
            <div 
            @touchstart="start" 
            @touchmove="move($event,'max')" 
            @touchend="end($event,'max')" 
            class="btn max" :style="`right:${maxRight}px`"></div>
        </div>
    </div>
</template>
<script>
export default {
    mounted(){
        //获取外层div宽度 (手机尺寸)
        var PriceBox=document.getElementsByClassName('Price')[0]
        this.width=parseFloat(window.getComputedStyle(PriceBox).width)
        this.resetting()
    },
    data(){
        return{
            width:0, //总宽度
            barBox:[10,20,30,20,20,50,30,20,100,120,140,110,230,270,300,400,450,480,500,490,480,320,300,340,200,50,100,80,100,100,50,20,30,20,20,30,20,30,10,10,10,20,30,20,20,50,10,80,10,10],
            minleft:0,  //最小按钮的 left
            maxRight:0, //最大按钮的 right
            nowX:0,     //当前pageX
            minendX:0,  //最小按钮上次操作的外边距
            maxendX:0,  //最大按钮上次操作的外边距
            choose:[0,50], //控制柱状box的class的数组
        }
    },
    methods:{
        //修改柱状图颜色
        changeBox(){
            var box=document.querySelectorAll('[data-i]')
            for(var i=0;i<box.length;i++){
                var num=box[i].dataset.i
                //如果柱状条内的data-i在choose数组的区间内 去掉not
                if(num>=this.choose[0] && num<=this.choose[1]){
                    box[i].classList.remove('not')
                }else{
                    box[i].classList.add('not')
                }
            }
        },
        start(e){
            //手指触摸获取当前nowX
            this.nowX=e.targetTouches[0].pageX
        },
        move(e,prop){
            var minPrice=this.$store.getters.getsel.minPrice
            var maxPrice=this.$store.getters.getsel.maxPrice
            //获取移动的pageX位置
            var to=e.targetTouches[0].pageX
            //判断是哪个按钮
            if(prop=='min'){
                var get=this.minendX+(to-this.nowX)
            }else{
                var get=this.maxendX+(this.nowX-to)
            }
            //设定区间
            if(get<0){
                get=0
            }else if(get>249.5){
                get=249.5
            }
            //没有赋值时如果值大于250 return
            if(prop=='min'){
                if(get+this.maxRight>250) return;
                this.minleft=get
                var min=parseInt(5000/250*(this.minleft))
                this.$store.commit('priceChange',{minPrice:min,maxPrice:maxPrice})
                this.choose[0]=Math.floor(min/100)
            }else{
                if(get+this.minleft>250) return;
                this.maxRight=get
                var max=parseInt(5000-5000/250*(this.maxRight))
                this.$store.commit('priceChange',{maxPrice:max,minPrice:minPrice})
                this.choose[1]=Math.floor(max/100)
            }
            //调用修改柱状图函数
            this.changeBox()
        },
        //手指离开时记录当前距离
        end(e,prop){
            if(prop=="min"){
                this.minendX=this.minleft
            }else{
                this.maxendX=this.maxRight
            }
        },
        // 重置
        resetting(){
            var minPrice=this.$store.getters.getsel.minPrice
            var maxPrice=this.$store.getters.getsel.maxPrice
            //根据获得的价钱区间 重置data变量  (后期添加vuex准备↓)
            this.minleft=minPrice/20
            this.minendX=this.minleft
            this.maxRight=(5000-maxPrice)/20
            this.maxendX=this.maxRight
            this.choose=[Math.ceil(this.minleft/5),Math.ceil(50-this.maxRight/5)-1]
            this.changeBox()
        },
    },
    computed:{
        getminPrice(){
            return this.$store.getters.getsel.minPrice
        },
        getmaxPrice(){
            return this.$store.getters.getsel.maxPrice
        }
    },
    watch:{
        getminPrice(val){
            if(val==0){
                this.resetting()
            }
        },
        getmaxPrice(val){
            if(val==5000){
                this.resetting()
            }
        }
    }
}
</script>
<style scoped>
    .Price{
        width:300px;
        margin:0 auto;
        padding-bottom:50px;
    }
    .Price>.title{
        height:16px;
        text-align:left;
        margin-bottom:10px;
    }
    .title>span{
        font-size:16px;
        color:#484848;
        font-weight:bold;
    }
    .barChart{
        width:100%;
        height:66px;
        display:flex;
    }
    .bar{
        width:1.5%;
        background:#008489;
        margin:0 1px;
    }
    .bar.not{
        background:#ebebeb;
    }
    .slideBox{
        width:100%;
        height:6px;
        position:relative;
        background:#ebebeb;
    }
    .slider{
        height:6px;
        margin-top:2px;
        background:#008489;
        z-index:50;
    }
    .btn{
        width:32px;
        height:32px;
        border-radius: 50%;
        border:2px solid #008489;
        background:white;
        position:absolute;
        top:-16px;
        z-index:100;
    }
    .btn.max{
        z-index:105;
    }
</style>


