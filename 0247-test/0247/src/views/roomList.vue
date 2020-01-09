<template>
    <div>
        <Select @foc="foc"></Select>
        <search-inside @son="getOn" :class="{inside:isInside}"></search-inside>
        <!-- loading -->
        <loading v-if="$store.getters.getLoading" :zIndex="5"></loading>
        <div v-else>
            <div v-if="list.length>0" class="listBody">
                <div @click="toDetailPage(key.rid)" class="roomList" v-for="(key,i) of list" :key="i" :data-rid="key.rid">
                    <heart :rid="key.rid" :nowCheck="key.isLike"></heart>
                    <sm-banner  :Switch="true" :rid="i" :image="image[i]" :smbtn="image[i].slice(1,image[i].length-1)"></sm-banner>
                    <div class="room-details">
                        <p class="gray">{{key.describ}}</p>
                        <p class="title"> {{key.big_title}}</p>
                        <roomlist-detail :toDetail="list[i]" :normal="list[i].room_advantage"></roomlist-detail>
                    </div>
                    <div class="footBox">
                        <span class="priceBox">
                            <span>￥{{key.price}}</span>
                            <span class="beforePrice">{{parseInt(key.price/0.8)}}</span>
                            <span class="even">每晚</span>
                        </span>
                        <div></div>
                    </div>
                    <div class="headPhoto">
                        <img :src="key.avatar==''?require(`../../public/index/popup1.jpg`):key.avatar" alt="">
                    </div>
                </div>
            </div>
            <div v-else class="noSearch">
                <div class="noBox">
                    <p class="title">没有结果</p>
                    <div class="detail">可以试着调整您的搜索范围，比如更改入住日期、删除筛选条件或调整价格范围。</div>
                    <div class="btn" @click="delSearch">删除所有筛选条件</div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import smBanner from '../components/smBanner.vue'
