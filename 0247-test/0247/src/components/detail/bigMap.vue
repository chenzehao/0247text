<template>
    <baidu-map :style="`height:${height}px`"
    @ready='handler' 
    :center="center" 
    :zoom="zoom" 
    class="bm-view" 
    ak="sRVM2um5hSNP4HABdVjDT90mHLYTm5n0"
    :scroll-wheel-zoom="true">
        <!-- 比例尺 -->
        <bm-scale anchor="BMAP_ANCHOR_TOP_RIGHT"></bm-scale>
        <!-- 定位 -->
        <bm-geolocation anchor="BMAP_ANCHOR_BOTTOM_RIGHT" :showAddressBar="true" :autoLocation="true"></bm-geolocation>
        <!-- 点 -->
        <bm-marker :position="center" :dragging="true" animation="BMAP_ANIMATION_BOUNCE">
        </bm-marker>
        <!-- 左上角退出 -->
        <div class="exit" @click="exit">X</div>
    </baidu-map>
</template>
<script>
export default {
    props:{
        accuracy:{type:String},
        latitude:{type:String}
    },
    data(){
        return{
            center:{lng:0,lat:0},
            zoom:3,
            height:0,
        }
    },
    methods:{
        handler ({BMap, map}) {
            this.center.lng = Number(this.accuracy)
            this.center.lat = Number(this.latitude)
            this.zoom = 15
        },
        exit(){
            this.$emit('closeMap',false)
        }
    },
    mounted(){
        this.height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
    }
}
</script>
<style scoped>
    .bm-view{
        width:100%;
        /* height:650px; */
        position:fixed;
        top:0;
        z-index: 2000;
    }
    .exit{
        position:absolute;
        top:10px;
        left:10px;
        background:rgba(0,0,0,0.5);
        color:white;
        width:40px;
        height:40px;
        text-align:center;
        line-height:40px;
        border-radius: 50%;
    }
</style>


