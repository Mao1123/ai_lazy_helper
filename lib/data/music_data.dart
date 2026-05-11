// 流行音乐
const List<String> popMusic = [
  '周杰伦 - 《稻香》',
  '林俊杰 - 《小酒窝》',
  '邓紫棋 - 《泡沫》',
  '薛之谦 - 《演员》',
  '毛不易 - 《消愁》',
  '李荣浩 - 《年少有为》',
  '陈奕迅 - 《十年》',
  '王菲 - 《红豆》',
  'Taylor Swift - 《Love Story》',
  'Ed Sheeran - 《Perfect》',
  '周杰伦 - 《晴天》',
  '林俊杰 - 《江南》',
  '五月天 - 《知足》',
  '孙燕姿 - 《遇见》',
  '蔡依林 - 《日不落》',
  '王力宏 - 《唯一》',
  '潘玮柏 - 《快乐崇拜》',
  'S.H.E - 《恋人未满》',
];

// 治愈系音乐
const List<String> healingMusic = [
  '久石让 - 《Summer》',
  '坂本龙一 - 《Merry Christmas Mr. Lawrence》',
  'Yiruma - 《River Flows in You》',
  'Ludovico Einaudi - 《Nuvole Bianche》',
  'Joe Hisaishi - 《天空之城》',
  '钢琴曲 - 《卡农》',
  '纯音乐 - 《天空之城》',
  '纯音乐 - 《安妮的仙境》',
  '纯音乐 - 《梦中的婚礼》',
  '纯音乐 - 《秋日私语》',
  '纯音乐 - 《致爱丽丝》',
  '纯音乐 - 《雨的印记》',
  '纯音乐 - 《神秘园之歌》',
  '纯音乐 - 《童年》',
  '纯音乐 - 《雪之梦》',
  '纯音乐 - 《星空》',
  '纯音乐 - 《水边的阿狄丽娜》',
  '纯音乐 - 《献给爱丽丝》',
];

// 摇滚音乐
const List<String> rockMusic = [
  'Beyond - 《海阔天空》',
  '五月天 - 《倔强》',
  '汪峰 - 《飞得更高》',
  '朴树 - 《平凡之路》',
  '崔健 - 《一无所有》',
  'AC/DC - 《Highway to Hell》',
  'Queen - 《Bohemian Rhapsody》',
  'Nirvana - 《Smells Like Teen Spirit》',
  'Linkin Park - 《Numb》',
  'Green Day - 《Basket Case》',
  'Beyond - 《光辉岁月》',
  '五月天 - 《突然好想你》',
  '黑豹乐队 - 《无地自容》',
  '唐朝乐队 - 《梦回唐朝》',
  'Radiohead - 《Creep》',
  'The Beatles - 《Let It Be》',
  'Led Zeppelin - 《Stairway to Heaven》',
  'Pink Floyd - 《Wish You Were Here》',
];

// 民谣音乐
const List<String> folkMusic = [
  '赵雷 - 《成都》',
  '宋冬野 - 《董小姐》',
  '马頔 - 《南山南》',
  '陈粒 - 《奇妙能力歌》',
  '房东的猫 - 《云烟成雨》',
  '朴树 - 《白桦林》',
  '老狼 - 《同桌的你》',
  '李健 - 《贝加尔湖畔》',
  'Bob Dylan - 《Blowin\' in the Wind》',
  'John Lennon - 《Imagine》',
  '赵雷 - 《鼓楼》',
  '毛不易 - 《像我这样的人》',
  '好妹妹乐队 - 《你曾是少年》',
  '花粥 - 《出山》',
  '隔壁老樊 - 《我曾》',
  'Jam - 《七月上》',
  '程璧 - 《春的临终》',
  '万能青年旅店 - 《杀死那个石家庄人》',
];

// 电子音乐
const List<String> electronicMusic = [
  'Avicii - 《Wake Me Up》',
  'Alan Walker - 《Faded》',
  'The Chainsmokers - 《Closer》',
  'Marshmello - 《Alone》',
  'Martin Garrix - 《Animals》',
  'David Guetta - 《Titanium》',
  'Calvin Harris - 《Summer》',
  'Zedd - 《Clarity》',
  'Kygo - 《Firestone》',
  'Skrillex - 《Bangarang》',
  'Avicii - 《Levels》',
  'Alan Walker - 《Alone》',
  'Daft Punk - 《Get Lucky》',
  'Disclosure - 《Latch》',
  'Flume - 《Never Be Like You》',
  'ODESZA - 《Say My Name》',
  'Major Lazer - 《Lean On》',
  'DJ Snake - 《Turn Down for What》',
];

// 古典音乐
const List<String> classicalMusic = [
  '贝多芬 - 《月光奏鸣曲》',
  '莫扎特 - 《小星星变奏曲》',
  '肖邦 - 《夜曲》',
  '巴赫 - 《G弦上的咏叹调》',
  '柴可夫斯基 - 《天鹅湖》',
  '维瓦尔第 - 《四季》',
  '德彪西 - 《月光》',
  '舒伯特 - 《小夜曲》',
  '拉赫玛尼诺夫 - 《第二钢琴协奏曲》',
  '马斯涅 - 《沉思》',
  '贝多芬 - 《命运交响曲》',
  '贝多芬 - 《欢乐颂》',
  '莫扎特 - 《安魂曲》',
  '肖邦 - 《离别曲》',
  '李斯特 - 《钟》',
  '圣桑 - 《天鹅》',
  '埃尔加 - 《爱的致意》',
  '帕赫贝尔 - 《卡农》',
];

// 心情对应的音乐类型
const Map<String, List<String>> moodMusicMap = {
  'happy': popMusic,
  'emo': healingMusic,
  'lazy': folkMusic,
  'crazy': electronicMusic,
};

// 时段对应的音乐类型
const Map<String, List<String>> timeMusicMap = {
  'morning': classicalMusic,
  'lunch': popMusic,
  'afternoon': folkMusic,
  'dinner': popMusic,
  'lateNight': healingMusic,
};

// 季节对应的音乐类型
const Map<String, List<String>> seasonMusicMap = {
  'spring': folkMusic,
  'summer': electronicMusic,
  'autumn': classicalMusic,
  'winter': healingMusic,
};
