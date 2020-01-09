<template>
    <div class="all">
        <div class="roomType">
            <p class="title">房源类型</p>
            <div class="checkBox">
                <div class="roomButton" :class="{'check':check1}" @click="change('one')">
                    <p class="smTitle">独立房间</p>
                    <p class="smDetail">有自己的独立房价，与他人共享客厅等空间</p>
                </div>
                <div class="roomButton" :class="{'check':check2}" @click="change('two')">
                    <p class="smTitle">合住房间</p>
                    <p class="smDetail">入住合用空间,例如公共休息室</p>
                </div>
            </div>
        </div>
        <div class="bedNum">
            <p class="title">房间布局</p>
            <div class="bedBox">
                <div class="smTitle">床铺数量</div>
                <div class="btnBox">
                    <div class="button">
                        <img @click="sub('bed')" v-if="$store.getters.getsel.count.bed>0" src="../../../public/image/screen/jian_green.png" alt="">
                        <img v-else src="../../../public/image/screen/jian.png" alt="">
                    </div>
                    <div class="showNum">{{$store.getters.getsel.count.bed}}{{$store.getters.getsel.count.bed>0?'+':''}}</div>
                    <div class="button">
                        <img @click="add('bed')" v-if="$store.getters.getsel.count.bed<16" src="../../../public/image/screen/add_green.png" alt="">
                        <img v-else src="../../../public/image/screen/add.png" alt="">
                    </div>
                </div>
            </div>
            <div class="bedBox">
                <div class="smTitle">卧室</div>
                <div class="btnBox">
                    <div class="button">
                        <img @click="sub('bedroom')" v-if="$store.getters.getsel.count.bedroom>0" src="../../../public/image/screen/jian_green.png" alt="">
                        <img v-else src="../../../public/image/screen/jian.png" alt="">
                    </div>
                    <div class="showNum">{{$store.getters.getsel.count.bedroom}}{{$store.getters.getsel.count.bedroom>0?'+':''}}</div>
                    <div class="button">
                        <img @click="add('bedroom')" v-if="$store.getters.getsel.count.bedroom<16" src="../../../public/image/screen/add_green.png" alt="">
                        <img v-else src="../../../public/image/screen/add.png" alt="">
                    </div>
                </div>
            </div>
            <div class="bedBox">
                <div class="smTitle">卫生间</div>
                <div class="btnBox">
                    <div class="button">
                        <img @click="sub('toliet')" v-if="$store.getters.getsel.count.toliet>0" src="../../../public/image/screen/jian_green.png" alt="">
                        <img v-else src="../../../public/image/screen/jian.png" alt="">
                    </div>
                    <div class="showNum">{{$store.getters.getsel.count.toliet}}{{$store.getters.getsel.count.toliet>0?'+':''}}</div>
                    <div class="button">
                        <img @click="add('toliet')" v-if="$store.getters.getsel.count.toliet<16" src="../../../public/image/screen/add_green.png" alt="">
                        <img v-else src="../../../public/image/screen/add.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data(){
        return{
            check1:false,
            check2:false,
        }
    },
    created(){
        [this.check1,this.check2]=this.$store.getters.getsel.roomType
    },
    methods:{
        sub(way){
            if(way=='bed'){
                this.$store.commit('bedChange',{way:'sub',where:'bed'})
            }else if(way=='bedroom'){
                this.$store.commit('bedChange',{way:'sub',where:'bedroom'})
            }else{
                this.$store.commit('bedChange',{way:'sub',where:'toliet'})
            }
        },
        add(way){
            if(way=='bed'){
                this.$store.commit('bedChange',{way:'add',where:'bed'})
            }else if(way=='bedroom'){
                this.$store.commit('bedChange',{way:'add',where:'bedroom'})
            }else{
                this.$store.commit('bedChange',{way:'add',where:'toliet'})
            }
        },
        change(way){
            if(way=='one'){
                if(this.check1){this.check1=false}
                else{this.check1=true}
            }else{
                if(this.check2){this.check2=false}
                else{this.check2=true}
            }
            this.$store.commit('roomChange',[this.check1,this.check2])
        }
    },
    computed:{
        getRoomType(){
            return this.$store.getters.getsel.roomType
        }
    },
    watch:{
        getRoomType(){
            [this.check1,this.check2]=this.$store.getters.getsel.roomType
        }
    }
}
</script>
<style scoped>
    .all{
        overflow: hidden;
    }
    /* 房间布局 */
    .bedNum{
        padding:24px;
    }
    .bedNum>.bedBox{
        display:flex;
        height:50px;
        padding:10px 0;
        justify-content: space-between;
        line-height:50px;
    }
    .bedNum>.bedBox>.smTitle{
        font-size:18px;
        color:#484848;
    }
    .bedNum>.bedBox>.btnBox{
        display:flex;
        width:50%;
        justify-content: space-around;
        
    }
    .btnBox>.button{
        margin-top:10px;
    }
    .btnBox>.showNum{
        font-weight:bold;
    }
    /* 房源类型 */
    .roomType{
        padding:24px;
        border-top:1px solid #eeeeee;
        border-bottom:1px solid #eeeeee;
    }
    .roomType>.title,.bedNum>.title{
        text-align:left;
        font-size:#484848;
        font-weight:bold;
        padding-bottom:10px;
    }
    .roomType>.checkBox{
        width:100%;
        display:flex;
        justify-content: space-between;
        height:100px;
    }
    .checkBox>.roomButton{
        width:47%;
        height:100%;
        border:1px solid #ddd;
        border-radius:5px;
        padding:10px;
        box-sizing: border-box;
        text-align: left;
    }
    .checkBox>.roomButton.check{
        border:1px solid #008489;
    }
    .roomButton>.smTitle{
        font-size:15px;
        font-weight: bold;
        color:#484848;
        margin-bottom:10px;
    }
    .roomButton>.smDetail{
        font-size:14px;
        font-weight:bold;
        color:#767676;
        line-height:18px;
    }
    .roomButton.check>.smTitle,.roomButton.check>.smDetail{
        color:#008489;
    }
</style>