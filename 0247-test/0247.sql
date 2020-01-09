SET NAMES UTF8;
DROP DATABASE IF EXISTS aby;
CREATE DATABASE aby CHARSET=UTF8;
USE aby;

/*管理员表*/
create table aby_manager(
  mid int primary key auto_increment, 
  username varchar(20), #用户名
  pwd varchar(20) #密码
);

/*用户表*/
/*用户表*/
create table aby_user(
  uid int primary key auto_increment,
  sex int default 0, #性别 0|1
  u_name varchar(128) default '', #用户名
  u_pwd varchar(128), #密码
  avatar varchar(128) default '', #头像
  email varchar(64) default '', #电子邮件
  intro varchar(200) default '', #自我介绍
  phone varchar(16), #手机号 
  age varchar(8) default '18',  #年龄
  home varchar(32) default '',  #家乡
  city varchar(32) default '',  #所在城市
  education varchar(32) default '', #教育
  industry varchar(32) default ''  #行业
);

/*首页轮播图表*/
create table aby_index_carousel(
  cid int primary key auto_increment,
  image_path varchar(128), #图片地址
  big_title varchar(64), #图片主标题
  small_title varchar(64), #图片副标题
  href varchar(128) #图片链接
);

/*喜欢列表 表*/
create table aby_like_list(
  lid int primary key auto_increment,
  uid int, #用户表id
  rid int #房屋表id
);

/*订单表*/
create table aby_order(
  oid int primary key auto_increment,
  o_date varchar(128), #订单详细日期
  o_days int, #订单天数
  o_time varchar(30), #订单创建时间
  o_price varchar(20), #订单总价
  isPay int default 0, #订单状态 0未支付 1已支付
  uid int, #用户表id
  rid int #房屋表id
);

/*房间表*/
create table aby_room(
  rid int primary key auto_increment,
  image_list varchar(500), #图片列表
  describ varchar(30), #房间描述
  big_title varchar(128), #房间主标题
  price DECIMAL(10,2), #房间价格
  bedroom_num int, #卧室数量
  bed_num int, #床的数量
  toilet_num int, #卫生间的数量
  person_num int, #最多容纳几人
  room_advantage varchar(128), #房间优势 如：(近地铁站、可以做饭、可存行李...)
  room_outline varchar(500), #房源概要
  room_detail varchar(500), #房源细节
  is_independent int, #是否有独立房间 0 无|1 有
  room_in varchar(20), #入住时间
  room_out varchar(20), #退房时间
  is_auto int, #是否可以自助入住 0 no|1 yes
  accuracy varchar(128), #房源精度
  latitude varchar(128), #房源纬度
  room_location varchar(128), #房源位置 如北京，中国
  romm_location_desc varchar(200), #位置描述
  travel_info varchar(200), #出行信息
  room_defined_date varchar(500), #房间已定日期
  uid int #房东表id
);

/*房间详情表*/
create table aby_room_detail(
  did int primary key auto_increment,
  romm_one varchar(20), #卧室1
  romm_two varchar(20), #卧室2
  romm_three varchar(20), #卧室3
  romm_public varchar(20), #客厅公共区域
  rid int #房间表id
);

/*基础设施表 所有存储0|1*/
create table aby_base_facility(
  bid int primary key auto_increment,
  wifi int, #无线
  kitchen int, #厨房
  shampoo int, #洗发水 
  hair_dryer int, #吹风机
  articles_daily_use int, #生活必需品
  air_conditioner int, #空调
  heating int, #暖气
  tv int, #电视
  washer int, #洗衣机
  desk int, #书桌/工作区域
  coat_hanger int, #衣架
  iron int, #熨斗
  rid int #房间表id
);

/*配套设施表*/
create table aby_mating_facility(
  mid int primary key auto_increment,
  elevator int, #电梯
  own_int int, #独立入口
  free_parking_spot int, #免费停车位
  rid int #房间表id
);

/*儿童设施表*/
create table aby_child_facility(
  cid int primary key auto_increment,
  bathtub int, #浴缸
  rid int #房间表id
);

/*安全设施表*/
create table aby_safety_facility(
  sid int primary key auto_increment,
  smoke_siren int, #烟雾报警器
  carbon_monoxide_siren int, #一氧化碳报警器
  rid int #房间表id
);

/*评价表*/
create table aby_comment(
  cid int primary key auto_increment,
  com_date varchar(30), #评价日期
  com_desc varchar(128), #评价描述
  truthfully_described varchar(10),#如实描述
  location_convenient varchar(10), #位置便利
  communication varchar(10), #沟通交流
  move_in varchar(10), #入住顺利
  clean varchar(10), #干净卫生
  cost_performance varchar(10), #高性价比
  rid int, #房间表id
  uid int #用户表id
);

/*房东表*/
create table aby_room_user(
  uid int primary key auto_increment,
  user_name varchar(128), #名称
  sex int, #性别 0 男 1 女
  avatar varchar(128), #头像
  register_time varchar(128), #注册时间
  intro varchar(200), #自我介绍
  can_language varchar(30), #语言
  recovery_rate varchar(10), #回复率
  recovery_time varchar(10), #回复时间 如：一小时内
  is_reg int, #是否验证 0|1
  is_super_praise int #是否为超赞房东
);

/*点击次数记录表 暂不用 */
create table aby_click_count(
  cid int primary key auto_increment
);

