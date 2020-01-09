<template>
    <div>
        <div @click="bianjigeren" class="userName-Img">
            <div>
                <p v-if="$store.getters.getInfo.u_name!=''">{{$store.getters.getInfo.u_name}}</p>
                <p v-else>手机认证用户{{$store.getters.getInfo.phone.slice(7)}}</p >
                <p>查看并编辑个人资料</p>
            </div>
            <div class="touxiang">
                <img v-if="$store.getters.getInfo.avatar!=''" :src="$store.getters.getInfo.avatar" alt="">
                <img v-else src="../../../public/index/popup2.jpg" alt="">
            </div>
        </div>
        <div class="buchong" @click="bianjibitian">
            <div>
                <p>补充必填资料</p>
                <span>添加您的昵称,个人邮箱与头像,省去重复填写,预订房源更高效快捷</span>
                <div class="jindutiao">
                    <div class="jindutiao-in" :style="`width:${width}`">

                    </div>
                </div>
            </div>
            <img src="../../../public/index/youjiantou.png" alt="">
        </div>
        <div class="all-bottom">
            <div class="fangyuan">
                <p class="erji-title">我的房源订单</p>
                <div class="lvxing-help">
                    <div @click="toOrder('all')">
                        <img src="../../../public/index/allorder.png" alt="">
                        <p>全部订单</p>
                    </div>
                    <div @click="toOrder('valid')">
                        <img src="../../../public/index/youxiaoorder.png" alt="">
                        <p>有效订单</p>
                    </div>
                    <div @click="toOrder('noPay')">
                        <img src="../../../public/index/zhifuorder.png" alt="">
                        <p>待支付订单</p>
                    </div>
                </div>
            </div>

            <div class="fangyuan">
                <p class="erji-title">旅程工具</p>
                <div class="lvxing-help">
                    <div>
                        <img src="../../../public/index/wenhao.png" alt="">
                        <p>获取帮助</p>
                    </div>
                    <div>
                        <img src="../../../public/index/xinglixiang.png" alt="">
                        <p>安全中心</p>
                    </div>
                    <div @click="history">
                        <img src="../../../public/index/chanpin.png" alt="">
                        <p>历史足迹</p>
                    </div>
                </div>
            </div>
            <div class="fangyuan">
                <div class="logout" @click="logout">
                    退出登录
                </div>
            </div>

        </div>
        <!-- 编辑个人资料 -->
        <editgeren @edit="getEdit" :class="{isExsits:isEditgeren}"></editgeren>
        <!-- 编辑必填资料 -->
        <edit @son="getOn" :class="{isAlive:isEdit}"></edit>
    </div>
