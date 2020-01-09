<template>
    <baidu-map 
    @click="openMap"
    @ready='handler' 
    :center="center" 
    :zoom="zoom" 
    class="bm-view" 
    ak="sRVM2um5hSNP4HABdVjDT90mHLYTm5n0"
    :dragging="false"
    :scroll-wheel-zoom="false"
    :double-click-zoom="false"
    :keyboard="false">
        <bm-marker :position="center" :dragging="true" animation="BMAP_ANIMATION_BOUNCE">
        </bm-marker>
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
            canChange:false
        }
    },
    methods:{
        handler ({BMap, map}) {
            this.center.lng = Number(this.accuracy)
            this.center.lat = Number(this.latitude)
            this.zoom = 15
            this.canChange=true
        },
        openMap(){
            this.$emit('openBtn',true)
        }
    },
    watch:{
        accuracy(val){
            if(this.canChange){
                this.center.lng=val
            }
        },
        latitude(val){
            if(this.canChange){
                this.center.lat=val
            }
        }
    }
}
</script>
<style scoped>
    .bm-view{
        width:90%;
        height:100px;
        margin:0 auto;
        margin-top:25px;
    }
</style>


