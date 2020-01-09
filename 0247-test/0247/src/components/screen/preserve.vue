<template>
    <div class="btnbox" @click="search">
        <div class="btn">保存</div>
    </div>
</template>
<script>
export default {
    methods:{
        search(){
            var sel=this.$store.getters.getsel
            this.$emit('closeZD')
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
                // 过渡效果结束
                setTimeout(()=>{
                    this.$store.commit('loadingChange',false)
                },1000)
            })
        },
    }
}
</script>
<style scoped>
    .btnbox{
        position:absolute;
        bottom:0;
        width: 100%;
        height:48px;
        background:#008489;
    }
    .btn{
        text-align:center;
        line-height:48px;
        color:white;
    }
</style>