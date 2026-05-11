// 喜剧电影
const List<String> comedyMovies = [
  '《夏洛特烦恼》',
  '《唐人街探案》',
  '《你好，李焕英》',
  '《飞驰人生》',
  '《西虹市首富》',
  '《疯狂的石头》',
  '《人在囧途》',
  '《让子弹飞》',
  '《功夫》',
  '《大话西游》',
];

// 治愈系电影
const List<String> healingMovies = [
  '《千与千寻》',
  '《龙猫》',
  '《你的名字》',
  '《天气之子》',
  '《哈尔的移动城堡》',
  '《悬崖上的金鱼姬》',
  '《起风了》',
  '《侧耳倾听》',
  '《猫的报恩》',
  '《借东西的小人阿莉埃蒂》',
];

// 动作电影
const List<String> actionMovies = [
  '《速度与激情》系列',
  '《碟中谍》系列',
  '《复仇者联盟》',
  '《钢铁侠》',
  '《蜘蛛侠》',
  '《蝙蝠侠》',
  '《黑客帝国》',
  '《终结者》',
  '《第一滴血》',
  '《敢死队》',
];

// 科幻电影
const List<String> sciFiMovies = [
  '《星际穿越》',
  '《盗梦空间》',
  '《流浪地球》',
  '《火星救援》',
  '《降临》',
  '《银翼杀手2049》',
  '《头号玩家》',
  '《阿凡达》',
  '《星球大战》系列',
  '《异形》系列',
];

// 恐怖电影
const List<String> horrorMovies = [
  '《招魂》系列',
  '《安娜贝尔》',
  '《小丑回魂》',
  '《电锯惊魂》',
  '《寂静之地》',
  '《逃出绝命镇》',
  '《遗传厄运》',
  '《仲夏夜惊魂》',
  '《昆池岩》',
  '《咒》',
];

// 爱情电影
const List<String> romanceMovies = [
  '《泰坦尼克号》',
  '《罗马假日》',
  '《情书》',
  '《怦然心动》',
  '《恋恋笔记本》',
  '《傲慢与偏见》',
  '《时空恋旅人》',
  '《真爱至上》',
  '《重庆森林》',
  '《花样年华》',
];

// 悬疑电影
const List<String> mysteryMovies = [
  '《看不见的客人》',
  '《消失的她》',
  '《误杀》',
  '《唐人街探案》',
  '《利刃出鞘》',
  '《致命ID》',
  '《七宗罪》',
  '《沉默的羔羊》',
  '《禁闭岛》',
  '《穆赫兰道》',
];

// 心情对应的电影类型
const Map<String, List<String>> moodMovieMap = {
  'happy': comedyMovies,
  'emo': healingMovies,
  'lazy': comedyMovies,
  'crazy': actionMovies,
};

// 时段对应的电影类型
const Map<String, List<String>> timeMovieMap = {
  'morning': comedyMovies,
  'lunch': comedyMovies,
  'afternoon': romanceMovies,
  'dinner': actionMovies,
  'lateNight': horrorMovies,
};

// 季节对应的电影类型
const Map<String, List<String>> seasonMovieMap = {
  'spring': romanceMovies,
  'summer': actionMovies,
  'autumn': mysteryMovies,
  'winter': healingMovies,
};
