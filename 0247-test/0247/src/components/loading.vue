<template>
    <div class="loading" :style="`height:${height}px;z-index:${zIndex}`">
        <img :style="`margin-top:${height/2-60}px`" src="../../public/image/loading/loading.gif" alt="">
    </div>
</template>
<script>
export default {
    props:['zIndex'],
    created(){
        this.height=document.documentElement.clientHeight
    },
    data(){
        return{
            height:0,
        }
    }
}
</script>
<style>
    .loading{
        width:100%;
        position:absolute;
        z-index:5;
        background:white;
    }
    .loading>img{
        width:60px;
    }
</style>