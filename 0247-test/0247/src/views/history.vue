<template>
    <div class="his">
        <div class="title">
            <img @click="goback" src="../../public/index/fanhui.png" alt="">
        </div>
        <div class="load-more-wrapper" @touchstart="touchStart($event)" @touchend="touchEnd($event)">
            <div class="inner">
                <div class="history">
                <p>历史足迹</p>
                <p>房源浏览历史</p>
                <div v-for="(elem,i) of list" :key="i" class="history-list" @click="jump(elem.rid)">
                    <div class="history-img">
                        <img :src="elem.image_list.split(',')[0]" alt="">
                    </div>
                    <div class="history-text">
                        <p>{{elem.describ}}</p>
                        <p>{{elem.big_title}}</p>
                        <p>￥{{elem.price}} <span>每晚</span></p>
                    </div>
                </div>
                <!-- <button @click="loadMore">加载更多</button> -->
            </div>
                <div v-if="isHistory">
                    <div class="load-more" v-show="enableLoadMore">{{loadMoreText}}</div>  
                    <div class="load-end" v-show="!enableLoadMore">我是有底线的!</div>  
                </div>
                <div v-else class="isfailed">您还没有浏览记录，快去看看吧</div>
            </div>
        </div>

            
    </div>
</template>
<script>

export default {
    data() {
        return {
            historySearch:[],
            list:[],
            // pno:0,
            enableLoadMore: true,

            loadMoreText: "上拉加载更多",
            startX: 0,
            startY: 0,
            isLoading: false,
            isHistory:false,   //判断是否有历史记录
            listSearch:[]   //请求后台的数组
        }
    },
    created() {
        if(localStorage.getItem("keyHistory")!=null){
            // localStorage.removeItem('keyHistory');
            this.historySearch=JSON.parse(localStorage.getItem("keyHistory"));
            for(var i=0;i<this.historySearch.length;i++){
                this.historySearch[i]=parseFloat(this.historySearch[i])
            }
            this.isHistory=true;
        }else{
            this.isHistory=false;
        }
            this.onLoadMore();
        
    },
    methods: {
        goback(){
            this.$router.go(-1);
            this.$store.commit("homePageChange","tab4");
        },
        getHistory(){
            this.axios.get("/index/record",{
                params:{
                    rids:JSON.stringify(this.listSearch)
                }
            }).then(result=>{
                if(result.data.data && result.data.data.length>0){
                    this.list=this.list.concat(result.data.data);
                    // this.pno++;
                    if(result.data.data.length<4){
                        this.enableLoadMore = false;
                    }
                    this.isLoading = false;
                    this.loadMoreText = '上拉加载更多'
                }else{
                    this.enableLoadMore = false;
                }
            })
        },
        onLoadMore(){//加载更多
            if(this.isHistory){
                setTimeout(()=>{
                    if(!this.enableLoadMore) {
                        return
                    }
                    this.listSearch=[];
                    if(this.historySearch.length>=4){
                        this.listSearch=this.historySearch.splice(0,4);
                        this.getHistory();
                    }else{
                        if(this.historySearch.length>0){
                            this.listSearch=this.historySearch;
                            // this.historySearch.splice(0);
                            this.getHistory();
                        }else{
                            this.enableLoadMore = false;
                        }
                    }
                    
                }, 300)
            }
        },
        jump(rid){
            this.$router.push("/roomDetail/" + rid);
        },
        touchStart(e) {
            this.startY = e.targetTouches[0].pageY;  //触摸目标在页面中的y坐标
            this.startX = e.targetTouches[0].pageX;  //触摸目标在页面中的x坐标
        },
        scrollToEnd(e) {
            var scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop; 
            // 屏幕的高度
            var screenHight=document.documentElement.clientHeight || document.body.clientHeight;
            // 文档的总高度
            if(document.querySelector(".his")){
                var all=document.querySelector(".his").scrollHeight;
            }

            if(scrollTop+screenHight>=all){
                this.doLoadMore()
            }
        },
        touchEnd(e) {
            if (this.isLoading) {
                return;
            }

            let endX = e.changedTouches[0].pageX,//触摸目标在页面中的x坐标
                endY = e.changedTouches[0].pageY,//触摸目标在页面中的y坐标
                dy = this.startY - endY,
                dx = endX - this.startX;
            if(Math.abs(dx) < 5 && Math.abs(dy) < 5) {//返回dx的绝对值，滑动小于5px不加载
                return;
            }
            if (endY < this.startY) {
                this.scrollToEnd(e)
            }
        },
        doLoadMore() {
            this.isLoading = true
            this.loadMoreText = '加载中...'
            this.onLoadMore();
        },
    },
}
</script>
<style scoped>

.load-more-wrapper {
    height: 100%;
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
    transition-duration: 300ms;
}
.load-more, .load-end {
    color: #aea699;
    font-size: .26rem;
    margin: .3rem 0;
    text-align: center;
}
.isfailed{
    margin-top:20px;
}

.title{
    width:100%;
    height:50px;
    position: fixed;
    background: #fff;
    top:0;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding:0 10px;
}
.history{
    width:90%;
    margin:0 auto;
    margin-top:80px;
    text-align: left;
}
.history>p:first-child{
    font-size: 32px;
    font-weight: 600;
}
.history>p+p{
    margin-top:30px;
}
.history-list{
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #ccc;
    padding: 20px 0px;
}
.history-img{
    width:30%;
    height:80px;
    border-radius: 5px;
    overflow: hidden;
}
.history-img img{
    width:100%;
    height:100%;
}
.history-text{
    width:65%;
    margin-left: 10px;
}
.history-text>p{
    overflow:hidden; /*溢出的部分隐藏*/
    white-space: nowrap; /*文本不换行*/
    text-overflow:ellipsis;
    margin-bottom:10px;
}
.history-text>p:first-child,.history-text span{
    color:#aaa;
}
.history-text>p:not(:first-child){
    color:#000;
    font-weight: bold;
}
.history-text>p:last-child{
    color:#008489;
}
.history-text span{
    font-size: 12px;
}
</style>
