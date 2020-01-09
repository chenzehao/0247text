<template>
    <div class="main" :style="{height:parseInt(height)+213+'px'}">
        <div class="fixed">
            <div class="top" v-if="page!='roomlist'">
                <!-- 增加给房间详情页发送数据的函数 -->
                <button @click="sendDetailMsg">
                    <svg viewBox="0 0 12 12" role="img" aria-label="关闭" focusable="false" style="height: 12px; width: 12px; display: block; fill: currentcolor;"><path d="m11.5 10.5c.3.3.3.8 0 1.1s-.8.3-1.1 0l-4.4-4.5-4.5 4.5c-.3.3-.8.3-1.1 0s-.3-.8 0-1.1l4.5-4.5-4.4-4.5c-.3-.3-.3-.8 0-1.1s.8-.3 1.1 0l4.4 4.5 4.5-4.5c.3-.3.8-.3 1.1 0s .3.8 0 1.1l-4.5 4.5z" fill-rule="evenodd"></path></svg>
                </button>
            </div>
            <div v-if="page=='roomDetail'">
                <p v-if="(!start)||(!end)" class="title">选择日期</p>
                <p v-else class="title2">
                    {{`${new Date(start.time).getMonth()+1}月${new Date(start.time).getDate()}日-${new Date(end.time).getMonth()+1}月${new Date(end.time).getDate()}日·${(new Date(end.time)-new Date(start.time))/86400000}晚`}}
                    <button @click="clear" class="button">清除</button>
                </p>
                <ul class="weekday">
                    <li>日</li>
                    <li>一</li>
                    <li>二</li>
                    <li>三</li>
                    <li>四</li>
                    <li>五</li>
                    <li>六</li>
                </ul>
            </div>
        </div>
        <div class="marginTop" :style="{height}" :class="{not:page=='roomlist'}">
            <div v-for="(el,i) of data" :key="i" class="date">
                <p>{{el.year}}年{{el.month}}月</p>
                <ul>
                    <li v-for="(el,i) of el.weekday" :key="i"></li>
                    <li v-for="(item,i) of el.dates" :key="i+el.weekday" @click="pickDate(item)" :class="{start:end&&item.isstart,start2:!end&&item.isstart,end:item.isend,selected:item.isselected,disabled:item.disabled}">{{item.date}}</li>
                </ul>
            </div>
        </div>
        <div class="bottom" v-if="page!='roomlist'">
            <button @click="sendDetailMsg">保存</button>
        </div>
    </div>
