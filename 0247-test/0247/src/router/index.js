import Vue from 'vue'
import VueRouter from 'vue-router'
// import Login from '../views/Login.vue'
import Homepage from '../views/Home.vue'
Vue.use(VueRouter)



const routes = [
  {
    path: '/',name: 'homepage',component: Homepage
  },
  {
    path: '/roomlist/:city',name: 'roomlist',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import( /*webpackChunkName: "roomList"*/  '../views/roomList.vue')
  },
  {
    path: '/roomDetail/:rid',name: 'roomdetail',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import( /*webpackChunkName: "roomDetail"*/  '../views/roomDetail.vue')
  },
  {
    path: '/login',name: 'login',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import( /*webpackChunkName: "Login"*/  '../views/Login.vue')
  },
  {
    path: '/pay/:oid',name: 'pay',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import( /*webpackChunkName: "pay"*/  '../views/pay.vue')
  },
  {
    path: '/history',name: 'history',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import( /*webpackChunkName: "history"*/  '../views/history.vue')
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
