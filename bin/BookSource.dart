import 'dart:convert';
import 'dart:ffi';

import 'package:BookSource/bean/book_source_rule_old.dart';
import 'package:BookSource/bean/book_source.dart';
import 'package:BookSource/bean/parttern_rule.dart';
import 'package:BookSource/book_source_list_reader.dart';

import 'dart:io' as io;

import 'package:BookSource/network/book_search.dart';
import 'package:flutter_qjs/flutter_qjs.dart';

// import 'package:dartjsengine/dartjsengine.dart';
import 'package:html/parser.dart';
import 'package:json_path/json_path.dart';

// import 'package:xml/xml.dart';
// import 'package:jsparser/jsparser.dart';
void main(List<String> arguments) {
  print("1");
  DynamicLibrary.open('kernel32.dll');
  DynamicLibrary.open('flutter_qjs_plugin.dll');
  print("2");
  // print(io.Platform.environment["path"]);
  // print(io.Platform.executable);
  callJS().then((value) => print(value));
  testJs();
}


Future<String> callJS() async {
  // try {
  //   JavascriptRuntime flutterJs = getJavascriptRuntime();
  //   JsEvalResult jsResult =
  //       flutterJs.evaluate("Math.trunc(Math.random() * 100).toString();");
  //
  //   return jsResult.stringResult;
  // } on PlatformException catch (e) {
  //   print('ERRO: ${e.details}');
  // }
  final engine = FlutterQjs(
    stackSize: 1024 * 1024, // change stack size here.
  );
  print("engine start");
  engine.dispatch();
  print("engine ready");
  try {

    var js=  await io.File(r'C:\Users\baziii\Desktop\bookjs.js')
        .readAsString();
    return (await engine.evaluate(
        'var result=7106468; ${js}'));
      //
      // parsejs(value, filename: 'test.js')
      // window.console.debug(value)
      // Parse expression:
      // Expression expression = Expression.parse("cos(x)*cos(x)+sin(x)*sin(x)==1");


    // return (await engine.evaluate(
    //     "Math.trunc(Math.random() * 100).toString();"));
  }
  // catch (e) {
  //   return (e.toString());
  // }
  finally {
    try {
      engine.port.close(); // stop dispatch loop
      engine.close(); // close engine
    } on JSError catch (e) {
      print(e); // catch reference leak exception
    }
  }
  return "null";
}

Future<void> testJs() async {
  // print(doc);
  //"http://www.ireader.com


  await io.File(r'C:\Users\baziii\Desktop\bookjs.js')
      .readAsString()
      .then((value) =>
  {
    // parsejs(value, filename: 'test.js')
    // window.console.debug(value)
    // Parse expression:
    // Expression expression = Expression.parse("cos(x)*cos(x)+sin(x)*sin(x)==1");


  })
  //     .then((value) => value.forEach((element) {
  //   // JsObject myObj = JSEngine().visitProgram(element);
  //   // print('${myObj.valueOf}');
  // }))
      ;
}

Future<void> testJsoupClass() async {
  // print(doc);
  //"http://www.ireader.com
  await io.File(r'C:\Users\baziii\Desktop\ireader.html')
      .readAsString()
      .then((value) => {parse(value)})
      .then(
          (value) =>
          value.forEach((element) {
//"class.sResult@tag.li|class.newShow@tag.li
            element.querySelectorAll('.newShow').forEach((element) {
              // print(element.outerHtml);
              element.querySelectorAll('li').forEach((e1) {
                // print(e1);
                print(e1.querySelector('.tryread')!.nodes[0].text);
                print(e1.querySelector('.introduce')!.nodes[0].text);
                print(e1.querySelector('img')!.attributes["src"]);
                print('-----split-----');
              });

              // print( element.querySelector('.introduce')!.nodes[0].text);
              // print('-----split-----');
              // print(element.nodes[0].text);
            });
            // element.querySelectorAll('class.introduce').forEach((element) {
            //   print(element.text);
            //  });

          })
  );
}

