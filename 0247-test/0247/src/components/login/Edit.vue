<template>
    <div class="edit">
        <div class="title">
            <img @click="goback" src="../../../public/index/fanhui.png" alt="">
            <span>编辑必填资料</span>
            <span>保</span>
        </div>
        <div class="touxiang">
            <!-- accept="image/*"表示不限制格式 -->
            <img v-if="avatar!=''" :src="avatar" accept="image/*">
            <img v-else src="../../../public/index/touxiangchange.png" accept="image/*">
            <input type="file" @change="changeAvatar" name="mypic" ref="fileUpload">
        </div>
        <div class="edit-uname">点击图片更换头像</div>
        <div class="edit-uname">
            编辑个人资料
        </div>
        <div class="personal">
            <div @click="niechen">
                <span>昵称</span>
                <span>{{u_name}}</span>
            </div>
            <div @click="myphone">
                <span>电话</span>
                <span>{{phone}}</span>
            </div>
            <div @click="myemail">
                <span>电子邮箱</span>
                <span>{{email}}</span>
            </div>
            <div @click="myintro">
                <span>自我介绍</span>
                <span>{{intro}}</span>
            </div>
        </div>
        <div class="saveEdit" @click="save">保存修改</div>

    </div>
</template>
<script>
export default {
    data(){
        return {
            userInfo:{},
            u_name:"",
            phone:"",
            email:"",
            intro:"",
            avatar:""
        }
    },
    mounted(){
        this.break();
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
    },
    methods:{
      changeAvatar(e){//点击图片更换头像
            //将头像的文件上传到后台的服务器端
            //需要注意的是formData.append(name,value),里面的name对应的是input 的name值，value对应
            //的是input的files[0]，不是input.val(),对于的type=file的input，图片是在input的FileList 里面，
            //这里用的是this.$refs.upload.files[0]，这是因为在vue中使用this.$refs.refname来获取dom的真实节点，用jq或者
            //js的获取节点的方法是拿不到的，
            //需要注意的是在ajax中使用formdata需要配置anync:true,contentType:false,processData:false,在axios中不配置也能上传
            let $target = e.target || e.srcElement//表示调用它的各种属性   ie下支持e.srcElement  ff下支持e.target
            let file = $target.files[0];//表示取第一张图 
            if(file.name.indexOf(".jpg")!=-1 || file.name.indexOf(".png")!=-1 || file.name.indexOf(".gif") !=-1 || file.name.indexOf(".jpeg") !=-1){

                var form = new FormData();
                form.append('mypic',this.$refs.fileUpload.files[0]);
                this.axios({
                 method:'post',
                 url:'/index/upload',
            //      anync:true,
            //      contentType:false,
            //      processData:false,
                 data:form
                }).then((res)=>{
                   if(res.data.code == 1){
                     this.avatar = res.data.msg;
                  }
               })
            //FileReader()对象允许web应用程序异步读取存储在用户计算机上的文件(或原始数据缓冲区)的内容，使用File或Blob对象指定要读取的文件或数据。其中File对象可以是来自用户一个<input>元素上选择文件后返回的FileList对象，也可以来自拖放操作生成的DataFransfer对象，还可以是来自一个HTMLCanvasElement上执行mozGetFile()方法后返回结果
                var reader = new FileReader()
                reader.onload = (data) => {
                     let res = data.target || data.srcElement
                     this.avatar = res.result
                  }
                  reader.readAsDataURL(file)

                 }else{
                    this.$toast("图片的格式不正确");
                  }
        },
      goback(){//返回
            this.$emit('son',true);
            this.u_name=this.userInfo.u_name;
            this.phone=this.userInfo.phone;
            this.email=this.userInfo.email;
            this.intro=this.userInfo.intro;
            this.avatar=this.userInfo.avatar;
        },
        break(){
            this.userInfo=this.$store.getters.getInfo;
            this.u_name=this.userInfo.u_name;
            this.phone=this.userInfo.phone;
            this.email=this.userInfo.email;
            this.intro=this.userInfo.intro;
            this.avatar=this.userInfo.avatar;
        },
      niechen(){
            this.$messagebox
            .prompt("请输入昵称") //输入框
            .then((result)=>{//回调函数
                if(result.value!=null){
                    this.u_name=result.value;
                }else{
                    this.u_name="";
                }
            }).catch(err=>{ //取消函数
            });
        },
      myphone(){
            // this.$messagebox
            // .prompt("请输入电话") //输入框
            // .then((result)=>{//回调函数
            //     if(result.value!=null){
            //         this.phone=result.value;
            //     }else{
            //         this.phone="";
            //     }
            // }).catch(err=>{ //取消函数
            // });
            this.$toast("电话号码不可更改");
        },
      myemail(){
            this.$messagebox
            .prompt("请输入邮箱") //输入框
            .then((result)=>{//回调函数
                if(result.value!=null){
                    this.email=result.value;
                }else{
                    this.email="";
                }
            }).catch(err=>{ //取消函数
            });
        },
      myintro(){
            this.$messagebox
            .prompt("请输入自我介绍") //输入框
            .then((result)=>{//回调函数
                if(result.value!=null){
                    this.intro=result.value;
                }else{
                    this.intro="";
                }
            }).catch(err=>{ //取消函数
            });
        },
      save(){//保存修改
            let reg=/^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
            let reg1= /^1[3-9][0-9]{9}$/;
            if(this.email!=""){
                if(!reg.test(this.email)){
                    this.$toast("请输入正确的邮箱");
                this.email=this.userInfo.email;
                return;
                }
            }
            if(!reg1.test(this.phone)){
                this.$toast("请输入正确的手机号");
                 this.phone=this.userInfo.phone;
                return;
            }
            var obj={
                uid:this.userInfo.uid,
                u_name:this.u_name,
                email:this.email,
                intro:this.intro,
                phone:this.phone,
                avatar:this.avatar,
                age:this.userInfo.age,
                sex:this.userInfo.sex,
                home:this.userInfo.home,
                city:this.userInfo.city,
                education:this.userInfo.education,
                industry:this.userInfo.industry
            }
            this.axios.get("/index/updUser",{params:obj}).then(result=>{
                if(result.data.code==1){
                    this.$store.commit('userChange',obj);
                    var str=JSON.stringify(obj);
                    sessionStorage.setItem('userInfo',str);
                    this.$emit('son',true);
                }
            })
        }
    }
}
</script>
<style scoped>
*{color:#484848;box-sizing: border-box;}
.edit{
    width:100%;
    height:100%;
    position:fixed;
    background: #fff;
    top:0;
    padding-bottom: 20px;
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
.touxiang{
    width:200px;
    height:200px;
    margin:0 auto;
    margin-top:50px;
    position:relative;
}
.touxiang img,.touxiang input{
    width:100%;
    height:100%;
    position: absolute;
    top:0;
    left: 0;
}
.touxiang input{
    opacity: 0;
}
.edit-uname{
    width:90%;
    color:#008489;
    font-weight:bold;
    margin:20px auto 20px;
    padding-bottom: 10px;
    border-bottom:1px solid #ddd;
    text-align: center;
}
.personal{
    width:90%;
    margin:0 auto;
    background:#fff;
    padding:10px;
    box-shadow: rgba(0,0,0,0.01) 0px 1px 2px,rgba(0,0,0,0.12) 0px 3px 18px;
}
.personal>div{
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom:1px solid #ddd;
    padding:8px 0px;
}
.saveEdit{
    width: 80%;
    margin:30px auto;
    color:#fff;
    background:#0aa1ed;
    text-align: center;
    padding:10px;
    border-radius:5px;
}
</style>

