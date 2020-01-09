const express=require('express');
const bodyParse=require('body-parser');
const cors=require("cors");
const session = require("express-session");
let indexRouter=require('./routers/index.js')
let likeRouter=require('./routers/like.js');
let sendRouter=require('./routers/send.js');

const app=express();
app.listen(8088);

//配置session对象
app.use(session({
  secret:"128位安全字符串",//加密条件
  resave:true,            //请求更新数据
  saveUninitialized:true  //保存初始化数据
}))

app.use(express.static('public'));
app.use(bodyParse.urlencoded({
    extended:false
}))
app.use(cors({
  origin:['http://localhost:8080','http://localhost:8081'],
  credentials:true
}))

app.use('/index',indexRouter);
app.use('/like',likeRouter);
app.use('/send',sendRouter);