</template>
<script>
import store from "../../store/index";
export default {
    props:{
        page:{type:String},
        defineddate:{type:String},
        rid:{type:Number}
    },
    data(){
        return {
            data:[],//保存显示月的数据
            year:0,  //保存显示日历的年份
            month:0,  //保存显示日历的月份
            date:0,   //保存显示日历的日期
            start:0,
            end:0,
            disabled:[],
            days:0,
            // ***********************
            height:(window.innerHeight-213)+'px',
        }
    },
    created(){      
        var data=this.$store.getters.getsel.data;
        if(data.length!=0){
            this.data=data;
            this.data.forEach(el=>{
                el.dates.forEach(date=>{
                    if(date.isstart)this.start=date;
                    if(date.isend)this.end=date;
                })
            })
        }else{
           this.load();
            // this.changeData();
            this.$store.commit("dataChange",this.data)
        }
    },
    updated(){
        this.bus.$on("clearDate",this.clear)
        this.bus.$on("clearsomething",()=>{         
                this.$store.commit("daysChange",0);
                this.$store.commit('dateChange',"");
                this.$store.commit("dataChange",[])        
        })
    },
    computed:{
        getRid(){
            return this.$route.path.split('/')[2]
        }
    },
    watch:{
        end(){
            this.sendMsg();
            if(this.end){
                this.days=(new Date(this.end.time)-new Date(this.start.time))/86400000;
                var arr=[];
                for(var i=this.start.time.getTime();i<=this.end.time.getTime();i+=86400000){
                    arr.push(i)
                }
                if(this.page=='roomlist'){
                    this.$store.commit("daysChange",this.days);
                }
                this.$store.commit('dateChange',arr.toString());
                this.$store.commit("dataChange",this.data)
            }
        },
        defineddate(){
            if(this.defineddate!=''){
            this.disabled=this.defineddate.split(',');
            for(var i=0;i<this.disabled.length;i++){
                this.disabled[i]=Number(this.disabled[i])
            }
            if(this.page=="roomDetail"){
                this.data.forEach(el=>{
                    el.dates.forEach(date=>{
                        if(this.disabled.length>0){
                            for(var i=0;i<this.disabled.length;i++){
                                if(this.disabled[i]==date.time.getTime()){
                                    date.disabled=true;
                                }
                            }
                        }
                    })
                })
            }
        }
        },
    },
    methods:{
        load(){
             for(var i=0;i<12;i++){
                this.update(this.year,this.month,this.date);
                    this.month++;
                }
            if(this.page=="roomDetail"){
                this.data.forEach(el=>{
                    el.dates.forEach(date=>{
                        if(this.disabled.length>0){
                            if(this.disabled.some(el2=>el2==date.time.getTime())){
                                date.disabled=true;
                            }
                        }
                    })
                })
            }
        },
        sendDetailMsg(){
            if(this.page=='roomDetail'){
                this.$store.commit("daysChange",this.days);
            }
            this.$emit("fun",window.innerHeight+'px');
        },
        sendMsg(){
            this.$emit("fun1",[this.start,this.end,this.days,this.data])
        },
        clear(){
            if(this.data){
                this.data.forEach(el=>{
                    el.dates.forEach(el1=>{
                        el1.isstart=false;
                        el1.isend=false;
                        el1.isselected=false;
                        // ****************
                        el1.disabled=false;
                    })
                })
                this.start=null;
                this.end=null;
            }
            // ******************
            this.data.forEach(el=>{
                el.dates.forEach(date=>{
                    if(this.disabled.some(el2=>el2==date.time.getTime())||date.time<new Date()){
                        date.disabled=true;
                    }
                })
            })
        },
        // 判断是否为闰年,返回true/false
        isLeapYear(year){
            return (year % 400 === 0) || (year % 100 !== 0 && year % 4 === 0);
        },
        // 获取一个月份的天数返回数组
        getMonthCount(year,month){
            var arr=[31, null, 31, 30,31, 30, 31, 31,30, 31, 30, 31];
            var count = arr[month-1] || (this.isLeapYear(year) ? 29 : 28);
            // month-1   数组从0开始
            var obj={};
            var dates=Array.from(new Array(count), (item, value) => item={
                date:value+1,
                time:new Date(year,month-1,value+1),
                isstart:false,
                isselected:false,
                isend:false,
                disabled:false,
            });
            var now=new Date();
            dates.forEach(el=>{
                if(el.time<now){
                    el.disabled=true;
                }
            })
            var weekday=this.getWeekday(year,month,1)
            obj={year,month,dates,weekday};
            return obj;
        },
        // 获取一个月份的第一天为周几
        getWeekday(year,month){
            var date=new Date(year,month-1,1);
            return date.getDay();
        },
        // 获取上个月份的天数数组
        getPreMonthCount(year,month){
            if(month==1){
                return this.getMonthCount(year-1,12)
            }else{
                return this.getMonthCount(year,month-1)
            }
        },
        // 获取下个月份的天数数组
        getNextMonthCount(year,month){
            if(month==12){
                return this.getMonthCount(year+1,1)
            }else{
                return this.getMonthCount(year,month+1)
            }
        },
        // 刷新显示月份函数
        update(year,month,date){
            if(!year&&!month&&!date){
                var now=new Date();
                year=now.getFullYear();
                month=now.getMonth()+1;
                date=now.getDate();
            }
            if(month==0){month=12;year-=1}
            if(month==13){month=1;year+=1}
            var currentMonth=this.getMonthCount(year,month);
            var res=[].concat(currentMonth);
            this.data=this.data.concat(res);
            this.year=year;
            this.month=month;
            this.date=date;
        },
        // 选择日期
        pickDate(obj){
            if(obj.disabled){
                return;
            }
            if(!this.start){
                obj.isstart=true;
                this.start=obj;
                // 遍历data,
                // 找到start后的第一个disabled
                // 将其变为可选状态
                // 将其后的日期变为disabled
                if(this.page=="roomDetail"){
                    var count=0;
                    var x;
                    this.data.forEach(el=>{
                        el.dates.forEach(date=>{
                            if(date.time.getTime()>obj.time.getTime()&&date.disabled==true&&count==0){
                                x=date.time.getTime();
                                count++;
                                date.disabled=false;
                            }
                            if((date.time.getTime()>x)&&(count==1)){
                                date.disabled=true;
                            }
                        })
                    })
                }
            }else if(!this.end){
                if(obj.time<=this.start.time){
                    this.start.isstart=false;
                    obj.isstart=true;
                    this.start=obj;
                    return;
                }
                if(this.page=="roomDetail"){
                    for(var i=this.start.time.getTime();i<obj.time.getTime();i+=86400000){
                        if(this.disabled.some(el=>el==i)){
                            return;
                        }
                    }
                }
                obj.isend=true;
                this.end=obj;
                this.data.forEach(el=>{
                    el.dates.forEach(item=>{
                        if(item.time>this.start.time&&item.time<this.end.time){
                            item.isselected=true;
                        }
                    })
                })
            }else if(this.start&&this.end){
                this.data.forEach(el=>{
                    el.dates.forEach(item=>{
                        item.isselected=false
                    })
                })
                this.start.isstart=false;
                this.end.isend=false;
                obj.isstart=true;
                this.start=obj;
                this.end=null;
            }
        }
    }
}
</script>
<style scoped>
    .main{
        color:#484848;
        overflow-x: hidden;
        /* ********************* */
        /* position:relative; */
    }
    .main>.fixed{
        width:100%;
        background: #fff;
    }
    .main>.fixed>.top{
        width:100%;
        height:60px;
        text-align: left;
    }
    .main>.fixed>.top button{
        border:0;
        background: transparent;
        padding:24px;
    }
    .button{
        border:0;
        background: transparent;
        margin-left:50px;
    }
    .main>.fixed .title,.main>.fixed .title2{
        height:40px;
        text-align: center;
    }
    .main>.fixed .title2{
        color:#008489;
    }
    .main>.fixed .weekday{
        display: flex;
        justify-content: space-around;
        list-style: none;
        font-size:14px;
        padding-bottom:8px;
        border-bottom:1px solid rgb(221,221,221);
    }
    .main>.marginTop{
        margin-bottom:20px;
        overflow-y: scroll;
        overflow-x: hidden;
    }
    .main>.marginTop.not{
        margin-top:67px;
    }
    .main>.marginTop>.date>p{
        text-align: center;
        padding:8px 0;
        font-size:14px;
    }
    .main>.marginTop>.date>ul{
        display:flex;
        list-style:none;
        flex-wrap:wrap;
        /* justify-content: space-around; */
        margin-right:-7px;
        font-size: 14px;
    }
    .main>.marginTop>.date>ul>li{
        width:14%;
        text-align: center;
        height:44px;
        margin-bottom:4px;
        box-sizing: border-box;
        padding:5px 0;
    }
    .start,.start2,.end,.selected,.all{
        background: rgb(0, 132, 137);
        color:#fff;
    }
    .start{
        border-radius: 22px 0 0 22px;
    }
    .start2{
        border-radius: 22px 22px 22px 22px;
    }
    .start:after,.start2:after{
        content: "入住";
        display:block;
        font-size:12px;
    }
    .end{
        border-radius:  0 22px 22px 0 ;
    }
    .end:after{
        content: "退房";
        display:block;
        font-size:12px;
    }
    .all{
        border-radius:  22px 22px 22px 22px ;
    }
    .disabled{
        color:#c4c4c4;
    }
    .main>.bottom{
        /* position:absolute;
        bottom:0; */
        width:100%;
        height:82px;
        background: #fff;
        text-align: center;
        box-sizing: border-box;
        padding:16px 24px;
        border-top: 2px solid #f2f2f2;
        margin:0;
        margin-top:-15px;
    }
    .main>.bottom>button{
        width:100%;
        height:100%;
        color:#fff;
        border:0;
        background: #008489;
        border-radius: 4px;
    }
</style>