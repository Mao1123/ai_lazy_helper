// 文学小说
const List<String> literatureBooks = [
  '《活着》- 余华',
  '《百年孤独》- 加西亚·马尔克斯',
  '《1984》- 乔治·奥威尔',
  '《小王子》- 圣埃克苏佩里',
  '《追风筝的人》- 卡勒德·胡赛尼',
  '《解忧杂货店》- 东野圭吾',
  '《白夜行》- 东野圭吾',
  '《三体》- 刘慈欣',
  '《围城》- 钱钟书',
  '《平凡的世界》- 路遥',
];

// 治愈系书籍
const List<String> healingBooks = [
  '《人间值得》- 中村恒子',
  '《被讨厌的勇气》- 岸见一郎',
  '《蛤蟆先生去看心理医生》- 罗伯特·戴博德',
  '《也许你该找个人聊聊》- 洛莉·戈特利布',
  '《小王子》- 圣埃克苏佩里',
  '《夏洛的网》- E.B.怀特',
  '《窗边的小豆豆》- 黑柳彻子',
  '《偷影子的人》- 马克·李维',
  '《岛上书店》- 加布瑞埃拉·泽文',
  '《一个人的好天气》- 青山七惠',
];

// 科幻书籍
const List<String> sciFiBooks = [
  '《三体》三部曲 - 刘慈欣',
  '《基地》- 艾萨克·阿西莫夫',
  '《银河帝国》- 艾萨克·阿西莫夫',
  '《沙丘》- 弗兰克·赫伯特',
  '《神经漫游者》- 威廉·吉布森',
  '《安德的游戏》- 奥森·斯科特·卡德',
  '《火星救援》- 安迪·威尔',
  '《你一生的故事》- 姜峯楠',
  '《华氏451》- 雷·布拉德伯里',
  '《美丽新世界》- 阿道司·赫胥黎',
];

// 心理学书籍
const List<String> psychologyBooks = [
  '《思考，快与慢》- 丹尼尔·卡尼曼',
  '《影响力》- 罗伯特·西奥迪尼',
  '《自控力》- 凯利·麦格尼格尔',
  '《亲密关系》- 罗兰·米勒',
  '《非暴力沟通》- 马歇尔·卢森堡',
  '《被讨厌的勇气》- 岸见一郎',
  '《自卑与超越》- 阿尔弗雷德·阿德勒',
  '《乌合之众》- 古斯塔夫·勒庞',
  '《社会心理学》- 戴维·迈尔斯',
  '《人性的弱点》- 戴尔·卡耐基',
];

// 历史书籍
const List<String> historyBooks = [
  '《人类简史》- 尤瓦尔·赫拉利',
  '《万历十五年》- 黄仁宇',
  '《明朝那些事儿》- 当年明月',
  '《全球通史》- 斯塔夫里阿诺斯',
  '《枪炮、病菌与钢铁》- 贾雷德·戴蒙德',
  '《丝绸之路》- 彼得·弗兰科潘',
  '《耶路撒冷三千年》- 西蒙·蒙蒂菲奥里',
  '《光荣与梦想》- 威廉·曼彻斯特',
  '《历史的温度》- 张玮',
  '《显微镜下的大明》- 马伯庸',
];

// 工具书
const List<String> toolBooks = [
  '《刻意练习》- 安德斯·艾利克森',
  '《原子习惯》- 詹姆斯·克利尔',
  '《深度工作》- 卡尔·纽波特',
  '《高效能人士的七个习惯》- 史蒂芬·柯维',
  '《原则》- 瑞·达利欧',
  '《穷查理宝典》- 彼得·考夫曼',
  '《学会提问》- 尼尔·布朗',
  '《如何阅读一本书》- 莫提默·艾德勒',
  '《金字塔原理》- 芭芭拉·明托',
  '《写作法宝》- 威廉·津瑟',
];

// 心情对应的书籍类型
const Map<String, List<String>> moodBookMap = {
  'happy': literatureBooks,
  'emo': healingBooks,
  'lazy': healingBooks,
  'crazy': sciFiBooks,
};

// 时段对应的书籍类型
const Map<String, List<String>> timeBookMap = {
  'morning': toolBooks,
  'lunch': literatureBooks,
  'afternoon': psychologyBooks,
  'dinner': historyBooks,
  'lateNight': healingBooks,
};

// 季节对应的书籍类型
const Map<String, List<String>> seasonBookMap = {
  'spring': literatureBooks,
  'summer': sciFiBooks,
  'autumn': historyBooks,
  'winter': psychologyBooks,
};