import roomlistDetail from '../components/roomlist/roomList_detail.vue'
import Select from '../components/roomlist/select.vue'
import SearchInside from '../components/search-inside.vue'
import loading from '../components/loading.vue'
import heart from '../components/like/heart.vue'
export default {
    components:{
        'sm-banner':smBanner,
        'roomlist-detail':roomlistDetail,
        "Select":Select,
        "searchInside":SearchInside,
        "loading":loading,
        "heart":heart,
    },
    data(){
        return {
            list:[],
            image:[],
            city:"",
            isInside:true,
        }
    },
    // 将图片链接转化数组
    created(){
        var roomlist=this.$store.getters.getRoomlist
        this.city=this.$route.path.split('/')[2]
        this.$store.commit('searchChange',this.city)
        var sel=this.$store.getters.getsel
        // 开始过渡
        this.$store.commit('loadingChange',true)
        this.axios.get('/index/condition',{
            params:{
                search:sel.search,
                date:sel.date,
                man:sel.man,
                child:sel.child,
                little:sel.little,
                minPrice:sel.minPrice,
                maxPrice:sel.maxPrice,
                roomType:sel.roomType,
                count:sel.count
            }
        }).then(res=>{
            var get=[]
            if(res.data.code!=-1){
                get=res.data.msg
            }
            this.$store.commit('roomListChange',get)
            // 过渡结束
            this.$store.commit('loadingChange',false)
        })
    },
    mounted(){
        window.scrollTo(0,0)
    },
    methods:{
        // 添加进喜欢列表
        tolike(e,rid){
            var isLike;
            if(e.target.nodeName=='svg'){
                isLike=e.target.parentElement.dataset.islike
            }else{
                isLike=e.target.dataset.islike
            }
            if(isLike==1){
                this.axios.get('like/like_add',{
                    params:{
                        rid
                    }
                }).then(res=>{
                    console.log(res)
                })
            }
        },
        delSearch(){
            this.$store.commit('delSearch')
            var sel=this.$store.getters.getsel
            this.axios.get('/index/condition',{
                params:{
                    search:sel.search,
                    date:sel.date,
                    man:sel.man,
                    child:sel.child,
                    little:sel.little,
                    minPrice:sel.minPrice,
                    maxPrice:sel.maxPrice,
                    roomType:sel.roomType,
                    count:sel.count
                }
            }).then(res=>{
                var get=[]
                if(res.data.code!=-1){
                    get=res.data.msg 
                }
                this.$store.commit('roomListChange',get)
            })
            //******************** */
            this.bus.$emit("clearDate")
        },
        //跳转详情页面
        toDetailPage(a){
            this.$router.push("/roomDetail/" + a);
        },
        getOn(data){
            this.isInside=data;
        },
        foc(data){
            this.isInside=data;
        }
    },
    computed:{
        getVuex(){
            return this.$store.getters.getRoomlist
        },
        getCity(){
            return this.$store.getters.getsel.search
        }
    },
    watch:{
        getVuex(val){
            if(val.length>0){
                this.image=[]
                this.list=val
                for(var key of this.list){
                    var img=key.image_list.split(',')
                    img.unshift(img[img.length-1])
                    img.push(img[1])
                    this.image.push(img)
                }
            }else{
                this.list=[]
            }
        },
        getCity(val){
            var sel=this.$store.getters.getsel
            this.$store.commit('searchChange',val)
            // 开始过渡
            this.$store.commit('loadingChange',true)
            this.axios.get('/index/condition',{
                params:{
                    search:sel.search,
                    date:sel.date,
                    man:sel.man,
                    child:sel.child,
                    little:sel.little,
                    minPrice:sel.minPrice,
                    maxPrice:sel.maxPrice,
                    roomType:sel.roomType,
                    count:sel.count
                }
            }).then(res=>{
                var get=[]
                if(res.data.code!=-1){
                    get=res.data.msg
                }
                this.$store.commit('roomListChange',get)
                // 过渡结束
                setTimeout(()=>{
                    this.$store.commit('loadingChange',false)
                },500)
            })
        }
    }
}
</script>
<style scoped>
    .tolike{
        position:absolute;
        top:10px;
        right:20px;
        z-index:5;
    }
    .noSearch>.noBox{
        width:80%;
        text-align:left;
        margin:0 auto;
        padding:20px 0;
        border-bottom:1px solid #ddd;
    }
    .noBox>.title{
        font-size:24px;
        color:#484848;
        font-weight:bold;
    }
    .noBox>.detail{
        font-size:14px;
        color:#484848;
        padding:10px 0;
    }
    .noBox>.btn{
        width:40%;
        height:35px;
        background:#008489;
        color:white;
        padding:6px 15px;
        font-size:14px;
        font-weight:bold;
        line-height:35px;
        /* box-sizing: border-box; */
        text-align:center;
        border-radius: 5px;
    }
    .headPhoto{
        position:absolute;
        width:44px;
        height:44px;
        border:2px solid white;
        border-radius: 50%;
        overflow: hidden;
        background:#eee;
        top:180px;
        right:20px;
    }
    .headPhoto>img{
        width:44px;
        height:44px;
    }
    .inside{
        display:none;
    }
    .listBody,.noSearch{
        margin-top:170px;
    }
    .roomList{
        width:85%;
        /* height:430px; */
        box-sizing:border-box;
        padding:4px;
        border-radius: 16px;
        background:#fff;
        margin:0 auto;
        box-shadow: 0 6px 30px rgba(0, 0, 0, 0.15);
        margin-bottom:16px;
        position:relative;
    }
    .room-details{
        width:100%;
        /* height:108px; */
        box-sizing: border-box;
        padding:16px 16px 8px 16px;
        text-align: left;
        border-bottom:1px solid #EBEBEB;
    }
    .room-details>.gray{
        color:#767676;
        font-size:12px;
        font-weight: 800;
    }
    .room-details>.title{
        text-overflow:ellipsis;
        width:100%;
        height:22px;
        overflow: hidden;
        white-space: nowrap;
        font-size:16px;
        font-weight: bold;
        color:#484848;
        line-height:22px;
        padding-left:5px;
        margin-bottom:8px;
    }
    .footBox{
        padding:16px;
        display:flex;
        justify-content: space-between;
    }
    .footBox>.priceBox{
        font-size:16px;
        font-weight: bold;
        color:#484848;
        text-align: left;
        display:flex;
        line-height:16px;
    }
    .beforePrice{
        color:#c4c4c4;
        text-decoration: line-through;
        margin-left:3px;
    }
    .footBox>.priceBox>.even{
        display:block;
        height:16px;
        font-size:12px;
        font-weight:500;
        line-height:18px;
        margin-left:10px;
    }
</style>


