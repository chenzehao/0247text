<template>
    <div class="editgeren">
        <div class="title">
            <img @click="goback" src="../../../public/index/fanhui.png" alt="">
            <span>编辑个人资料</span>
            <span>保</span>
        </div>
        <div class="geren">
            <div class="Uname-Img">
                <div class="touxiang-geren" @click="tanchuang">
                    <img v-if="this.$store.getters.getInfo.avatar!=''" :src="this.$store.getters.getInfo.avatar" alt="">
                    <img v-else src="../../../public/index/popup2.jpg" alt="">
                </div>
                <div>
                    <p v-if="this.$store.getters.getInfo.u_name!=''" @click="tanchuang">{{this.$store.getters.getInfo.u_name}}</p>
                    <p v-else @click="tanchuang">手机认证用户{{this.$store.getters.getInfo.phone.slice(7)}}</p>
                </div>
            </div>
            <p class="person">个人信息</p>
            <p>完善的个人信息有助于获取房东的信任</p>
            <div class="bottom-message">
                <div class="message" @click="showSex=true">
                    <span>性别</span>
                    <span v-if="sexValue==''">选择你的性别 ></span>
                    <span v-else>{{sexValue}}</span>
                </div>
                <div class="message" @click="showAge=true">
                    <span>年龄</span>
                    <span v-if="ageValue==''">选择你的年龄 ></span>
                    <span v-else>{{ageValue}}岁</span>
                </div>
                <div class="message" @click="homecityVisible=true">
                    <span>家乡</span>
                    <span v-if="home==''">选择你的家乡 ></span>
                    <span v-else>{{home}}</span>
                    <!-- <span v-if="HomeProvince==''">选择你的家乡 ></span> -->
                    <!-- <span v-else>{{HomeProvince}}-{{HomeCity}}</span> -->
                </div>
                <div class="message" @click="cityVisible=true">
                    <span>所在城市</span>
                    <span v-if="staycity==''">选择你常待的城市 ></span>
                    <span v-else>{{staycity}}</span>
                    <!-- <span v-if="Province==''">选择你常待的城市 ></span>
                    <span v-else>{{Province}}-{{City}}</span> -->
                </div>
                <div class="message" @click="showEducation=true">
                    <span>教育</span>
                    <span v-if="educationValue==''">选择你的教育背景 ></span>
                    <span v-else>{{educationValue}}</span>
                </div>
                <div class="message" @click="showIndustry=true">
                    <span>行业</span>
                    <span v-if="industryValue==''">选择你工作的行业 ></span>
                    <span v-else>{{industryValue}}</span>
                </div>
            </div>
                <div class="saveEditgeren" @click="saveEdit">保存修改</div>
        </div>
        <!-- 性别弹出框 -->
        <van-popup v-model="showSex" position="bottom">
        <van-picker
            show-toolbar
            :columns="sex"
            @cancel="showSex = false"
            @confirm="sexConfirm"
        />
        </van-popup>
        <!-- 年龄弹出框 -->
        <van-popup v-model="showAge" position="bottom">
        <van-picker
            show-toolbar
            :columns="age"
            @cancel="showAge = false"
            @confirm="ageConfirm"
        />
        </van-popup>
        <!-- 教育弹出框 -->
        <van-popup v-model="showEducation" position="bottom">
        <van-picker
            show-toolbar
            :columns="education"
            @cancel="showEducation = false"
            @confirm="educationConfirm"
        />
        </van-popup>
        <!-- 行业弹出框 -->
        <van-popup v-model="showIndustry" position="bottom">
        <van-picker
            show-toolbar
            :columns="industry"
            @cancel="showIndustry = false"
            @confirm="industryConfirm"
        />
        </van-popup>
        <!-- 家乡城市二级联动 -->
        <van-popup v-model="homecityVisible" position="bottom">
        <van-picker
            show-toolbar
            :columns="citys"
            @cancel="homecityVisible = false"
            @confirm="homecityConfirm"
            @change="onChange"
        />
        </van-popup>
        <!-- 城市二级联动 -->
        <van-popup v-model="cityVisible" position="bottom">
        <van-picker
            show-toolbar
            :columns="citys"
            @cancel="cityVisible = false"
            @confirm="cityConfirm"
            @change="onChange"
        />
        </van-popup>
    </div>
