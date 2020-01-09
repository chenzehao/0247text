
const getTimeSTR = (day) => {
    let a = day.split(',')
    let start = new Date(parseInt(a[0]))
    let end = new Date(parseInt(a[a.length-1]))
    return start.getMonth()+1+'月'+start.getDate()+'日至'+(end.getMonth()+1)+"月"+end.getDate()+'日'
}

const isFinish = (time) => {
    let timer = time.split(',')
    let start = parseInt(timer[0])
    let end = parseInt(timer[timer.length-1])
    let timeNow = new Date().getTime()
    if(start>timeNow){
        return '行程未开始'
    }else if(start<timeNow && end>timeNow){
        return '行程进行中'
    }else{
        return '行程已完成'
    }
}

const getFirstImage = (img) => {
    let arr = img.split(',')
    return arr[0]
}

export default {
    getTimeSTR,isFinish,getFirstImage
}