const express=require('express');
const query=require('./query')
const pool=require('../pool')
const router=express.Router();
// 修改头像模块 multer
const multer = require('multer');
const fs = require('fs');
// 保存头像目录
var upload = multer({dest:'../public/image/avatar'})

//当改变图片时，保存在服务器端
router.post("/upload",upload.single("mypic"),(req,res)=>{
  var file = req.file;
  //创建新文件名
  //获取原有文件名后缀 比如1.jpg
  var srcFile = file.originalname;
  var i1 = srcFile.lastIndexOf(".");
  var len = srcFile.length;
  var suffix = srcFile.substring(i1,len);
  //时间戳+随机数+后缀
  var fileName = new Date().getTime()+Math.floor(Math.random()*9999)+suffix;
  var newFileName = './public/image/avatar/'+fileName;
  //将临时文件移动upload目录
  //fs.renameSync() 阻塞(同步)
  fs.renameSync(file.path,newFileName);
  res.send({code:1,msg:"http://127.0.0.1:8088/image/avatar/"+fileName});
})


// 首页通过城市检索房源 12-12
router.get('/room/:location',(req,res)=>{
  //1.参数 页码 一页几行
  var pno=req.query.pno;
  var ps=req.query.pageSize;
  //2.默认指定页码一页几行
  if(!pno||pno<=0) pno=1//默认第一页
  if(!ps) ps=4//一页有多少

  var offset=(pno-1)*ps;
  ps=parseInt(ps);

  var location=req.params.location;
  var sql=`
  select r.*,count(c.cid) counts from aby_room r 
  left join aby_comment c on r.rid=c.rid 
  where room_location like '%${location}%' 
  group by r.rid 
  limit ${offset},${ps}
  `;
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      pro_comment(result).then(result=>{
        //处理评价分数
        for(let i=0;i<result.length;i++){
          var scoreSum=0;
          if(result[i].comment){
            for(var j=0;j<result[i].comment.length;j++){
              var oneRoom=0;
              oneRoom+=parseFloat(result[i].comment[j].truthfully_described);
              oneRoom+=parseFloat(result[i].comment[j].location_convenient);
              oneRoom+=parseFloat(result[i].comment[j].communication);
              oneRoom+=parseFloat(result[i].comment[j].move_in);
              oneRoom+=parseFloat(result[i].comment[j].clean);
              oneRoom+=parseFloat(result[i].comment[j].cost_performance);
              scoreSum+=(oneRoom/6);//每个房间的平均分
            }
            result[i].comment=scoreSum/result[i].comment.length;
          }
        }
        res.send({code:1,data:result})
      });
    }else{
      res.send({code:-1});
    }
  })
}); 

// 首页通过房源id检索评价数量 12-10
router.get('/commentCount/:rid',(req,res)=>{
  var rid=req.params.rid;
  var sql=`select count(*) count from aby_comment where rid=${rid}`;
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,data:result});
    }else{
      res.send({code:-1});
    }
  })
})

// 轮播图 12-10
router.get('/carousel',(req,res)=>{
  var sql=`select * from aby_index_carousel`;
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,data:result});
    }else{
      res.send({code:-1});
    }
  })
})

//Promise 查询房源对应评价列表 函数封装
function pro_comment(result1){
  return new Promise(
    function(resolve,reject){
      let result=[];
      let long=result1.length
      let i=0;
      for(let a=0;a<result1.length;a++){
        let rid=result1[a].rid;
        // let sql2=`select * from aby_comment where rid=${rid}`;
        let sql2=`select c.*,u.u_name,u.avatar from aby_comment c inner join aby_user u on u.uid=c.uid where rid=${rid}`;
        pool.query(sql2,(err,result2)=>{
          if(err) throw err;
          i++
          if(result2.length>0){
            result1[a].comment=result2;
            result.push(result1[a])
          }else{
            result.push(result1[a])
          }
          if(i==long){
            resolve(result)
          }
        })
      }
    }
  )
}
//Promise 查询房源是否在喜欢列表中
function pro_like(result,uid){
  return new Promise(resolve=>{
    var flagLength=0;
    let newArr=[]
    for(let i=0;i<result.length;i++){
      var sql=`select * from aby_like_list where rid=${result[i].rid} and uid=${uid}`;
      pool.query(sql,(err,like_result)=>{
        if(err) throw err;
        if(like_result.length>0){
          result[i].isLike=true;
          newArr.push(result[i])
        }else{
          result[i].isLike=false;
          newArr.push(result[i])
        }
        flagLength++;
        if(flagLength==result.length){
          resolve(newArr);
        }
      })
    }
  })
}