/*****************房间表插入数据*****************/
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d1-1.jpg,http://127.0.0.1:8088/image/details/d1-2.jpg,http://127.0.0.1:8088/image/details/d1-3.jpg,http://127.0.0.1:8088/image/details/d1-4.jpg,http://127.0.0.1:8088/image/details/d1-5.jpg,http://127.0.0.1:8088/image/details/d1-6.jpg,http://127.0.0.1:8088/image/details/d1-7.jpg,http://127.0.0.1:8088/image/details/d1-8.jpg,http://127.0.0.1:8088/image/details/d1-9.jpg','北京 · 普通公寓里的独立房间','天安门 王府井 国贸 欢乐谷 5号线,10号线宋家庄地铁站 【 晓贺之家】之【贺】交通便利',288,1,1,1,2,'近地铁站|高性价比|可存行李','【晓贺之家】内共有三个房间,我们自己住一个房间,还有两个房间分别为【晓】､【贺】,风格不一样哦｡晚上关灯后打开星星灯别有一番感觉｡PS: Unable to provide services for foreign friends|紧邻地铁宋家庄站(5号线､10号线),交通便利,|周围有首开-福茂商场,京客隆超市,可满足日常生活需求｡|快餐有KFC､麦当劳､味多美面包坊,呷脯呷脯､虾吃虾涮､老家肉饼等等|来到这里希望您可以全身心的放松,可以有一种回到家的感觉,我们会提供一次性牙膏及梳子,鉴于个人卫生习惯,不提供毛巾,请自备｡在淋浴过程中洗发露与沐浴液都是和我们用一样的牌子｡|来到这里:|NO.1地理位置超级好|宋家庄地铁站为5号线的始发站,10号线为北京最大环线,宋家庄为10号线的中间站,只需转1次地铁,便可去各大景点:天坛､王府井､西单､东单､欢乐谷､雍和宫等等｡|NO.2推荐特色美食|作为两枚地道吃货,我们会推荐当地美食,还有各种给特色小吃街哦,让您绝对不虚此行｡|NO.3规划行程|我们会根据您的旅游时间,为您推荐最适合的形成,让您在北京玩的开心｡','房间白天和晚上都会给您带来不一样的惊喜,不定期还会有饭后甜点及水果哦｡',1,'14:00后','12:00',0,'116.434908','39.851735','宋家庄·北京，中国','地理位置非常好,在宋家庄地铁站｡5号线始发站,并且在北京最大环线10号线地铁,可直达及转站地铁,到达大部分旅游及知名商圈｡','Tips:|5号线地铁|5号直达【天坛】【雍和宫】|5号转7号—【欢乐谷景区】【北京西站】|5号转14号—【北京南站】【朝阳公园】【望京】|5号转1号—【国贸】【王府井】【天安门】【西单】【军事博物馆】|5号转2号—【前门】【鼓楼大街】【北京站】|5号转6号—【南锣鼓巷】【北海北】|5号转15号—【奥林匹克公园】【清华大学】','',1);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d2-1.jpg,http://127.0.0.1:8088/image/details/d2-2.jpg,http://127.0.0.1:8088/image/details/d2-3.jpg,http://127.0.0.1:8088/image/details/d2-4.jpg,http://127.0.0.1:8088/image/details/d2-5.jpg,http://127.0.0.1:8088/image/details/d2-6.jpg,http://127.0.0.1:8088/image/details/d2-7.jpg,http://127.0.0.1:8088/image/details/d2-8.jpg,http://127.0.0.1:8088/image/details/d2-9.jpg','北京 · 普通公寓里的独立房间','【温馨观景厅室】 (只接待女孩由屏风和布帘组成)近天安门故宫前门王府井北京南站南苑机场8/14地铁',1010,1,1,1,1,'近地铁站|高性价比|自助入住|可以做饭|可存行李','森系田园小清新风,属于客厅隔间,由屏风和帘布隔出的一个独立空间,最多只可住一人,有门无锁,但很安全哒~|是两室一厅一卫一厨的客厅,另外两个卧室,一间接待客人也是规定只接待女生,另一间是我父母在住哦~|亲亲们~土土家提供免费寄存行李哦,可以提前来放行李也可以退房当天寄存｡此套房源基本是只接待女孩子,家里很安全也很温馨,希望小姐姐们住的开心放心|除了床单被套基础设施之外,我们还将提供:|1.一次性牙刷牙膏以及非一次性漱口杯|2.一客一洗的毛巾浴巾|3.非一次性凉拖|4.洗发露,沐浴液|5.加湿器|6.烧水壶|7.晾水壶以及水杯|8.碧然德滤水壶|9.吹风机|等等|很多小姐姐看见房间第一句都是“哇,好大呀,比图片上看着大多了”哈哈,原谅我拍照技术有限,实际确实比图片上看起来大一些哦~|位于黄金中轴线,眺望窗外,从永定门到故宫一直到鸟巢都可以一览无余!室内采光极好,设备齐全,温馨舒适,满足你的少女心|交通非常方便!位于永定门外大街,离地铁永定门外站步行5分钟即到｡公交车站就在小区门口｡离北京南站一站地的距离','这个厅室身为房主的初衷是想为独自来北京的小姐姐们提供一个舒适又温暖的环境,性价比也很高!虽是客厅隔间,但是布置的很温馨,小细节都有关注到,沙发床专门配了床垫,让亲睡的更舒服~还有一座小沙发和一个大茶几桌,可以写字工作｡大台灯化妆镜收纳盒小绿植加湿器茶水套装甚至晾衣杆都有,有木有很贴心|以下是房主的内心独白~~~啦啦啦~~|(挑剔的客人请绕行!!!我们绝不欢迎以五星级的标准来要求民宿的客人,如果您真的那么挑剔那么请您选择更加合适的住所,我们真的接待不起!!办民宿以来,遇到了各式各样的小姐姐,大多都非常有礼貌也很亲切随和可爱有趣,感谢你们的到来让我和家人的生活充满了色彩!房主真的是很用心的想给来北京的小姐姐们提供一个温暖的房间,让你们能感受到家的感觉｡但是我们确实不是五星级的酒店,肯定会有不足的地方,欢迎交流意见,我们也很乐意接受并及时调整!谢谢你们的支持和认可~~~么么哒!)',1,'14:00后','12:00',1,'116.385488','39.87128','南站·北京·中国','离北京南站 南苑机场 前门 天坛 西单 天安门都近哦~位于二环中轴线 纵观永定门故宫一直到鸟巢 感兴趣的亲可以带上望远镜眺望帝都夜景 快来放空心灵吧','离土土家比较近的景点:天坛公园,自然博物馆,前门,西单,天安门,故宫,王府井等等|*故宫/清华/北大需要提前预约|*看升国旗建议从我家(夏季三点/冬季五点)打车过去,顺的话十几分钟就能到的,因为需要排队过安检,人也比较多,去晚了几本就看不到什么了~|*长城/奥林匹克/鸟巢/水立方,建议买一日游,车接车送的,选择适合自己的路线,起点定北京南站即可｡大众点评/ (Hidden by Airbnb) / (Hidden by Airbnb) 一般都有卖的哦~','',1);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d3-1.jpg,http://127.0.0.1:8088/image/details/d3-2.jpg,http://127.0.0.1:8088/image/details/d3-3.jpg,http://127.0.0.1:8088/image/details/d3-4.jpg,http://127.0.0.1:8088/image/details/d3-5.jpg,http://127.0.0.1:8088/image/details/d3-6.jpg,http://127.0.0.1:8088/image/details/d3-7.jpg,http://127.0.0.1:8088/image/details/d3-8.jpg,http://127.0.0.1:8088/image/details/d3-9.jpg','北京 · 整间LOFT','Ruined houseA【距离雍和宫地铁站仅300米】(面积最大,设施最棒)后海､南锣鼓巷､故宫',338,1,1,1,2,'近地铁站|高性价比|可以做饭','If you are not from China please contact me before you book. (如果您不是中国人,请在预订前联系我｡)|您好|这里是你的佛系房东志楠|一个96年有理想的哥哥或弟弟:D|我的房子在雍和宫旁边的五道营胡同里面|一个杂院里面的五间房(我住了一间)|因为是杂院所以说实话|院子里的环境挺一般的|不过室内肯定是没问题的哈|每间房都是小型loft|并且都有独立的卫生间|厨房有只有一间需要大家共用|调味品和厨具都很齐全|到附近的地铁站步行大概4分钟|雍和宫站2号线和5号线|每间房都是我自己设计装修的|耗时三个月投入了很多心血|所以真的希望你能在这里找到家的感觉|并且喜欢这里','',1,'14:00后','12:00',0,'116.424879','39.955113','文化胡同·北京，中国','我们的小房子坐落于北京著名的文化胡同.|这条胡同里各色餐馆和店铺林立,可以满足多种味觉需求,多种购物需求.','胡同东西向胡同口均通往最近的地铁站和附近景区,距离二环内诸多著名名胜古迹非常近.|距离地铁站五分钟.胡同口还有公交去往各个方向.','',2);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d4-1.jpg,http://127.0.0.1:8088/image/details/d4-2.jpg,http://127.0.0.1:8088/image/details/d4-3.jpg,http://127.0.0.1:8088/image/details/d4-4.jpg,http://127.0.0.1:8088/image/details/d4-5.jpg,http://127.0.0.1:8088/image/details/d4-6.jpg,http://127.0.0.1:8088/image/details/d4-7.jpg,http://127.0.0.1:8088/image/details/d4-8.jpg,http://127.0.0.1:8088/image/details/d4-9.jpg','北京 · 普通公寓里的独立房间','【山2】二环中心 2/7/5地铁|各交通站点直达|5km内至东单前门天安门故宫三里屯核心地标',158,1,1,1,2,'高性价比|可以做饭|可存行李','这是一个舒适的私人空间,小区的周围是各种商店和市场,交通便利｡ 对于旅行者来说这是一个很好的选择,对于学生朋友来说,这里更是绝对不能错过的地方,整洁干净､设备齐全,性价比超级好哦!在这里你不会感到寂寞,因为我们努力的营造着一个真正的家的氛围｡','为“游在山海间”的你,真正的提供“住进人情里”的感受｡如果你愿意可以在这里享受一顿家常菜,即使在外也能有家的感觉｡',1,'','12:00',0,'116.424365','39.916383','南城·北京，中国','这里是北京南城,距离南三环路有3分钟的步行路程｡ 南城是一个拥有许多餐馆和市场的住宅区｡ 如果您想体验北京人的日常生活,那么这是一个不错的选择｡','离10号线和5号线都特别近,可以步行过去｡三环路上公交车站很多,几乎哪里都能到｡另外我的房源离北京南站特别近,打车过来最多15分钟｡','',2);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d5-1.jpg,http://127.0.0.1:8088/image/details/d5-2.jpg,http://127.0.0.1:8088/image/details/d5-3.jpg,http://127.0.0.1:8088/image/details/d5-4.jpg,http://127.0.0.1:8088/image/details/d5-5.jpg,http://127.0.0.1:8088/image/details/d5-6.jpg,http://127.0.0.1:8088/image/details/d5-7.jpg,http://127.0.0.1:8088/image/details/d5-8.jpg,http://127.0.0.1:8088/image/details/d5-9.jpg','上海 · 整间LOFT','Greendoor/ Spainsh style/FCC',589,1,1,1,1,'高性价比|自助入住','-----------------------------------|请您务必阅读所有房屋说明|这个价格,地段 设计 已经尽力啦(눈_눈)苛刻者请移步其他房东房源｡目前房间预订只限一个人入住｡只住的下一个人｡|房源位于华山路武康庭｡西班牙洋房建筑,位于衡复文化区, 华山路/长乐路/武康路/安福路路口,上海四大网红街交汇处,紧邻上海戏剧学院｡优雅的梧桐,斑驳的树影,沿街老洋房犹如气度不凡､面容端庄的老太太,娓娓诉说着她们曾经的花样年华｡哪怕是一面墙,也许它也曾见证了这里辉煌的过去;哪怕是一株草,也许它已经陪伴历史度过了无数个风风雨雨｡ (ps:如果你们觉得这种老别墅房子是破房子的,也请移步其他房源)',"room is same as photo shows,small but cozy,if your height more than 180cm,please don't book this small room ,because bed size is 1m*2m just for a single man and not huge man .toilet is sepreate from the room ,in front of door.|many coffee and bakery shop around here . such as baker&spice etc1km from subway station, Changshu road station, line 7&/line 1. it mean you need walk around 10-15mints.4 stations from bund .|5 stations from YU YUAN & CHENG HUANG MIAO (YU YUAN GARDEN AND CITY GOD TEMPLE)",0,'16:00后','12:00',1,'121.445453','31.212883','上海，中国','武康路 安福路,两条我最近喜欢的路,希望你们也可以意会到它｡安福路像一位能一见钟情就迅速坠入爱河的恋人,即使耗尽新鲜感,经历从热恋到习以为常冷淡期,还能体味到历久弥新的深度,也会领悟到平平淡淡从从容容才是真的真理｡就像当红小生李宗翰在博客中写道:“安福路给我一种莫名的安定感,说不上来的似曾相识 ”｡','穿过镇宁路就有到达上海各热门景点的快速公交网红71路｡|往左走,江苏路地铁站有2/11号线,往右走,静安寺地铁站有2/7号线,附近ofo､摩拜共享单车很多｡骑单车到达两个地铁站大约只要5分钟｡|步行到地铁1/7号线常熟路地铁站1.2km左右,大约10分钟｡附近也有上海图书馆地铁站10号线｡','',2);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d6-1.jpg,http://127.0.0.1:8088/image/details/d6-2.jpg,http://127.0.0.1:8088/image/details/d6-3.jpg,http://127.0.0.1:8088/image/details/d6-4.jpg,http://127.0.0.1:8088/image/details/d6-5.jpg,http://127.0.0.1:8088/image/details/d6-6.jpg,http://127.0.0.1:8088/image/details/d6-7.jpg,http://127.0.0.1:8088/image/details/d6-8.jpg,http://127.0.0.1:8088/image/details/d6-9.jpg','成都市 · 整套公寓','限时特惠!【高层视野榻榻米房】可开发票/春熙路/宽窄巷子/地铁口 / 乳胶寝具/祖马龙个护',198,1,1,1,3,'近地铁站|高性价比|自助入住|可以做饭','请注意:本房源不在春熙路,由于谷歌地图偏差原因,我们正在联系系统解决此问题｡|本房源不在春熙路,房源位骡马市地铁站F口,位置绝佳,交通极其便利,毗邻富力中心､成都体育馆, 乘坐地铁一站直达文殊院､宽窄巷子､天府广场五分钟即可到春熙路｡|如果此房源在您选定日期无房,请点击我的头像浏览我在的另外几套房源,同样装修风格,同样硬件设施,为您带来同样的体验｡|超过｢ 两年｣民宿运营经验|我们的房源全部都是｢实拍｣|不做任何｢PS｣不加任何｢滤镜｣让您所见即所得|正宗｢市中心｣房源|室内｢新风系统｣中央空调 保证新鲜空气循环','榻榻米房间,户型方正,房源内所有空间房客均可使用',0,'15:00后','',1,'104.073514','30.673819','成都市，四川省，中国','民宿位于西玉龙街和顺城大街主干线,成都CBD核心地带,过马路就是富力天汇广场,餐饮娱乐十分便利,紧邻成都市中心天府广场,春熙路,宽窄巷子,锦里,交通便利,四通八达,吃喝玩乐一应俱全','请注意:本房源不在春熙路,由于谷歌地图偏差原因,我们正在联系系统解决此问题｡本房源不在春熙路,房源位骡马市地铁站F口,位置绝佳,交通极其便利,毗邻富力中心､成都体育馆, 乘坐地铁一站直达文殊院､宽窄巷子､天府广场五分钟即可到春熙路｡|民宿就在地铁1号线,4号线换乘站骡马市站地面,步行入站只需要三分钟｡|距离天府广场､宽窄巷子一站直达,步行五分钟可至富力天汇购物中心','',2);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d7-1.jpg,http://127.0.0.1:8088/image/details/d7-2.jpg,http://127.0.0.1:8088/image/details/d7-3.jpg,http://127.0.0.1:8088/image/details/d7-4.jpg,http://127.0.0.1:8088/image/details/d7-5.jpg,http://127.0.0.1:8088/image/details/d7-6.jpg,http://127.0.0.1:8088/image/details/d7-7.jpg,http://127.0.0.1:8088/image/details/d7-8.jpg,http://127.0.0.1:8088/image/details/d7-9.jpg','西安市 · 整套公寓','[星宿•贰]西安南门外城墙边2号线地铁口旁日系原木投影房,近碑林钟楼回民街体育场大雁塔南门酒吧街',318,1,1,1,2,'近地铁站|高性价比|自助入住|可以做饭','房源处于中轴线上,城墙脚下,交通便利,房间可观长安街夜景;|房屋位于长安北路,全新小区,楼下即就是商场,距离地铁站200米,距离城墙250米,附近有机场大巴停靠站点(30分钟一趟,票价25元)距离小寨､钟楼均20分钟可达;|靠近城墙景区售票处,紧邻南大街酒吧街,吃喝玩乐配套设施齐全,附近有便利店､小吃街､电影院､酒吧等','房屋位于长安北路,全新小区,临近商场和地铁,家电齐全,宽带已接入!全新日系原木装修,配备百寸高清投影,公寓的房间面积为45平米,大窗配备蒲席和坐垫,可供禅思及冥想,房间明亮通风,驻足窗前即见城市美景,空气清新,视野开阔｡配有一张大床,家电家具齐全｡',0,'15:00后','12:00',1,'108.954072','34.239557','西安市，陕西省，中国','房源处于中轴线上,城墙脚下,交通便利,房间可观长安街夜景;|房屋位于长安北路,全新小区,楼下即就是商场,距离地铁站200米,距离城墙250米,附近有机场大巴停靠站点(30分钟一趟,票价25元)距离小寨､钟楼均20分钟可达;|靠近城墙景区售票处,紧邻南大街酒吧街,吃喝玩乐配套设施齐全,附近有便利店､小吃街､电影院､酒吧等','公交: (Phone number hidden by Airbnb) 路;教育专线;游7路;游8/610路|地铁:2号线永宁门站,可达钟楼､小寨､北客站等｡|机场大巴:南稍门西安宾馆站,30分钟一趟,票价25元｡','',1);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d8-1.jpg,http://127.0.0.1:8088/image/details/d8-2.jpg,http://127.0.0.1:8088/image/details/d8-3.jpg,http://127.0.0.1:8088/image/details/d8-4.jpg,http://127.0.0.1:8088/image/details/d8-5.jpg,http://127.0.0.1:8088/image/details/d8-6.jpg,http://127.0.0.1:8088/image/details/d8-7.jpg,http://127.0.0.1:8088/image/details/d8-8.jpg,http://127.0.0.1:8088/image/details/d8-9.jpg','西安市 · 整套公寓','room3 城墙大雁塔之下简欧风格温馨舒适,大雁塔地铁4号线李家村站步行2分钟即到万达广场 交通便利',225,1,1,1,2,'可存行李','房间是一个大的开间宽敞明亮,有独立的卫生间,交通特别便利,距离市内景点特别近','温馨舒适,简洁大方,非常适合度假旅游｡房间是一个大的开间宽敞明亮,有独立的卫生间｡配搭暖色调舒适效果给你带来家一样的体验和感觉｡',0,'15:00后','12:00',0,'108.974339','34.231552','碑林区李家村路，西安市，陕西省，中国','楼下有万达广场,里面小吃很多,购买生活用品也很方便,门口有十几条公交车站,交通十分便利｡楼下还有星巴克咖啡｡','门口就是李家村大型公交站台,因为是主干道有多条公交线路｡有 (Phone number hidden by Airbnb) 等公交线路｡楼下就是万达的大型停车场｡','',1);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d9-1.jpg,http://127.0.0.1:8088/image/details/d9-2.jpg,http://127.0.0.1:8088/image/details/d9-3.jpg,http://127.0.0.1:8088/image/details/d9-4.jpg,http://127.0.0.1:8088/image/details/d9-5.jpg,http://127.0.0.1:8088/image/details/d9-6.jpg,http://127.0.0.1:8088/image/details/d9-7.jpg,http://127.0.0.1:8088/image/details/d9-8.jpg,http://127.0.0.1:8088/image/details/d9-9.jpg','北京 · 整间LOFT','(网红打卡皇城根loft)南锣鼓巷地铁站200米 天安门 故宫 雍和宫 故宫 景山 北海 王府井',259,1,1,1,4,'可以做饭|可存行李','抱歉因一些特殊原因外籍港澳台,新疆西藏客人输不接待敬请谅解|所处位置离南锣鼓巷步行2分钟,步行后海5分钟烟袋斜街5分钟,簋街步行10分钟|房子的位置位于北京北城正中心,去哪里都非常方便地图所见','原清末明初建筑房高五米,单层墙体厚达50公分以上,老式城墙砖,冬暖夏凉,远观古朴,屋内装修现代,|所处位置离南锣鼓巷步行2分钟,步行后海5分钟烟袋斜街5分钟,簋街步行10分钟|房子的位置位于北京北城正中心,去哪里都非常方便地图所见',0,'14:00后','12:00',0,'116.411271','39.901576','北海，北京，中国','天安门   北海   什刹海,故宫    雍和宫    恭王府    南锣鼓巷,宋庆龄故居,景山公园   太 (Website hidden by Airbnb) 火神庙','地铁六号线八号线|公交 (Phone number hidden by Airbnb) 特八  特九  三路 (Phone number hidden by Airbnb)','',3);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d10-1.jpg,http://127.0.0.1:8088/image/details/d10-2.jpg,http://127.0.0.1:8088/image/details/d10-3.jpg,http://127.0.0.1:8088/image/details/d10-4.jpg,http://127.0.0.1:8088/image/details/d10-5.jpg,http://127.0.0.1:8088/image/details/d10-6.jpg,http://127.0.0.1:8088/image/details/d10-7.jpg,http://127.0.0.1:8088/image/details/d10-8.jpg,http://127.0.0.1:8088/image/details/d10-9.jpg','上海 · 整套公寓','09{四地铁交汇}畅游*清新一居/近光启城.衡山路/上海体育馆/第六人民医院',218,1,1,1,2,'高性价比|自助入住','独门独户!不是合租的房间!同一个小区差不多的我有八间,这间没了可以点进我的主页看看别间|一公里内4个地铁站,出行方便｡地铁3号线,4号线,宜山路地铁站,1号线,4号线上海体育馆,1号线,11号线徐家汇站,4号线上海体育场｡ 距离复旦大学附属华山医院(伽马医院)仅1.1公里,步行即可到达｡ 距离第六人民医院,胸科医院步行20分钟即可到达｡ 全新装修,屋内配套设施齐全｡','【位置】 房源所处位置位于徐汇区蒲汇塘路文定路路路口,位于徐家汇,宜山路,上海体育馆地铁站中间位置,毗邻上海电影集团,徐汇区政府,周边有光启公园,徐家汇圣依纳爵主教堂,徐汇公学旧址,徐家汇公园,漕溪公园,距离光启城,星游城,美罗城,步行十分钟即可到达｡|【房屋亮点】 专业保洁清扫,五星级品质床品,让您住的安心｡ 房屋配置智能密码锁,一客一密码,出入无需钥匙门卡｡ 专业入住指引,全程自助,给您最安静的享受｡|【屋内设施】 房屋内均提供24小时热水,无线Wi-Fi,电视,免费提供一次性牙刷牙膏,免费提供洗发水､沐浴乳､浴巾,拖鞋,吹风机,热水壶｡所有床上用品及浴巾一客一换,干净卫生,房屋均配备冷暖空调,独立卫生间｡',1,'15:00后','12:00',1,'121.390331','31.171867','上海，中国','房源周边光启城,星游城,美罗城,太平洋百货等商场都可以去购物哦~房源出来就有便利店哦,可以购买日常生活用品呢｡距离最近的医院是复旦大学附属中山医院徐汇医院｡凯进路56号文定菜市场可以买菜呢,最近的停车场在文定路200号,停车10元/小时,80元/天｡','上海火车站:距离上海火车站9公里,地铁4号线直达,宜山路站3号口出,约35分钟,打车约30元｡ 虹桥火车站/虹桥机场:距离15公里,打车40分钟,50元｡地铁10号线虹桥路站转4号线,宜山路站3号口出,约40分钟 浦东机场; 距离47公里,打车约1小时,170元｡地铁2号线世纪大道站转4号线,上海体育馆站4号口出,约1小时30分钟','',4);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d11-1.jpg,http://127.0.0.1:8088/image/details/d11-2.jpg,http://127.0.0.1:8088/image/details/d11-3.jpg,http://127.0.0.1:8088/image/details/d11-4.jpg,http://127.0.0.1:8088/image/details/d11-5.jpg,http://127.0.0.1:8088/image/details/d11-6.jpg,http://127.0.0.1:8088/image/details/d11-7.jpg,http://127.0.0.1:8088/image/details/d11-8.jpg,http://127.0.0.1:8088/image/details/d11-9.jpg','上海 · 整套房子','【MOSSYHOUSE】独门整租,永康路网红街,近地铁1/10/12号线/淮海中路/新天地/田子坊',160,1,1,1,2,'高性价比|自助入住|可以做饭','请务必仔细阅读以下内容哈|【MOSSYHOUSE】位于淮海中路iapm环贸附近,是屋主Mossy和与女票共同设计的一间独立小房｡我们像对待自己的孩子一样用心经营这间小屋,希望通过小屋结识来自世界各地的你们,努力给热爱旅行的你们带来最好的旅行体验｡|订前一定要看详情!!确保您接受详情中的缺点再预定,所以我们不接受5星以下的差评,如果您居住中有任何的问题,都希望先和我们沟通,我们会尽所有努力解决!','￫房间概况|1. 房屋设计简单而温馨,面积不大但五脏俱全,包括独立卫生间,厨房,一张榻榻米双人床,还有很有趣的床底秘密基地,是单人或情侣来上海旅行的或短租的最佳选择｡|2. 房间设施包括空调,烘洗一体洗衣机,灶台,抽烟机,冰箱,淋浴,马桶｡|3. 房间安装有100兆电信宽带,网速很快,看剧游戏无压力｡|4. 房间提供沐浴露,洗发水,牙膏,牙刷,矿泉水,水杯,碗,盘,卫生纸等,总之房间内你能看到的都可以用｡|5. 放置冰箱的柜子里放有一个小凳子,由于房间床有一定高度,所以凳子是拉出来做小台阶的,然后行李箱就可以放置在柜子里啦｡',1,'13:00后','11:00',1,'121.443035','31.209538','上海，中国','位于上海市中心淮海中路Iapm附近的历史文化建筑保护区,位置超好,周围都是老洋房,环境很棒,体验上海本地生活,闹中取静｡','7分钟步行500米即可至地铁1/10/12号线陕西南路地铁站','',4);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d12-1.jpg,http://127.0.0.1:8088/image/details/d12-2.jpg,http://127.0.0.1:8088/image/details/d12-3.jpg,http://127.0.0.1:8088/image/details/d12-4.jpg,http://127.0.0.1:8088/image/details/d12-5.jpg,http://127.0.0.1:8088/image/details/d12-6.jpg,http://127.0.0.1:8088/image/details/d12-7.jpg,http://127.0.0.1:8088/image/details/d12-8.jpg,http://127.0.0.1:8088/image/details/d12-9.jpg','上海 · 独栋房里的独立房间','【丛林卷】民宿/上海最有设计感的ins网红民宿/田子坊淮海中路/花园洋房/主卧独卫/2人以上高性价比',300,1,2,1,3,'自助入住|可以做饭|可存行李','【丛林卷】民宿是设计师打造的美式艺术简风家居 所有的木制品均为手工打造,给你艺术的氛围 是网红打卡的拍照首选｡隐于闹市的民宿会带给你不一样的体验｡房屋位于徐汇区嘉善路169弄 ,位于上海市中心,10min到达淮海中路,上海最大的UA､adidas､Nike旗舰店,享受摩登城市带来的魅力｡这是上海最小资的区域,几乎可以找到所有美食网红店｡基本上可以走路去田子坊新天地｡出租车程十分钟之內可达徐家汇､外滩等顶级商圈｡小区门口就有超市,24小时便利店｡1km内有4个地铁站,适合打卡魔都的你｡整套房子为独门进入,进门便是阳光院子可在院子内high tea享受午后阳光｡ 您预定的房间在进门主卧,房间里默认设有2米宽双人床一张､如需加床联系房东､高档床品一客一换,舒适的被褥枕头､洗漱用品､毛巾､拖鞋､高速wifi ､空调､地毯,独立卫生间洗浴间､配备全地暖､洗衣机､厨房用品 ｡客厅玻璃窗使得屋内拥有超棒采光阳光从玻璃房顶洒入怎么摆拍都很美 ｡冰箱里已经为您准备好冷饮,即使短暂停留也能感受到家的温度,很高兴认识你｡入住前可联系房东为您解惑,也请预定前仔细阅读房屋守则｡请勿带走任何品哦,否则照价赔偿','如果这个房源不可定 点击我的头像 查看其他房源进行预订哦',1,'14:00后','12:00',1,'121.466752','31.215182','上海，中国','近白月光 田子坊 淮海中路 等商圈|距离外滩/城隍庙15分钟车程','如果你要去虹桥火车站或虹桥机场乘坐地铁10号线30分钟,如果你去往浦东机场可以连接换乘的2号线｡','',4);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d13-1.jpg,http://127.0.0.1:8088/image/details/d13-2.jpg,http://127.0.0.1:8088/image/details/d13-3.jpg,http://127.0.0.1:8088/image/details/d13-4.jpg,http://127.0.0.1:8088/image/details/d13-5.jpg,http://127.0.0.1:8088/image/details/d13-6.jpg,http://127.0.0.1:8088/image/details/d13-7.jpg,http://127.0.0.1:8088/image/details/d13-8.jpg,http://127.0.0.1:8088/image/details/d13-9.jpg','成都市 · 整套公寓','连住有惊喜【高层优享大床房】可开发票/春熙路/宽窄巷子/地铁口 / 乳胶寝具/祖马龙个护',292,1,1,1,2,'近地铁站|自助入住|可以做饭','请注意:本房源不在春熙路,由于谷歌地图偏差原因,我们正在联系系统解决此问题｡|本房源不在春熙路,房源位骡马市地铁站F口,位置绝佳,交通极其便利,毗邻富力中心､成都体育馆, 乘坐地铁一站直达文殊院､宽窄巷子､天府广场五分钟即可到春熙路｡|如果此房源在您选定日期无房,请点击我的头像浏览我在的另外几套房源,同样装修风格,同样硬件设施,为您带来同样的体验｡','房源内部空间房客均可使用',0,'15:00后','',1,'104.071501','30.675101','成都市，四川省，中国','民宿位于西玉龙街和顺城大街主干线,成都CBD核心地带,过马路就是富力天汇广场,餐饮娱乐十分便利,紧邻成都市中心天府广场,春熙路,宽窄巷子,锦里,交通便利,四通八达,吃喝玩乐一应俱全','请注意:本房源不在春熙路,由于谷歌地图偏差原因,我们正在联系系统解决此问题｡本房源不在春熙路,房源位骡马市地铁站F口,位置绝佳,交通极其便利,毗邻富力中心､成都体育馆, 乘坐地铁一站直达文殊院､宽窄巷子､天府广场五分钟即可到春熙路｡|民宿就在地铁1号线,4号线换乘站骡马市站地面,步行入站只需要三分钟｡|距离天府广场､宽窄巷子一站直达,步行五分钟可至富力天汇购物中心','',2);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d14-1.jpg,http://127.0.0.1:8088/image/details/d14-2.jpg,http://127.0.0.1:8088/image/details/d14-3.jpg,http://127.0.0.1:8088/image/details/d14-4.jpg,http://127.0.0.1:8088/image/details/d14-5.jpg,http://127.0.0.1:8088/image/details/d14-6.jpg,http://127.0.0.1:8088/image/details/d14-7.jpg,http://127.0.0.1:8088/image/details/d14-8.jpg,http://127.0.0.1:8088/image/details/d14-9.jpg','成都市 · 整套公寓','【廊桥夜梦】市中心|安顺廊桥|成都十景|合江亭|九眼桥酒吧一条街|春熙路|江景房',888,1,1,1,2,'可以做饭','这是一间位于【安顺廊桥】九眼桥旁的舒适公寓,九眼桥夜景尽收眼底｡|家里我选了现代白的色调带来超舒适的质感｡|一室一厅+一厨一卫,可住2人｡除了无比舒适的棉麻大床,还有极米Z6投影､高速Wi-Fi､超大客厅可将九眼桥繁华夜景尽收眼底｡','Hi ,我是你的可爱房东,很高兴认识你,有预感你也是个有趣的人喔!|喜欢住民宿的你,一定也是厌倦了酒店式的千篇一律和毫无新意,希望在旅途中也拥有家的温暖与陪伴｡同样在我心里,民宿充满温柔的力量,让旅途中的我们收获回家的全身心放松与舒适,还能在朝夕之间感受当地最真实淳朴的生活文化,认识更多有趣的灵魂,探索从未遇见的精彩｡|欢迎来到我的小家,用心布置的家和静心挑选的好物希望你喜欢,如果小家已被预定,【点击我的头像】还能看到更多可爱的房子~在您预定前我们可以在Airbnb平台沟通,我会保持在线,有问题随时联系我哦｡预定确认后,可在社交软件/电话保持联系｡|你什么都不用想,只管好好住!',1,'15:00后','',0,'104.411684','30.323736','成都，四川，中国','住在这里,不仅享受舒适的居住空间,而且你的生活有超多选择,很多地方抬脚即达~|1､我家附近生活非常方便,有重庆船长老灶火锅､重庆袁老四老火锅､梨园火锅､蓉城老饕食堂等;全家便利店､WOWO便利店､水果店､红旗超市､各大银行｡|2､20分钟步行到:春熙路､太古里､大慈寺,楼下就是九眼桥酒吧街|3､临近多家著名医院:四川省第四人民医院､四川电力医院|4､位于成都核心地区:临近太古里､春熙路､九眼桥等地,对旅游观光的朋友太友好了|5､20分钟车程:到达宽窄巷子､杜甫草堂､成都东站等地','1､到达我家的最近地铁站|3号线【新南门】站,B口,步行800米|2号线【东门大桥】站,A口,步行1000米|7站￫成都东站|7站￫成都站(火车北站)|2､火车站|  【成都东站】打车25分钟/地铁30分钟|  【成都站】打车28分钟/地铁30分钟|3､机场|  【成都双流国际机场】47分钟打车/地铁46分钟','',5);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d15-1.jpg,http://127.0.0.1:8088/image/details/d15-2.jpg,http://127.0.0.1:8088/image/details/d15-3.jpg,http://127.0.0.1:8088/image/details/d15-4.jpg,http://127.0.0.1:8088/image/details/d15-5.jpg,http://127.0.0.1:8088/image/details/d15-6.jpg,http://127.0.0.1:8088/image/details/d15-7.jpg,http://127.0.0.1:8088/image/details/d15-8.jpg,http://127.0.0.1:8088/image/details/d15-9.jpg','成都市 · 整套公寓','【Ricardo-爱若】文殊院地铁站100米,浪漫主义,想和你共度余生',269,1,1,1,2,'近地铁站|自助入住','———关于Ricardo-爱若———|爱若是绝望 以洒脱心体验刹那戏台|爱若是邪心 与其谈心与其俱飞起来|爱若灌我醉 我定踏入极地而不知还|爱若清我醒 何时渡过欲流到达彼 (Website hidden by Airbnb) ——《爱若》陈粒','———关于房屋构造———|爱若是一室一卫的整套民宿,房屋内有一张1.5m的双人床,还有一个可以看夜景拍照的小阳台｡爱若是以婚礼为主题的民宿,适合大家在这里拍拍拍,我们提供了头纱､手捧花等道具｡房屋内设施一应俱全,有小米水离子吹风机､卷发棒,配备了坚果巨幕投影仪,可以窝在其中看电影听音乐,非常浪漫,适合情侣出行或者朋友结伴游玩｡|———关于房屋位置及交通———|爱若距离文殊院地铁站100m,步行1分钟可至地铁站,步行13分钟到达文殊院,地铁20分钟到达春熙路,17分钟到达宽窄巷子,40分钟到达锦里｡|从机场-爱若:地铁50分钟可到达｡|从成都东站-爱若:地铁37分钟可到达｡|从成都南站-爱若:地铁26分钟可到达｡|楼下就有便利店及饭店,距离183米有铂金城购物广场,637米有富力天汇购物广场,931米有百盛｡周围吃喝玩乐一应俱全,非常方便~',1,'14:00后','12:00',1,'104.079039','30.680152','成都市，四川省，中国','距离文殊院步行10分钟即可到达,文殊院旁有很出名的洞子口张老二凉粉','因为楼下就是地铁站,建议乘坐地铁出行,去哪里都很方便','',6);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d16-1.jpg,http://127.0.0.1:8088/image/details/d16-2.jpg,http://127.0.0.1:8088/image/details/d16-3.jpg,http://127.0.0.1:8088/image/details/d16-4.jpg,http://127.0.0.1:8088/image/details/d16-5.jpg,http://127.0.0.1:8088/image/details/d16-6.jpg,http://127.0.0.1:8088/image/details/d16-7.jpg,http://127.0.0.1:8088/image/details/d16-8.jpg,http://127.0.0.1:8088/image/details/d16-9.jpg','西安市 · 整套公寓','西巷⑤､巨惠月!钟楼*回民街*浪漫星空顶*高端公寓步行十分钟到钟楼/回民街/鼓楼/城墙/永宁门/南门',95,1,1,1,2,'近地铁站|自助入住','【Go.民宿】位于西安城中心,步行十分钟就是钟楼,步行五分钟是回民街及地铁口,实现了真正的闹中取静,方便快捷｡配备高端投影仪加智能电视,可以躺在大床上享受高清大片,也可以窝在沙发上看电视!满足您所有的需求! 感谢您可以点开我的民宿,愿用您三分钟阅读下面的文字来了解我!这是我一个个字码上去的,并没有复制和抄袭!您也可以点开我的头像,选择另一种房间风格,体验不同的感觉!同时,我们是持有正规营业执照的民宿,在相关部门均进行备案,正规化管理模式,为您的安全加以保障!|在旅途中,要享受住宿带给我们的舒适｡清晨的一杯牛奶和一份早餐,静静坐在沙发上享用,细细品味千年古城的第一缕阳光,计划旅途,晒一晒太阳,把时间放慢,再放慢｡|傍晚逛累了,泡一杯茶或一杯咖啡,选一部喜欢的电影,让时间轻抚着疲惫的身体,闭目养神,发一发呆,或是静静地思考旅行的意义,是舒适而不是凑合｡|夜幕降临,躺在舒适的大床上一杯酒､一段故事,这才是旅行,这一刻,仿佛一切归于平静｡|交通便利､设施齐全､安全､干净､舒适｡这是我们民宿的标准!总之,在您舒适旅行之余,也一定会让您感觉到物超所值~','【周边】|在市中心,周边设施很齐全,楼下有特色小吃､星巴克､24小时便利店､超市､ktv､电影院､药店､医院等成熟的设施配套,楼下即是商场,吃喝玩乐一条龙,步行500米即是大洋百货(类似于万达的综合体商场),看电影､购物､吃饭､娱乐一应俱全｡楼下不远即是回民街(西羊市､北院门),也是西安最火的网红街,欢迎您去打卡｡晚上小区旁边有夜市,吃烤肉,喝啤酒,一定能满足你的味蕾｡所以可以说,吃､喝､玩,仅需步行十分钟,即可享受｡|【出行】|去钟楼､回民街,地铁口步行大约五分钟(800米左右),碑林博物馆,书院门(古董､字画､古宅一条街),骡马市(网红店很多的一个地方,老牌步行商业街)､青曲社(苗阜 王声的相声社),顺城巷､城墙､酒吧一条街基本上都是步行即可到达｡所以我建议您可以选择慢慢行走在千年古都的街头,一边品味着古都的慢生活,一边欣赏着古都的魅力｡不要再为目的地而疲于奔波,旅行的真谛是随心,当然,因为在市中心,即使你晚上回来的再晚,也不会让您觉得不安全｡|【安全】|首先,我们是持有正规营业执照的民宿,并在当地相关部门进行备案,为您的安全､卫生加以保障!我们的名称:宏府大厦,有兴趣的朋友可以搜搜这个地址,可以看到内部环境｡公寓是酒店式管理服务,区别于老旧小区和普通居民楼｡楼下大堂有保安服务,公共区域全摄像头覆盖,24小时保安巡逻,为您的旅行安全保障｡|【舒适】|Wifi､24小时热水供应､空调､天然气､卫浴等设备齐全｡我还为大家准备了比较好的一次性洗漱用品,带有自己logo的一次性拖鞋等消耗品,同时还配有大桶品牌洗发水､沐浴露､牙膏,适合连续居住多日的您｡浴巾,毛巾,床单,被罩都是次次消毒清洗｡为您旅游的舒适､干净加以保障｡|【省心】|我们采用的高档指纹密码锁,区别于普通的指纹密码锁,安全保证的同时在您入住时间内给您单独授权一个独一无二的密码,入住期间密码不变,在您退房后,密码自动失效｡为您旅途减少更多麻烦,您的省心,是对我最大的评价｡',0,'14:00后','12:00',1,'108.95346','34.265725','西安市，陕西省，中国','楼下有星巴克,酒吧,商场,等等一应俱全','楼下即是公交站,步行十分钟是钟楼,回民街,及地铁口｡','',7);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d17-1.jpg,http://127.0.0.1:8088/image/details/d17-2.jpg,http://127.0.0.1:8088/image/details/d17-3.jpg,http://127.0.0.1:8088/image/details/d17-4.jpg,http://127.0.0.1:8088/image/details/d17-5.jpg,http://127.0.0.1:8088/image/details/d17-6.jpg,http://127.0.0.1:8088/image/details/d17-7.jpg,http://127.0.0.1:8088/image/details/d17-8.jpg,http://127.0.0.1:8088/image/details/d17-9.jpg','西安市 · 整套公寓','【一再•白露】100英寸巨幕投影/地铁旁/城墙/回民街/钟楼/大雁塔/南门/小寨/北客站',110,1,1,1,2,'近地铁站|高性价比|自助入住','社区较老,所以我对整体房屋进行了全面的改造,将老旧电视换成100英寸巨幕投影,以及加入了浓厚艺术气息的布景,请在绘画区尽情展示您的艺术天赋吧~','一室的大开间配合独立的卫生间结合舒适宽敞的精装设计满足您的视觉味蕾+居住体验',1,'15:00后','12:00',1,'108.946324','34.25583','西安市，陕西省，中国','楼下就有便利店,清晨周边街区有很多当地地道的早饭摊位哦','距离一号线玉祥门地铁站直线距离500米,距离房屋200米的位置有公交车站,离西安最著名的小吃街“回民街”仅有一站地铁站的距离','',7);


