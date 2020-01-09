<template>
    <!-- 点击搜索框出现的搜索 -->
    <div class="search-inside" :class="{off:isOff}">
      <!-- 上方搜索框 -->
      <div class="search-bar">
				<!-- 搜索文字和小图标 -->
        <div class="search-text">
            <div @click="selectCity(inputMsg)" class="search-img">
              <!-- <img src="../../public/index/search.png" alt=""> -->
              <svg viewBox="0 0 16 16" role="presentation" aria-hidden="true" focusable="false" style="height:16px;width:16px;display:block;fill:#484848"><path d="m2.5 7c0-2.5 2-4.5 4.5-4.5s4.5 2 4.5 4.5-2 4.5-4.5 4.5-4.5-2-4.5-4.5m13.1 6.9-2.8-2.9c.7-1.1 1.2-2.5 1.2-4 0-3.9-3.1-7-7-7s-7 3.1-7 7 3.1 7 7 7c1.5 0 2.9-.5 4-1.2l2.9 2.8c.2.3.5.4.9.4.3 0 .6-.1.8-.4.5-.5.5-1.2 0-1.7"></path></svg>
            </div>
            <input v-model="inputMsg" @keyup.13="selectCity(inputMsg)" class="search-input" ref="searchTxt" type="text" placeholder="搜「北京」试试">
        </div>
		<!-- 取消搜索按钮 -->
        <button @click="cancel" class="search-cancel">取消</button>
      </div>
		<!-- 下方的最近搜索 -->
      <div class="search-place">
          <!-- 显示最近搜索和热门 -->
          <div v-if="inputMsg==''|inputMsg==undefined" class="search-nearly-hot">
            <!-- 最近搜索和下面的城市列表 -->
            <div v-show="searchNearAll==true" class="search-near-all">
                <div class="search-nearly">
                    最近搜索
                </div>
                <!-- 最近搜索下面的城市 -->
                <div class="search-nearly-place">
                    <div class="search-nearly-placeall">
                        <!-- 最近搜索下的按钮 -->
                        <button  v-for="(elem,i) of nearSearch" :key="i" class="search-nearly-city" @click="selectCity(elem)">
                            <div class="search-nearly-img">
                                <img src="../../public/index/timeclock.png" alt="">
                            </div>
                            <div class="search-nearly-city-item">
                                {{elem}}
                            </div>
                        </button>
                        <!-- 最近搜索下面横条右侧的距离 -->
                        <div class="search-padding12"></div>  
                    </div>
                </div>
            </div>
            
            <!-- 国内热门--海外及港澳台热门 -->
            <div>
                <button @click="selectCountry(0)" :class="{countryin:isIncountry,countryout:!isIncountry}">国内热门目的地</button>
                <button @click="selectCountry(1)" :class="{countryin:!isIncountry,countryout:isIncountry}">海外及港澳台热门目的地</button>
            </div>
            <!-- 如果选中国内热门则显示国内 -->
            <div v-if="isIncountry==true">
                <button v-for="(elem,i) of countryIn" :key="i" class="country-in-city" @click="selectCity(elem)">{{elem}}</button>
            </div>
            <!-- 如果选中海外及港澳台热门热门则显示海外及港澳台热门 -->
            <div v-else>
                <button v-for="(elem,i) of countryOut" :key="i"  class="country-out-city" @click="selectCity(elem)">{{elem}}</button>
            </div>

          </div>
          <!-- 显示输入框输入内容时 -->
          <!-- <span%20style='color:#484848;font-weight:bold;'>北京</span>，中国 -->
          <div v-else class="search-list">
            <!-- <div v-for="(elem,i) of list" :key="i" :data-city="elem" @click="selectCitys" class="search-list-item" role="button" tabindex="0"> -->
            <div v-for="(elem,i) of list" :key="i" :data-city="elem" @click="selectCity(elem,i)" class="search-list-item" role="button" tabindex="0">
                <!-- 显示搜索图标 -->
                <div class="search-icon">
                    <img src="../../public/index/search_icon.png" alt="">
                </div>
                <!--显示搜索出来的位置信息-->
                <div class="search-location" v-html="elem">
                    
                </div>
                <!-- 显示搜索出来的地区或是街区 -->
                <div class="search-area">
                    地区
                </div>
            </div>
            {{msg}}
          </div>
      </div>
    
    </div>
