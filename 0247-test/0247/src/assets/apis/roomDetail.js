import axios from 'axios';
export function getRoomDetail(rid){
  return new Promise((resolve,reject)=>{
    axios.get(`/index/roomDetail/${rid}`).then(result=>{
      resolve(result.data);
    })
  })
}