/*****************房间详情表插入数据*****************/
insert into aby_room_detail values(null,'1张 1.8米宽双人床','','','',1);
insert into aby_room_detail values(null,'1张沙发床','','','',2);
insert into aby_room_detail values(null,'','','','1张 1.8米宽双人床',3);
insert into aby_room_detail values(null,'1张小号双人床','','','',4);
insert into aby_room_detail values(null,'1张 1米宽单人床','','','1张沙发床',5);
insert into aby_room_detail values(null,'1张 2米宽双人床','','','',6);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','','','',7);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','','','',8);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','','','',9);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','','','',10);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','','','',11);
insert into aby_room_detail values(null,'1张 2米宽双人床，1张沙发床','','','',12);
insert into aby_room_detail values(null,'1张 2米宽双人床','','','',13);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','','','',14);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','','','',15);
insert into aby_room_detail values(null,'1张 2米宽双人床','','','',16);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','','','',17);

/*****************基础设施表插入数据*****************/
insert into aby_base_facility values(null,1,0,1,1,1,1,1,0,1,1,1,1,1);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,0,1,1,1,0,2);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,3);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,4);
insert into aby_base_facility values(null,1,0,1,1,1,1,1,0,0,1,1,1,5);
insert into aby_base_facility values(null,1,0,1,1,1,1,1,0,0,1,1,1,6);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,0,7);
insert into aby_base_facility values(null,1,0,1,1,1,1,1,1,0,0,1,0,8);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,9);
insert into aby_base_facility values(null,1,0,1,1,1,1,1,1,1,1,1,1,10);
insert into aby_base_facility values(null,1,1,1,1,1,1,0,0,1,1,0,0,11);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,0,12);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,0,13);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,0,1,1,14);
insert into aby_base_facility values(null,1,0,1,1,1,1,0,1,1,0,1,0,15);
insert into aby_base_facility values(null,1,0,1,1,1,1,1,1,0,1,1,1,16);
insert into aby_base_facility values(null,1,0,1,1,1,1,1,1,0,1,1,0,17);

