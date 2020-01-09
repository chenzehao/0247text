<template>
  <div class="detail-room">
    <div class="center-box">
      <div class="one_room" v-for="(item,i) of toBedRoom" :key="i" v-show="item">
        <p class="roomName">{{roomName[i]}}</p>
        <div class="roomImg">
          <svg v-if="bedRooms[i].name=='双人床'" viewBox="0 0 24 24" role="presentation" aria-hidden="true" focusable="false" style="height:24px;width:24px;fill:currentColor"><path d="m23.96 14.81-2.96-7.41v-5.02a1.39 1.39 0 0 0 -1.39-1.38h-15.22c-.77 0-1.39.62-1.39 1.38v5.02l-2.96 7.41-.04.19v5.61c0 .64.43 1.17 1.01 1.33 0 .02-.01.04-.01.06v1.5a.5.5 0 0 0 1 0v-1.5h20v1.5a.5.5 0 0 0 1 0v-1.5c0-.02-.01-.04-.01-.06a1.39 1.39 0 0 0 1.01-1.33v-5.61zm-19.96-12.43c0-.21.17-.38.39-.38h15.22a.39.39 0 0 1 .39.39v4.61h-1v-1.61c0-.77-.62-1.39-1.39-1.39h-3.21c-.78 0-1.4.62-1.4 1.39v1.61h-2v-1.61c0-.77-.62-1.39-1.39-1.39h-3.22c-.77 0-1.39.62-1.39 1.39v1.61h-1zm14 3.01v3.21a.39.39 0 0 1 -.39.39h-3.21a.39.39 0 0 1 -.4-.38v-3.22a.39.39 0 0 1 .39-.39h3.21a.39.39 0 0 1 .39.39zm-8 0v3.21a.39.39 0 0 1 -.39.4h-3.22a.39.39 0 0 1 -.39-.39v-3.22a.39.39 0 0 1 .39-.39h3.21a.39.39 0 0 1 .39.39zm-6.16 2.61h1.16v.61c0 .77.62 1.39 1.39 1.39h3.21c.78 0 1.4-.62 1.4-1.39v-.61h2v .61c0 .78.62 1.39 1.39 1.39h3.21c.78 0 1.4-.62 1.4-1.39v-.61h1.16l2.8 7h-21.92zm19.16 12.61c0 .21-.18.39-.39.39h-21.22a.39.39 0 0 1 -.39-.39v-4.61h22z" fill-rule="evenodd"></path></svg><!--双人床-->
          <svg v-else-if="bedRooms[i].name=='单人床'" viewBox="0 0 24 24" role="presentation" aria-hidden="true" focusable="false" style="height: 24px; width: 24px; fill: currentcolor;"><path d="m20.99 15.39-1.99-8.45v-5.44c0-.83-.68-1.5-1.5-1.5h-10a1.5 1.5 0 0 0 -1.5 1.5v5.44l-1.99 8.44-.01.12v5.01c0 .66.43 1.2 1.02 1.4-.01.03-.02.06-.02.09v1.5a.5.5 0 0 0 1 0v-1.5h13v1.5a.5.5 0 0 0 1 0v-1.5c0-.03-.01-.06-.02-.09a1.49 1.49 0 0 0 1.02-1.4v-5.01l-.01-.12zm-13.99-13.89a.5.5 0 0 1 .5-.5h9.99c.27 0 .5.23.5.5v4.5h-2v-2.51c.01-.82-.66-1.49-1.48-1.49h-4.02c-.82 0-1.49.67-1.49 1.49v2.51h-2zm8 1.99v4.02a.5.5 0 0 1 -.49.49h-4.02a.5.5 0 0 1 -.49-.49v-4.02c0-.27.22-.49.49-.49h4.02c.27 0 .49.22.49.49zm-8.01 3.63.01-.12h2v .51c0 .82.67 1.49 1.49 1.49h4.02c.82 0 1.49-.67 1.49-1.49v-.51h2l .01.12 1.86 7.88h-14.74l1.86-7.89zm13.01 13.39a.5.5 0 0 1 -.5.49h-14c-.28 0-.5-.22-.5-.49v-4.51h15z" fill-rule="evenodd"></path></svg><!--单人床-->
          <svg v-else viewBox="0 0 24 24" role="presentation" aria-hidden="true" focusable="false" style="height: 24px; width: 24px; fill: currentcolor;"><path d="m22.95 16.29v-.01l-.95-1.9-.01-5.38c0-1.47-1.46-2.77-2.99-2.97v-1.53a2.5 2.5 0 0 0 -2.51-2.5h-9.98a2.5 2.5 0 0 0 -2.51 2.5v1.55c-1.57.21-3 1.48-3 2.96v5.38l-.95 1.89v.01a.49.49 0 0 0 -.05.21v3a .5.5 0 0 0 .5.5h.5v1.5a.5.5 0 0 0 1 0v-1.5h19v1.5a.5.5 0 0 0 1 0v-1.5h.5a.5.5 0 0 0 .5-.5v-3a .49.49 0 0 0 -.05-.21zm-3.95-9.25c1.02.19 1.99 1.08 1.99 1.97v3.37l-1.99-4zm-7-4.04h4.49c.83 0 1.51.67 1.51 1.5v3.5h-6zm0 6h6.19l3.5 7h-20.38l3.5-7zm-7-4.5a1.5 1.5 0 0 1 1.51-1.5h4.49v5h-6zm-3 4.51c0-.89.94-1.76 2-1.96v1.33l-2 4zm20 9.99h-21v-2h21z" fill-rule="evenodd"></path></svg><!--沙发床 -->
        </div>
        <p class="roomDesc">{{item}}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    toBedRoom:{type:Array},
    bedRooms:{type:Array}
  },
  data(){
    return{
      bedRoom:[],//存储床的数量和名称
      roomName:['卧室1','卧室2','卧室3','客厅/公共区域']
    }
  }
}
</script>

<style scoped>
.detail-room{
  background:#fff;
  padding:16px 0;
  border-bottom:8px solid #f2f2f2;
  /* text-align:left; */
}
.detail-room .center-box{
  display:flex;
  overflow-x: auto;
}
.detail-room .center-box::-webkit-scrollbar{
  display:none
}
.detail-room .one_room{
  /* width:152px; */
  flex:none;
  padding:12px 16px;
  border:1px solid #ebebeb;
  border-radius:4px;
  margin-right:16px;
  box-sizing:border-box;
}
.detail-room .roomName{
  font-size:10px;
  font-weight: bold;
}
.detail-room .roomImg{
  padding:16px 0;
}
.detail-room .roomDesc{
  font-size:14px;
  line-height:18px;
  color:#484848
}
</style>