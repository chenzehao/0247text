var sql=require('mysql');
var pool=sql.createPool({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'aby',
  connectionLimit: 10 
});
module.exports=pool;