/*****************配套设施表插入数据*****************/
insert into aby_mating_facility values(null,1,1,0,1);
insert into aby_mating_facility values(null,1,0,0,2);
insert into aby_mating_facility values(null,0,0,0,3);
insert into aby_mating_facility values(null,1,0,0,4);
insert into aby_mating_facility values(null,0,0,0,5);
insert into aby_mating_facility values(null,0,0,0,6);
insert into aby_mating_facility values(null,1,1,0,7);
insert into aby_mating_facility values(null,1,1,0,8);
insert into aby_mating_facility values(null,0,1,0,9);
insert into aby_mating_facility values(null,1,1,0,10);
insert into aby_mating_facility values(null,0,1,0,11);
insert into aby_mating_facility values(null,0,1,0,12);
insert into aby_mating_facility values(null,1,1,0,13);
insert into aby_mating_facility values(null,1,1,0,14);
insert into aby_mating_facility values(null,1,1,0,15);
insert into aby_mating_facility values(null,1,1,0,16);
insert into aby_mating_facility values(null,1,0,0,17);

/*****************儿童设施表插入数据*****************/
insert into aby_child_facility values(null,0,1);
insert into aby_child_facility values(null,0,2);
insert into aby_child_facility values(null,0,3);
insert into aby_child_facility values(null,0,4);
insert into aby_child_facility values(null,0,5);
insert into aby_child_facility values(null,0,6);
insert into aby_child_facility values(null,0,7);
insert into aby_child_facility values(null,0,8);
insert into aby_child_facility values(null,0,9);
insert into aby_child_facility values(null,0,10);
insert into aby_child_facility values(null,0,11);
insert into aby_child_facility values(null,0,12);
insert into aby_child_facility values(null,0,13);
insert into aby_child_facility values(null,1,14);
insert into aby_child_facility values(null,0,15);
insert into aby_child_facility values(null,0,16);
insert into aby_child_facility values(null,0,17);