void jsonPathSoup() {
  var doc =
      r'{"totalcount":4601,"pagecount":307,"bookinfo":[{"catename":"天外飞蝶","bid":"42203","juanid":"61666","chapterid":"1526540","authorname":"屿霖铃","sex_flag":"nan","finish":1,"charnum":"503704","updatetime":"1359392554","tag":null,"total_hit":"2918670","redticket":null,"total_flower":"1024","authorid":"340377","classname":"异界大陆","classid":"3","classid2":"14","intro":"<p>绝对值得一读的作品</p><p>他，是异界大陆的王子，运筹帷幄，能征善战，唯独悲情；</p><p>她，是地球的普通女孩，为了朋友，和地球一修真门派的师姐师兄们到了异界；\r</p><p>因为，这门派和异界有一个千年契约。\r</p><p>人、兽、魔、妖、神，谁才是最后的霸主？\r</p><p>河蟹大军、蚕豹魔军、飞龙骑士、火焰骑兵、金甲武士、天弓骑兵，</p><p>公主、王子，谁是你的千年一梦？</p><p>尽在《天外飞蝶》！</p>","star":"9.10","lzinfo":"1","salenum":"1344","month_hit":"114","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/4/22/42203_middle.jpg","last_update_title":"第224章 王子回归"},{"catename":"诸天外卖系统","bid":"105507","juanid":"187554","chapterid":"1188833","authorname":"我自不凡","sex_flag":"nan","finish":2,"charnum":"774790","updatetime":"1606868133","tag":["无敌流","爽文","装逼"],"total_hit":"3225","redticket":"0","total_flower":"358","authorid":"416909","classname":"现代修真","classid":"1","classid2":"40","intro":"<p>一场车祸后，李不凡觉醒了“诸天外卖系统”，能通达诸天万界。<br />\r</p><p>他为仙侠世界某大佬送了一份外卖，竟然得到了修仙功法！</p><p>于是，他就成为了修仙者。<br />\r</p><p>他又给电影世界的九叔送了一份外卖，得到了道家法术“五雷正法”！</p><p>于是，他学会了仙家法术。<br />\r</p><p>他进入天龙八部世界，给乔峰送去外卖，竟然得到了乔峰的醍醐灌顶，以及“降龙十八掌”？</p><p>修为大涨。<br />\r</p><p>于是，他开挂的人生开始了……</p>","star":"0.00","lzinfo":"0","salenum":"0","month_hit":"139","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/10/55/105507_middle.jpg","last_update_title":"第366章 小姐姐真帅气"},{"catename":"囧囧飞仙","bid":"92696","juanid":"159441","chapterid":"13966138","authorname":"九策","sex_flag":"nv","finish":1,"charnum":"211240","updatetime":"1527945726","tag":null,"total_hit":"16704","redticket":null,"total_flower":"0","authorid":"402830","classname":"综合其他","classid":"2","classid2":"10","intro":"——何为囧仙？ \r\n——擅画春宫秘戏，偷窥上仙美色，为哮天犬搭母狗，为月老配怨偶，行骗太上老君的仙丹。衣衫永远不整，头发永远散乱，全身永远一副邋遢样，满身的凡夫俗气。 \r\n——作为一个囧仙，她的理想是：温饱淫私欲，压倒众仙郎。 \r\n——跟了本帝君，让你每顿温饱淫私欲，且一日多餐，只压本君一仙就好。\r\n——自从被你压倒之后，本真君六根不净，日夜思淫，我俩一同上诛仙台，到凡间思淫去吧！\r\n\r\n","star":"0.00","lzinfo":"1","salenum":"0","month_hit":"242","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/9/26/92696_middle.jpg","last_update_title":"番外：小曜之帮凶"},{"catename":"天外飞鹰到我家","bid":"45209","juanid":"59239","chapterid":"1395193","authorname":"殷绰","sex_flag":"nv","finish":1,"charnum":"190759","updatetime":"1353431294","tag":null,"total_hit":"44873","redticket":"0","total_flower":"1","authorid":"0","classname":"穿越时空","classid":"2","classid2":"8","intro":"谁能比她更幸运，买个变形金刚玩具回家竟然给她变成了活生生的香艳大帅哥一枚！<br />\r\n让高渐思告诉你与来自公元3009年的大黄蜂殷鹰生活在一个屋檐下会发生怎样爆笑又甜蜜的故事。<br />\r\n考试不过关，不用怕，有聪明的大黄蜂帮忙搞定；<br />\r\n生活无聊不用怕，有温柔的大黄蜂免费陪数星星；<br />\r\n身娇肉贵不用怕，有身手敏捷的大黄蜂来当搬运工；<br />\r\n想感受多拉A梦随意门的快感，没问题，大黄蜂带你瞬间转移。<br />\r\n再加上高傲小姐韦子爵、斯文俊逸却又行为诡异的向阳，以及一只会尖叫会偷吃泡芙的宠物老鹰侍卫“小鸟”又如何……<br />\r\n还迟疑什么，快过来领略一场异想天开的新纪元爱情传奇——<br />\r\n<br />\r\n<br />\r\n<br />\r\n","star":"7.50","lzinfo":"1","salenum":"40","month_hit":"120","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/4/52/45209_middle.jpg","last_update_title":"第54场 容我去疗伤"},{"catename":"武侠之宝箱系统","bid":"101805","juanid":"179562","chapterid":"109291","authorname":"一朵大白云","sex_flag":"nv","finish":1,"charnum":"1331471","updatetime":"1562841733","tag":null,"total_hit":"28599","redticket":"0","total_flower":"0","authorid":"0","classname":"综合其他","classid":"2","classid2":"10","intro":"穿越融合各大武侠小说的“大武侠”世界，并获得“宝箱系统\\\"，随处都可开启宝箱，获得至宝。<br />\r\n开启白银宝箱，获得武技——八极崩！<br />\r\n开启黄金宝箱，获得剑法——天外飞仙！<br />\r\n开启神级宝箱，获得宠物——小囡囡~","star":"0.00","lzinfo":"1","salenum":"0","month_hit":"712","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/10/18/101805_middle.jpg","last_update_title":"第655章   打败林平之，萧凌归隐"},{"catename":"我被迫成了掌门","bid":"112492","juanid":"202652","chapterid":"1311660","authorname":"火爆鱿鱼","sex_flag":"nan","finish":1,"charnum":"730692","updatetime":"1614543979","tag":null,"total_hit":"761","redticket":"0","total_flower":"0","authorid":"417824","classname":"东方玄幻","classid":"3","classid2":"13","intro":"意外重生，觉醒诸天签到系统。<br />\r\n“叮，恭喜宿主，获得白云城主叶孤城技能卡--天外飞仙！”<br />\r\n“叮，恭喜宿主，获得药尊者药尘异火---骨灵冷火!”<br />\r\n“叮，恭喜宿主，获得恶魔果实.....”<br />\r\n 诸天万界，任何物品都有机会得到！<br />\r\n本想与世无争，过着混吃等死的生活，然而雷霆却被迫成了掌门！<br />\r\n麻烦不断，系统又下达任务，为了完成任务，诸天万族劫难不断。","star":"0.00","lzinfo":"1","salenum":"0","month_hit":"56","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/11/24/112492_middle.jpg","last_update_title":"第350章  离去"},{"catename":"山里有棵仙灵树","bid":"77374","juanid":"128008","chapterid":"11718380","authorname":"醉舞幽篁","sex_flag":"nan","finish":2,"charnum":"4432","updatetime":"1464338506","tag":null,"total_hit":"897","redticket":null,"total_flower":"0","authorid":"380838","classname":"都市异能","classid":"1","classid2":"32","intro":"遭遇女友背叛，科研成果被夺，江离毅然回乡投身家乡建设事业。\r\n偶得隐藏于天外飞石之中的仙灵树，从此贫困闭塞的山村成为富饶之地，商贾名流云集，各路美女蜂拥而至……\r\n友情提示： 本书书友群，57332692，欢迎各路豪杰！","star":"0.00","lzinfo":"0","salenum":"0","month_hit":"36","shouquanname":"免费","bookface":"https://img2.hongshu.com/img/001.jpg","last_update_title":"第2章 坟头长草，脑门开树"},{"catename":"我在乡村开淘宝","bid":"81940","juanid":"137225","chapterid":"12522205","authorname":"天外有仙","sex_flag":"nan","finish":1,"charnum":"690559","updatetime":"1492415385","tag":["热血","异能","种田"],"total_hit":"17655","redticket":"0","total_flower":"33","authorid":"386191","classname":"现实百态","classid":"1","classid2":"5","intro":"<p>平凡大学生手机里突然多了一个叫做天庭淘宝的软件，由此他走上了一条不同凡响的淘宝店主生涯，卖东西给神仙，同样，仙界的东西也被他买到了手中。<br />\r</p><p>山神的人参种子和快速成长试剂帮他发家致富。<br />\r</p><p>符仙的各种符咒能帮他锄强扶弱。<br />\r</p><p>太上老君的各式丹药能帮他救死扶伤。<br />\r</p><p>……<br />\r</p><p>厨神：求求你卖一本精品菜谱给我吧，玉皇大帝已经吃腻了我做的菜了。<br />\r</p><p>太上老君座下童子：我用太上老君亲手炼制的丹药换你一个空调吧，我坐在火炉旁边都快热死了。<br />\r</p><p>逍遥仙子：我用一颗仙果换你岛国的女明星影碟给我解锁新姿势好不好？</p><p>……<br />\r</p><p>刘志感觉这个世界乱套了，这天上的神仙也太没节操了吧！</p><p>三十年河东，三十年河西，莫欺少年穷！且看一平凡少年如何逆袭，走上发家致富之路。<br />\r</p>","star":"0.00","lzinfo":"1","salenum":"23","month_hit":"351","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/8/19/81940_middle.jpg","last_update_title":"第三百一十五章：十里花海（大结局）"},{"catename":"绝世皇帝系统","bid":"85408","juanid":"143756","chapterid":"12422823","authorname":"天外有仙","sex_flag":"nan","finish":2,"charnum":"4693","updatetime":"1488527405","tag":null,"total_hit":"11443","redticket":null,"total_flower":"5","authorid":"386191","classname":"异界大陆","classid":"3","classid2":"14","intro":"\r\n　　神武大陆，宗门林立，武道昌盛，经历上古时代的天地大变，灵气充沛，各路英雄豪杰层出不穷，宗门也如同雨后春笋一般不断涌现，人人都能开宗立派，广收弟子，而作为上古时期正统的皇室，却衰落到极致！\r\n       刘志携绝世皇帝系统穿越到大宋王国一个废物皇帝身上，看他如何除奸臣、中兴大宋，成为一代明君。\r\n","star":"0.00","lzinfo":"0","salenum":"0","month_hit":"73","shouquanname":"免费","bookface":"https://img2.hongshu.com/bookface/8/54/85408_middle.jpg","last_update_title":"第二章：连续晋级"},{"catename":"极品无敌仙医","bid":"59402","juanid":"88394","chapterid":"11903797","authorname":"暗鼎","sex_flag":"nan","finish":1,"charnum":"2002140","updatetime":"1471917625","tag":["都市","热血","异能","爽文","美女","许飞","仙医","中医","玄医"],"total_hit":"2846537","redticket":"0","total_flower":"2480","authorid":"347090","classname":"都市异能","classid":"1","classid2":"32","intro":"<p>玄医真仙第八十八代传人许飞，浪迹都市开了家小医馆。<br />\r</p><p>原本籍籍无名的小玄医，依靠失传千年的春秋针法，银针渡人，术法渡鬼。<br />\r</p><p>柔情待亲人，嚣张戏美女！</p><p>侠义对朋友，妖孽虐敌人！</p><p>看身怀绝技的小玄医狂扫孽障，拥揽众美，傲立都市！<br />\r</p><p>仙医群：375531058</p>","star":"8.20","lzinfo":"1","salenum":"86030","month_hit":"411","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/5/94/59402_middle.jpg","last_update_title":"第762章  大结局"},{"catename":"都市修仙蛊医","bid":"93841","juanid":"162046","chapterid":"14247256","authorname":"笔下痕","sex_flag":"nan","finish":1,"charnum":"618165","updatetime":"1535420745","tag":["修炼","功法","扮猪吃虎","无敌流","热血","爽文"],"total_hit":"19615","redticket":"0","total_flower":"37","authorid":"404044","classname":"现代修真","classid":"1","classid2":"40","intro":"<p><p>昂首攀南斗，翻身依北辰，举头天外望，无我这般人。<br />\r</p><p>一代蛊尊者横空出世，以一手蛊毒傲视整个修仙界，却是在飞升大道的最后关头惨遭好友暗算，灵魂陨落至地球少年杨修身上。<br />\r</p><p>身份低微的他遭嘲讽，遭暗算，以及各种不公对待，且看一代仙尊如何化解这不公，脚踩富二代，连同前世今生，一起再回巅峰！</p></p>","star":"0.00","lzinfo":"1","salenum":"185","month_hit":"159","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/9/38/93841_middle.jpg","last_update_title":"第三百章：最终一战大结局"},{"catename":"都市之妖孽仙帝","bid":"114204","juanid":"206367","chapterid":"1495255","authorname":"天外之人","sex_flag":"nan","finish":2,"charnum":"10488","updatetime":"1624583308","tag":["异界","丹药","无敌流","热血","爽文","美女","重生"],"total_hit":"91","redticket":"0","total_flower":"0","authorid":"427630","classname":"现代修真","classid":"1","classid2":"40","intro":"恭喜修仙世家叶家再出一帝！<br />\n叶仙帝重回都市，曾经的屈辱和背叛，他要百倍千倍的奉还！<br />\n“这一刻起，我叶枫要保护的人，谁也别想动，就是阎王来了也不行！”——叶仙帝","star":"0.00","lzinfo":"0","salenum":"0","month_hit":"91","shouquanname":"免费","bookface":"https://img2.hongshu.com/img/001.jpg","last_update_title":"第5章 动手"},{"catename":"霸武九重天","bid":"68711","juanid":"110785","chapterid":"11741268","authorname":"木汤","sex_flag":"nan","finish":1,"charnum":"674296","updatetime":"1465353451","tag":["玄幻","爽文","美女","升级","冒险","热血"],"total_hit":"2598845","redticket":"0","total_flower":"173","authorid":"370284","classname":"东方玄幻","classid":"3","classid2":"13","intro":"<p>少年何辟,年少中毒,不可修武,受尽凌辱!</p><p>被人陷害,意外得神诀,破尸毒,得天赋,练盘古开天诀,走上霸武破天逆袭惊天震地之路!</p><p>天是我的,地是我的,天外天还是我的,还有什么不是我的?</p><p>为什么天是我的?这天这地是谁开的?盘古,宾GO,没见我练的是什么吗?</p><p>盘古开天诀</p>","star":"7.50","lzinfo":"1","salenum":"2795","month_hit":"376","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/6/87/68711_middle.jpg","last_update_title":"第296章 大结局（下）终章"},{"catename":"逆天星尊","bid":"87437","juanid":"147765","chapterid":"13627410","authorname":"随风逐停","sex_flag":"nan","finish":1,"charnum":"600215","updatetime":"1521531277","tag":["丹药","扮猪吃虎","热血","爽文","升级"],"total_hit":"18831","redticket":"0","total_flower":"37","authorid":"374540","classname":"转世重生","classid":"3","classid2":"33","intro":"<p>一代丹神杨凡，以逆天手段炼制上古神丹，丹成之际召来奇异星辰导致重伤，最后更是被他的挚爱烟雨儿暗算身亡……<br />\r</p><p>然而杨凡不仅没死，反而带着天外星辰借尸还魂，丹神重生。<br />\r</p><p>凭借意外得到的创界星辰诀，这一世，杨凡注定逆天而行，成就星尊之威！</p>","star":"0.00","lzinfo":"1","salenum":"180","month_hit":"274","shouquanname":"VIP","bookface":"https://img2.hongshu.com/bookface/8/74/87437_middle.jpg","last_update_title":"第二百九十二章 结束一切"},{"catename":"飞尊","bid":"99381","juanid":"174332","chapterid":"15404956","authorname":"白色风沙","sex_flag":"nan","finish":2,"charnum":"6112","updatetime":"1554892133","tag":null,"total_hit":"175","redticket":null,"total_flower":"0","authorid":"409185","classname":"东方玄幻","classid":"3","classid2":"13","intro":"仙凡一线之间。一念神圣，一念凡尘。一念飞仙！","star":"0.00","lzinfo":"0","salenum":"0","month_hit":"28","shouquanname":"免费","bookface":"https://img2.hongshu.com/img/001.jpg","last_update_title":"第2章：仙缘"}]}';
  // var soup = Beautifulsoup(doc);
  // final prices = JsonPath(r"$.bookinfo.[*]");
  final prices = JsonPath(r"$.bookinfo[*]");

  prices
      .read(JsonCodec().decoder.convert(doc))
      .map((match) => '${match.path}:\t${match.value}')
      .forEach(print);
}

void search() {
  new io.File(r'C:\Users\baziii\Desktop\书源.json')
      .readAsString()
      .then((value) => BookSourcesReader.read(value))
      .then((value) =>
      value.forEach((element) {
        printBookSourceUrl(element);
      }));
}

void printBookSourceUrl(BookSource source) {
  // if( source.bookSourceUrl.contains('https://api.zhuishushenqi.com')) {
  if (source.bookSourceUrl.contains('https://www.hongshu.com') ||
      source.bookSourceUrl.contains('https://api.zhuishushenqi.com')) {
    // BookSearch.fromRule(source, "天外飞仙", 1).searchBooks();
    // print(source);

    if (source.ruleSearch != null) {
      print((source.searchUrl).toString());
      BookSearch.fromRule(source, "天外飞仙", 1).init().searchBooks().then(
              (value) =>
              PatternRule.getStringList(
                  PatternRule.parse(source.ruleSearch!.bookList!), value)
                  .forEach((element) {
                print(PatternRule.getString(
                    PatternRule.parse(source.ruleSearch!.name!), element));
              }));
    }
    // BookSearch.fromRule(source, "天外飞仙", 1).searchBooks();
  }
}
