<template>
    <div class="myLogin">
        <div @click="login" class="reg-login">
            <span>注册/登录</span>    
            <img src="../../public/index/popup2.jpg" alt="">
        </div>
        <div class="lvxing">
            <p class="erji-title">旅程工具</p>
            <div class="lvxing-help">
                <div>
                    <img src="../../public/index/wenhao.png" alt="">
                    <p>获取帮助</p>
                </div>
                <div>
                    <img src="../../public/index/xinglixiang.png" alt="">
                    <p>行程计划</p>
                </div>
            </div>
        </div>
        <p class="erji-title fangdong">成为房东/体验达人</p>
        <div class="tiyan">
            <span>开始体验</span>
            <img src="../../public/index/youjiantou.png" alt="">
        </div>
    </div>
</template>
<script>
export default {
    methods:{
        login(){
            this.$router.push("/login");
        }
    }
}
</script>
<style scoped>
*{color: #484848}
.myLogin{
    width: 90%;
    margin:0 auto;
}
.tiyan,.reg-login{
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.reg-login{
    border-bottom: 1px solid #ccc;
    padding: 50px 0px 30px;
    font-size: 28px;
}
.reg-login>span{
    font-weight: 600;
}
.lvxing-help{
    display: flex;
    font-size: 14px;
}
.lvxing-help>div{
    margin:20px;
}
.lvxing-help>div p,.tiyan>span{
    color:#484848;
}
.lvxing{
    padding-top: 20px;
    border-bottom: 1px solid #ccc;
}
.erji-title{
    text-align: left;
    font-size: 20px;
    font-weight: 600;
}
.fangdong{
    margin-top:20px;
}
.tiyan{
    margin-top:20px;
}
.tiyan img{
    width:18px;
}
</style>