/*****************安全设施表插入数据*****************/
insert into aby_safety_facility values(null,1,0,1);
insert into aby_safety_facility values(null,0,0,2);
insert into aby_safety_facility values(null,0,0,3);
insert into aby_safety_facility values(null,1,1,4);
insert into aby_safety_facility values(null,1,0,5);
insert into aby_safety_facility values(null,1,0,6);
insert into aby_safety_facility values(null,1,1,7);
insert into aby_safety_facility values(null,0,0,8);
insert into aby_safety_facility values(null,1,1,9);
insert into aby_safety_facility values(null,1,1,10);
insert into aby_safety_facility values(null,0,0,11);
insert into aby_safety_facility values(null,1,1,12);
insert into aby_safety_facility values(null,1,1,13);
insert into aby_safety_facility values(null,1,1,14);
insert into aby_safety_facility values(null,1,0,15);
insert into aby_safety_facility values(null,1,1,16);
insert into aby_safety_facility values(null,0,0,17);

/*new房间表*/
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d18-1.jpg,http://127.0.0.1:8088/image/details/d18-2.jpg,http://127.0.0.1:8088/image/details/d18-3.jpg,http://127.0.0.1:8088/image/details/d18-4.jpg,http://127.0.0.1:8088/image/details/d18-5.jpg,http://127.0.0.1:8088/image/details/d18-6.jpg,http://127.0.0.1:8088/image/details/d18-7.jpg,http://127.0.0.1:8088/image/details/d18-8.jpg,http://127.0.0.1:8088/image/details/d18-9.jpg','北京 · 平房里的合住房间','王府井旁胡同里的老北京四合院之四人间B，步行到地铁站5分钟',315.00,2,2,2,6,'近地铁站|高性价比|可以做饭','咱家坐落在北京市中心的胡同保护区，古迹随处可见，周边的房屋甚至树木都有着古老的历史。生活气息浓厚。交通便利，距离地铁5、6号线东四站只需5分钟步行，距离故宫、天安门、南锣鼓巷、钟鼓楼只要15分钟自行车程。我们有舒适的公共休闲大厅，书吧里的书可以随手翻看，院子及露台铺满鲜花绿植。房间干净精致，科勒卫浴及优质的床品床垫媲美星级酒店。四四围合而成的小院儿，院子和露台都是露天的，可以赏月观星，享受清晨和黄昏以及静谧的暗夜。','With the surrounding areas being rapidly developed,the historical and culturalcharacters of us remains,make it an unique and quiet place to stay in the heart of a crowded city.If you choose to stay in,a sip of Chinese tea on the terrace or in the garden is a good idea.We also add some facilities to satisfy the needs of modern living,such as hotel quality bedding and hygienic washrooms.We are very convenient for sightseeing, with Tiananmen Square and the Forbidden City and Houhai pub street, just 15minutes bike ride away. Wangfujing shopping street is less than 15mimute walking.',0,'14:00后','12:00',0,'116.417796','39.914398','东四，北京，中国','胡同里古迹随处可见，对面墙上的泰山石敢当，精美雕刻的门楼甚至清代王府的墙砖。遛鸟、下棋的大爷、操着儿化音的大妈无处不让你体会这里是北京。','距离地铁5、6号线东四站只需步行5分钟，周边更有10余条公交线路。提供自行车租赁服务，免费替客人叫车。提供免费停车位。','',18);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d19-1.jpg,http://127.0.0.1:8088/image/details/d19-2.jpg,http://127.0.0.1:8088/image/details/d19-3.jpg,http://127.0.0.1:8088/image/details/d19-4.jpg,http://127.0.0.1:8088/image/details/d19-5.jpg,http://127.0.0.1:8088/image/details/d19-6.jpg,http://127.0.0.1:8088/image/details/d19-7.jpg,http://127.0.0.1:8088/image/details/d19-8.jpg,http://127.0.0.1:8088/image/details/d19-9.jpg','北京 · 整套公寓','天安门崇文门前门故宫市中心星级豪华公寓两室一厅loft带电梯',568.00,2,3,1,5,'近地铁站|可以做饭','房子紧邻珠市口地铁站，仅300米，步行3分钟即达。距离长安街仅1公里，打车不足10分钟即到天安门、故宫、前门大栅栏、天坛、国家博物馆。步行大约一刻钟达到天安门广场，地处北京市心脏地带，地理位置优越，房子在五星级豪华酒店内（金霖酒店），复式两居，空间宽敞，有电梯，配备中央空调，24小时供暖。有电视、冰箱、洗衣机、wifi 。天安门、故宫、天坛、国家博物馆，中山公园、天桥艺术中心、德云社、前门步行街、大栅栏商业街等 非常近。客厅配备一个大电视。 超大主卧，1.8米超大双人床和一个1.2米宽的床；次卧备1.5米双人床。厨房内配备电冰箱、电饭煲，锅具、厨具、餐具、洗涤用品一应俱全。卫生间提供24小时热水，还有吹风机、洗衣机。 我们免费提供拖鞋、牙具、洗手液、吹风机、满足您入住的洗漱需求。房子一客一扫，保证床上用品、洗漱用品一客一换。|附近300米有过街楼和天桥路口东站，可乘坐23/57/6/34/35/110/夜10路等去往北京各处。 出门300米即是7号线珠市口地铁站 。','交通便利，位置优越，装修高档，居住环境好',1,'14:00后','12:00',0,'116.428832','39.905071','天安门，北京，中国','步行15分钟左右到天安门广场，离前门、天安门、故宫、王府井、国家大剧院、天坛都非常近，在市中心，地理位置非常优越。','步行至珠市口地铁站(7号线):4分钟｡|步行至前门步行街南口:7分钟｡|步行至刘老根大舞台:7分钟｡','',18);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d20-1.jpg,http://127.0.0.1:8088/image/details/d20-2.jpg,http://127.0.0.1:8088/image/details/d20-3.jpg,http://127.0.0.1:8088/image/details/d20-4.jpg,http://127.0.0.1:8088/image/details/d20-5.jpg,http://127.0.0.1:8088/image/details/d20-6.jpg,http://127.0.0.1:8088/image/details/d20-7.jpg,http://127.0.0.1:8088/image/details/d20-8.jpg,http://127.0.0.1:8088/image/details/d20-9.jpg','北京 · 整套公寓','极客之寓·高端现代公寓·近南站前门天坛',998.00,3,3,2,6,'近地铁站|自助入住|可以做饭','极客之寓-黑白灰极简风格|公寓坐落于北京老街区,南二环附近。|步行300可达地铁站。|小区门口即是公交站。|可以叫车停到楼下。|公寓内有三间卧室:|靠北次卧暖色系,采光很好。|中间的次卧是灰色系,适合休息,睡懒觉。|朝南的是主卧,主卧内有独立卫浴以及开放式衣柜。采用半透明的玻璃,非常现代,有情调。|卧室的床品,床垫都是精挑细选的。绝对给您最好的入住体验。|公共活动区域:|厨房+部分门厅:|2+1炉灶,配有大吸力吹风机。水槽带食品粉碎机。水龙头旁边就是净水器的出水龙头。同时,给喜欢做饭的您陪有烤箱和蒸箱。当然,洗碗机肯定是必不可少的。13套超大洗碗机,可以同时清洗全天使用的餐具。|客餐厅是一体的,显得整体更通透。餐桌配有6把椅子。如果有客人临时来访,在阳台储物柜还有四把备用的折叠椅。餐桌旁就是餐边柜。除了一些精美饰品之前,配有红酒杯,香槟杯,冷饮杯和茶杯。均为6人套。客厅相对简单。4米长的真皮沙发,65寸液晶电视。可以同家人一起享受饭后时光。阳台更是准备了麻将机,给爱好麻将的朋友。|还有很多很多细节和设计都是精心给您准备的。|欢迎您来入住体验。','高端电器组合：65寸三星电视，定制冰箱，蒸烤箱，洗碗机，西门子洗衣机，干衣机，三星中央空调，戴森吸尘器，戴森吹风机，bose音箱。|厨房配备了全套WMF厨具，各种调料都有准备。|三个卧室的床品均使用的80支以上纯棉面料。',1,'14:00后','12:00',1,'116.427212','39.871681','安乐林路，北京，中国','安乐林路，小区出入口均在道路南侧。入口靠东，出口靠西。','小区出来往东或往西步行400米，均能到达地铁站。地铁14号线，右边更近一点，是景泰站。','',17);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d21-1.jpg,http://127.0.0.1:8088/image/details/d21-2.jpg,http://127.0.0.1:8088/image/details/d21-3.jpg,http://127.0.0.1:8088/image/details/d21-4.jpg,http://127.0.0.1:8088/image/details/d21-5.jpg,http://127.0.0.1:8088/image/details/d21-6.jpg,http://127.0.0.1:8088/image/details/d21-7.jpg,http://127.0.0.1:8088/image/details/d21-8.jpg,http://127.0.0.1:8088/image/details/d21-9.jpg','北京 · 整套公寓','【CBD·璀璨之夜】国贸高层超赞观景两居公寓/紧邻银泰中心/国贸商城/长安街',1580.00,2,2,2,5,'可以做饭|可存行李','坐落在寸土寸金的CBD中央，尽享璀璨繁华的夜景。与潘石屹的顶层豪宅对望，楼下即是CBD森林公园。','【客厅】超大落地窗，尽享无敌夜景。配极米旗舰款投影仪-N20，100寸超清投影，哈曼卡顿音响，享受完美家庭影院带来的视听盛宴；吧台配菲利普全自动研磨咖啡机，提供埃塞俄比亚优质咖啡豆，搭配我们为您精心挑选的小零食，让您与家人朋友尽享悠闲下午茶时光。|【主卧·优雅紫】2m*1.8m 舒适大床；超五星级床垫，枕头软硬可调整，单面超大落地窗。|【主卫生间】浴缸+淋浴，配飞利浦吹风机、新西兰ecostore洗手液、日本马油洗护三件套、浴巾手巾以及牙具套装，给您带来舒适的洗护体验。|【次卧·复古绿】2m*1.8m 舒适大床；超五星级床垫，两面落地窗，白天采光极佳，夜晚观赏车水马龙的东三环以及CBD的繁华夜景。|【次卫生间】防滑淋浴房，配飞利浦吹风机、新西兰ecostore洗手液、日本马油洗护三件套、浴巾手巾以及牙具套装，给您带来舒适的洗护体验。|【厨房】无敌观景位厨房，冰箱、烤箱、厨具、米面调料、餐具、酒具一应俱全。|【洗衣房】配海尔全自动洗衣机、蓝月亮洗衣液、专业内衣洗涤液、滴露消毒液，为您带来洁净舒适的体验。',0,'14:00后','12:00',1,'116.465148','39.913261','CBD，北京，中国','公寓位于CBD核心地区，紧邻银泰中心、国贸商城；距离永安里地铁站460米，距离国贸地铁站780米，楼下有超市和各种餐厅，交通生活极其便利。','','',17);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d22-1.jpg,http://127.0.0.1:8088/image/details/d22-2.jpg,http://127.0.0.1:8088/image/details/d22-3.jpg,http://127.0.0.1:8088/image/details/d22-4.jpg,http://127.0.0.1:8088/image/details/d22-5.jpg,http://127.0.0.1:8088/image/details/d22-6.jpg,http://127.0.0.1:8088/image/details/d22-7.jpg,http://127.0.0.1:8088/image/details/d22-8.jpg,http://127.0.0.1:8088/image/details/d22-9.jpg','北京 · 整间LOFT','【有宿】故宫天安门前门loft，紧邻地铁，新中式艺术公寓（免费接机）',638.00,3,4,1,7,'近地铁站|可存行李|自助入住|可以做饭','感恩节回馈：即日起-12月31日期间预定三天及以上的住客送接机或送机～|Hi~欢迎来到小浠的家！在这里您将结识一些有趣的人、聆听一些有趣的事。|主题风格：以“繁华京城觅得归处”为装饰主题，愿您在京城的繁华深处，享受家一般温暖的住处。|地理位置：位于前门大栅栏步行街边，距离天安门大约1公里，可步行观升旗；紧邻地铁7号线珠市口站，另有多条公交地铁路线贯穿北京各大知名景点。','房屋空间：Loft复式空间，楼下是开放式空间，楼上是标准主次卧，全景大玻璃窗，朝阳温暖阳光房。|设施用品：一层是1张1.5米宽中式拔步床+干湿分离洗手间+开放式厨房+餐厅；二层主卧是1张1.8米宽大米+1个儿童房配1.2米宽折叠沙发，次卧是1张1.5米宽双人床；屋内配备电视、冰箱、洗衣机；厨房配备全套厨具和餐具。|入住服务：房屋内无任何收费项目，不在线下收取其他任何费用；床品布草一客一换；可住6-7人；免费提供WIFI、洗发水、沐浴露、洗衣液、牙刷、香皂、梳子、拖鞋、毛巾、浴巾、电吹风、电蚊香等日常用品。|安全保障：24小时门院岗亭及大堂保安，一客一换的密码锁入门自助入住。|由于语言沟通问题，暂不接待外宾和少数民族地区同胞。',1,'14:00后','12:00',1,'116.41963','39.89884','珠市口东大街|18号，北京，中国','位于前门大栅栏步行街边，距离天安门大约1公里，可步行看升旗。周边有前门、大栅栏、天安门、故宫、天坛、刘老根大舞台、天桥剧场等诸多景点，有四季民福烤鸭店、稻香村糕点、丰泽园、全聚德等诸多美食餐厅。公寓门口即是地铁站，有多条地铁、公交路线贯通北京众多知名景点，交通便利，环境优美且清净。','地铁：7号线至珠市口站下车，C口（东南口）出站后往前直走，见路口右转即可；|公交：乘坐57路公交至过街楼站下车，步行280米即可；乘坐622路公交至珠市口南站下车，步行400米即可。','',17);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d23-1.jpg,http://127.0.0.1:8088/image/details/d23-2.jpg,http://127.0.0.1:8088/image/details/d23-3.jpg,http://127.0.0.1:8088/image/details/d23-4.jpg,http://127.0.0.1:8088/image/details/d23-5.jpg,http://127.0.0.1:8088/image/details/d23-6.jpg,http://127.0.0.1:8088/image/details/d23-7.jpg,http://127.0.0.1:8088/image/details/d23-8.jpg,http://127.0.0.1:8088/image/details/d23-9.jpg','北京 · 整套酒店式公寓','【北京一家】8人看升旗逛天坛天安门前门天桥大栅栏家门口地铁',581.00,2,4,1,7,'近地铁站|可存行李|自助入住|可以做饭','等你这么久，你终于点开了我的房子！您看到的这套房子是分成上下两层的loft，一层是客厅、开放式厨房。厨房配备炒锅、煮锅、刀叉等厨房用品。里面有干湿分离的卫浴设施。二层是两个卧室及步入式衣帽间。精装修,全覆盖免费WiFi,中央空调、24小时热水。全新家具家电、床上用品、日常生活设备一应俱全。','我的房子出门就是地铁。京城核心区景点几乎都可步行到达。马路对面就是京城名楼丰泽园饭庄。购物，饮食都非常方便。',1,'14:00后','12:00',1,'116.394791','39.898019','天坛，北京，中国','距离京城的核心地区的景点都很近。步行可达天安门，故宫，天坛。家门口就是纪晓岚故居。','建议在家门口搭乘地铁出行。','',17);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d24-1.jpg,http://127.0.0.1:8088/image/details/d24-2.jpg,http://127.0.0.1:8088/image/details/d24-3.jpg,http://127.0.0.1:8088/image/details/d24-4.jpg,http://127.0.0.1:8088/image/details/d24-5.jpg,http://127.0.0.1:8088/image/details/d24-6.jpg,http://127.0.0.1:8088/image/details/d24-7.jpg,http://127.0.0.1:8088/image/details/d24-8.jpg,http://127.0.0.1:8088/image/details/d24-9.jpg','北京 · 整栋别墅','【赠早餐】可烧烤、家庭公司团建聚会轰趴娱乐全能、独栋别墅、近九华山庄小汤山温泉',2580.00,6,4,4,12,'可以做饭','房屋整体情况：房屋的整个使用面积为500多平，采用的是欧式装修风格，分为地下一层， 地上二层，总共分为三层，分为动、静区，集餐饮、娱乐、居住为一体。一共有6卧4卫2厅地下一层为主要的休闲娱乐区，台球区，地下餐厅，影音区，麻将区、茶艺厅，库房；地上一层有中西厨房，餐厅，客厅，客厅中有钢琴，可以自行弹琴，有两个卧室，有一个公共卫生间，车库，二层有一间主卧，三间客卧，还有1个公共卫生间。麻将区、桌球区、茶艺台 私家影音KTV室等备有烧烤架，可以在室外进行烧烤。','',1,'14:00后','12:00',0,'116.376021','40.112871','温都水城，北京，中国','1 距离物美超市大约11分钟车程；距离温都水城大约17分钟车程；2.洼里博物·乡居楼乡村文化庄园：车行15分钟就可到达，庄园内有特色的农家菜、乡村农具展、洼里博物馆、乡村游乐场、儿童乐园、小动物园、采摘、垂钓和会议等场所。 3.温都水城：车行15分钟可到达，内含大型水上娱乐、温泉理疗养生馆、观光旅游、商务会议于一体，目标是形成以"水"为亮点，以温榆河生态旅游为依托、整体占地面积近万亩的绿色休闲旅。4.中国航空博物馆：车行15分钟可到达，馆藏270余架飞机、99架国家文物飞机、近万件航空文物，是集科技教育、旅游于一体的国家级军事主题博物馆，也是亚洲规模最大、跻身世界前5位的航空博物馆。近温都水城，小汤山，龙脉温泉，九华山庄都可进行泡温泉，军都山滑雪 周边多个大型超市，位置绝佳，交通方便','高德导航搜索保利陇上即可到达别墅区|乘坐地铁5号线到达天通苑北下车 滴滴打车会方便一些','',16);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d25-1.jpg,http://127.0.0.1:8088/image/details/d25-2.jpg,http://127.0.0.1:8088/image/details/d25-3.jpg,http://127.0.0.1:8088/image/details/d25-4.jpg,http://127.0.0.1:8088/image/details/d25-5.jpg,http://127.0.0.1:8088/image/details/d25-6.jpg,http://127.0.0.1:8088/image/details/d25-7.jpg,http://127.0.0.1:8088/image/details/d25-8.jpg,http://127.0.0.1:8088/image/details/d25-9.jpg','北京 · 整栋别墅','山顶pension',4999.00,5,4,5,15,'高性价比|可以做饭|可存行李','这座私人别墅是欧式木屋建筑风格，环绕整个森林山脉，并且也在0247的官方lnstagram账号出现|留在这里，体验木屋周边的景色，美丽的设计师木屋在每一个窗户都可以看到不同的山景，开放式生活，有十几种娱乐设施和风景如画的无边泳池，坐落在一个远离喧嚣的北京近郊|周边有水长城 银山塔林景区，莽山森林公园景区，周边有多家采摘园，垂钓园等','这里是我独一无二的家，设计这里加上装修用了两年多的时间，希望来到山顶pension客人可以给您带来真正放松体验，期待您的到来',1,'14:00后','12:00',0,'116.214041','40.112873','上庄村，北京，中国','上庄村 瓯北木屋村','自带免费停车场','',16);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d26-1.jpg,http://127.0.0.1:8088/image/details/d26-2.jpg,http://127.0.0.1:8088/image/details/d26-3.jpg,http://127.0.0.1:8088/image/details/d26-4.jpg,http://127.0.0.1:8088/image/details/d26-5.jpg,http://127.0.0.1:8088/image/details/d26-6.jpg,http://127.0.0.1:8088/image/details/d26-7.jpg,http://127.0.0.1:8088/image/details/d26-8.jpg,http://127.0.0.1:8088/image/details/d26-9.jpg','北京 · 整套酒店式公寓','观云·美高梅公馆Loft 顶级公寓/地铁旁超便利/超市餐馆/天安门国贸首选',490.00,2,2,2,4,'可以做饭|可存行李','+高端酒店式公寓，钓鱼台国宾馆和美高梅酒店联合打造的顶级物业，24小时前台贴心服务，进出刷卡安全保障。| |+位置优越，300米内有地铁宋家庄站、大型超市首开福茂、京客隆等数十家商业体，多家餐馆走路可达，吃穿用应有尽有，24小时便利店和麦当劳肯德基。| |+地铁可快速抵达王府井、天安门、国贸、西单、北京站等地。10号线可换乘机场快轨。| |+Loft双层精致户型，开放式卧室，和榻榻米床垫，另有小沙发床，可供4–6人入住。| |+全智能家居控制系统、新风系统、中央空调，一个面板控制灯光、空调、窗帘等。精心打造一个有温度的家。| |注：2人以上每人加50元/天。如使用厨房锅碗请务必打扫干净谢谢！','+Loft双层精致户型，开放式卧室，和榻榻米床垫，另有小沙发床，可供4–6人入住。| |+全智能家居控制系统、新风系统、中央空调，一个面板控制灯光、空调、窗帘等。精心打造一个有温度的家。',0,'14:00后','12:00',0,'116.433838','39.852509','首开福茂，北京，中国','+位置优越，300米内有地铁宋家庄站、大型超市首开福茂、京客隆等数十家商业体，多家餐馆走路可达，吃穿用应有尽有，24小时便利店和麦当劳肯德基。','楼的西侧附路边有收费停车位。滴滴打车非常方便快捷','',16);
insert into aby_room values(null,'http://127.0.0.1:8088/image/details/d27-1.jpg,http://127.0.0.1:8088/image/details/d27-2.jpg,http://127.0.0.1:8088/image/details/d27-3.jpg,http://127.0.0.1:8088/image/details/d27-4.jpg,http://127.0.0.1:8088/image/details/d27-5.jpg,http://127.0.0.1:8088/image/details/d27-6.jpg,http://127.0.0.1:8088/image/details/d27-7.jpg,http://127.0.0.1:8088/image/details/d27-8.jpg,http://127.0.0.1:8088/image/details/d27-9.jpg','北京 · 整间LOFT','天安门故宫国贸后海双井东单西单同仁协和宋家庄5号10号亦庄始发北欧高端豪华奢精装阳光北欧复式大床套房',448.00,2,3,2,4,'可以做饭|自助入住|可存行李','宝宝们，冬天太冷，快回家取暖暖吧！一、鲁能钓鱼台美高梅公馆，依照五星标准高品质建设，配有农夫山泉矿泉水和精美小吃点心，雀巢咖啡、红糖姜茶、铁观音、大红袍、正山小种等高档茶叶等您来品，近30平的客厅让您有一个休闲放松的自由空间，给你一个五星级的家。高德导航鲁能钓鱼台美高梅公馆，具体为82号院2号楼，楼下有标志性的狮子雕像。距离300米的宋家庄地铁站，是10、5号和亦庄线的始发换乘站，北京地铁核心枢纽。房间布置为北欧ins风，超大唯美的落地窗及飘窗，窗朝向正南，日照充足，采光好，是公馆内稀有的楼王位置阳光房。|二、周边有大型商超、饭店、医院、银行，构成了繁华的宋家庄商业圈。天安门、天坛、王府井、西单、东单、协和医院、同仁医院、北京站、北京西站、北京南站、大兴国际机场等重要地标，乘坐地铁或乘车在10-20分钟均可到达，交通非常方便。|三、室内设施全套采用高档品牌，科勒厨卫，美国新风系统，多伦斯直饮水，三星电视，西门子滚筒洗衣机，西门子冰箱，德国空气净化器，小米电视盒子，小米体重秤，小米U口智能插排，美的微波炉，阿里斯顿热水器，德国进口花洒，美的电磁炉，居家做饭洗衣都非常方便，给您高品质的居家入住体验。|四、房间配备智能家居，云控制，可控制全屋灯具、中央空调、新风，一键掌控回家、离家模式，自动升降式餐桌，语音小米音响享受高品质音效视听盛宴，小米盒子智能播放各类电视频道节目，支持手机投影。|五、宜家品质舒适沙发，纪梵希法兰绒床上用品，舒适亲肤，专业洗涤。二层主卧有一张2米双人床，榻榻米有小黄人卡通睡袋或者2米双人床（二选一），客厅一张1.5沙发床，客房有一张1.5可折叠单人床。|六、为喜欢做饭的朋友配备了齐备的厨房用品，有品牌电饭煲，美的微波炉，西门子电磁炉、冰箱，科勒厨具，切菜板，切刀，刮刨刀，蒸锅煮锅炒菜锅一应俱全，锅铲，汤勺，漏勺，以及各种调料。|七、高品质洗漱用品，一客一换。舒肤佳泡沫洗手液、高露洁牙膏，阿道夫沐浴液让您放松全身，享受SPA级的护肤享受。|八、联通宽带光纤入户，免费wifi，速度流畅，王者荣耀、吃鸡等游戏畅游high玩。|九、密码锁一客一换，电梯门禁刷卡进入，且只在所住楼层停靠，大堂24小时管家安保服务，安全私密。','',1,'14:00后','12:00',1,'116.429278','39.852869','王府井，北京，中国','楼内安装有进口大品牌电梯，楼道内干净整洁。小区内绿树环抱、清新怡人，在这里您不用担心大都市的吵闹和喧嚣。物业管理安全有序，24小时保安巡视，24小时大堂管家，行人出入需要刷门禁卡，外人拜访通过可视通话控制电梯，让您住的安全放心。周边设施齐全，餐饮有肯德基，永和大王，宽板凳，嘉和一品，真功夫，护国寺小吃，必胜客，和合谷，呷浦呷浦，老北京铜锅涮肉，杨记兴臭鳜鱼，海底捞火锅，兰州拉面，乔外婆麻辣香锅，山城辣妹子重庆火锅，麦当劳，天天渔港，田老师红烧肉，魏家凉皮。金融机构有工商银行，建设银行，中国银行，兴业银行，交通银行，邮储银行，北京农商银行商场有首开福茂，扑满山商城，爱琴海世界之花，石榴中心斯坦福广场，方庄购物中心。景点有天坛，陶然亭公园，法华寺，永定门公园，龙潭公园。医院有同仁医院，协和医院东院区，东城区第一人民医院，北京航天总医院。','交通发达便利：|一、距离天安门8公里，开车20分钟到达。|二、距离南三环刘家窑桥1.2公里，开车3分钟到达。|三、距离国贸9公里，开车15分钟到达。|四、距离北京南站5公里，开车13分钟到达。|五、距离北京西站16公里，开车23分钟到达。|六、距离宋家庄地铁站步行5分钟，地铁5号线、10号线、亦庄线三线交汇，在宋家庄站乘地铁30分钟即可到达北京站、北京南站。|七、在宋家庄地铁站可以换乘后直达北京大兴国际机场。|八、乘汽车经德贤路高架、南五环、大兴机场高速30分钟也可到达北京大兴国际机场。','',16);
/*new房间详情表*/
insert into aby_room_detail values(null,'1张 1.8米宽双人床','1张 1.8米宽双人床','','',18);
insert into aby_room_detail values(null,'1张 1米宽单人床','1张 1.8米宽双人床','','',19);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','1张 1.8米宽双人床','1张 1.8米宽双人床','',20);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','1张 1.8米宽双人床','','',21);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','1张 2米宽双人床','1张 1.8米宽双人床','1张沙发床',22);
insert into aby_room_detail values(null,'1张 1.5米宽双人床','1张 1.5米宽双人床','','1张 1.5米宽沙发床',23);
insert into aby_room_detail values(null,'1张 2 米宽双人床','1张 1.8 米宽双人床','','1张 1.5米宽沙发床',24);
insert into aby_room_detail values(null,'1张 2 米宽双人床','1张 1.8 米宽双人床','','1张 1.5米宽沙发床',25);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','1张地板床垫','','1张沙发床',26);
insert into aby_room_detail values(null,'1张 1.8米宽双人床','1张 1.8 米宽双人床','','1张沙发床',27);
/*new基础设施表*/
insert into aby_base_facility values(null,1,1,0,1,1,1,1,0,1,1,1,1,18);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,0,19);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,20);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,21);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,22);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,23);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,24);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,25);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,0,26);
insert into aby_base_facility values(null,1,1,1,1,1,1,1,1,1,1,1,1,27);
/*new配套设施表*/
insert into aby_mating_facility values(null,0,0,1,18);
insert into aby_mating_facility values(null,1,1,0,19);
insert into aby_mating_facility values(null,1,1,0,20);
insert into aby_mating_facility values(null,1,1,0,21);
insert into aby_mating_facility values(null,1,0,0,22);
insert into aby_mating_facility values(null,1,1,0,23);
insert into aby_mating_facility values(null,0,1,1,24);
insert into aby_mating_facility values(null,0,1,1,25);
insert into aby_mating_facility values(null,1,1,0,26);
insert into aby_mating_facility values(null,1,1,1,27);
/*new儿童设施表*/
insert into aby_child_facility values(null,0,18);
insert into aby_child_facility values(null,1,19);
insert into aby_child_facility values(null,1,20);
insert into aby_child_facility values(null,1,21);
insert into aby_child_facility values(null,0,22);
insert into aby_child_facility values(null,0,23);
insert into aby_child_facility values(null,1,24);
insert into aby_child_facility values(null,1,25);
insert into aby_child_facility values(null,1,26);
insert into aby_child_facility values(null,1,27);
/*new安全设施表*/
insert into aby_safety_facility values(null,1,1,18);
insert into aby_safety_facility values(null,1,0,19);
insert into aby_safety_facility values(null,1,1,20);
insert into aby_safety_facility values(null,1,1,21);
insert into aby_safety_facility values(null,1,0,22);
insert into aby_safety_facility values(null,1,1,23);
insert into aby_safety_facility values(null,1,1,24);
insert into aby_safety_facility values(null,1,1,25);
insert into aby_safety_facility values(null,1,1,26);
insert into aby_safety_facility values(null,1,1,27);