</template>
<script>
export default {
    data(){
        return {
            nearSearch:[],
            countryIn:["北京","上海","成都","重庆","杭州","厦门","广州","西安"],
            countryOut:["大阪","东京","台北","香港","京都","曼谷","首尔","清迈"],
            isIncountry:true,//判断是否为国内热门目的地true为是，false为否
            isOff:false, //设置取消开关
            inputMsg:"",//输入框输入的文字
            searchNearAll:false, //最近搜索和下面的城市列表是否显示
            canSearch:true,     //控制搜索开关，防止连续触发事件
            list:[],            //存储搜索下拉框中的数据
            msg:""              //当搜索结果不存在时显示的文字
        }
    },
    created(){
        if(localStorage.getItem("keyCity")!=null){
            // localStorage.removeItem('keyCity');
            this.nearSearch=JSON.parse(localStorage.getItem("keyCity"));
            if(this.nearSearch.length>0){
                this.searchNearAll=true;
            }
        }
        //1219
        if(this.a!==undefined){//判断是否是从主页面中search.vue进来的
            this.inputMsg="";
        }else if(this.$store.getters.getsel.search!==""){
            this.inputMsg=this.$store.getters.getsel.search;
        }
    },
    // updated(){
    //     var sea=document.querySelector(".search-list");
    //     if(sea!==null){
    //         this.$nextTick((x)=>{ //正确写法
    //             this.$refs.searchTxt.focus();
    //         })
    //     }
    // },
    props:["a"],
    methods:{
        selectCountry(i){
            if(i==0){
                this.isIncountry=true;
            }else if(i==1){
                this.isIncountry=false;
            }
        },
        cancel(){//取消按钮
            this.isOff=true;
            this.$emit('son',this.isOff);
            this.isOff=false;//重置isOff为初始值
            if(this.a!==undefined){//判断是否是从主页面中search.vue进来的
                this.inputMsg="";
            }else{
                this.inputMsg=this.$store.getters.getsel.search
            }
        },
        selectCity(citys,i){//点击热门城市
            if(citys.trim()!==""){
                if(i!=undefined){
                    //添加最近搜索的地点
                    var searchLoaction=document.querySelectorAll(".search-location")[i];
                    this.$router.push("/roomlist/"+searchLoaction.textContent);
                    // console.log(searchLoaction.textContent);
                    this.isOff=true;
                    if(this.nearSearch.length>0){
                        for(var i=0;i<this.nearSearch.length;i++){
                            //数组去掉重复的，把当前选中的放在第一位，再保存起来
                            if(searchLoaction.textContent==this.nearSearch[i]){
                                this.isInside=true;
                                this.nearSearch.splice(i,1);
                                this.nearSearch.unshift(searchLoaction.textContent);
                                //设置最多能留5个最近访问
                                if(this.nearSearch.length>5){
                                    this.nearSearch.splice(5);
                                }
                                //保存在本地浏览器
                                localStorage.setItem("keyCity",JSON.stringify(this.nearSearch));
                            }
                        }
                        //如果没有重复的，直接在数组开头添加
                        if(!this.isInside){
                            this.nearSearch.unshift(searchLoaction.textContent);
                            //设置最多能留5个最近访问
                            if(this.nearSearch.length>5){
                                this.nearSearch.splice(5);
                            }
                            localStorage.setItem("keyCity",JSON.stringify(this.nearSearch));
                        }
                    }else{
                        this.nearSearch.unshift(searchLoaction.textContent);
                        localStorage.setItem("keyCity",JSON.stringify(this.nearSearch));
                    }
                }else{
                    this.$router.push("/roomlist/"+citys);
                    this.isOff=true;
                    //添加最近搜索的地点
                    if(this.nearSearch.length>0){
                        for(var i=0;i<this.nearSearch.length;i++){
                            if(citys==this.nearSearch[i]){
                                this.isInside=true;
                                this.nearSearch.splice(i,1);
                                this.nearSearch.unshift(citys);
                                //设置最多能留5个最近访问
                                if(this.nearSearch.length>5){
                                    this.nearSearch.splice(5);
                                }
                                localStorage.setItem("keyCity",JSON.stringify(this.nearSearch));
                            }
                        }
                        if(!this.isInside){
                            this.nearSearch.unshift(citys);
                            //设置最多能留5个最近访问
                            if(this.nearSearch.length>5){
                                this.nearSearch.splice(5);
                            }
                            localStorage.setItem("keyCity",JSON.stringify(this.nearSearch));
                        }
                    }else{
                        this.nearSearch.unshift(citys);
                        localStorage.setItem("keyCity",JSON.stringify(this.nearSearch));
                    }
                    // console.log(this.nearSearch);
                }
            }
            //1219****
            this.$emit('son',this.isOff);
            this.isOff=false;//重置isOff为初始值
        },
        search(){//输入文字时触发搜索
            this.msg="";//当搜索结果不存在时显示的文字
            if(this.canSearch==true){
                this.canSearch=false;
                this.list=[];
                setTimeout(() => {
                    if(this.inputMsg.trim()!==""){
                        this.axios.get("index/roomList/"+this.inputMsg).then(result=>{
                            // console.log(result.data);
                            if(result.data.code==1){
                                this.msg="";
                                for(var i=0;i<result.data.data.length;i++){
                                    if(result.data.data[i].room_location.indexOf(this.inputMsg)!=-1){
                                        this.list.push(result.data.data[i].room_location);
                                    }else if(result.data.data[i].big_title.indexOf(this.inputMsg)!=-1){
                                        this.list.push(result.data.data[i].big_title);
                                    }else if(result.data.data[i].describ.indexOf(this.inputMsg)!=-1){
                                        this.list.push(result.data.data[i].describ);
                                    }
                                }
                                // console.log(this.list);//1220
                                // 下拉列表最多显示5条信息
                                if(this.list.length>5){
                                    this.list.splice(5);
                                }
                                //查询文字高亮显示
                                var arr=this.list;
                                arr.forEach((elem,i,arr)=>{
                                    let replaceReg=new RegExp(this.inputMsg,'ig');
                                    let replaceString="<span style='color:#484848;font-weight:bold;'>"+this.inputMsg+"</span>";
                                    arr[i]=arr[i].replace(replaceReg,replaceString);
                                })
                                this.list=arr;
                            }else{
                                this.msg="没有该数据";//当搜索结果不存在时显示的文字
                            }
                        })
                    }
                        
                    this.canSearch=true;
                }, 200);
                
            }
        }
    },
    watch:{
        inputMsg(){
            this.search();
        }
    }
}
</script>
<style scoped>
*{box-sizing: border-box;}
/*当搜索框有东西输入时显示*/
.search-list{
    width:100%;
    display: table;
}
.search-list-item{
    display: table-row;
    /* outline: none; */
}
.search-icon,.search-location,.search-area{
    display: table-cell;
    padding-top: 16px;
    padding-bottom: 16px;
    vertical-align: middle;
    border-bottom: 1px solid rgb(235, 235, 235);
}
.search-icon{
    text-align: left;
    color: rgb(118, 118, 118);
    width: 32px;
    font-size: 24px;
    line-height: 14px;
}
.search-icon img{
    width:24px;
}
.search-location{
    text-align: left;
    font-size: 14px;
    color: rgb(118, 118, 118);
}
.search-area{
    text-align: right;
    font-size: 12px;
    color: rgb(156, 156, 156);
    min-width: 32px;
}
.search-inside{
  width:100%;
  height:100%;
  position:fixed;
  left:0px;
  top:0px;
  padding-top:96px;
  background:#fff;
  z-index:2000;
}
.search-bar{
  width:100%;
  position:fixed;
  top:0;
  left:0;
  box-shadow:rgba(0,0,0,0.15) 0px 3px 15px;
  padding:16px 80px 24px 24px;
}
/*搜索框*/
.search-text{
    box-shadow: rgba(0,0,0,0.01) 0px 1px 2px,rgba(0,0,0,0.12) 0px 3px 18px;
    border:none;
    border-radius:3px;
    font-size: 14px;
    height:48px;
    line-height:48px;
    position: relative !important;
    padding-left: 48px;
    padding-right: 24px;
    color:rgb(72,72,72);
}
.search-img{
    width: 6%;
    height: 6%;
    position:absolute;
    top:30%;
    left:8%;
}
.search-img img{
    width: 100%;
}
.search-input{
		width:100%;
    font-size: 16px;
    font-weight: bold;
    border:0;
}
.search-input:focus{
    outline: none;
}
.search-cancel,.countryin,.countryout,.country-in-city,.country-out-city{
	border:0;
    outline: none;
    background: none;
}
/*取消按钮*/
.search-cancel{
    width:72px;
    height: 48px;
    position: absolute;
    top:16px;
    right:8px;
    line-height: 48px;
		font-size: 14px;
    color: #484848;
    padding:0;
}
.off{
    display: none;
}
.search-place{
    padding: 24px;
}
.search-nearly-hot{
    text-align: left;
}
.search-nearly{
    font-size: 12px;
    padding:8px 0px;
}
.search-nearly-place{
    margin-left: -24px;
    margin-right:-24px;
    position: relative;
    margin-top:0;
    overflow-y: hidden;
}
.search-nearly-placeall{
    display: flex;
    overflow-x:auto;
    white-space: nowrap;
    padding-left: 24px;
    padding-bottom:16px;
    margin-bottom:-16px;
}
.search-nearly-city{
    box-shadow: rgba(0,0,0,0.1) 0px 1px 2px;
    margin-right: 8px;
    margin-bottom: 16px;
    text-align: left;
    position: relative;
    border:0.5px solid rgb(219, 220, 221);
    border-radius: 3px;
    padding: 16px 16px 16px 36px;
    background: none;
    outline: none;
}
.search-nearly-img{
    width:14px;
    height:14px;
    position:absolute;
    left: 12px;
    top:50%;
    margin-top:-7px;
}
.search-nearly-img img{
    width:100%;
}
.search-nearly-city-item{
    font-size:16px;
    font-weight: 600;
    color: #484848;
}
.search-padding12{
    padding:12px;
}
.countryin,.countryout{
    font-size: 12px;
    margin-right: 32px;
    margin-bottom: 16px;
    color: rgb(0, 132, 137);
    padding: 16px 0px;
}
.countryin{
    border-bottom: 2px solid rgb(0, 132, 137);
}
.countryout{
    color: #484848;
}
.country-in-city,.country-out-city{
    color: rgb(72, 72, 72);
    box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 2px;
    font-size: 14px;
    line-height: 24px;
    margin-right: 8px;
    margin-bottom: 8px;
    border:0.5px solid rgb(219, 220, 221);
    border-radius: 3px;
    padding: 16px;
    color: #484848;
}

</style>