// 首页通过输入框内容检索出对应的房源列表 12-10
router.get('/roomList/:search',(req,res)=>{
  var uid=req.session.uid;
  var search=req.params.search;
  // var sql=`select * from aby_room where room_location like ?`;
  var sql=`select r.*,u.avatar from aby_room r left join aby_room_user u on u.uid=r.uid where r.room_location like ?`
  query(sql,[`%${search}%`])
  .then(result=>{
    if(result!=undefined){
      if(result.length>0){
        pro_comment(result).then(result=>{
          if(uid){
            pro_like(result,uid).then(result=>{
              res.send({code:1,data:result})
            })
          }else{
            res.send({code:1,data:result})
          }
        })
      }else{
        return query("select * from aby_room where big_title like ?",[`%${search}%`]);
      }
    }
  })
  .then(result=>{
    if(result!=undefined){
      if(result.length>0){
        // res.send({code:1,data:result});
        if(uid!=undefined){
          pro_like(result,uid).then(result=>{
            res.send({code:1,data:result})
          })
        }else{
          res.send({code:1,data:result})
        }
        // res.send({code:1,data:result})
      }else{
        return query("select * from aby_room where describ like ?",[`%${search}%`]);
      }
    }
  }).then(result=>{
    if(result!=undefined){
      if(result.length>0){
        // res.send({code:1,data:result});
        if(uid!=undefined){
          pro_like(result,uid).then(result=>{
            res.send({code:1,data:result})
          })
        }else{
          res.send({code:1,data:result})
        }
        // res.send({code:1,data:result})
      }else{
        res.send({code:-1});
      }
    }
  })
})

// 根据房源id查询房源详情(房源、评价、房东) 12-11
router.get('/roomDetail/:rid',(req,res)=>{
  var rid=req.params.rid;
  var uid=req.session.uid;
  var sql=`select r.*,u.*,d.* from aby_room r
    left join aby_room_user u on r.uid=u.uid
    left join aby_room_detail d on r.rid=d.rid
    where r.rid=${rid}`;
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result!=undefined){
      if(result.length>0){
        facility(result).then(result=>{
          // res.send({code:1,data:result});
          pro_comment(result).then(result=>{
            //处理评价分数
            for(let i=0;i<result.length;i++){
              var scoreSum=0;
              if(result[i].comment){
                for(var j=0;j<result[i].comment.length;j++){
                  var oneRoom=0;
                  oneRoom+=parseFloat(result[i].comment[j].truthfully_described);
                  oneRoom+=parseFloat(result[i].comment[j].location_convenient);
                  oneRoom+=parseFloat(result[i].comment[j].communication);
                  oneRoom+=parseFloat(result[i].comment[j].move_in);
                  oneRoom+=parseFloat(result[i].comment[j].clean);
                  oneRoom+=parseFloat(result[i].comment[j].cost_performance);
                  scoreSum+=(oneRoom/6);//每个房间的平均分
                }
                result[i].commentScore=scoreSum/result[i].comment.length;
              }
            }
            // res.send({code:1,data:result});
            if(uid){
              pro_like(result,uid).then(result=>{
                res.send({code:1,data:result});
              })
            }else{
              res.send({code:1,data:result});
            }
          })
        })
      }else{
        res.send({code:-1})
      }
    }
  })
})

// 查询四个设施表
function facility(result){
  return new Promise(
    function(resolve,reject){
      var rid=result[0].rid;
      var sql1=`select wifi,kitchen,shampoo,hair_dryer,articles_daily_use,air_conditioner,heating,tv,washer,desk,coat_hanger,iron from aby_base_facility where rid=${rid}`;
      query(sql1).then(result1=>{
        if(result1.length>0) {
          result[0].base=result1;
          return query(`select elevator,own_int,free_parking_spot from aby_mating_facility where rid=${rid}`);
        }
      }).then(result2=>{
        if(result2.length>0){
          result[0].mating=result2;
          return query(`select bathtub from aby_child_facility where rid=${rid}`);
        }
      }).then(result3=>{
        if(result3.length>0){
          result[0].child=result3;
          return query(`select smoke_siren,carbon_monoxide_siren from aby_safety_facility where rid=${rid}`);
        }
      }).then(result4=>{
        if(result4.length>0){
          result[0].safe=result4;
          resolve(result);
        }
      })
    }
  )
}