</template>
<script>
import myaddress from '../../assets/address.json' //引入省市区数据
export default {
    data(){
        return {
            userInfo:{},
            // 性别
            sexValue:"",
            showSex:false,
            sex:["男","女"],
            // 年龄
            ageValue:"",
            showAge:false,
            age:[],
            // 教育
            educationValue:"",
            showEducation:false,
            education:["博士","硕士","本科","大专","高中","其他"],
            // 行业
            industryValue:"",
            showIndustry:false,
            industry:["计算机/互联网/通讯/电子","会计/金融/银行/保险","贸易/消费/制造/营运","制药/医疗","广告/媒体","房地产/建筑","教育/培训","服务业","物流/运输","能源/原材料","政府/非盈利机构","其他"],

            // 家乡
            homecityVisible:false,
            HomeProvince:"",
            HomeCity:"",

            // 城市
            cityVisible:false,
            Province:"",
            City:"",
            citys: [
                {
                values: Object.keys(myaddress), //省份数组
                className: 'slot1'
                },
                {
                values: myaddress['北京市'],
                className: 'slot2'
                }
            ],
            // 
            home:"",
            staycity:""
        }
    },
    created(){
        this.break()
    },
    mounted() {
        for(var i=18;i<=50;i++){
            this.age.push(i);
        }
        this.break()
    },
    methods: {
        sexConfirm(value){
            this.sexValue = value;
            this.showSex = false;
        },
        ageConfirm(value){
            this.ageValue=value;
            this.showAge=false;
        },
        educationConfirm(value){
            this.educationValue=value;
            this.showEducation=false;
        },
        industryConfirm(value){
            this.industryValue=value;
            this.showIndustry=false;
        },
        homecityConfirm(value){
            this.HomeProvince=value[0];
            this.HomeCity=value[1];
            this.homecityVisible=false;
            this.home=this.HomeProvince+"-"+this.HomeCity;
        },
        cityConfirm(value){
            this.Province=value[0];
            this.City=value[1];
            this.cityVisible=false;
            this.staycity=this.Province+"-"+this.City;
        },
        onChange(picker, values) {
            picker.setColumnValues(1, myaddress[values[0]]);
        },
        tanchuang(){
            this.$toast("头像和昵称请到补充必填资料中修改");
        },
        goback(){
            this.$emit('edit',true);
            this.sexValue=this.userInfo.sex==1?"男":"女";
            this.ageValue=this.userInfo.age;
            this.home=this.userInfo.home;
            this.staycity=this.userInfo.city;
            this.educationValue=this.userInfo.education;
            this.industryValue=this.userInfo.industry;
        },
        // 刷新数据
        break(){
            this.userInfo=this.$store.getters.getInfo;
            this.sexValue=this.userInfo.sex==1?"男":"女";
            this.ageValue=this.userInfo.age;
            this.home=this.userInfo.home;
            this.staycity=this.userInfo.city;
            this.educationValue=this.userInfo.education;
            this.industryValue=this.userInfo.industry;
        },
        saveEdit(){//保存修改
            var sexV=1;
            if(this.sexValue=="男"){
                sexV=1;
            }else{
                sexV=0;
            }
            var obj={
                uid:this.userInfo.uid,
                u_name:this.userInfo.u_name,
                email:this.userInfo.email,
                intro:this.userInfo.intro,
                phone:this.userInfo.phone,
                avatar:this.userInfo.avatar,
                age:this.ageValue+"",
                sex:sexV,
                home:this.home,
                city:this.staycity,
                education:this.educationValue,
                industry:this.industryValue
            }
            this.axios.get("/index/updUser",{params:obj}).then(result=>{
                if(result.data.code==1){
                    this.$store.commit('userChange',obj);
                    var str=JSON.stringify(obj);
                    sessionStorage.setItem('userInfo',str);
                    this.$emit('edit',true);
                    this.break()
                }
            })
        }
    },
    computed:{
        getUserInfo(){
            var userInfo = this.$store.getters.getInfo
            if(Object.keys(userInfo).length>0){
                return userInfo
            }
        }
    },
    watch:{
        getUserInfo(val){
            this.break()
        }
    }
}
</script>
<style scoped>
*{color:#484848;box-sizing: border-box;}
.Uname-Img{
    display: flex;
    justify-content: start;
    align-items: center;
    padding:20px 0px 20px;
}
.Uname-Img>div>p{
    color:#000;
    font-size: 20px;
    /* font-weight: bold; */
}
.touxiang-geren{
    width:70px;
    height:70px;
    border-radius:50%;
    overflow: hidden;
    margin-right: 30px;
    box-shadow: rgba(0,0,0,0.01) 0px 1px 2px,rgba(0,0,0,0.12) 0px 3px 18px;
}
.touxiang-geren>img{
    width:100%;
    height:100%;
}
.editgeren{
    width:100%;
    height:100%;
    position:fixed;
    background: #fff;
    top:0;
    z-index: 1000;
}
.title{
    width:100%;
    height:50px;
    position: fixed;
    top:0;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding:0 10px;
}
.title>span{
    font-weight: 600;
    font-size: 20px;
}
.title>span+span{
    opacity: 0;
}
.geren{
    width:90%;
    margin:0 auto;
    margin-top:60px;
}
.geren .person{
    color:#000;
    font-weight: 600;
    margin-bottom: 3px;
}
.geren>p+p{
    font-size: 14px;
    margin-bottom: 30px;
}
.message{
    display: flex;
    justify-content: space-between;
    align-items: center;
    line-height: 3;
    border-bottom: 1px solid #ccc;
}
.message>span+span{
    color:#aaa;
}
.bottom-message{
    box-shadow: rgba(0,0,0,0.01) 0px 1px 2px,rgba(0,0,0,0.12) 0px 3px 18px;
    padding:5px 8px 3px;
}
.saveEditgeren{
    width: 80%;
    margin:30px auto;
    color:#fff;
    background:#0aa1ed;
    text-align: center;
    padding:10px;
    border-radius:5px;
}
</style>
