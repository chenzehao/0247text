<template>
<!-- 页脚 -->
  <div class="foot">
    <!-- 下拉列表 -->
    <div class="one">
      <!-- 语言 -->
      <div class="selector">
        <select  name="language_selector">
            <option v-for="(language,i) in languages" :key="i">
              {{language}}
            </option>
        </select>
        <span class="_1idvclr">
          <svg viewBox="0 0 18 18" role="presentation" aria-hidden="true" focusable="false">
            <path d="m16.29 4.3a1 1 0 1 1 1.41 1.42l-8 8a1 1 0 0 1 -1.41 0l-8-8a1 1 0 1 1 1.41-1.42l7.29 7.29z" fill-rule="evenodd"></path>
          </svg>
        </span>
      </div>
      <!-- 币种 -->
      <div class="selector">
        <select  name="money_selector">
            <option v-for="(money,i) in moneies" :key="i">
              {{money}}
            </option>
        </select>
        <span class="_1idvclr">
          <svg viewBox="0 0 18 18" role="presentation" aria-hidden="true" focusable="false">
          <path d="m16.29 4.3a1 1 0 1 1 1.41 1.42l-8 8a1 1 0 0 1 -1.41 0l-8-8a1 1 0 1 1 1.41-1.42l7.29 7.29z" fill-rule="evenodd"></path>
        </svg>
        </span>
      </div>
    </div>
    <div class="two">
      <!-- 注册/登录 -->
      <div class="t-one">
          <button>注册/登录</button>
      </div>
      <!-- 条款 -->
      <div class="t-one">
        <button >条款</button>
      </div>      
    </div>
    <div class="two">
      <!-- 帮助 -->
      <div class="t-one">
        <button>帮助</button>
      </div>
      <!-- 隐私政策 -->
      <div class="t-one">
        <button>隐私政策</button>
      </div>
    </div>
    <!-- 底部文字 -->
    <div class="bottom">
    </div>

  </div>
</template>
<script>
export default {
  data(){
    return{
      languages:['中文(简体)','Bahasa Indonesia','Bahasa Melayu','Català','Dansk','Deutsch','English','Español','Eλληνικά','Français','Hrvatski','Italiano','Magyar','Nederlands','Norsk','Polski','Português','Suomi','Svenska','Türkçe','Íslenska','Čeština','Русский','ภาษาไทย','中文 (繁體)','日本語','한국어'],
      moneies:['CNY 人民币','USD 美元','JPY 日元','HKD 港币','TWD 新台币','EUR 欧元','GBP 英镑','AUD 澳大利亚元','AED 阿联酋迪拉姆','BGN 保加利亚列弗','PLN 波兰兹罗提','BRL 巴西雷亚尔','DKK 丹麦克朗','RUB 俄罗斯卢布','PHP 菲律宾比索','COP 哥伦比亚比索','CRC 哥斯达黎加科朗','KRW 韩元','KRW 韩元','CAD 加拿大元','HRK 克罗地亚库纳','RON 罗马尼亚列伊','MAD 摩洛哥迪拉姆','PEN 秘鲁索尔','MYR 马来西亚林吉特','MXN 墨西哥比索','ZAR 南非兰特','NOK 挪威克朗','SEK 瑞典克朗','CHF 瑞士法郎','SAR 沙特里亚尔','TRY 土耳其里拉','THB 泰铢','UYU 乌拉圭比索','SGD 新加坡元','NZD 新西兰元','HUF 匈牙利福林','INR 印度卢比','ILS 以色列新谢克尔','CLP 智利比索']

    }
  }
}
</script>
<style stoped>
  /* 页脚 */
  .foot{
    margin:24px 24px 0 24px !important;
    border-top:rgba(196, 196, 196, 0.2);
  }
  /* 页脚公有样式 */
  .foot>.one,.foot>.two{
    width:100% !important;
    height:44px;
    display: flex;
  }
  .foot>.one>.selector,.foot>.two>.t-one{
    width:50% !important;
    font-size: 14px !important;
    display: flex;
    justify-content: flex-start;
    padding:0 8px 0 8px;
    position: relative;
  }
  /* 下拉列表 */
  .foot>.one>.selector>select{
    width:100%;
    background-color: #fff !important;
    color:#484848;
    font-size:16px;
    padding:11px 40px 11px 11px;
    -webkit-appearance: none !important;
    appearance:none;
    -moz-appearance:none;
    outline: none;
    border: 1px solid rgba(196, 196, 196, 0.2) !important;
  }
  .foot>.one>.selector>._1idvclr{
    position: absolute !important;
    top: 16px !important;
    right: 16px !important;
  }
  .foot>.one>.selector>._1idvclr>svg{
    height: 16px;
    width: 16px;
    display: block;
  }
  .foot>.two>.t-one>button{
    width:100%;
    background: none;
    border:none;
    text-align: left;
    color:#484848;
    font-size: 14px;
    line-height: 44px;
  }
  .foot>.two>.t-one>a{
    width:100%;
    color:#484848;
    font-size: 14px;
    text-align: left;
    line-height: 44px;
    text-indent: 2px;
  }
  /* <!-- 底部文字 --> */
  .bottom{
    display: flex;
    flex-wrap: wrap;
    text-align: left;
    margin-top: 24px;
    margin-bottom: 64px;
  }
  .bottom>div{
    font-size: 10px !important;
    color: #767676 !important;
    display: inline-block !important;
    margin-top:4px;
  }
  .bottom>div>a{
    color: #767676 !important;
  }
</style>