// 账号密码登录
router.get('/login',(req,res)=>{
  var username=req.query.phone;
  var sql=`select * from aby_user where phone=? and u_pwd=md5(?)`;
  var pass=req.query.pass;
  if(!username){
    username=req.query.email
    sql=`select * from aby_user where email=? and u_pwd=md5(?)`;
  }
  pool.query(sql,[username,pass],(err,result)=>{
    if(err) throw err;
    if(result.length>0){//登录成功
      //将登录成功用户id保存到session对象中
      req.session.uid=result[0].uid;
      res.send({code:1,msg:'登录成功',data:result});
    }else{
      res.send({code:-1})
    }
  })
})

// 房间列表页多条件查询
router.get('/condition',(req,res)=>{
  var sql=`select r.*,u.avatar from aby_room r left join aby_room_user u on u.uid=r.uid`;
  // 首先得到前台请求的数据对象
  var obj=req.query;
  var search=obj.search;//关键字
  var date=obj.date;//日期
  var man=eval(obj.man);//成年人
  var child=eval(obj.child);//小孩
  var little=eval(obj.little);//婴儿
  var minPrice=eval(obj.minPrice);//最小价格
  var maxPrice=eval(obj.maxPrice);//最大价格
  var roomType=obj.roomType;//房间类型
  var count=obj.count;//床、卧室、卫生间数量
  /* ------------------ */
  // 如果obj不为空,sql加where关键字
  if(Object.keys(obj).length>0||(search!=''&&date!=''&&man!=0&&child!=0&&little!=0&&minPrice!=0&&maxPrice!=5000&&roomType!=['false','false']&&count!='{"bed":0,"bedroom":0,"toliet":0}')){
    sql+=` where `;
  }
  /* ------------------ */
  // 判断生成最终sql查询
  if(search){//判断关键字是否传值 如果关键字已传值
    roomList(search).then(result=>{
      sql+=result;
      conditions(req,res,sql,date,man,child,little,minPrice,maxPrice,roomType,count)
    })
  }else{
    conditions(req,res,sql,date,man,child,little,minPrice,maxPrice,roomType,count)
  }
})

// 封装复杂查询除关键字外的检索
function conditions(req,res,sql,date,man,child,little,minPrice,maxPrice,roomType,count){
  var uid=req.session.uid;
  if(man||child||little){//判断人数是否传值 如果人数已传值
    var person_num=0;
    if(man) person_num+=parseFloat(man);
    if(child) person_num+=parseFloat(child);
    if(little) person_num+=parseFloat(little);
    sql+=`and person_num >= ${person_num} `;
  }
  // if(minPrice&&maxPrice){//判断最大/最小价格是否传值 如果价格已传值 值没传过来
    sql+=`and price BETWEEN ${minPrice} and ${maxPrice} `;
  // }
  if(roomType[0]=='true'&&roomType[1]=='false'){// 独立房间是否为true
    sql+=`and is_independent = 1 `;
  }else if(roomType[0]=='false'&&roomType[1]=='true'){// 合住房间是否为true
    sql+=`and is_independent = 0 `;
  }
  if(count){//判断床、卧室、卫生间数量 如果数量已传值
    var arr=count.split(',');//将传过来的对象字符串用,分隔开 得到数组
    var numArr=[];//用来存储最后的数量的数组 床/卧室/卫生间
    for(var i=0;i<arr.length;i++){
      if(i<arr.length-1){
        numArr.push(eval(arr[i].split(':')[1]));
      }else{
        numArr.push(eval(arr[i].split(':')[1].split('}')[0]));
      }
    }
    sql+=`and bed_num >= ${numArr[0]} and bedroom_num >= ${numArr[1]} and toilet_num >= ${numArr[2]} `;
  }
  if(date){//判断日期 如果日期已传值 值没传过来
    sql+=`and room_defined_date not like '%${date}%'`;    
  }
  
  sql=sql.replace(/(?<=where)\sand/g,'');//给sql语句进行处理，将where 后的 and关键字去掉
  // sql=sql.replace(//g,'')
  // 通过sql语句复杂检索
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      // res.send({code:1,msg:result});
      if(uid){
        pro_like(result,uid).then(result=>{
          res.send({code:1,msg:result});
        })
      }else{
        res.send({code:1,msg:result});
      }
    }else{
      res.send({code:-1});
    }
  })
}