/*****************房东表插入数据*****************/
insert into aby_room_user values(null,'南与先生',0,'http://127.0.0.1:8088/image/avatar/tx13.jpg','2018年7月','欢迎大家来到西安旅游,您的需求就是我想做的｡','中文','100%','1小时以内',1,1);#西安
insert into aby_room_user values(null,'Andrew',0,'http://127.0.0.1:8088/image/avatar/tx14.jpg','2017年9月','大家好 我是Andrew|今年二十一岁 刚刚大学毕业|喜欢旅行 |17岁时一个人去西藏|18岁时一个人去东南亚几国|19岁时一个人去印度 日本 俄罗斯|20岁时一个人去马尔代夫 土耳其|今年 计划去巴基斯坦  以色列 和 朝鲜|虽然脚步一直停留在亚洲|但我相信无论身处何地,最美好的风景 永远都在路上｡','','98%','1小时以内',1,1);#成都
insert into aby_room_user values(null,'清水三郎',0,'http://127.0.0.1:8088/image/avatar/tx15.jpg','2019年10月','','','100%','1小时以内',1,0);#北京
insert into aby_room_user values(null,'绳',0,'http://127.0.0.1:8088/image/avatar/tx16.jpg','2018年11月','您好,我是阿绳^_^,本人是个喜爱美好事物且性格内敛沉稳的男生｡我喜欢美好有趣的事物,喜欢旅游,喜欢品咖啡,目前致力于分享美好有趣的民宿｡出身于提供世界级顾客服务公司的我,会努力让您选择的每一个房间,度过的每一晚都觉得温暖~~魔都上海有太多的美好,太多的纸醉金迷,希望您白天游览热情的国际都市,夜晚回到房间ye能体会老上海的风情#','','100%','1小时以内',1,1);#上海
insert into aby_room_user values(null,'一只',1,'http://127.0.0.1:8088/image/avatar/tx17.jpg','2018年10月','','','100%','1小时以内',1,1);#成都
insert into aby_room_user values(null,'Yohani',1,'http://127.0.0.1:8088/image/avatar/tx18.jpg','2018年3月','多年的绘画经历带给我不一样的感官体验,旅途中的一花一木教会我享受生活,从北上广深的996抽离出来,来到了成都这座最有生活气息的城市,私以为美好的一切要与你们分享｡|90后的我们从上学打工赚钱去看山川湖海到上班被禁锢在钢筋水泥中不得其乐,毅然决然的放弃了游戏策划的工作,设计了Ricardo——这个完全由我和小伙伴自己打造的小小的民宿｡将热爱的一切放在这所房子里,给每一位来到这里的游者全新的不一样的体验,希望大家能因此更热爱这段旅程更热爱成都这个地方｡','中文|English','100%','1小时以内',1,1);#成都
insert into aby_room_user values(null,'西巷.',0,'http://127.0.0.1:8088/image/avatar/tx19.jpg','2018年8月','HI~我是.西巷､Go民宿的房东,一个90后小哥哥,我没有走过世界多少个国家,也没有游遍中国的大好河山,但我希望你有,我也希望能和每一个房客都成为朋友,听你们的故事｡Go民宿每个房源都有他们的特色,而且所有的房源都是高档酒店式公寓内,位置都集中在回民街,钟楼,鼓楼附近,期待您的预订｡|我也不知道谁曾经说过,但是我很喜欢:每一次你旅行所花的钱,都是在为你想要的生活投票｡','中文','100%','1小时以内',1,1);#西安
/*****newnewnewnewnewnewnewnewnew****/
insert into aby_room_user values(null,'凌',0,'http://127.0.0.1:8088/image/avatar/tx20.jpg','2015年9月','喜欢旅行,而且是自己做攻略,喜欢住在有当地特色的客房里,由此深深体会当地人的生活｡一直认为旅行是不同于旅游的｡旅行是在吃住玩都无限接近当地人,是能触摸到当地的人文历史的,是可以放松身心的~而旅游是那种脚步匆匆的游走于景区,与当地没有过多交流的,只是证明这里我来过｡于是我开了这间四合院的旅舍,想在这间温暖的小店里遇见温暖的你｡','中文','100%','1小时以内',1,1);
insert into aby_room_user values(null,'学文',0,'http://127.0.0.1:8088/image/avatar/tx21.jpg','2019年8月','您好,我是学文,我喜爱美食,旅行,音乐,热情好客｡我相信每一个旅行者都是随性热爱自由的人｡旅行的意义,是遇见一些人,再与他们告别｡每一次的相遇都是一种缘分,要珍惜每一次的邂逅｡','','96%','1小时以内',1,1);
insert into aby_room_user values(null,'Fook',1,'http://127.0.0.1:8088/image/avatar/tx22.jpg','2016年4月','Im your host Fook. Working at a luxury fashion group , Take charge of Visual Merchandising & Project Management Manager.can see. Have many interesting decorations in my rooms. I really hope you can enjoy your stay.','中文,Engligh,日本语','100%','1小时以内',1,0);
insert into aby_room_user values(null,'Yijun',0,'http://127.0.0.1:8088/image/avatar/tx23.jpg','2011年6月','喜欢旅游,欢迎来自各地的有趣的访客:)|avid traveller, been to 52 countries and love exploring the world.|Benefited from AIRBNB and now I am starting to rent out my spare room','中文,English','100%','1小时以内',1,0);
insert into aby_room_user values(null,'藝',1,'http://127.0.0.1:8088/image/avatar/tx24.jpg','2016年7月','入住期间有任何问题随时联系我','中文','100%','1小时以内',1,1);
insert into aby_room_user values(null,'章',1,'http://127.0.0.1:8088/image/avatar/tx25.jpg','2018年2月','做了很多年的家居､文化与艺术美学的杂志主编,接触了很多艺术家很希望有一天也可以把来自世界各地的家居灵感变为现实生活中可观,可感的实体空间,能创造出一个“家的奇妙物语”的系列,由此有了现在的“复得旅店”,它必须要有最舒适宜人的酒店般的住宿体验之外,还要提供一个逃离原有生活､充满幻想','中文(简体),英文','100%','1小时以内',1,1);
insert into aby_room_user values(null,'Sammi',0,'http://127.0.0.1:8088/image/avatar/tx26.jpg','2016年2月','喜欢旅行,而且是自己做攻略','中文','100%','1小时以内',1,1);
insert into aby_room_user values(null,'莉',1,'http://127.0.0.1:8088/image/avatar/tx04.jpg','2016年2月','喜欢住在有当地特色的客房里,由此深深体会当地人的生活｡','中文','100%','1小时以内',1,1);
insert into aby_room_user values(null,'童',1,'http://127.0.0.1:8088/image/avatar/tx05.jpg','2019年5月','我是一个调香师,也是深度旅行爱好者,在旅行中经常选择不同风格特色的air bnb居住｡希望我提供的air bnb住宿可以让您有温馨放松的居住体验｡我们在2019年的air bnb特色:橘郡之乡,温柔相伴｡','中文','100%','1小时以内',1,0);
insert into aby_room_user values(null,'Pony',0,'http://127.0.0.1:8088/image/avatar/tx06.jpg','2017年8月','我热爱旅游,期待和你成为朋友~|——关于掌宿CactusSpace|掌宿CactusSpace的核心理念是｢住+展｣, 打造的是一个融入生活中的艺术民宿｡与来自世界各地的友人分享这一切,在通过预订入住的时间里,与展出作品有足够多的时间相处,让您沉醉其中细细欣赏墙上展示的艺术作品,和艺术家完成隔空对话｡ 与此同时,掌宿CactusSpace致力于挖掘和培养国内外青年艺术家,发现好作品,帮艺术家在民宿里举办展览,合作后的收益共赢｡ 在入住民宿过程中,房子里展示的每一件作品都可以购买带回家中,如果你有意向,欢迎联系房东询价｡ ','中文','98%','1小时以内',1,1);
insert into aby_room_user values(null,'天空飞翔',0,'http://127.0.0.1:8088/image/avatar/tx07.jpg','2018年11月','欢迎各位朋友入住我们的民宿｡我是大连人,2010年中国科学院研究生院硕士毕业后留在北京｡目前在国内一家很好的地产基金带一个团队｡作为十几年的老北漂,以及每年60天以上出差旅游的人,我经历过在北京租房以及旅居过程中遇到的几乎所有的不愉快｡因此在北京为朋友提供一个美好体验的家成为我个人的一个心愿｡|2018年我和朋友一起进入到民宿这个行业｡无论您是来北京旅游､就业､探亲还是医疗,我们将竭尽全力为您“提供一个五星级的短租体验”｡|为此我们将做到:|1､家里干净整洁,一客一换,每个房间安排专门的管理员｡如因房间产生的问题我们绝不推卸责任,第一时间进行处理和安排,尽全力让您满意｡|2､依靠我们在北京居住经历,为住在我们家的朋友提供力所能及的咨询服务｡目前比较成熟咨询主要有北京的旅游线路以及北京餐饮｡|欢迎入住我们家,给我们一个为您“提供一个五星级的短租体验”的机会｡','中文,English','100%','1小时以内',1,1);