</template>
<script>
import Edit from './Edit.vue'
import Editgeren from './Editgeren.vue'
export default {
    data(){
        return {
            userInfo:{},
            isEdit:true,
            isEditgeren:true,
            jindulist:1,//进度条数组长度
            width:"20%",  //进度条宽度
            isOut:false, //是否退出登录
            isName:false, //监听昵称是否变化
            isEmail:false,//监听邮箱是否变化
            isIntro:false,//监听自我介绍是否变化
            isAvatar:false//监听头像是否变化
        }
    },
    mounted(){
        this.userInfo=this.$store.getters.getInfo;
        // 进度条
        if(this.userInfo.u_name!=""){
            this.isName=true;
            this.jindulist++;
        }
        if(this.userInfo.email!=""){
            this.isEmail=true;
            this.jindulist++;
        }
        if(this.userInfo.intro!=""){
            this.isIntro=true;
            this.jindulist++;
        }
        if(this.userInfo.avatar!=""){
            this.isAvatar=true;
            this.jindulist++;
        }
        this.width=`${this.jindulist*20}%`;
    },
    computed: {
        // getUserInfo
        info(){
            var info=this.$store.getters.getInfo;
            if(Object.keys(info).length>0){
                return info
            }
        },
        // 计算属性，vuex用来配合监听
        Uname(){
            return this.$store.getters.getInfo.u_name;
        },
        Email(){
            return this.$store.getters.getInfo.email;
        },
        Intro(){
            return this.$store.getters.getInfo.intro;
        },
        Avatar(){
            return this.$store.getters.getInfo.avatar;
        }
    },
    watch: {
        // info(val){
        //     this.userInfo=this.$store.getters.getInfo;
        // },
        Uname(val){
            if(!this.isOut){
                if(val!=""){
                    this.userInfo.u_name=val;
                    if(!this.isName){
                        this.isName=true;
                        this.jindulist++;
                    }
                }else{
                    this.isName=false;
                    this.userInfo.u_name="";
                    this.jindulist--;
                }
            }
        },
        Email(val){
            if(val!=""){
                if(!this.isEmail){
                    this.isEmail=true;
                    this.jindulist++;
                }
            }else{
                this.isEmail=false;
                this.jindulist--;
            }
        },
        Intro(val){
            if(val!=""){
                if(!this.isIntro){
                    this.isIntro=true;
                    this.jindulist++;
                }
            }else{
                this.isIntro=false;
                this.jindulist--;
            }
        },
        Avatar(val){
            if(!this.isOut){
                if(val!=""){
                    this.userInfo.avatar=val;
                    if(!this.isAvatar){
                        this.isAvatar=true;
                        this.jindulist++;
                    }
                }else{
                    this.isAvatar=false;
                    this.userInfo.avatar="";
                    this.jindulist--;
                }
            }
        },
        jindulist(){
            if(!this.isOut){
                this.width=`${this.jindulist*20}%`;
            }
        }
    },
    methods:{
        history(){//跳转浏览记录组件
            this.$router.push("/history");
        },
        toOrder(page){//跳转Order订单组件
            this.$store.commit('orderChange',page)
            this.$store.commit('homePageChange','tab3')
        },
        bianjigeren(){//编辑个人
            this.isEditgeren=false;
        },
        bianjibitian(){//编辑必填
            this.isEdit=false;
        },
        getOn(data){//编辑必填
            this.isEdit=data;
        },
        getEdit(data){//编辑个人
            this.isEditgeren=data;
        },
        logout(){//注销登录1223
            this.axios.get('index/logout').then(res=>{
                if(res.data.code==1){
                    this.isOut=true;
                    this.$router.go(0);
                    this.$store.commit('logOut');
                    sessionStorage.setItem('userInfo',JSON.stringify({}));
                }
            })
        }
    },
    components:{
        "edit":Edit,
        "editgeren":Editgeren
    }
}
</script>
<style scoped>
*{color:#484848;text-align: left;box-sizing: border-box;}
.isAlive{
    display: none;
}
.isExsits{
    display: none;
}
.userName-Img{
    width:90%;
    margin:0 auto;
    padding:50px 0px 20px;
}
.userName-Img>div>p:first-child{
    font-size: 24px;
}
.userName-Img>div>p:last-child,.tiyan,.tiyan>span{
    color:#008489;
}
.userName-Img>div>p:last-child{
    margin-top:5px;
}
.touxiang{
    width:80px;
    height:80px;
    border-radius:50%;
    overflow: hidden;
    box-shadow: rgba(0,0,0,0.01) 0px 1px 2px,rgba(0,0,0,0.12) 0px 3px 18px;
    /* background:#008489; */
}
.touxiang>img{
    width:100%;
    height:100%;
}
.buchong,.tiyan,.lvxing-help,.userName-Img{
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.buchong{
    width:92%;
    margin:0 auto;
    padding:20px;
    border-radius:5px;
    box-shadow: rgba(0,0,0,0.01) 0px 1px 2px,rgba(0,0,0,0.12) 0px 3px 18px;
    line-height: 20px;
}
.buchong>img{
    margin-left: 5px;
}
.buchong p,.userName-Img>div>p:first-child{
    font-weight: 600;
}
.buchong span,.lvxing-help,.tiyan{
    font-size: 14px;
}
.jindutiao{
    height:5px;
    margin-top:5px; 
    background:#ccc;
    border-radius:5px;
    position: relative;
}
.jindutiao-in{
    position:absolute;
    height:5px;
    top:0;
    left:0;
    border-radius: 5px;
    background:orange;
    transition: width 0.5s linear;
}
.erji-title{
    text-align: left;
    font-size: 18px;
    font-weight: 600;
}
.all-bottom{
    width: 90%;
    margin:20px auto 70px;
}
.fangyuan{
    padding-top: 20px;
    border-top: 1px solid #ccc;
}
.lvxing-help{
    flex-wrap: wrap;
    justify-content: space-around;
}
.lvxing-help>div{
    text-align: center;
    margin:20px;
}
.lvxing-help>div p{
    margin-top:5px;
}
.logout{
    text-align: center;
    background:#008489;
    color:#fff;
    padding:10px 0px;
    font-size: 20px;
    border-radius: 3px;
}
</style>