// 封装查询房间列表函数
function roomList(search){
  var sqlResult=``;
  var sql=`select r.*,u.avatar from aby_room r left join aby_room_user u on u.uid=r.uid where r.room_location like ?`
  return new Promise(resolve=>{
    query(sql,[`%${search}%`])
    .then(result=>{
      if(result!=undefined){
        if(result.length>0){
          sqlResult=`and room_location like '%${search}%'`;
          resolve(sqlResult);
        }else{
          return query("select * from aby_room where big_title like ?",[`%${search}%`]);
        }
      }
    })
    .then(result=>{
      if(result!=undefined){
        if(result.length>0){
          sqlResult=`and big_title like '%${search}%'`;
          resolve(sqlResult);
        }else{
          return query("select * from aby_room where describ like ?",[`%${search}%`]);
        }
      }
    }).then(result=>{
      if(result!=undefined){
        if(result.length>0){
          sqlResult=`and describ like '%${search}%'`;
          resolve(sqlResult);
        }else{
          sqlResult=``;
          resolve(sqlResult);
        }
      }
    })
  })
  
}

// 修改用户
router.get('/updUser',(req,res)=>{
  var obj=req.query;
  pool.query('update aby_user set ? where uid = ?',[obj,obj.uid],(err,result)=>{
    if(err) throw err;
    if(result.affectedRows>0){
      res.send({code:1,msg:'修改成功'});
    }else{
      res.send({code:-1});
    }
  })
})

//判断用户id是否存在
router.get('/checkUser',(req,res)=>{
  var sessionUid=req.session.uid
  var getUid=req.query.uid
  if(sessionUid==getUid){
    res.send({code:1,msg:'用户已登录'})
  }else{
    res.send({code:2,msg:'用户未登录'})
  }
})

//退出登录
router.get('/logout', function(req, res) {
  req.session.destroy(function(err) {
    if(req.session==undefined){
      res.send({code:1,msg:'注销成功'});
    }else{
      res.send({code:-1,msg:'注销失败'});
    }
  })
})

//创建订单
router.get('/addOrder',(req,res)=>{
  //   o_date varchar(128), #订单详细日期
  //   o_days int, #订单天数
  //   o_time varchar(20), #订单创建时间
  //   o_price varchar(20), #订单总价
  //   isPay int, #订单状态 0未支付 1已支付
  //   uid int, #用户表id
  //   rid int #房屋表id
  var uid=req.session.uid;//用户id
  var obj=req.query;
  if(!uid){
    res.send({code:-1,msg:'用户未登录'});
    return;
  }
  pool.query('insert into aby_order set ?',[obj],(err,result)=>{
    if(err) throw err;
    if(result.affectedRows>0){
      pool.query('select * from aby_room where rid=?',[obj.rid],(err,result1)=>{//查询房间信息
        if(err) throw err;
        if(result1.length>0){
          // var defineDate=result1[0].room_defined_date+','+obj.o_date;
          var defineDate='';
          if(result1[0].room_defined_date==''){
            defineDate=obj.o_date
          }else{
            defineDate=result1[0].room_defined_date+','+obj.o_date;
          }
          pool.query('update aby_room set room_defined_date=? where rid=?',[defineDate,obj.rid],(err,result2)=>{//修改房间已定日期
            if(err) throw err;
            if(result2.affectedRows>0){
              res.send({code:1,msg:'订单创建成功',orderId:result.insertId});
            }else{
              res.send({code:-2,msg:'订单创建失败'})
            }
          })
        }else{
          res.send({code:-2,msg:'订单创建失败'})
        }
      })
    }else{
      res.send({code:-2,msg:'订单创建失败'});
    }
  })
})

// 订单列表
router.get('/orderList',(req,res)=>{
  var uid=req.session.uid;
  var sql='';
  var status=req.query.status;
  if(status==0){//订单未支付
    sql=`select * from aby_order where uid=? and isPay=0`;
  }else if(status==1){//订单已支付
    sql=`select * from aby_order where uid=? and isPay=1`;
  }else if(status==2){//全部订单
    sql=`select * from aby_order where uid=?`;
  }
  if(!uid){
    res.send({code:-1,msg:'用户未登录'});
    return;
  }
  pool.query(sql,[uid],(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      // res.send({code:1,data:result});
      pro_order(result).then(result=>{
        res.send({code:1,data:result});
      })
    }else{
      res.send({code:-2,msg:'没有相关订单'});
    }
  })
})

// 更新订单状态
router.get('/orderStatus',(req,res)=>{
  var uid=req.session.uid;
  var oid=req.query.oid;
  if(!uid){
    res.send({code:-1,msg:'用户未登录'});
    return;
  }
  pool.query('update aby_order set isPay=1 where uid=? and oid=?',[uid,oid],(err,result)=>{
    if(err) throw err;
    if(result.affectedRows>0){
      res.send({code:1,msg:'订单修改成功'});
    }else{
      res.send({code:-2,msg:'订单修改失败'});
    }
  })
})