/*****************用户表插入数据*****************/
insert into aby_user values(null,1,'tom',md5('123456'),'http://127.0.0.1:8088/image/avatar/tx01.jpg','15210505833@163.com','','15210505833',"18","","","","");
insert into aby_user values(null,1,'jerry',md5('123456'),'http://127.0.0.1:8088/image/avatar/tx02.jpg','1091248122@qq.com','','18910090900',"18","","","","");
insert into aby_user values(null,1,'tom1',md5('654321'),'http://127.0.0.1:8088/image/avatar/tx03.jpg','18211111111@163.com','','15383988084',"18","","","","");
insert into aby_user values(null,0,'jane',md5('654321'),'http://127.0.0.1:8088/image/avatar/tx04.jpg','13611111111@163.com','','18614232798',"18","","","","");
insert into aby_user values(null,1,'sala',md5('654321'),'http://127.0.0.1:8088/image/avatar/tx05.jpg','18911111111@163.com','','15130348585',"18","","","","");
insert into aby_user values(null,1,'dingding',md5('654321'),'http://127.0.0.1:8088/image/avatar/tx06.jpg','13622222222@163.com','','13622222222',"18","","","","");
insert into aby_user values(null,1,'airec',md5('654321'),'http://127.0.0.1:8088/image/avatar/tx07.jpg','18612345312@163.com','','18612345312',"18","","","","");
insert into aby_user values(null,0,'mike',md5('111111'),'http://127.0.0.1:8088/image/avatar/tx08.jpg','13512374212@163.com','','13512374212',"18","","","","");
insert into aby_user values(null,0,'HuiJun',md5('444444'),'http://127.0.0.1:8088/image/avatar/tx09.jpg','18633333333@163.com','','18633333333',"18","","","","");
insert into aby_user values(null,0,'andy',md5('111111'),'http://127.0.0.1:8088/image/avatar/tx10.jpg','18976769876@163.com','','18976769876',"18","","","","");
insert into aby_user values(null,1,'jenny',md5('111111'),'http://127.0.0.1:8088/image/avatar/tx11.jpg','13512323334@163.com','','13512323334',"18","","","","");
insert into aby_user values(null,0,'deny',md5('111111'),'http://127.0.0.1:8088/image/avatar/tx12.jpg','13510101010@163.com','','13510101010',"18","","","","");


