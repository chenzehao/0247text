<template>
  <div id="app">
    <router-view :key="key"></router-view>
  </div>
</template>
<script>
export default {
  name:'App',
  created(){
    var json=sessionStorage.getItem('userInfo')
    var user=JSON.parse(json)
    if(user!=null){
      if(Object.keys(user).length!=0){
        this.axios.get('index/checkUser',{params:{uid:user.uid}}).then(res=>{
          if(res.data.code==1){
            this.$store.commit('userChange',{
              uid:user.uid,
              u_name:user.u_name,
              avatar:user.avatar,
              email:user.email,
              intro:user.intro,
              phone:user.phone,
              sex:user.sex,
              age:user.age,
              home:user.home,
              city:user.city,
              education:user.education,
              industry:user.industry
            })
          }else{
            this.$store.commit('logOut')
          }
        })
      }
    }
  },
  computed:{
    key(){
      // 给router-view加个唯一的key，来保证路由切换时都会重新渲染触发钩子了
      return this.$route.name?this.$route.name+ +new Date():this.$route+ +new Date();
    }
  }
}
</script>
<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