// 删除订单
router.get('/orderDel',(req,res)=>{
  var uid=req.session.uid;
  var oid=req.query.oid;
  if(!uid){
    res.send({code:-1,msg:'用户未登录'});
    return;
  }
  var defineDate='';
  var rid='';
  query('select o_date,rid from aby_order where oid=?',[oid]).then(result=>{
    defineDate=result[0].o_date;//拿到指定订单的预定日期
    rid=result[0].rid;//拿到指定订单的房间号
    query('delete from aby_order where oid=?',[oid]).then(result=>{
      if(result.affectedRows>0){
        query('select room_defined_date from aby_room where rid=?',[rid]).then(result=>{
          var str='';
          if(result.length>0){
            var oldArr=defineDate.split(',');//订单的已订日期
            var newArr=result[0].room_defined_date.split(',');//对应房间的已订日期
            var threeArr=[]
            for(var i=0;i<oldArr.length;i++){
              for(var j=0;j<newArr.length;j++){
                if(oldArr[i]==newArr[j]){
                  // threeArr.push(oldArr[i]);
                  newArr.splice(j,1);
                }
              }
            }
            str=newArr.join(',');
            // var str=threeArr.join(',');
          }
          query('update aby_room set room_defined_date=? where rid=?',[str,rid]).then(result=>{
            if(result.affectedRows>0){
              res.send({code:1,msg:'订单删除成功'});
            }else{
              res.send({code:-2,msg:'订单删除失败'});
            }
          })
        })
      }else{
        res.send({code:-2,msg:'订单删除失败'});
      }
    })
  })
  // pool.query('delete from aby_order where oid=?',[oid],(err,result)=>{
  //   if(err) throw err;
  //   if(result.affectedRows>0){
  //     res.send({code:1,msg:'订单删除成功'});
  //     pool.query('',[],(err,result)=>{

  //     })
  //   }else{
  //     res.send({code:-2,msg:'订单删除失败'});
  //   }
  // })
})

// 获取订单状态
router.get('/getOrderStatus',(req,res)=>{
  var uid=req.session.uid;//用户id
  var oid=req.query.oid;
  if(!uid){
    res.send({code:-1,msg:'用户未登录'});
    return;
  }
  pool.query('select isPay from aby_order where oid=?',[oid],(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,data:result});
    }else{
      res.send({code:-2});
    }
  })
})

// 封装订单房间数据
function pro_order(result){
  return new Promise(resolve=>{
    var orderLength=0;
    for(let i=0;i<result.length;i++){
      var rid=result[i].rid;
      var sql=`select * from aby_room where rid=${rid}`;
      pool.query(sql,(err,result1)=>{
        if(err) throw err;
        if(result1.length>0){
          result[i].room=result1;
        }
        orderLength++;
        if(orderLength==result.length){
          resolve(result);
        }
      })
    }
  })
}

// 浏览记录分页查询
router.get('/record',(req,res)=>{
  var uid=req.session.uid;
  if(!uid){
    res.send({code:-1,msg:'用户未登录'});
    return;
  }
  var rids=req.query.rids;
  rids=rids.split(',')
  rids[0]=rids[0].slice(1)
  rids[rids.length-1]=rids[rids.length-1].slice(0,-1)
  
  var sql=`select * from aby_room where rid in (${rids})`;
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      // 把result结果处理成rids的顺序
      var newArr=[];
      for(var i=0;i<rids.length;i++){
        for(var j=0;j<result.length;j++){
          if(result[j].rid==rids[i]){
            newArr[i]=result[j]
          }
        }
      }
      res.send({code:1,data:newArr})
    }else{
      res.send({code:-1});
    }
  })
  //1.参数 页码 一页几行
  // var pno=req.query.pno;
  // var ps=req.query.pageSize;
  // //2.默认指定页码一页几行
  // if(!pno||pno<=0) pno=1//默认第一页
  // if(!ps) ps=4//一页有多少

  // var offset=(pno-1)*ps;
  // ps=parseInt(ps);

  // var sql=`select * from aby_room where rid in (${rids}) limit ${offset},${ps}`;
  // pool.query(sql,(err,result)=>{
  //   if(err) throw err;
  //   if(result.length){
  //     res.send({code:1,data:result});
  //   }else{
  //     res.send({code:-1});
  //   }
  // })
})

module.exports=router;