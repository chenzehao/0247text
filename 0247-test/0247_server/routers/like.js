const express=require('express');
const query=require('./query')
const pool=require('../pool')
const router=express.Router();

// 查询喜欢列表
router.get('/like_sear',(req,res)=>{
  let uid=req.session.uid
  if(!uid){
    res.send({code:-3,msg:'用户未登录'});
    return;
  }
  pool.query(`select * from aby_like_list where uid=${uid}`,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      var arr=[]
      for(var i in result){
        arr.unshift(result[i].rid)
      }
      let allLike=[]
      for(let i=0;i<arr.length;i++){
        pool.query(`select * from aby_room where rid=${arr[i]}`,(err,result)=>{
          if(result.length>0){
            allLike.push(result[0])
            if(allLike.length>=arr.length){
              res.send({code:1,data:allLike})
            }
          }
        })
      }
    }else{
      res.send({code:-1});
    }
  })
})

// 添加喜欢列表
router.get('/like_add',(req,res)=>{
  var uid=req.session.uid;
  if(!uid){
    res.send({code:-3,msg:'用户未登录'});
    return;
  }
  let rid=req.query.rid;//房间id
  var selSql=`select * from aby_like_list where rid=${rid} and uid=${uid}`;//查询语句
  var addSql=`insert into aby_like_list set ?`;//添加语句
  var insObj={uid:uid,rid:rid};//插入的数据对象
  query(selSql).then(result=>{
    if(result.length<=0){//说明结果中没有数据，可以插入新的数据
      return query(addSql,[insObj]);
    }else{//说明此数据已经添加
      res.send({code:-2,msg:'此数据已经存在'})
    }
  }).then(result=>{
    if(result.affectedRows>0){
      res.send({code:1,msg:'添加成功'});
    }else{
      res.send({code:-1,msg:'添加失败'});
    }
  })

})

// 删除喜欢列表
router.get('/like_del',(req,res)=>{
  let rid=req.query.rid;
  let uid=req.session.uid
  query('delete from aby_like_list where rid=? and uid=?',[rid,uid]).then(result=>{
    if(result.affectedRows>0){
      res.send({code:1,msg:'删除成功'});
    }else{      
      res.send({code:-1,msg:'删除失败'});
    }
  })
})

module.exports=router;