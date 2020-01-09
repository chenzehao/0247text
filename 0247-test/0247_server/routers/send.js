const express=require('express');
const query=require('./query')
const router=express.Router();

// 阿里云短信验证码
const Core = require('@alicloud/pop-core');

// 系统发送的验证码
let systemCode='';

//发送短信验证码
router.get('/send',(req,res)=>{
  // res.send('发送短信');
  // 得到用户在前端输入的手机号
  var phone=req.query.phone;
  var str=``;
  for(var i=0;i<6;i++){
    str+=parseInt(Math.random()*10);
  }
  // 阿里云短信验证码
  var client = new Core({
    accessKeyId: 'LTAI4FhnaPf2utn2PCb7hUEF',
    accessKeySecret: '0dElpI4Xajyf4yQMS6RY75NoLcBcO8',
    endpoint: 'https://dysmsapi.aliyuncs.com',
    apiVersion: '2017-05-25'
  });
  var params = {
    "RegionId": "cn-hangzhou",
    "PhoneNumbers": phone,//用户手机号
    "SignName": "零二四七民宿",//短信签名名称
    "TemplateCode": "SMS_181210182",//短信模版id
    "TemplateParam":`{"code":'${str}'}`
  }
  var requestOption = {
    method: 'POST'
  };
  client.request('SendSms', params, requestOption).then((result) => {

    // 先判断短信发送是否成功
    if(result.Message=='OK'){
      // 把系统发送的验证码赋值给全局变量
      systemCode=str;
    }
  }, (ex) => {

  })
})

router.get('/verify',(req,res)=>{
  var phone=parseFloat(req.query.phone);
  var verifyCode=req.query.code;
  if(verifyCode==systemCode){//说明验证成功
    var sql=`select * from aby_user where phone=${phone}`;
    query(sql).then(result=>{
      if(result.length>0){//说明是老用户
        req.session.uid=result[0].uid;
        res.send({code:1,data:result});
        return
      }else{//说明是新用户
        return query('insert into aby_user set phone=?,u_pwd=md5(123456)',[phone])
      }
    }).then(result=>{//新用户
      if(result){
        if(result.affectedRows>0){//数据插入成功
          return query('select * from aby_user where phone=?',[phone])
        }else{//数据插入失败
          res.send({code:-1});
        }
      }
    }).then(result=>{
      if(result && result.length>0){
        req.session.uid=result[0].uid;
        res.send({code:1,data:result});
      }
    })
  }else{//验证码输入错误
    res.send({code:-2,msg:'验证码错误'});
  }
})

module.exports=router;