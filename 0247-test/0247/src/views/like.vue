<template>
    <div class="like">
        <div class="likeTitle">
            <p class="bigTitle">心愿单</p>
            <p class="smTitle" v-show="listnum>0">{{listnum}}个心愿</p>
        </div>
        <loading v-if="$store.getters.getLoading"  :zIndex="5"></loading>
        <div v-else>
            <div v-show="listnum<=0" class="noLike">
                <p>轻点您喜欢的住宿和体验活动，为您的下一趟旅程做好准备</p>
                <div class="toRoomlist" @click="toRoomlist">查看推荐房源</div>
            </div>
            <div v-show="listnum>0" class="likeBox" v-for="(key,i) of list" :key="i" :data-rid="key.rid" @click="toDetail(key.rid)">
                <heart :rid="key.rid" :nowCheck="true" @closeThis="close"></heart>
                <div class="likePic">
                    <like-banner :image="image[i]" :bid="i"></like-banner>
                </div>
                <div class="detailBox">
                    <p class="smTitle">{{key.describ}}</p>
                    <p class="bigTitle">{{key.big_title}}</p>
                    <p class="price">￥{{key.price}}/晚</p>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import likeBanner from '../components/like/likeBanner.vue'
import heart from '../components/like/heart.vue'
import loading from '../components/loading.vue'
export default {
    components:{
        "like-banner":likeBanner,
        "heart":heart,
        "loading":loading
    },
    data(){
        return{
            list:[],
            listnum:0,
            image:[],
        }
    },
    created(){
        this.start()
    },
    methods:{
        // 开始请求
        start(){
            // 开始过渡
            this.$store.commit('loadingChange',true)
            this.axios.get(`like/like_sear`).then((result)=>{
                // 过渡结束
                setTimeout(()=>{
                    this.$store.commit('loadingChange',false)
                },500)
                let code=result.data.code
                if(code==-2){
                    this.$router.push("/login");
                }else if(code==1){
                    this.list=result.data.data
                    for(let key of this.list){
                        let img=key.image_list.split(',')
                        img.unshift(img[img.length-1])
                        img.push(img[1])
                        this.image.push(img)
                    }
                    this.listnum=this.list.length
                }else{
                    this.list=[]
                }
            })
        },
        close(rid){
            let box=document.querySelector(`[data-rid='${rid}']`)
            box.classList.add('close')  
            setTimeout(()=>{
                box.parentNode.removeChild(box);
                this.listnum--
            },410)
        },
        toDetail(rid){
            this.$router.push(`/roomDetail/${rid}`)
        },
        toRoomlist(){
            this.$router.push(`/roomList/北京`)
        }
    }
}
</script>
<style scoped>
    .noLike>p{
        line-height:20px;
    }
    .noLike>.toRoomlist{
        border:1px solid #ddd;
        float:right;
        width:40%;
        height:40px;
        line-height:40px;
        text-align:center;
        font-weight:800;
        border-radius: 5px;
        background:#008489;
        color:white;
        margin-top:20px; 
        letter-spacing:1px;
    }
    .noLike>.toRoomlist::before{
        clear:both;
    }
    .detailBox>.smTitle{
        color: #767676;
        font-size: 12px;
        font-weight: 800;
    }
    .detailBox>.bigTitle{
        width: 100%;
        font-size: 16px;
        /* font-weight: bold; */
        font-weight:500;
        color: #484848;
        line-height: 22px;
        padding-left: 5px;
        margin-bottom:3px;
    }
    .detailBox>.price{
        color:#008489;
        font-weight:600;
    }
    .like{
        width:80%;
        margin:0 auto;
        margin-top:30px;
        margin-bottom:80px;
    }
    .likeTitle{
        text-align: left;
        margin:10px 0;
        position:relative;
        z-index:100;
    }
    .bigTitle{
        font-size:22px;
        color:#484848;
        font-weight:bold;
    }
    .smTitle{
        color:#484848;
        margin-top:8px;
    }
    .likeBox{
        width:100%;
        position:relative;
        margin:0 auto;
        padding-bottom:20px;
        margin-bottom:20px;
        opacity: 1;
    }
    .likeBox.close{
        opacity: 0;
        transition: opacity .4s linear;
    }
    .like>.likeBox:not(:last-child){
        border-bottom:1px solid #ddd;
    }
    .likePic{
        width:100%;
        height:200px;
    }
    .detailBox{
        width:100%;
        box-sizing:border-box;
        margin-top:10px;
        text-align:left;
    }
    .noLike{
        text-align: left;
    }
</style>


