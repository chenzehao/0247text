<template>
    <div>
        <div class="peopleBox">
            <div class="people_title">成人</div>
            <div class="btnBox">
                <div class="button">
                    <img @click="sub('man')" v-if="$store.getters.getsel.man>0" src="../../../public/image/screen/jian_green.png" alt="">
                    <img v-else src="../../../public/image/screen/jian.png" alt="">
                </div>
                <div class="showNum">{{$store.getters.getsel.man}}</div>
                <div class="button">
                    <img @click="add('man')" v-if="$store.getters.getsel.man<16" src="../../../public/image/screen/add_green.png" alt="">
                    <img v-else src="../../../public/image/screen/add.png" alt="">
                </div>
            </div>
        </div>
        <div class="peopleBox">
            <div class="people_title">儿童</div>
            <div class="btnBox">
                <div class="button">
                    <img @click="sub('child')" v-if="$store.getters.getsel.child>0" src="../../../public/image/screen/jian_green.png" alt="">
                    <img v-else src="../../../public/image/screen/jian.png" alt="">
                </div>
                <div class="showNum">{{$store.getters.getsel.child}}</div>
                <div class="button">
                    <img @click="add('child')" v-if="$store.getters.getsel.child<5" src="../../../public/image/screen/add_green.png" alt="">
                    <img v-else src="../../../public/image/screen/add.png" alt="">
                </div>
            </div>
        </div>
        <div class="peopleBox">
            <div class="people_title">婴儿</div>
            <div class="btnBox">
                <div class="button">
                    <img @click="sub('little')" v-if="$store.getters.getsel.little>0" src="../../../public/image/screen/jian_green.png" alt="">
                    <img v-else src="../../../public/image/screen/jian.png" alt="">
                </div>
                <div class="showNum">{{$store.getters.getsel.little}}</div>
                <div class="button">
                    <img @click="add('little')" v-if="$store.getters.getsel.little<5" src="../../../public/image/screen/add_green.png" alt="">
                    <img v-else src="../../../public/image/screen/add.png" alt="">
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import {peopleChange} from 'vuex'
export default {
    methods:{
        sub(type){
            if(type=='man'){
                this.$store.commit('peopleChange',{way:'sub',where:'man'})
            }else if(type=='child'){
                this.$store.commit('peopleChange',{way:'sub',where:'child'})
            }else{
                this.$store.commit('peopleChange',{way:'sub',where:'little'})
            }
        },
        add(type){
            if(type=='man'){
                this.$store.commit('peopleChange',{way:'add',where:'man'})
            }else if(type=='child'){
                this.$store.commit('peopleChange',{way:'add',where:'child'})
            }else{
                this.$store.commit('peopleChange',{way:'add',where:'little'})
            }
        }
    },
}
</script>
<style scoped>
    .peopleBox{
        width:90%;
        margin:0 auto;
        padding:10px 0;
        text-align:center;
        display:flex;
        justify-content: space-between;
        height:50px;
        line-height:50px;
    }
    .peopleBox>.people_title{
        color:#484848;
        font-size:18px;
        width:40px;
    }
    .peopleBox>.btnBox{
        width:50%;
        height:50px;
        display:flex;
        justify-content: space-around;
        line-height:50px;
    }
    .btnBox>.button{
        width:32px;
        height:32px;
        margin-top:10px;
    }
    .btnBox>.showNum{
        font-size:16px;
        font-weight:bold;
    }
</style>