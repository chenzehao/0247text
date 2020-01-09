<template>
    <div>
        <div @click="search" class="search">
            <div class="search-img">
                <!-- <img src="../../../public/index/search.png" alt=""> -->
                <svg viewBox="0 0 16 16" role="presentation" aria-hidden="true" focusable="false" style="height:16px;width:16px;display:block;fill:#484848"><path d="m2.5 7c0-2.5 2-4.5 4.5-4.5s4.5 2 4.5 4.5-2 4.5-4.5 4.5-4.5-2-4.5-4.5m13.1 6.9-2.8-2.9c.7-1.1 1.2-2.5 1.2-4 0-3.9-3.1-7-7-7s-7 3.1-7 7 3.1 7 7 7c1.5 0 2.9-.5 4-1.2l2.9 2.8c.2.3.5.4.9.4.3 0 .6-.1.8-.4.5-.5.5-1.2 0-1.7"></path></svg>
            </div>
            <div class="search-text">搜「北京」试试</div>
        </div>
        <!-- 上方固定搜索框 -->
        <div @click="search" class="search-bar" :class="{inside:isAlive}">
            <div class="search-bar-item">
                <div class="search-bar-item-in">
                    <div class="search-bar-item-in-img">
                        <svg viewBox="0 0 16 16" role="presentation" aria-hidden="true" focusable="false" style="height:16px;width:16px;display:block;fill:#484848"><path d="m2.5 7c0-2.5 2-4.5 4.5-4.5s4.5 2 4.5 4.5-2 4.5-4.5 4.5-4.5-2-4.5-4.5m13.1 6.9-2.8-2.9c.7-1.1 1.2-2.5 1.2-4 0-3.9-3.1-7-7-7s-7 3.1-7 7 3.1 7 7 7c1.5 0 2.9-.5 4-1.2l2.9 2.8c.2.3.5.4.9.4.3 0 .6-.1.8-.4.5-.5.5-1.2 0-1.7"></path></svg>
                    </div>
                    <div class="search-bar-item-in-text">搜「北京」试试</div>
                </div>
            </div>
        </div>
        <search-inside @son="getOn" a="1" :class="{inside:isInside}"></search-inside>
    </div>

</template>
<script>
import SearchInside from '../search-inside.vue'
export default {
    data(){
        return {
            isInside:true,
            isAlive:true
        }
    },
    created(){
        var scrollTop=0;
    },
    mounted(){
        // 添加监听手指滑动事件
        window.addEventListener('scroll', this.handleScroll);
    },
    methods:{
        search(){
            this.isInside=false;
            this.$store.commit('searchChange','')
        },
        getOn(data){
            this.isInside=data;
        },
         handleScroll () {
            // 距离顶部的距离
            var scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop; 
            if(scrollTop>160){
                this.isAlive=false;
            }else{
                this.isAlive=true;
            }
        }
    },
    components:{
        searchInside:SearchInside
    },
    destroyed () {
        // 销毁事件，不然会报错
        window.removeEventListener('scroll', this.handleScroll)
  }
}
</script>
<style scoped>
*{box-sizing: border-box;}
.search-bar,.search-bar-item-in{
    box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.01), 0px 3px 18px rgba(0, 0, 0, 0.12);
    background-color: #FFF;
}
.search-bar{
    position: fixed;
    top: 0px;
    left: 0px;
    right: 0px;
    height: 86px;
    z-index:2000;
}
.search-bar-item{
    position: fixed;
    padding-top: 17px;
    left: 24px;
    right: 24px;
    z-index: 2000;
}
.search-bar-item-in,.search-text{
    line-height: 48px;
    padding-left: 48px;
}
.search-bar-item-in{
    border-radius: 3px;
    height: 48px;
    position: relative;
}
.search-bar-item-in-img,.search-img{
    position: absolute;
    top: 50%;
    left: 16px;
    margin-top: -8px;
}
.search-text,.search-bar-item-in-text{
    color:#bcbcbc;
    text-align:left;
}
.search-bar-item-in-text{
    background-color: transparent;
    border: 0px;
    width: 100%;
    font-size: 16px;
    margin-left: -8px;
}
.search{
    /* width: 80%; */
    height:48px;
    background-color: #fff;
    position: absolute;
    left:24px;
    right:24px;
    top:160px;
    border-radius: 4px;
    box-shadow: 0 6px 30px rgba(0, 0, 0, 0.15);
}
.inside{
    display:none;
}
</style>