/*****************评价表插入数据*****************/
insert into aby_comment values(null,'2019年11月','床超舒服的,忍不住想问问房东床单被套哪里买的,哈哈｡','5','5','5','5','5','5',1,1);
insert into aby_comment values(null,'2019年10月','民宿用的东西都是很高大上的,一开始密码锁和洗衣机都不会用,研究了老半天｡洗澡冷热水的开关是相反的,要入住的宝宝请注意一下｡枕头太高了,导致彻夜失眠,最后一天直接不枕枕头,才好睡一点｡房东人很好,同意帮我们寄放行李,顺便帮房东的手工坊打一波广告~','5','5','5','5','5','5',1,2);
insert into aby_comment values(null,'2019年10月','房间很干净,小姐姐人也很好,会提前联系你,最让我心动的是一次性马桶垫,真的细节打动我!房间里放着攻略非常用心!','5','5','5','5','5','5',1,3);
insert into aby_comment values(null,'2019年9月','房主很好,发信息回复的很快,房子很漂亮,很适合拍照片,也很干净,投影也挺棒,卫生间还有一次性坐垫很贴心,卫生间其他的再改进一下就更好了','5','5','5','5','5','5',1,4);
insert into aby_comment values(null,'2019年9月','房子真的超级好看 完全和图片上一样 非常适合拍照 床也超级舒服 整个房间就是漂亮!地理位置不错出行方便~','5','5','5','5','5','5',1,5);
insert into aby_comment values(null,'2019年11月','位置便利,房间干净整洁,房东热情亲切~','5','5','5','5','5','5',2,6);
insert into aby_comment values(null,'2019年10月','很干净','5','5','5','5','5','5',2,7);
insert into aby_comment values(null,'2019年10月','房间很不错 房东很不错','5','5','5','5','5','5',2,8);
insert into aby_comment values(null,'2019年9月','可以','5','5','5','5','5','5',2,9);
insert into aby_comment values(null,'2019年11月','房东很热心,介绍当地景点美食,房间也比较干净感谢','5','5','5','5','5','5',2,10);
insert into aby_comment values(null,'2019年11月','房东很nice','5','5','5','5','5','5',2,11);
insert into aby_comment values(null,'2019年12月','就除了用热水有点麻烦之外 都挺好的 被子很暖,位置也挺方便的','5','5','5','5','5','5',2,12);
/**newnewnewnewnewnewnew**/
insert into aby_comment values(null,'2019年11月','五道营胡同位置很好，房子挺温馨，就是厕所的下水道有点不给力','3','2','5','4','4','5',3,6);
insert into aby_comment values(null,'2019年11月','外面连名宿名字前台都没有，进入就真的跟难民营一样。然后空调根本就跟摆设一样，这么冷的天一点用都没有，就靠电热毯了，还是第三天晚上才发现在床角落有个。取暖器还是坏的，大半夜从隔壁屋搬的 洗澡下水道堵塞，水如果漏到外面的取暖器极其危险⚠️ 外面的环境如果可以撇开不说，至少这么冷的天取暖设施做好一点。反正我们下次是不会再住了，除了地理位置好一点没有别的了。','1','1','1','1','1','1',3,3);
insert into aby_comment values(null,'2019年11月','厕所下水有点儿问题 不过不影响使用 整体感觉挺好的!!','2','1','2','1','1','1',3,4);
insert into aby_comment values(null,'2019年10月','房东很好讲话!房间与照片没啥差别~大概20平，设备啥的也挺全的（有小米电视且有vip）~','2','1','3','4','1','1',3,5);
insert into aby_comment values(null,'2019年8月','地点非常nice，胡同出来超多小店应有尽有，离地铁站也很近，','1','1','3','4','1','1',3,7);


/*****************首页轮播图表插入数据*****************/
insert into aby_index_carousel values(null,'http://127.0.0.1:8088/image/index/banner/banner1.png','奇遇澳洲','纵情纯净大自然','');
insert into aby_index_carousel values(null,'http://127.0.0.1:8088/image/index/banner/banner2.png','南方房源推荐','温暖难过,活力过冬','');
insert into aby_index_carousel values(null,'http://127.0.0.1:8088/image/index/banner/banner3.png','冬日闲暇好去处','周末特惠房源推荐','');
insert into aby_index_carousel values(null,'http://127.0.0.1:8088/image/index/banner/banner4.png','国内新年目的地','跳上高铁去旅行','');
insert into aby_index_carousel values(null,'http://127.0.0.1:8088/image/index/banner/banner5.png','免前落地签指南','拿起护照说走就走','');

/*****************订单表插入数据*****************/
insert into aby_order values(null,'1575216000000,1575302400000',1,'1575216000000','335',1,1,1);
insert into aby_order values(null,'1577203200000,1577289600000,1577376000000',2,'1577203200000','230',0,2,2);
insert into aby_order values(null,'1577203200000,1577289600000,1577376000000',2,'1577203200000','230',0,2,2);
insert into aby_order values(null,'1577203200000,1577289600000,1577376000000',2,'1577203200000','230',0,2,2);
insert into aby_order values(null,'1577203200000,1577289600000,1577376000000',2,'1577203200000','230',0,2,2);
insert into aby_order values(null,'1577203200000,1577289600000,1577376000000',2,'1577203200000','230',0,2,2);
insert into aby_order values(null,'1577203200000,1577289600000,1577376000000',2,'1577203200000','230',0,2,2);