<template>
    <div class="index">
        <banner :width="width"></banner>
        <!-- <popup class="login" :isIndex="true"></popup> -->
        <search></search>
        <area1></area1>
        <prot></prot>
        <foot></foot>
    </div>
</template>
<script>
import Banner from '../components/index/banner.vue'
import Foot from '../components/index/foot.vue'
import Prot from '../components/index/prot.vue'
import Popup from '../components/Popup.vue'
import search from "../components/index/search.vue"
import Area1 from '../components/area.vue'
export default {
    props:['width'],
    components:{
        "banner":Banner,
        "foot":Foot,
        "prot":Prot,
        "popup":Popup,
        "search":search,
        "area1":Area1,
    }
}
</script>
<style scpoed>
    *{
        margin: 0;padding:0;
    }
    .index{
        position: relative;
        width:100%;
    }
    .index>.login{
        position: absolute;
        top:0;right:0;
    }
</style>


