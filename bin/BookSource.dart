import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:BookSource/bean/book_source_rule_old.dart';
import 'package:BookSource/bean/book_source.dart';
import 'package:BookSource/parse_factory.dart';
import 'package:BookSource/rule/rule_factory.dart';
import '../lib/xpath/xpath_selector.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import '../lib/parttern_rule.dart';
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
  // print("1");
  // DynamicLibrary.open('kernel32.dll');
  // DynamicLibrary.open('flutter_qjs_plugin.dll');
  // print("2");
  // // print(io.Platform.environment["path"]);
  // // print(io.Platform.executable);
  // callJS().then((value) => print(value));
  // callRegex().then((value) => print(value));
  // testJs();
  // callRegex();
  // callRegex();
  // callXpath();
  // testGet();
  search();

  // testDetailJsoup();
  // testJsJavaAjax();
}


Future<void> testDetailJsoup() async {
  // print(doc);
  //"http://www.ireader.com
  print('-----start-----');
  var detail=await
  io.File(r'C:\Users\baziii\IdeaProjects\BookSource\book_detail.xml').readAsString();
  var element=parse(detail);
  print(element);
//"class.sResult@tag.li|class.newShow@tag.li
    element.querySelectorAll('input[id=hidbid]').forEach((e1) {
    // print(element.outerHtml);
    print(e1.attributes['value']);
    print('-----split-----');
  });
    // element.querySelectorAll('class.introduce').forEach((element) {
    //   print(element.text);
    //  });
}
testJsJavaAjax() async {
  var html = await
  io.File(r'C:\Users\baziii\IdeaProjects\BookSource\book_detail.xml').readAsString();
  var ruleContent="[id=hidbid]@value&&[id=hidjid]@value&&[id=hidcid]@value\n<js>\n;function _long2str(v,w){var vl=v.length;var sl=v[vl-1]&0xffffffff;for(var i=0;i<vl;i++){v[i]=String.fromCharCode(v[i]&0xff,v[i]>>>8&0xff,v[i]>>>16&0xff,v[i]>>>24&0xff);}if(w){return v.join('').substring(0,sl);}else{return v.join('');}}\r\n;function _str2long(s,w){var len=s.length;var v=[];for(var i=0;i<len;i+=4){v[i>>2]=s.charCodeAt(i)|s.charCodeAt(i+1)<<8|s.charCodeAt(i+2)<<16|s.charCodeAt(i+3)<<24;}if(w){v[v.length]=len;}return v;}\r\n;function _hs_decrypt(str,key){if(str==''){return'';}var v=_str2long(str,false);var k=_str2long(key,false);var n=v.length-1;var z=v[n-1],y=v[0],delta=0x9E3779B9;var mx,e,q=Math.floor(6+52/(n+1)),sum=q*delta&0xffffffff;while(sum!=0){e=sum>>>2&3;for(var p=n;p>0;p--){z=v[p-1];mx=(z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);y=v[p]=v[p]-mx&0xffffffff;}z=v[n];mx=(z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);y=v[0]=v[0]-mx&0xffffffff;sum=sum-delta&0xffffffff;}return _long2str(v,true);}\r\n;function _my_base64decode(str){var c1,c2,c3,c4,base64DecodeChars=new Array(-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,62,-1,-1,-1,63,52,53,54,55,56,57,58,59,60,61,-1,-1,-1,-1,-1,-1,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,-1,-1,-1,-1,-1,-1,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,-1,-1,-1,-1,-1);var i,len,out;len=str.length;i=0;out='';while(i<len){do{c1=base64DecodeChars[str.charCodeAt(i++)&0xff];}while(i<len&&c1==-1);if(c1==-1)break;do{c2=base64DecodeChars[str.charCodeAt(i++)&0xff];}while(i<len&&c2==-1);if(c2==-1)break;out+=String.fromCharCode((c1<<2)|((c2&0x30)>>4));do{c3=str.charCodeAt(i++)&0xff;if(c3==61)return out;c3=base64DecodeChars[c3];}while(i<len&&c3==-1);if(c3==-1)break;out+=String.fromCharCode(((c2&0XF)<<4)|((c3&0x3C)>>2));do{c4=str.charCodeAt(i++)&0xff;if(c4==61)return out;c4=base64DecodeChars[c4];}while(i<len&&c4==-1);if(c4==-1)break;out+=String.fromCharCode(((c3&0x03)<<6)|c4);}return out;}\r\n;function _utf8to16(str){var out,i,len,c;var char2,char3;out='';len=str.length;i=0;while(i<len){c=str.charCodeAt(i++);switch(c>>4){case 0:case 1:case 2:case 3:case 4:case 5:case 6:case 7:out+=str.charAt(i-1);break;case 12:case 13:char2=str.charCodeAt(i++);out+=String.fromCharCode(((c&0x1F)<<6)|(char2&0x3F));break;case 14:char2=str.charCodeAt(i++);char3=str.charCodeAt(i++);out+=String.fromCharCode(((c&0x0F)<<12)|((char2&0x3F)<<6)|((char3&0x3F)<<0));break;}}return out;}\n;function _myreplace(s,a,b){return s.replace(new RegExp(a,'g'),b);};\n;function _mytrim(s){return _myreplace(_myreplace(s,'\\r',''),'\\n','');};\n\nvar document = {\n    createElement : function(){return this;},\n    setAttribute : function(){return;},\n    getElementsByTagName : function(){return [this];},\n    parentNode : {\n        insertBefore : function(){return;},\n    },\n    styleSheets : [\n        {\n            addRule : function(){return;},\n        },\n    ],\n},\ntop = {\n    window : {\n        location : {\n            href : '',\n        },\n    },\n},\nwindow = top['window'],\n_mycon = '获取内容失败',\n_myjs,\narr = result.split('\\n'),\n_curbid = arr[0],\n_curjid = arr[1],\n_curcid = arr[2],\n_ajaxurl = 'https://www.hongshu.com/bookajax.do',\n_tkey = _ajaxurl +'@method=getchptkey&bid='+ _curbid +'&cid='+ _curcid,\n_key = JSON.parse(java.ajax(_tkey)).key, _tcon = _ajaxurl +'@method=getchpcontent&bid='+ _curbid +'&jid='+ _curjid +'&cid='+ _curcid;\n_tcon = JSON.parse(java.ajax(_tcon));\nif(_tcon.content != ''){\n    _mycon = _myreplace(_utf8to16(_hs_decrypt(_my_base64decode(_tcon.content), _key)), '&lt;p&gt;', '');\n    _mycon = _myreplace(_mycon, '&lt;/p&gt;', '_thebr_');\n};\nif(_tcon.hasOwnProperty('other')){\n    if(_tcon.other != ''){\n        _mycon = _myreplace(_mycon, '&lt;span class=', '');\n        _mycon = _myreplace(_mycon, '&gt;&lt;/span&gt;', '');\n        _mycon = _myreplace(_mycon, '\\r', '');\n        _mycon = _myreplace(_mycon, '\\n', '_thebr_');\n        _mycon = _myreplace(_mycon, '`',  '｀');\n        _mycon = _myreplace(_mycon, \"'\", '｀');\n        _myjs = _mytrim(_utf8to16(_hs_decrypt(_my_base64decode(_tcon.other), _key)));\n        eval(_myjs);\n        words.forEach(function(e,i){\n            _mycon = _myreplace(_mycon, '｀context_kw'+i+'｀', e);\n        });\n        _mycon = _myreplace(_mycon, '_thebr_', '\\n');\n        _mycon = '已加密☄ฺ(◣д◢)☄ฺ ☄ฺ(◣д◢)☄ฺ ☄ฺ(◣д◢)☄ฺ\\n' + _mycon;\n    }else{\n        _mycon = '未加密(づ ●─● )づ (づ ●─● )づ (づ ●─● )づ\\n' + _myreplace(_mycon, '_thebr_', '\\n');\n    };\n};return _mycon;\n</js>";
  var rule= RuleFactory.parse(ruleContent);
  print(await ParseFactory.getParser(rule).getString(html));
  ////*[@class='chapter-list2 bom150 clearfix']//li
  // XPath.source(html).query("//*[@category='chapterlist']//li").list().forEach((element) {print(element);});

  // var li=r'<li><a href="/content/42203/61198-1496966.html" target="_blank" title="第140章 依依舍之(2012-12-07 19:55:02)" class="qh">第140章 依依舍之</a><span class="vip">vip</span></li>';
  //
  // XPath.source(li).query("//a/@href").list().forEach((element) {print(element);});
  // XPath.source(li).query("//a[@class='qh']/text()").list().forEach((element) {print(element);});
}

 callXpath() async {
  var html = await
   io.File(r'C:\Users\baziii\IdeaProjects\BookSource\book.xml').readAsString();
  ////*[@class='chapter-list2 bom150 clearfix']//li
  XPath.source(html).query("//*[@category='chapterlist']//li").list().forEach((element) {print(element);});

  // var li=r'<li><a href="/content/42203/61198-1496966.html" target="_blank" title="第140章 依依舍之(2012-12-07 19:55:02)" class="qh">第140章 依依舍之</a><span class="vip">vip</span></li>';
  //
  // XPath.source(li).query("//a/@href").list().forEach((element) {print(element);});
  // XPath.source(li).query("//a[@class='qh']/text()").list().forEach((element) {print(element);});
}
Future<String> callRegex() async {
  var unjson =
      "{Seq: '1f9caa033a22bc75e72437d8952992cd',PushToken: 'AqJmTQBjP541B9G8V90FwOfjyWUbqhf9dOrENy47ckhK'}";
  var regex = RegExp(r"('?\w*'?){1}:");
  regex.allMatches(unjson).forEach((element) {
    print(element.group(0));
    print(element.group(1));
  });
  var json = (unjson.replaceAllMapped(
          regex,
          (m) => r"'$1':".replaceAllMapped(
              RegExp(r"\$(\d)"), (m2) => m.group(int.parse(m2.group(1)!))!)))
      .replaceAll(r"'", '"');
  print(JsonCodec().decoder.convert(json));
  if (true) {
    return '';
  }
  final s = "123-4567-89,987-6543-21";
  print(s.replaceAllMapped(
      RegExp(r"(\d+)-(\d+)-(\d+)"),
      (m) => r"$3-$1-$2".replaceAllMapped(
          RegExp(r"\$(\d)"), (m2) => m.group(int.parse(m2.group(1)!))!)));

  var content =
      '{"code":0,"count":100,"data":[{"author":"龙鳞","chapterCnt":373,"clsId":2,"clsIdSecond":23,"clsName":"奇幻 - 魔法校园","createTime":"2018-11-19 07:04:34","downCnt":0,"esScore":33629,"fullFlag":3,"id":394785,"intro":"","isOnShelf":0,"lastUpdate":"2018-03-30 16:26:00","loveCnt":0,"name":"天外飞仙","photoPath":"/70/147e3429e29bb996dc0b828643e29a7f.jpg","postDate":"2018-11-12 00:04:19.000","readCnt":0,"relTagName":[],"retention":2073,"score":6363,"status":1,"strScore":"6.4","wordCnt":1286498},{"author":"戚少","chapterCnt":20,"clsId":4,"clsIdSecond":29,"clsName":"仙侠 - 奇幻修真","createTime":"2018-11-23 21:44:35","downCnt":0,"esScore":33384,"fullFlag":2,"id":532157,"intro":"天道不仁，以万物为刍狗。天地为棋盘，众生皆为棋子。问苍茫大地，谁主沉浮？死亡并不是结束，而是新的开始。天外来客坠入西冥山脉，是意外还是意图？天道布局谁能阻挡？欧阳天身为天眷之子，命运之路到底何去何从？强者，注定踏着累累白骨走上巅峰。而弱者注定成为…\n","isOnShelf":0,"lastUpdate":"2017-04-26 16:08:35","loveCnt":0,"name":"天外飞仙","photoPath":"/70/147e3429e29bb996dc0b828643e29a7f.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":630,"score":6500,"status":1,"strScore":"6.5","wordCnt":73161},{"author":"小昌","chapterCnt":1,"clsId":4,"clsIdSecond":28,"clsName":"仙侠 - 现代修真","createTime":"2019-03-06 12:56:26","downCnt":0,"esScore":33140,"fullFlag":3,"id":724767,"intro":"小昌，80后新锐作家，广西作家协会会员，山东冠县人，1982年出生，大学教师。曾在《北方文学》、《黄河文学》、《延河》等杂志发表中短篇小说若干。现居广西北海。","isOnShelf":0,"lastUpdate":"2018-06-01 17:47:09","loveCnt":0,"name":"天外飞仙","photoPath":"/2035/649160F2994BDDC20291FEC05110F9E8/t5_215476.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":735,"score":6300,"status":1,"strScore":"6.3","wordCnt":2464},{"author":"天外飞仙","chapterCnt":4,"clsId":5,"clsIdSecond":31,"clsName":"都市 - 医道圣手","createTime":"2019-01-14 11:35:37","downCnt":0,"esScore":29701,"fullFlag":2,"id":624088,"intro":"最强邪医强势下山，专给各路美女治病……","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"最强都市邪医","photoPath":"/1583/1D2648901520E7697BC1CAEBA560B25A/1D2648901520E7697BC1CAEBA560B25A.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":100,"score":8044,"status":1,"strScore":"8.0","wordCnt":13029},{"author":"天外飞仙","chapterCnt":661,"clsId":5,"clsIdSecond":31,"clsName":"都市 - 医道圣手","createTime":"2019-06-12 07:37:23","downCnt":0,"esScore":29285,"fullFlag":2,"id":893139,"intro":"主角:苏怡凡,唐诚。 “臭小子，你眼睛往哪里瞄？”“小姐姐，不要生气嘛，我在给你看病呢。”最强都市邪医强势下山，专给各路美女治病……","isOnShelf":0,"lastUpdate":"2018-10-25 05:06:00","loveCnt":0,"name":"至强都市邪医","photoPath":"/1078/795EA00B390593F2C1984E94436839C1/795EA00B390593F2C1984E94436839C1.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":463,"score":6000,"status":1,"strScore":"6.0","wordCnt":1823386},{"author":"月神","chapterCnt":2178,"clsId":5,"clsIdSecond":31,"clsName":"都市 - 医道圣手","createTime":"2019-04-07 11:09:23","downCnt":0,"esScore":20750,"fullFlag":2,"id":820213,"intro":"主角:。 有些女人不能碰，碰一碰，要你命！太上老君炼丹童子——徐甲，睡了嫦娥，惹怒玉皇大帝，在孙猴子的庇护下，魂穿人间，凭着一手炼丹术、医术，风水，道术，混的风生水起。懂天文，识地理，...","isOnShelf":0,"lastUpdate":"2018-07-01 11:56:00","loveCnt":0,"name":"天外飞医","photoPath":"/3262/5810EAD9263DAF07DEE85B903BC9C64E/5810EAD9263DAF07DEE85B903BC9C64E.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1123,"score":6000,"status":1,"strScore":"6.0","wordCnt":6514932},{"author":"月神_幻文小说网","chapterCnt":179,"clsId":5,"clsIdSecond":31,"clsName":"都市 - 医道圣手","createTime":"2018-11-23 23:53:03","downCnt":0,"esScore":19746,"fullFlag":2,"id":543251,"intro":"有些女人不能碰，碰一碰，要你命！太上老君炼丹童子——徐甲，睡了嫦娥，惹怒玉皇大帝，在孙猴子的庇护下，魂穿人间，凭着一手炼丹术、医术，风水，道术，混的风生水起。懂天文，识地理，能捉鬼，能降妖。精医术，通道术，会治病，会杀人。很热血、很邪…\n","isOnShelf":0,"lastUpdate":"2016-09-06 04:09:24","loveCnt":0,"name":"天外飞医","photoPath":"/70/147e3429e29bb996dc0b828643e29a7f.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":2613,"score":6545,"status":1,"strScore":"6.5","wordCnt":469558},{"author":"夜天寒(书坊)","chapterCnt":145,"clsId":4,"clsIdSecond":29,"clsName":"仙侠 - 奇幻修真","createTime":"2018-11-19 02:18:59","downCnt":0,"esScore":19331,"fullFlag":2,"id":380533,"intro":"天，何谓天？仙，又何谓仙？造化之下，众生蝼蚁，皆可为仙，世间却无仙！仙在何方，地葬之下。仙在何方，苍莽之天！\n","isOnShelf":0,"lastUpdate":"2015-06-05 14:37:33","loveCnt":0,"name":"飞仙天外天","photoPath":"/257/4DDF78AED43882E3F299237F0131C0CA/4DDF78AED43882E3F299237F0131C0CA.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6100,"status":1,"strScore":"6.1","wordCnt":461062},{"author":"天外肥仙","chapterCnt":6544,"clsId":6,"clsIdSecond":43,"clsName":"校园 - 校园修真","createTime":"2019-10-07 12:00:46","downCnt":0,"esScore":18693,"fullFlag":2,"id":906703,"intro":"  温柔似水的校花，匪气十足的少年，因为一支神奇钢笔，自此生活变的多姿多彩了起来。","isOnShelf":0,"lastUpdate":"2019-10-06 18:56:11","loveCnt":0,"name":"校园花心高手","photoPath":"/3123/6661E82CAF738405A329BB92D305D711/6661E82CAF738405A329BB92D305D711.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":3069,"score":6500,"status":1,"strScore":"6.5","wordCnt":15066421},{"author":"天外肥仙","chapterCnt":5572,"clsId":6,"clsIdSecond":42,"clsName":"校园 - 校园生活","createTime":"2019-06-12 04:43:16","downCnt":0,"esScore":18448,"fullFlag":2,"id":892191,"intro":"主角:。 温柔似水的校花，匪气十足的少年，因为一支神奇钢笔，自此生活变的多姿多彩了起来。","isOnShelf":0,"lastUpdate":"2018-04-01 03:57:00","loveCnt":0,"name":"校园护花高手","photoPath":"/72/0014b4d4b9c91c6fde386eb1343d94be.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1108,"score":6333,"status":1,"strScore":"6.3","wordCnt":12552107},{"author":"夜天寒","chapterCnt":200,"clsId":5,"clsIdSecond":33,"clsName":"都市 - 都市高手","createTime":"2019-04-04 19:14:40","downCnt":0,"esScore":18381,"fullFlag":2,"id":792135,"intro":"长剑舞天，问道征仙！ 天路轮回，问一声何为天？天道天道，天既无道，那我便逆了这天！ 仙道佛途，万万年下，谁已成仙? 乱古的迷局，喋血的飞影，仙陨天陨，谁操纵了背后的一切？ 沉沦的大世，一路血歌，破开三界！开万世飞升，盛世成仙！ 开了一个读者群，喜欢玩的就来吧：272616807","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"飞仙天外天","photoPath":"/3674/2DA486B80060E85C56C2EE920A455D2A/2DA486B80060E85C56C2EE920A455D2A.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6000,"status":1,"strScore":"6.0","wordCnt":535183},{"author":"屿霖铃","chapterCnt":226,"clsId":1,"clsIdSecond":19,"clsName":"玄幻 - 斗气世界","createTime":"2018-12-04 00:36:04","downCnt":0,"esScore":17948,"fullFlag":3,"id":589991,"intro":"他，是异界大陆的王子，运筹帷幄，能征善战，唯独悲情；她，是地球的普通女孩，为了朋友，和地球一修真门派的师姐师兄们到了异界；因为，这门派和异界有一个千年契约。人、兽、魔、妖、神，谁才是最后的霸主？ 河蟹大军、蚕豹魔军、飞龙骑士、火焰骑兵、金甲武士、天弓骑兵，公主、王子，谁是你的千年一梦？尽在“天外飞蝶”！","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"天外飞蝶","photoPath":"/282/84BB9CE296C1082CAA3D6514A4A31AAB/84BB9CE296C1082CAA3D6514A4A31AAB.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6500,"status":1,"strScore":"6.5","wordCnt":521012},{"author":"屿霖铃","chapterCnt":226,"clsId":1,"clsIdSecond":22,"clsName":"玄幻 - 东方玄幻","createTime":"2019-04-06 23:47:47","downCnt":0,"esScore":17720,"fullFlag":3,"id":815925,"intro":"主角:。 绝对值得一读的作品他，是异界大陆的王子，运筹帷幄，能征善战，唯独悲情；她，是地球的普通女孩，为了朋友，和地球一修真门派的师姐师兄们到了异界；因为，这门派和异界有一个千年契约。人、兽、魔、妖、神，谁才是最后的霸主？河蟹大军、蚕豹魔军、飞龙骑士、火焰骑兵、金甲武士、天弓骑兵，公主、王子，谁是你的千年一梦？尽在《天外飞蝶》！","isOnShelf":0,"lastUpdate":"2018-11-02 06:42:00","loveCnt":0,"name":"天外飞蝶","photoPath":"/846/44187074E375EE80DC5AB6C1A6B01E4C/44187074E375EE80DC5AB6C1A6B01E4C.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6000,"status":1,"strScore":"6.0","wordCnt":545956},{"author":"天外有仙","chapterCnt":315,"clsId":5,"clsIdSecond":37,"clsName":"都市 - 乡土生活","createTime":"2018-11-23 01:29:07","downCnt":0,"esScore":17671,"fullFlag":3,"id":450865,"intro":"平凡大学生手机里突然多了一个叫做天庭淘宝的软件，由此他走上了一条不同凡响的淘宝店主生涯，卖东西给神仙，同样，仙界的东西也被他买到了手中。山神的人参种子和快速成长试剂帮他发家致富。符仙的各种符咒能帮他锄强扶弱。太上老君的各式丹药能帮他救死扶伤。……厨神：求求你卖一本精品菜谱给我吧，玉皇大帝已经吃腻了我做的菜了。太上老君座下童子：我用太上老君亲手炼制的丹药换你一个空调吧，我坐在火炉旁边都快热死了。逍遥仙子：我用一颗仙果换你岛国的女明星影碟给我解锁新姿势好不好？……刘志感觉这个世界乱套了，这天上的神仙也太没节操了吧！三十年河东，三十年河西，莫欺少年穷！且看一平凡少年如何逆袭，走上发家致富之路。","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"我在乡村开淘宝","photoPath":"/672/75138D7E2D18318BAD34FFF73C6B4B4B/75138D7E2D18318BAD34FFF73C6B4B4B.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1153,"score":6461,"status":1,"strScore":"6.5","wordCnt":744104},{"author":"金铃动","chapterCnt":3893,"clsId":4,"clsIdSecond":29,"clsName":"仙侠 - 奇幻修真","createTime":"2019-02-24 12:51:45","downCnt":0,"esScore":17437,"fullFlag":2,"id":663045,"intro":"仙与魔的永恒争斗，琴与剑的绝世情缘，这是一个宏大而瑰丽的仙侠世界，一对少男少女踏上修仙路……","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"极品飞仙","photoPath":"/2190/B13A7A9E4931EEE3E4154ED711634320/B13A7A9E4931EEE3E4154ED711634320.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":4244,"score":8984,"status":1,"strScore":"9.0","wordCnt":8556812},{"author":"天外肥仙","chapterCnt":2441,"clsId":5,"clsIdSecond":40,"clsName":"都市 - 职场生活","createTime":"2019-05-20 00:43:52","downCnt":0,"esScore":16780,"fullFlag":2,"id":873790,"intro":"温柔似水的校花，匪气十足的少年，因为一支神奇钢笔，自此生活变的多姿多彩了起来。","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"校园护花高手(校对)","photoPath":"/1608/6DBEB45D127F410F3D60D84D1719F23D/6DBEB45D127F410F3D60D84D1719F23D.jpg","postDate":"2019-05-14 22:48:00.000","readCnt":0,"relTagName":[],"retention":291,"score":6000,"status":1,"strScore":"6.0","wordCnt":11986132},{"author":"天外飞鞋","chapterCnt":150,"clsId":5,"clsIdSecond":33,"clsName":"都市 - 都市高手","createTime":"2018-12-03 20:38:07","downCnt":0,"esScore":16353,"fullFlag":2,"id":578428,"intro":"谁说只有男人能重生，左拥右抱好不逍遥．女人照样可以，混娱乐卖流行，天下大事照样参与！左拥右抱就免了吧，其实我是一个腐女！腐的最高境界，天下大同！我拍耽美剧，我开娱乐公司，我祸害整个娱乐圈。各位狼女们，你们最萌的配对有哪些？本书都能找到！绝对精彩！==================感谢凌嘉ｍｍ帮偶做封面书友群：50461389腐女联盟—即将人满1284906很ｃj的腐女群（女生群）—人满！57631872包月读者群（新开）—包月用户请进！\n","isOnShelf":0,"lastUpdate":"2013-05-13 09:44:48","loveCnt":0,"name":"腐女重生","photoPath":"/407/51E824B0BFBECF5CA3D3B8DFCB439BCD/51E824B0BFBECF5CA3D3B8DFCB439BCD.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1744,"score":7076,"status":1,"strScore":"7.1","wordCnt":402936},{"author":"天外有仙","chapterCnt":315,"clsId":5,"clsIdSecond":38,"clsName":"都市 - 都市生活","createTime":"2019-04-06 16:14:12","downCnt":0,"esScore":16191,"fullFlag":3,"id":812447,"intro":"主角:。 平凡大学生手机里突然多了一个叫做天庭淘宝的软件，由此他走上了一条不同凡响的淘宝店主生涯，卖东西给神仙，同样，仙界的东西也被他买到了手中。山神的人参种子和快速成长试剂帮他发家致富。符仙的各种符咒能帮他锄强扶弱。太上老君的各式丹药能帮他救死扶伤。……厨神：求求你卖一本精品菜谱给我吧，玉皇大帝已经吃腻了我做的菜了。太上老君座下童子：我用太上老君亲手炼制的丹药换你一个空调吧，我坐在火炉旁边都快热死了。逍遥仙子：我用一颗仙果换你岛国的女明星影碟给我解锁新姿势好不好？……刘志感觉这个世界乱套了，这天上的神仙也太没节操了吧！三十年河东，三十年河西，莫欺少年穷！且看一平凡少年如何逆袭，走上发家致富之路。","isOnShelf":0,"lastUpdate":"2018-09-16 03:53:00","loveCnt":0,"name":"我在乡村开淘宝","photoPath":"/1124/35CEFAB503B0BBA46B6B7067741E7264/35CEFAB503B0BBA46B6B7067741E7264.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6000,"status":1,"strScore":"6.0","wordCnt":686285},{"author":"玄色","chapterCnt":96,"clsId":2,"clsIdSecond":23,"clsName":"奇幻 - 魔法校园","createTime":"2018-12-03 22:05:37","downCnt":0,"esScore":16186,"fullFlag":3,"id":584330,"intro":"","isOnShelf":0,"lastUpdate":"2011-12-15 20:42:00","loveCnt":0,"name":"天外非仙","photoPath":"/2235/ABD16E4AA630A087DE67096A80D13565/ABD16E4AA630A087DE67096A80D13565.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":985,"score":6727,"status":1,"strScore":"6.7","wordCnt":258128},{"author":"天外散仙","chapterCnt":121,"clsId":4,"clsIdSecond":30,"clsName":"仙侠 - 古典仙侠","createTime":"2018-11-19 07:43:36","downCnt":0,"esScore":16065,"fullFlag":2,"id":396133,"intro":"大禹治水的传说，是中华民族悠久历史和灿烂文化的重要组成部分，也是中华民族远古神话传说里的最精彩的一章。他的治水经历，充满了我国古代先民在征服自然，改造自然的过程中，坚韧不拔和不屈不挠的斗争精神。千百年来，大禹治水的传说和治服洪水的丰功伟绩，一直为后世的人们所传诵。在这传诵的过程中，又给这一壮举披上了神话的外衣，使这一传说更加美丽，迷人。\n","isOnShelf":0,"lastUpdate":"2016-06-15 08:25:00","loveCnt":0,"name":"大禹治水演义","photoPath":"/3311/33F309CD8D9867BCC88D89864AB097BE/33F309CD8D9867BCC88D89864AB097BE.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6100,"status":1,"strScore":"6.1","wordCnt":518541}],"enumCode":"SUCCESS","msg":"20","pageCount":5,"pageNo":1,"pageSize":20,"success":true}';

  var reg = RegExp(
      r'author":"([^"]*)[^}]*clsName":"([^"]*)[^}]*id":(\d+),"intro":"([^}]*?)",[^}]*lastUpdate":"([^"]*)[^}]*name":"([^"]*)","photoPath":"([^"]*)');
  // var content=  await io.File(r'C:\Users\baziii\Desktop\regex.html')
  //     .readAsString();
  // var reg=RegExp('href(?:[^"]*"){7}([^"]*)(?:[^"]*"){6}([^"]*)(?:[^>]*>)([^<]*)(?:[^:]*:)([^<]*)(?:[^>]*>){2}([^<]*)(?:[^:]*:)([^<]*)(?:[^>]*>){3}([^<]*)');

  var reg1 = RegExp(r'$1');
  // reg=RegExp('href(?:[^\"]*\"){7}([^\"]*)(?:[^\"]*\"){6}([^\"]*)(?:[^>]*>)([^<]*)(?:[^：]*：)([^<]*)(?:[^>]*>)');

  reg.allMatches(content).forEach((element) {
    print(element.group(0));
    var replace = element.group(0)!.replaceAllMapped(
        reg,
        (m) => r'$1'.replaceAllMapped(
            RegExp(r"\$(\d)"), (m2) => m.group(int.parse(m2.group(1)!))!));
    print(replace);
    // var list=[];
    // for (var i=1;i<=element.groupCount;i++){
    //   // print(element.group(i));
    //   list.add(element.group(i));
    // }
    // print(element.group(0));
    // print(element.group(1)); //author
    // print(element.group(2)); //tag
    // print(element.group(3)); //bookId
    // print(element.group(4)); // intro
    // print(element.group(5)); //lastUpdate
    // print(element.group(6)); //bookname
    // print(element.group(7)); //pic
    // print('---------------');
    // print( parse(list.toString()).querySelector(r'$1'));
  });
  return "";
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
  final engine = IsolateQjs (
  // final engine = FlutterQjs (
    stackSize: 1024 * 1024
  );
  // engine.dispatch();
  // final setToGlobalObject = await engine.evaluate(" (key, val) => { this[key] = val; }");
  final setToGlobalObject = await engine.evaluate("(key, val) => { this[key] = val; }");
  // await setToGlobalObject.invoke([
  //   "print",
  //   IsolateFunction((dynamic? url) async{
  //     if(url == null){
  //       print("null");
  //     }else {
  //       if(url is Future){
  //         print( await (url as Future));
  //       }else {
  //         print(url.toString());
  //       }
  //     }
  //   }),
  // ]);
  await (setToGlobalObject as JSInvokable ).invoke(["print", IsolateFunction((dynamic? url) async {
    if(url == null){
      print("null");
    }else {
      if(url is Future){
        print( await (url as Future));
      }else {
        print(url.toString());
      }
    }
  })]);
  Future? future ;
  Future? urlFuture ;
  await (setToGlobalObject as JSInvokable ).invoke(["http", IsolateFunction((String url) async {
    // var reulst=  (await Dio().get(url)).toString();
    var r=await  Dio().get(url);
    return '123';
  })]);
  // await setToGlobalObject.invoke([
  //   "http",
  //   IsolateFunction((String url) async {
  //     print(url);
  //     // var result =await Dio().get(url);
  //     // print(result);
  //     // return "1234567";
  //
  //     var result=await  Dio().get(url).then((response) => response.data);
  //     return "123";
  //   }),
  // ]);

  // var json2 = await io.File(r'C:\Users\baziii\IdeaProjects\BookSource\json2.js').readAsString();
  //  await engine.evaluate(json2);
  try {
    var js = await io.File(r'C:\Users\baziii\IdeaProjects\BookSource\bookjs.js').readAsString();
    // future = engine.evaluate('var result=7106468; ${js}');
    // urlFuture!.asStream().forEach((element) {
    //   Isolate.current.
    //
    // });
    js='var result=7106468; ${js}';
    // js = ' async function dothis(){$js}; dothis()';
    var jsResult= ( await engine.evaluate(js));

    print('jsresult : $jsResult');
    return jsResult;
    //
    // parsejs(value, filename: 'test.js')
    // window.console.debug(value)
    // Parse expression:
    // Expression expression = Expression.parse("cos(x)*cos(x)+sin(x)*sin(x)==1");

    // return (await engine.evaluate(
    //     "Math.trunc(Math.random() * 100).toString();"));
  }
  catch (e) {
    print (e.toString());
  }
   finally {
    try {
      // setToGlobalObject.free();
      // engine.port.close(); // stop dispatch loop
      // engine.close(); // close engine
    } on JSError catch (e) {
      print(e); // catch reference leak exception
    }
  }
  return "null";
}
class AwaitFunction extends JSInvokable {
  final Function _func;
  AwaitFunction(this._func);

  @override
  invoke(List args, [thisVal]) async {
    /// wrap this into function
    final passThis =
    RegExp('{.*thisVal.*}').hasMatch(_func.runtimeType.toString());
    print('await start');
    final ret =
    await Function.apply(_func, args, passThis ? {#thisVal: thisVal} : null);
    JSRef.freeRecursive(args);
    JSRef.freeRecursive(thisVal);
    print('await result:${ret}');
    return ret;
  }

  @override
  String toString() {
    return _func.toString();
  }

  @override
  destroy() {}
}

Future<void> testJs() async {
  // print(doc);
  //"http://www.ireader.com

  await io.File(r'C:\Users\baziii\Desktop\bookjs.js')
          .readAsString()
          .then((value) => {
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
      .then((value) => value.forEach((element) {
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
          }));
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
  new io.File(r'C:\Users\baziii\IdeaProjects\BookSource\lib\book_source.json')
  // new io.File(r'C:\Users\baziii\IdeaProjects\BookSource\single_test_book_source.json')
      .readAsString()
      .then((value) => BookSourcesReader.read(value))
      .then((value) =>
            printBookSourceUrl(value.first)
          );
}

void printBookSourceUrl(BookSource source) async {
  // if( source.bookSourceUrl.contains('https://api.zhuishushenqi.com')) {
  if (
      // source.bookSourceUrl.contains('https://www.hongshu.com')
      // ||
      //     source.bookSourceUrl.contains('https://api.zhuishushenqi.com')
      // ||
      true
      // source.bookSourceUrl.contains('https://read.xiaoshuo1-sm.com')

      ) {
    // BookSearch.fromRule(source, "天外飞仙", 1).searchBooks();
    // print(source);

    if (source.ruleSearch != null) {
      // print((source.searchUrl).toString());
      var book =
      // await BookSearch.fromRule(source, Uri.encodeComponent("传说"), 1)
      //     .init()
      //     .searchBooks()


      await io.File(Directory.current.path+'/'+r'class.xml')
          .readAsString()
      //  await Future.value(
      //         r'{"code":0,"count":100,"data":[{"author":"龙鳞","chapterCnt":373,"clsId":2,"clsIdSecond":23,"clsName":"奇幻 - 魔法校园","createTime":"2018-11-19 07:04:34","downCnt":0,"esScore":33630,"fullFlag":3,"id":394785,"intro":"","isOnShelf":0,"lastUpdate":"2018-03-30 16:26:00","loveCnt":0,"name":"天外飞仙","photoPath":"/70/147e3429e29bb996dc0b828643e29a7f.jpg","postDate":"2018-11-12 00:04:19.000","readCnt":0,"relTagName":[],"retention":2073,"score":6363,"status":1,"strScore":"6.4","wordCnt":1286498},{"author":"戚少","chapterCnt":20,"clsId":4,"clsIdSecond":29,"clsName":"仙侠 - 奇幻修真","createTime":"2018-11-23 21:44:35","downCnt":0,"esScore":33311,"fullFlag":2,"id":532157,"intro":"天道不仁，以万物为刍狗。天地为棋盘，众生皆为棋子。问苍茫大地，谁主沉浮？死亡并不是结束，而是新的开始。天外来客坠入西冥山脉，是意外还是意图？天道布局谁能阻挡？欧阳天身为天眷之子，命运之路到底何去何从？强者，注定踏着累累白骨走上巅峰。而弱者注定成为…\n","isOnShelf":0,"lastUpdate":"2017-04-26 16:08:35","loveCnt":0,"name":"天外飞仙","photoPath":"/70/147e3429e29bb996dc0b828643e29a7f.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":630,"score":6500,"status":1,"strScore":"6.5","wordCnt":73161},{"author":"小昌","chapterCnt":1,"clsId":4,"clsIdSecond":28,"clsName":"仙侠 - 现代修真","createTime":"2019-03-06 12:56:26","downCnt":0,"esScore":33141,"fullFlag":3,"id":724767,"intro":"小昌，80后新锐作家，广西作家协会会员，山东冠县人，1982年出生，大学教师。曾在《北方文学》、《黄河文学》、《延河》等杂志发表中短篇小说若干。现居广西北海。","isOnShelf":0,"lastUpdate":"2018-06-01 17:47:09","loveCnt":0,"name":"天外飞仙","photoPath":"/2035/649160F2994BDDC20291FEC05110F9E8/t5_215476.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":735,"score":6300,"status":1,"strScore":"6.3","wordCnt":2464},{"author":"天外飞仙","chapterCnt":4,"clsId":5,"clsIdSecond":31,"clsName":"都市 - 医道圣手","createTime":"2019-01-14 11:35:37","downCnt":0,"esScore":29721,"fullFlag":2,"id":624088,"intro":"最强邪医强势下山，专给各路美女治病……","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"最强都市邪医","photoPath":"/1583/1D2648901520E7697BC1CAEBA560B25A/1D2648901520E7697BC1CAEBA560B25A.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":100,"score":8044,"status":1,"strScore":"8.0","wordCnt":13029},{"author":"天外飞仙","chapterCnt":661,"clsId":5,"clsIdSecond":31,"clsName":"都市 - 医道圣手","createTime":"2019-06-12 07:37:23","downCnt":0,"esScore":29257,"fullFlag":2,"id":893139,"intro":"主角:苏怡凡,唐诚。 “臭小子，你眼睛往哪里瞄？”“小姐姐，不要生气嘛，我在给你看病呢。”最强都市邪医强势下山，专给各路美女治病……","isOnShelf":0,"lastUpdate":"2018-10-25 05:06:00","loveCnt":0,"name":"至强都市邪医","photoPath":"/1078/795EA00B390593F2C1984E94436839C1/795EA00B390593F2C1984E94436839C1.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":463,"score":6000,"status":1,"strScore":"6.0","wordCnt":1823386},{"author":"月神","chapterCnt":2178,"clsId":5,"clsIdSecond":31,"clsName":"都市 - 医道圣手","createTime":"2019-04-07 11:09:23","downCnt":0,"esScore":20805,"fullFlag":2,"id":820213,"intro":"主角:。 有些女人不能碰，碰一碰，要你命！太上老君炼丹童子——徐甲，睡了嫦娥，惹怒玉皇大帝，在孙猴子的庇护下，魂穿人间，凭着一手炼丹术、医术，风水，道术，混的风生水起。懂天文，识地理，...","isOnShelf":0,"lastUpdate":"2018-07-01 11:56:00","loveCnt":0,"name":"天外飞医","photoPath":"/3262/5810EAD9263DAF07DEE85B903BC9C64E/5810EAD9263DAF07DEE85B903BC9C64E.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1123,"score":6000,"status":1,"strScore":"6.0","wordCnt":6514932},{"author":"月神_幻文小说网","chapterCnt":179,"clsId":5,"clsIdSecond":31,"clsName":"都市 - 医道圣手","createTime":"2018-11-23 23:53:03","downCnt":0,"esScore":19705,"fullFlag":2,"id":543251,"intro":"有些女人不能碰，碰一碰，要你命！太上老君炼丹童子——徐甲，睡了嫦娥，惹怒玉皇大帝，在孙猴子的庇护下，魂穿人间，凭着一手炼丹术、医术，风水，道术，混的风生水起。懂天文，识地理，能捉鬼，能降妖。精医术，通道术，会治病，会杀人。很热血、很邪…\n","isOnShelf":0,"lastUpdate":"2016-09-06 04:09:24","loveCnt":0,"name":"天外飞医","photoPath":"/70/147e3429e29bb996dc0b828643e29a7f.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":2613,"score":6545,"status":1,"strScore":"6.5","wordCnt":469558},{"author":"夜天寒(书坊)","chapterCnt":145,"clsId":4,"clsIdSecond":29,"clsName":"仙侠 - 奇幻修真","createTime":"2018-11-19 02:18:59","downCnt":0,"esScore":19295,"fullFlag":2,"id":380533,"intro":"天，何谓天？仙，又何谓仙？造化之下，众生蝼蚁，皆可为仙，世间却无仙！仙在何方，地葬之下。仙在何方，苍莽之天！\n","isOnShelf":0,"lastUpdate":"2015-06-05 14:37:33","loveCnt":0,"name":"飞仙天外天","photoPath":"/257/4DDF78AED43882E3F299237F0131C0CA/4DDF78AED43882E3F299237F0131C0CA.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6100,"status":1,"strScore":"6.1","wordCnt":461062},{"author":"天外肥仙","chapterCnt":6544,"clsId":6,"clsIdSecond":43,"clsName":"校园 - 校园修真","createTime":"2019-10-07 12:00:46","downCnt":0,"esScore":18622,"fullFlag":2,"id":906703,"intro":"  温柔似水的校花，匪气十足的少年，因为一支神奇钢笔，自此生活变的多姿多彩了起来。","isOnShelf":0,"lastUpdate":"2019-10-06 18:56:11","loveCnt":0,"name":"校园花心高手","photoPath":"/3123/6661E82CAF738405A329BB92D305D711/6661E82CAF738405A329BB92D305D711.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":3069,"score":6500,"status":1,"strScore":"6.5","wordCnt":15066421},{"author":"夜天寒","chapterCnt":200,"clsId":5,"clsIdSecond":33,"clsName":"都市 - 都市高手","createTime":"2019-04-04 19:14:40","downCnt":0,"esScore":18429,"fullFlag":2,"id":792135,"intro":"长剑舞天，问道征仙！ 天路轮回，问一声何为天？天道天道，天既无道，那我便逆了这天！ 仙道佛途，万万年下，谁已成仙? 乱古的迷局，喋血的飞影，仙陨天陨，谁操纵了背后的一切？ 沉沦的大世，一路血歌，破开三界！开万世飞升，盛世成仙！ 开了一个读者群，喜欢玩的就来吧：272616807","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"飞仙天外天","photoPath":"/3674/2DA486B80060E85C56C2EE920A455D2A/2DA486B80060E85C56C2EE920A455D2A.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6000,"status":1,"strScore":"6.0","wordCnt":535183},{"author":"天外肥仙","chapterCnt":5572,"clsId":6,"clsIdSecond":42,"clsName":"校园 - 校园生活","createTime":"2019-06-12 04:43:16","downCnt":0,"esScore":18377,"fullFlag":2,"id":892191,"intro":"主角:。 温柔似水的校花，匪气十足的少年，因为一支神奇钢笔，自此生活变的多姿多彩了起来。","isOnShelf":0,"lastUpdate":"2018-04-01 03:57:00","loveCnt":0,"name":"校园护花高手","photoPath":"/72/0014b4d4b9c91c6fde386eb1343d94be.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1108,"score":6333,"status":1,"strScore":"6.3","wordCnt":12552107},{"author":"屿霖铃","chapterCnt":226,"clsId":1,"clsIdSecond":19,"clsName":"玄幻 - 斗气世界","createTime":"2018-12-04 00:36:04","downCnt":0,"esScore":17947,"fullFlag":3,"id":589991,"intro":"他，是异界大陆的王子，运筹帷幄，能征善战，唯独悲情；她，是地球的普通女孩，为了朋友，和地球一修真门派的师姐师兄们到了异界；因为，这门派和异界有一个千年契约。人、兽、魔、妖、神，谁才是最后的霸主？ 河蟹大军、蚕豹魔军、飞龙骑士、火焰骑兵、金甲武士、天弓骑兵，公主、王子，谁是你的千年一梦？尽在“天外飞蝶”！","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"天外飞蝶","photoPath":"/282/84BB9CE296C1082CAA3D6514A4A31AAB/84BB9CE296C1082CAA3D6514A4A31AAB.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6500,"status":1,"strScore":"6.5","wordCnt":521012},{"author":"屿霖铃","chapterCnt":226,"clsId":1,"clsIdSecond":22,"clsName":"玄幻 - 东方玄幻","createTime":"2019-04-06 23:47:47","downCnt":0,"esScore":17774,"fullFlag":3,"id":815925,"intro":"主角:。 绝对值得一读的作品他，是异界大陆的王子，运筹帷幄，能征善战，唯独悲情；她，是地球的普通女孩，为了朋友，和地球一修真门派的师姐师兄们到了异界；因为，这门派和异界有一个千年契约。人、兽、魔、妖、神，谁才是最后的霸主？河蟹大军、蚕豹魔军、飞龙骑士、火焰骑兵、金甲武士、天弓骑兵，公主、王子，谁是你的千年一梦？尽在《天外飞蝶》！","isOnShelf":0,"lastUpdate":"2018-11-02 06:42:00","loveCnt":0,"name":"天外飞蝶","photoPath":"/846/44187074E375EE80DC5AB6C1A6B01E4C/44187074E375EE80DC5AB6C1A6B01E4C.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6000,"status":1,"strScore":"6.0","wordCnt":545956},{"author":"天外有仙","chapterCnt":315,"clsId":5,"clsIdSecond":37,"clsName":"都市 - 乡土生活","createTime":"2018-11-23 01:29:07","downCnt":0,"esScore":17678,"fullFlag":3,"id":450865,"intro":"平凡大学生手机里突然多了一个叫做天庭淘宝的软件，由此他走上了一条不同凡响的淘宝店主生涯，卖东西给神仙，同样，仙界的东西也被他买到了手中。山神的人参种子和快速成长试剂帮他发家致富。符仙的各种符咒能帮他锄强扶弱。太上老君的各式丹药能帮他救死扶伤。……厨神：求求你卖一本精品菜谱给我吧，玉皇大帝已经吃腻了我做的菜了。太上老君座下童子：我用太上老君亲手炼制的丹药换你一个空调吧，我坐在火炉旁边都快热死了。逍遥仙子：我用一颗仙果换你岛国的女明星影碟给我解锁新姿势好不好？……刘志感觉这个世界乱套了，这天上的神仙也太没节操了吧！三十年河东，三十年河西，莫欺少年穷！且看一平凡少年如何逆袭，走上发家致富之路。","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"我在乡村开淘宝","photoPath":"/672/75138D7E2D18318BAD34FFF73C6B4B4B/75138D7E2D18318BAD34FFF73C6B4B4B.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1153,"score":6461,"status":1,"strScore":"6.5","wordCnt":744104},{"author":"金铃动","chapterCnt":3893,"clsId":4,"clsIdSecond":29,"clsName":"仙侠 - 奇幻修真","createTime":"2019-02-24 12:51:45","downCnt":0,"esScore":17409,"fullFlag":2,"id":663045,"intro":"仙与魔的永恒争斗，琴与剑的绝世情缘，这是一个宏大而瑰丽的仙侠世界，一对少男少女踏上修仙路……","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"极品飞仙","photoPath":"/2190/B13A7A9E4931EEE3E4154ED711634320/B13A7A9E4931EEE3E4154ED711634320.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":4244,"score":8984,"status":1,"strScore":"9.0","wordCnt":8556812},{"author":"天外肥仙","chapterCnt":2441,"clsId":5,"clsIdSecond":40,"clsName":"都市 - 职场生活","createTime":"2019-05-20 00:43:52","downCnt":0,"esScore":16709,"fullFlag":2,"id":873790,"intro":"温柔似水的校花，匪气十足的少年，因为一支神奇钢笔，自此生活变的多姿多彩了起来。","isOnShelf":0,"lastUpdate":"","loveCnt":0,"name":"校园护花高手(校对)","photoPath":"/1608/6DBEB45D127F410F3D60D84D1719F23D/6DBEB45D127F410F3D60D84D1719F23D.jpg","postDate":"2019-05-14 22:48:00.000","readCnt":0,"relTagName":[],"retention":291,"score":6000,"status":1,"strScore":"6.0","wordCnt":11986132},{"author":"天外飞鞋","chapterCnt":150,"clsId":5,"clsIdSecond":33,"clsName":"都市 - 都市高手","createTime":"2018-12-03 20:38:07","downCnt":0,"esScore":16366,"fullFlag":2,"id":578428,"intro":"谁说只有男人能重生，左拥右抱好不逍遥．女人照样可以，混娱乐卖流行，天下大事照样参与！左拥右抱就免了吧，其实我是一个腐女！腐的最高境界，天下大同！我拍耽美剧，我开娱乐公司，我祸害整个娱乐圈。各位狼女们，你们最萌的配对有哪些？本书都能找到！绝对精彩！==================感谢凌嘉ｍｍ帮偶做封面书友群：50461389腐女联盟—即将人满1284906很ｃj的腐女群（女生群）—人满！57631872包月读者群（新开）—包月用户请进！\n","isOnShelf":0,"lastUpdate":"2013-05-13 09:44:48","loveCnt":0,"name":"腐女重生","photoPath":"/407/51E824B0BFBECF5CA3D3B8DFCB439BCD/51E824B0BFBECF5CA3D3B8DFCB439BCD.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1744,"score":7076,"status":1,"strScore":"7.1","wordCnt":402936},{"author":"玄色","chapterCnt":96,"clsId":2,"clsIdSecond":23,"clsName":"奇幻 - 魔法校园","createTime":"2018-12-03 22:05:37","downCnt":0,"esScore":16227,"fullFlag":3,"id":584330,"intro":"","isOnShelf":0,"lastUpdate":"2011-12-15 20:42:00","loveCnt":0,"name":"天外非仙","photoPath":"/2235/ABD16E4AA630A087DE67096A80D13565/ABD16E4AA630A087DE67096A80D13565.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":985,"score":6727,"status":1,"strScore":"6.7","wordCnt":258128},{"author":"天外有仙","chapterCnt":315,"clsId":5,"clsIdSecond":38,"clsName":"都市 - 都市生活","createTime":"2019-04-06 16:14:12","downCnt":0,"esScore":16119,"fullFlag":3,"id":812447,"intro":"主角:。 平凡大学生手机里突然多了一个叫做天庭淘宝的软件，由此他走上了一条不同凡响的淘宝店主生涯，卖东西给神仙，同样，仙界的东西也被他买到了手中。山神的人参种子和快速成长试剂帮他发家致富。符仙的各种符咒能帮他锄强扶弱。太上老君的各式丹药能帮他救死扶伤。……厨神：求求你卖一本精品菜谱给我吧，玉皇大帝已经吃腻了我做的菜了。太上老君座下童子：我用太上老君亲手炼制的丹药换你一个空调吧，我坐在火炉旁边都快热死了。逍遥仙子：我用一颗仙果换你岛国的女明星影碟给我解锁新姿势好不好？……刘志感觉这个世界乱套了，这天上的神仙也太没节操了吧！三十年河东，三十年河西，莫欺少年穷！且看一平凡少年如何逆袭，走上发家致富之路。","isOnShelf":0,"lastUpdate":"2018-09-16 03:53:00","loveCnt":0,"name":"我在乡村开淘宝","photoPath":"/1124/35CEFAB503B0BBA46B6B7067741E7264/35CEFAB503B0BBA46B6B7067741E7264.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6000,"status":1,"strScore":"6.0","wordCnt":686285},{"author":"天外散仙","chapterCnt":121,"clsId":4,"clsIdSecond":30,"clsName":"仙侠 - 古典仙侠","createTime":"2018-11-19 07:43:36","downCnt":0,"esScore":16072,"fullFlag":2,"id":396133,"intro":"大禹治水的传说，是中华民族悠久历史和灿烂文化的重要组成部分，也是中华民族远古神话传说里的最精彩的一章。他的治水经历，充满了我国古代先民在征服自然，改造自然的过程中，坚韧不拔和不屈不挠的斗争精神。千百年来，大禹治水的传说和治服洪水的丰功伟绩，一直为后世的人们所传诵。在这传诵的过程中，又给这一壮举披上了神话的外衣，使这一传说更加美丽，迷人。\n","isOnShelf":0,"lastUpdate":"2016-06-15 08:25:00","loveCnt":0,"name":"大禹治水演义","photoPath":"/3311/33F309CD8D9867BCC88D89864AB097BE/33F309CD8D9867BCC88D89864AB097BE.jpg","postDate":"","readCnt":0,"relTagName":[],"retention":1000,"score":6100,"status":1,"strScore":"6.1","wordCnt":518541}],"enumCode":"SUCCESS","msg":"20","pageCount":5,"pageNo":1,"pageSize":20,"success":true}')
      //     await Future.value('{"status":1,"info":{"page":1,"size":50,"count":2,"total":61,"qp_rewrite":"天外飞仙","qp_trigger":"NOVEL"},"aladdin":{"title":"天外之天","author":"一点点水","category":"现代修真","tags":"爽文,轻松,道术,小说","hh_hot":3,"words":906340,"host":"shuqi.com","base":0,"bid":7880451,"mgbid":0,"authorid":4192552,"status":0,"top_class":"502","formats":1,"cover":"http://img-tailor.11222.cn/bcv/big/1138177880451.jpg","desc":"现世修道者屡次犯界，几位帝君相继陨落，祢九不得不放弃闲云野鹤似的生活，一力承担起守护仙界的重担。当祢九终于踏入现世，开始探索现世修道者开启两界通道的秘法之时，才发现自己竟然是别人口中无恶不作的‘魔君’。道派佛门散修古巫，还有神秘的特调局，就像一个大漩涡把祢九卷入深渊，一边要隐藏自己的身份，一边层出不穷的麻烦又无法袖手旁观。祢九该何去何从？","latest_chapter":{"cid":"1221600","cname":"第二百八十六章 不才神卦门狄修","ctime":1573092903},"first_chapter":{"cid":"1126384","cname":"第一章帝君之位","ctime":1549540502}},"data":[{"title":"天外来客:王妃你不懂爱","author":"猫爵士","category":"穿越时空","tags":"王爷,爽文,王妃,小说","hh_hot":0,"words":223959,"host":"shuqi.com","base":0,"bid":7166484,"mgbid":0,"authorid":675608,"status":1,"top_class":"502","formats":1,"first_cid":829173,"first_chapter":"第一章:时空乱流","cover":"http://img-tailor.11222.cn/bcv/big/201707181619594866.jpg","desc":"她是一个很神秘的女人，阴差阳错之下她嫁我为妻。慢慢的我发现她拥有常人没有的能力。无碍，我们也算萍水相逢，只要她想离开我也绝不阻拦。可这个女人竟然招惹了这么多烂桃花！那个叫萧风的。她说只把他当朋友当亲人，好，我忍。另一个叫夕阳的，好吧，他是你哥，算了。怎么又多了个叫若未生的！那人看你的眼神让我很不爽！来来来，你过来，让我告诉你什么是爱，要不然你被别人拐走了怎么办？！"},{"title":"剑来","author":"烽火戏诸侯","category":"古典仙侠","tags":"剑修,剑道,小说","hh_hot":2,"words":8622892,"host":"shuqi.com","base":0,"bid":7106468,"mgbid":0,"authorid":4429,"status":0,"top_class":"502","formats":1,"first_cid":807554,"first_chapter":"序章","cover":"http://img-tailor.11222.cn/bcv/big/201706271144594675.jpg","desc":"大千世界，无奇不有。我陈平安，唯有一剑，可搬山，倒海，降妖，镇魔，敕神，摘星，断江，摧城，开天！"},{"title":"上古","author":"星零","category":"古典仙侠","tags":"战神,爱恨情仇,轻松,废材流,小说","hh_hot":144403,"words":563471,"host":"shuqi.com","base":0,"bid":173759,"mgbid":0,"authorid":154804,"status":1,"top_class":"502","formats":1,"first_cid":311744,"first_chapter":"第一章序","cover":"http://img-tailor.11222.cn/bcv/big/202106301105072920.jpg","desc":"（已改编影视《千古玦尘》正在热播，由周冬雨、许凯主演）上古之神，万年前几近毁灭殆尽。如今世间仅存四位上古之神，前三位是正儿八经的上神，这最后一位……有神说她是走了狗屎运，投了个好胎，也有神说这三界八荒里面子上看起来最风光、里子里瞧起来最凄清的也就是这一位了。只是这些神仙们是羡慕嫉妒恨，还是真的心有戚戚焉呢，说都说不准。但可以肯定的是，哪怕是千万年以后，三界八荒里，除了那三人以外，三界众生都只能对着她弯下神仙的傲骨，恭敬的唤一声：上神。"},{"title":"仙武帝尊","author":"六界三道","category":"古典仙侠","tags":"爽文,小说","hh_hot":140198,"words":9449179,"host":"shuqi.com","base":0,"bid":6890613,"mgbid":0,"authorid":2826737,"status":1,"top_class":"502","formats":1,"first_cid":795323,"first_chapter":"第一章门派弃徒","cover":"http://img-tailor.11222.cn/bcv/big/201610310738595499.jpg","desc":"九千年前，仙武帝尊率领百万神将打入太古洪荒，却无一人归来，只有一缕真火遗留世间。九千年后，门派废徒叶辰，被赶出宗门，无以为家，机缘巧合之下偶得真火，再踏仙武之路。这是一个神魔仙佛并立的世界，这是一个诸天万域混乱的年代，叶辰的逆天征途，由此开始。"},{"title":"剑骨","author":"会摔跤的熊猫","category":"古典仙侠","tags":"剑修,剑道,小说","hh_hot":105079,"words":4438706,"host":"shuqi.com","base":0,"bid":7959446,"mgbid":0,"authorid":2025569,"status":0,"top_class":"502","formats":1,"first_cid":1387465,"first_chapter":"第一章 成为不朽","cover":"http://img-tailor.11222.cn/bcv/big/202008171642358000.jpg","desc":"霜杀百草的年代，少年走出菩萨庙，接过全天下最重的剑，向着人世间，斩开了一线光明。"},{"title":"地煞七十二变","author":"祭酒","category":"古典仙侠","tags":"修士,爽文,小说","hh_hot":94220,"words":820825,"host":"shuqi.com","base":0,"bid":7725435,"mgbid":0,"authorid":94447,"status":0,"top_class":"502","formats":1,"first_cid":1082442,"first_chapter":"第一章七十二变","cover":"http://img-tailor.11222.cn/bcv/big/201808141518031392.jpg","desc":"地煞七十二般变化，每一般变化，就是一项神通。一本神奇的黄壳书将李长安送回古代世界，每斩杀一个妖魔，就获得一项神通。画皮鬼、僵尸王、蜘蛛魔……一个个妖魔倒在他的剑下。通幽、剑术、斩妖……一项项神通从书中获得。当他诛灭百鬼，拔剑四顾，才发现这一切不过是滚滚大潮前一个小小浪头。"},{"title":"渡劫之王","author":"无罪","category":"古典仙侠","tags":"修士,爽文,小说","hh_hot":61746,"words":2610538,"host":"shuqi.com","base":0,"bid":8251583,"mgbid":0,"authorid":4401,"status":0,"top_class":"502","formats":1,"first_cid":1366731,"first_chapter":"引子","cover":"http://img-tailor.11222.cn/bcv/big/202007222000008007.jpg","desc":"王离是玄天宗的修士，带着他修行的师姐在渡劫失败之后脑子就出了些问题，以至于王离的修行之路也变得有点不太正常起来。"},{"title":"史上最狂老祖","author":"燕灵仙君","category":"古典仙侠","tags":"强者重生,小说","hh_hot":53740,"words":7517108,"host":"shuqi.com","base":0,"bid":7975017,"mgbid":0,"authorid":4241769,"status":1,"top_class":"502","formats":1,"first_cid":1219844,"first_chapter":"第001章 傻子","cover":"http://img-tailor.11222.cn/bcv/big/202001141549532473.jpg","desc":"万年前，混世大魔王林天在人界成为无敌传说。万年后，林天修‘轮回弑天决’重回故里。曾经他创建的第一大宗已经成了不入流门派，而徒弟们又下落不明，最可恶的是徒孙们被人欺压。一怒之下，林天一手撕天，一脚跺地，让无数仙神陪葬！"},{"title":"拯救美强惨男二","author":"九月流火","category":"古典仙侠","tags":"爽文,轻松,甜宠,小说","hh_hot":36737,"words":920351,"host":"shuqi.com","base":0,"bid":8322997,"mgbid":0,"authorid":430360,"status":1,"top_class":"502","formats":1,"first_cid":1476703,"first_chapter":"穿书","cover":"http://img-tailor.11222.cn/bcv/big/1161778322997.jpg","desc":"洛晗看了一本人人恋爱脑、为了爱情不顾一切的仙侠小说，之后被召唤穿书，得知原来她是小说里的天道化身。小说后期，主角们为了爱发动战争，差点毁灭世界。她为了自救，只好走上拯救世界之路。想要制止战争，最好的办法就是把黑化男二掰回来。男二凌清宵是全书美强惨，他本来是嫡子，却被人和私生子男主调换，以庶子身份长大，受尽虐待。后来身份暴露，生母养母都护着男主，连女主也为了男主，捅了凌清宵致命一刀。凌清宵坠落深渊，百死一生，后来硬是从地狱爬回来，从此黑化，吊打全场。洛晗穿过去时已经太晚了，凌清宵已然掉入深渊。她只能救起凌清宵，天天跟他念叨真善美，试图让他好好搞事业，不要谈恋爱。后来……凌清宵确实搞好了事业，统一六界，天地独尊，但是她却被扣下了。 “听说求子，要和天道许愿？”“我欲求长相厮守，儿孙满堂，不知天道允不允。”洛晗是天道意识的化身，日常可以听到六界对天发誓。诸如—— 原男主：“天道不公，我要逆天！”洛晗：少碰瓷，我压根不认识你是谁。男N：“天下若有人敢欺负她，我便杀尽天下人！”洛晗：你说什么？你再说一遍？ 美强惨男二：“惟愿吾天，平安喜乐，安康顺遂。” 一生所求唯有你。"},{"title":"太平客栈","author":"莫问江湖","category":"古典仙侠","tags":"修士,爽文,小说","hh_hot":36329,"words":5746737,"host":"shuqi.com","base":0,"bid":8265379,"mgbid":0,"authorid":1350495,"status":0,"top_class":"502","formats":1,"first_cid":1383429,"first_chapter":"第一章 太平客栈","cover":"http://img-tailor.11222.cn/bcv/big/202008171733022093.jpg","desc":"剑未佩妥，出门已是江湖。千帆过尽，归来仍是少年。…………生逢乱世，战火席卷天下，生灵涂炭，人命犹如草芥。及冠之时，仗义行侠四海，长剑在手，劈开一挂清明。十年饮冰，难凉热血。披荆斩棘，愿开太平。"},{"title":"太古剑尊","author":"青石细语","category":"古典仙侠","tags":"剑修,穿越,剑道,小说","hh_hot":35737,"words":10889067,"host":"shuqi.com","base":0,"bid":5864708,"mgbid":0,"authorid":2403879,"status":0,"top_class":"502","formats":1,"first_cid":406573,"first_chapter":"第1章金色心脏","cover":"http://img-tailor.11222.cn/bcv/big/201805041758492517.jpg","desc":"并指青云，气吞幽冥。大道交错，剑者独尊。这是一个人和一把剑的故事！红尘三千丈，琉璃染天香。群雄共逐鹿，剑尊掌苍黄。剑的真谛，万年之秘，以血海无涯重铸登天之路，以亿万枯骨再炼剑道经书。一切尽在太古剑尊。"},{"title":"炼气十万年","author":"勺子","category":"古典仙侠","tags":"爽文,小说","hh_hot":22881,"words":4139379,"host":"shuqi.com","base":0,"bid":7981961,"mgbid":0,"authorid":21070,"status":1,"top_class":"502","formats":1,"first_cid":1150687,"first_chapter":"第一章 炼气十万年","cover":"http://img-tailor.11222.cn/bcv/big/1140647981961.jpg","desc":"十万年前，他是天岚宗开山弟子，他师傅飞升了，他在炼气。九万年前，他的师侄飞升，他在炼气。五万年前，天岚宗看门的老狗也飞升了，他还在炼气。三万年前，山下的那颗老树也成了妖，渡劫未成，身死道消，他依然在炼气。一万年前，天岚宗第九千八百七十二代弟子张无极也飞升了，徐阳默默的炼气。他闭关一万年，最终，他突破了炼气期第九千九百九十九层！一万年后，他破关而出！"},{"title":"师叔万万岁","author":"东南俗人","category":"古典仙侠","tags":"扮猪吃虎,修士,小说","hh_hot":22617,"words":2778317,"host":"shuqi.com","base":0,"bid":8265508,"mgbid":0,"authorid":4355747,"status":0,"top_class":"502","formats":1,"first_cid":1384256,"first_chapter":"第1章：我求你别修仙了","cover":"http://img-tailor.11222.cn/bcv/big/202008191616085207.jpg","desc":"昊天宗一代弟子，昊天宗开山祖师的“兄长”，昊天宗所有人的师叔，活了万年的老怪物，史上最强炼气期，帅出天际的第一美男子。苏凡，终于出关了。作为一个炼气期就要渡劫的惊世天才，为了能够渡过自己的第十二次雷劫，苏凡决定出关寻找天材地宝，为渡劫做准备，冲击炼气期第十二层。结果……苏凡：我只想渡个劫而已，你们能不能不要来惹我了？"},{"title":"仙朝","author":"平生未知寒","category":"古典仙侠","tags":"修士,爽文,小说","hh_hot":21797,"words":2350043,"host":"shuqi.com","base":0,"bid":8265397,"mgbid":0,"authorid":4355437,"status":0,"top_class":"502","formats":1,"first_cid":1499460,"first_chapter":"序","cover":"http://img-tailor.11222.cn/bcv/big/202008171522025526.jpg","desc":"“郢都城的日落，是天底下最美的景色。”“可惜再也看不到了。”顾泯微笑着看向朝霞，轻声说道：“大厦已倾，泯然众人。”"},{"title":"问镜","author":"减肥专家","category":"古典仙侠","tags":"修士,爽文,小说","hh_hot":21293,"words":5114180,"host":"shuqi.com","base":0,"bid":97650,"mgbid":0,"authorid":223,"status":1,"top_class":"502","formats":1,"first_cid":331065,"first_chapter":"第一章上仙","cover":"http://img-tailor.11222.cn/bcv/big/201605111342201638.jpg","desc":"我有一镜，乾坤山河也照得；我有一剑，人心鬼域皆斩破；我有一城，九重天里云中座；我有一心，长生路上笑蹉跎。世人为何要长生？因为长生包容一切的欲望，长生便是无限的可能。"},{"title":"洪荒之我真不是天道","author":"鬼疯子","category":"东方玄幻","tags":"修士,洪荒,热血,古典仙侠,小说","hh_hot":20863,"words":1704095,"host":"shuqi.com","base":0,"bid":8493852,"mgbid":0,"authorid":3360785,"status":0,"top_class":"502","formats":1,"first_cid":1871674,"first_chapter":"第1章 大罗论道西昆仑","cover":"http://img-tailor.11222.cn/bcv/big/1190708493852.jpg","desc":"玄清穿越到洪荒，自以为跟脚普通，又正逢龙汉大劫，便只想苟活。却不曾想一个个的洪荒大能都来到了他的茶馆。祖龙：“前辈沏的茶蕴含大道道韵，竟让我准圣修为更进一步！”三清：“前辈的书画里时间长河奔涌，深谙盘古真意，吾等受益匪浅。”女娲：“前辈，我想给您暖床，您看我配吗？”"},{"title":"仙都","author":"陈猿","category":"古典仙侠","tags":"热血,仙侠,修炼,架空,小说","hh_hot":19445,"words":3433915,"host":"shuqi.com","base":0,"bid":2331688,"mgbid":0,"authorid":1290037,"status":0,"top_class":"502","formats":1,"first_cid":687337,"first_chapter":"第一节多了一个肉食者","cover":"http://img-tailor.11222.cn/bcv/big/201702171045414532.jpg","desc":"他从未想过自己能得到上天的眷顾，奇遇不断，有惊无险，最终抱得美女归，而且不止一个。任何获得都要付出代价，美味背后隐藏着毒药，这世上或许有巧合和机缘，第一次是幸运，第二次是奇迹，第三次绝对是噩梦。"},{"title":"通天之路","author":"无罪","category":"古典仙侠","tags":"修士,强者附体,小说","hh_hot":18376,"words":4132810,"host":"shuqi.com","base":0,"bid":99887,"mgbid":0,"authorid":4401,"status":1,"top_class":"502","formats":1,"first_cid":327386,"first_chapter":"第一章翘臀小美女","cover":"http://img-tailor.11222.cn/bcv/big/201601191549408618.jpg","desc":"一个灵岳城里的低阶小散修魏索，在交易的时候被人骗了，拿到了一个破损的低级法宝，可是这个不值一文的破损法宝里头，却有一个已经活了几万年的器灵...而且和几万年前相比，很多原本稀少的东西现在已经很多了，魏索首先发现，价值半颗下品灵石的火符的炼制材料现在就很多……"},{"title":"我家老婆是女帝","author":"深巷说书人","category":"东方玄幻","tags":"修士,爽文,热血,古典仙侠,小说","hh_hot":17207,"words":1580073,"host":"shuqi.com","base":0,"bid":8493848,"mgbid":0,"authorid":3749871,"status":0,"top_class":"502","formats":1,"first_cid":1657188,"first_chapter":"第1章 我老婆都是女帝","cover":"http://img-tailor.11222.cn/bcv/big/1123238493848.jpg","desc":"世人皆求长生而不得，林凡是一个凡人，却可以长生！从此，这世上多了一个无敌至尊！“我是仙，神为奴，魔为仆，一手平九天，一剑荡世间！”——林凡"},{"title":"我真不是隐世高人","author":"七黑","category":"古典仙侠","tags":"系统,迪化流,小说","hh_hot":16959,"words":772654,"host":"shuqi.com","base":0,"bid":8336712,"mgbid":0,"authorid":87954,"status":0,"top_class":"502","formats":1,"first_cid":1529907,"first_chapter":"第1章 坑爹系统","cover":"http://img-tailor.11222.cn/bcv/big/1155958336712.jpg","desc":"    他是个凡人，却拥有着神鬼莫测之能力，种菜成宝药，养鱼化龙神，就连混沌圣兽也争先恐后认他为主人。纪默：原来，凡人之躯，也可碾压神明……"},{"title":"穿成病娇反派的小作精","author":"茶茶木","category":"古典仙侠","tags":"反派,系统,穿书,小说","hh_hot":16388,"words":503634,"host":"shuqi.com","base":0,"bid":8322987,"mgbid":0,"authorid":1934713,"status":1,"top_class":"502","formats":1,"first_cid":1627411,"first_chapter":"第 1 章","cover":"http://img-tailor.11222.cn/bcv/big/202012040951162825.jpg","desc":"池鱼穿越了。穿成曾风光无限的白城城主独女，今男主下堂妻，身娇体弱三步倒的黑心小作精一枚。有过诸如毒杀女主，暗杀反派白月光，羞辱身有缺陷的病娇反派大魔王等等骇人听闻的前科。在这种地狱模式的开局情况下，随身系统发布的第一项任务便是：——拯救世界。池鱼肃穆：“看来我的命就是做一个救世英雄。路漫漫其修远兮，吾将上下而求索！” 宣誓的十多分钟后，她被反派大魔王捏碎了颅骨。…… 池鱼：“？？？”故意搞我？这么难的副本还有下的必要吗请问？垃圾系统是不是在想P吃！“我死了，全文完结撒花。”系统：“不，在完成拯救世界任务之前，你可以无限复活。”…… 半个月之后。 池鱼再遇反派大魔王，被其一剑穿胸。再两个月。被反派大魔王抱在怀里，当人肉挡箭牌。 池鱼：“……口吐芬芳。”五年之后。忍辱负重、身残志坚的池鱼，成功搞活原男女主cp悲掉的爱情线，令其重燃斗志，镇压住反派大魔王，拯救全世界。事了拂衣去，深藏身与名，顺势“死”于大战之中。……然而她这一“死”，全线全崩。大魔王暴走，屠尽天下。系统：“……咱也不知道哪里出了问题，咱们再来一遍好吗？”池鱼：“系统你没有妈妈。”"},{"title":"剑王朝","author":"无罪","category":"古典仙侠","tags":"爽文,小说","hh_hot":15869,"words":2769151,"host":"shuqi.com","base":0,"bid":4942679,"mgbid":0,"authorid":4401,"status":1,"top_class":"502","formats":1,"first_cid":361707,"first_chapter":"第一章剑炉余孽","cover":"http://img-tailor.11222.cn/bcv/big/201912041734489839.jpg","desc":"自连灭韩、赵、魏三大王朝，大秦王朝已经迎来前所未有之盛世，强大的修行者层出不穷，人人都以身为秦人而荣，但丁宁，一个出身毫无疑问的秦国都长陵普通的市井少年，每天所想的，却是颠覆大秦王朝，杀死修行已至前所未有的第八境的秦皇帝。"},{"title":"真灵九变","author":"睡秋","category":"古典仙侠","tags":"爽文,小说","hh_hot":13729,"words":4880431,"host":"shuqi.com","base":0,"bid":128880,"mgbid":0,"authorid":138354,"status":1,"top_class":"502","formats":1,"first_cid":314419,"first_chapter":"第1章七层","cover":"http://img-tailor.11222.cn/bcv/big/201604071815408666.jpg","desc":"一个持续了数万年的阴谋，布置下重重的迷雾；一个普通修士的热血奋斗，彰显着激情澎湃；一个门派的崛起，预示着权谋与利益；一场人妖两族的对抗，展示着联盟与背叛；一场大劫的临近，埋藏着杀戮与秘辛；一段段秘辛的揭露，拨开了重重的迷雾。且看真灵派普通修士陆平，如何在这个大舞台中将自己的存在展示的淋漓尽致，成就一段属于他一个人的传奇，揭开一段段不为人所知的过去！"},{"title":"仙路争锋","author":"缘分0","category":"古典仙侠","tags":"修士,爽文,小说","hh_hot":13613,"words":4778523,"host":"shuqi.com","base":0,"bid":4000539,"mgbid":0,"authorid":15151,"status":1,"top_class":"502","formats":1,"first_cid":381280,"first_chapter":"第一章为梦去追","cover":"http://img-tailor.11222.cn/bcv/middle/202104271659155255.jpg","desc":"修仙如渡河，万马千军竟争帆。因此当你选择了这条路时，你就已经踏上了永不停歇的人生竞赛。要想赢得胜利，需要的不仅是勇往直前的勇气，更要面对无数的风刀霜剑与腥风血雨。争夺，在踏上仙途之前，就已开始！"},{"title":"仙路至尊","author":"睡秋","category":"古典仙侠","tags":"热血,修炼,巅峰,架空,小说","hh_hot":13503,"words":6127767,"host":"shuqi.com","base":0,"bid":4743780,"mgbid":0,"authorid":138354,"status":1,"top_class":"502","formats":1,"first_cid":389593,"first_chapter":"第一章仙灵","cover":"http://img-tailor.11222.cn/bcv/big/201601191722037410.jpg","desc":"仙路通长生，至尊能逍遥，当长生不再逍遥，众生皆为囚徒，于是阴谋丛生，内乱迭起，外族入侵，……在这样一个世界当中，有这样一位少年，他逆流而上，踏血而行，斗枭雄，灭诸王，于百族之中横行无忌，杀出一条通往至尊宝座的长生仙路！仙路无尽，至尊有期，他用鲜血铸就了一段自己的不朽传奇！"},{"title":"符皇","author":"萧瑾瑜","category":"古典仙侠","tags":"仙侠,小说","hh_hot":13160,"words":6890061,"host":"shuqi.com","base":0,"bid":4381779,"mgbid":0,"authorid":172498,"status":1,"top_class":"502","formats":1,"first_cid":323631,"first_chapter":"第一章陈汐","cover":"http://img-tailor.11222.cn/bcv/big/201604131042325905.jpg","desc":"家族被毁，亲人失踪，婚约被撕……这个松烟城人人讥笑的扫把星，却获得百万年前荒古时期的一座神魔洞府传承！从此以后制神符，炼体魄，修无上剑道，悟法则奥义……凭借过人的胆识和逆天的机缘，在这神魔纵横，妖魅潜行的大世界中，最终踏上无尽大道的巅峰，掌控天下！"},{"title":"民调局异闻录之勉传","author":"耳东水寿","category":"古典仙侠","tags":"道术,小说","hh_hot":10663,"words":8251043,"host":"shuqi.com","base":0,"bid":6284117,"mgbid":0,"authorid":2552386,"status":1,"top_class":"502","formats":1,"first_cid":656773,"first_chapter":"第一章初次见面的两个人","cover":"http://img-tailor.11222.cn/bcv/big/201809261610476972.jpg","desc":"这是关于一个长生不老的男人跨越两千年的故事，在每一段历史的角落里都曾经留下过他的名字。他曾经是一些人心中的噩梦，也曾经把一些被噩梦困扰着的人们唤醒。故事的开始他的名字叫做吴勉，故事的结局他的名字叫做无敌。"},{"title":"修仙狂徒","author":"王小蛮","category":"古典仙侠","tags":"穿越,小说","hh_hot":10490,"words":12288201,"host":"shuqi.com","base":0,"bid":81604,"mgbid":0,"authorid":16307,"status":1,"top_class":"502","formats":1,"first_cid":318408,"first_chapter":"序之章","cover":"http://img-tailor.11222.cn/bcv/big/201601191546589913.jpg","desc":"街头混混穿越异界，附身世家落魄少爷。脑子里带着本时灵时不灵的残破符法，心眼里藏着点花痞色坏的小心思。且看他在残酷修真界中左右逢源，誓做纨绔的修仙生活。"},{"title":"家兄又在作死","author":"尤前","category":"古典仙侠","tags":"搞笑,升级文,金手指,小说","hh_hot":9696,"words":633421,"host":"shuqi.com","base":0,"bid":6023875,"mgbid":0,"authorid":2718268,"status":1,"top_class":"502","formats":1,"first_cid":421736,"first_chapter":"第一章我叫顺风快递","cover":"http://img-tailor.11222.cn/bcv/big/201710161645507320.jpg","desc":"修界第一人，玉华派太上老祖后池，修为深不可测，千百年来未逢敌手。却被魔尊嘲讽为骨灰级的老光棍，化石级的单身狗，别说是妹子，连个妹妹都没有。为了找回场子，他决定把对方如珠如宝的妹妹，拐过来当自己妹妹。先救她，养她，教她法术，喂她吃饭，给她讲床头故事，送她奇珍异宝。嗯，这样应该就是个完美的哥哥了，她绝对想不起原来的哥哥。妹妹时夏：这个一脸杀气，每天晚上拉她起来讲鬼故事的变态，到底想干什么？修仙界好可怕，她想回地球！"},{"title":"无双仙帝","author":"狗贼蛋","category":"古典仙侠","tags":"爽文,小说","hh_hot":9593,"words":2013660,"host":"shuqi.com","base":0,"bid":8245993,"mgbid":0,"authorid":4343727,"status":1,"top_class":"502","formats":1,"first_cid":1382541,"first_chapter":"第1章 我师父指定有点问题","cover":"http://img-tailor.11222.cn/bcv/big/202007141117095168.jpg","desc":"林玄修炼数十载，拜入宗门最弱长老门下。林玄原本觉得，自己师父除了长得漂亮一无是处，然后他发现师父好像不简单。随手给的法宝，竟然媲美天阶法宝！用来浇灌果树的池水，竟然是珍贵的灵液！院子里随处可见的杂草，竟然全都是价值连城的仙药直到有一天，师父悄咪咪地跟他说道：“我不装了，我摊牌了，我是仙帝！”"},{"title":"混沌天体","author":"骑着蜗牛去旅行","category":"古典仙侠","tags":"修士,逆袭,小说","hh_hot":9222,"words":7225228,"host":"shuqi.com","base":0,"bid":2577844,"mgbid":0,"authorid":27359,"status":1,"top_class":"502","formats":1,"first_cid":386764,"first_chapter":"第1章：河图洛书","cover":"http://img-tailor.11222.cn/bcv/big/201810111855568430.jpg","desc":"废物？不能修炼？不，我乃是天地间最强大的体质——混沌天体！脚踏大地，肩扛山岳，头顶苍穹！我命由我不由天！天地最强体质的变强之路，一个卑微存在的崛起之路，一个无上存在的升级之路。"},{"title":"九天剑主","author":"火神","category":"古典仙侠","tags":"剑修,剑道,小说","hh_hot":9132,"words":8076415,"host":"shuqi.com","base":0,"bid":6877518,"mgbid":0,"authorid":79680,"status":1,"top_class":"502","formats":1,"first_cid":739093,"first_chapter":"第一章十日之约","cover":"http://img-tailor.11222.cn/bcv/big/201902021128371872.jpg","desc":"九天九地，魂者林立。强者立于九天，如璀璨星辰，弱者匍匐大地，似渺小蝼蚁。少年白夜意外开启神秘天魂，修无上魂术，御魂御剑，冲上九天，荡尽星辰，传奇由此开始..."},{"title":"仙国大帝","author":"观棋","category":"古典仙侠","tags":"爽文,小说","hh_hot":9078,"words":3753210,"host":"shuqi.com","base":0,"bid":162985,"mgbid":0,"authorid":20635,"status":1,"top_class":"502","formats":1,"first_cid":240402,"first_chapter":"第一章九星连珠，天门开！","cover":"http://img-tailor.11222.cn/bcv/big/201603311518018608.jpg","desc":"天下之大，惟我正统！以天朝之势横扫天下仙门！一个修帝王之道的强者，降临仙门林立的世界，让修行者鄙夷的一个世俗王朝，一步步走到与各大顶级仙门平起平坐。王朝的法则是，普天之下莫非王土，率土之滨莫非王臣！天下正统只有一个，一切仙门，都是非法组织！"},{"title":"财法仙途","author":"木井","category":"古典仙侠","tags":"修士,爽文,小说","hh_hot":8392,"words":2067590,"host":"shuqi.com","base":0,"bid":8253383,"mgbid":0,"authorid":2631700,"status":0,"top_class":"502","formats":1,"first_cid":1369802,"first_chapter":"第一章 、资质不够，钱来凑","cover":"http://img-tailor.11222.cn/bcv/big/1123068253383.jpg","desc":"林夕踏足仙之巅，成就世间无敌后，回顾往昔，总是不禁感慨：修仙生活呐，真是朴实无华，且枯燥。众人：你这个可恶的有钱人可闭嘴吧，快给我去感受真正修仙者的艰难和心酸啊！这是一个有钱人，拿钱硬生生砸出一条长生坦途的故事。"},{"title":"我终于抢救了他们的脑子","author":"打僵尸","category":"古典仙侠","tags":"炮灰,穿书,小说","hh_hot":8156,"words":544688,"host":"shuqi.com","base":0,"bid":8477934,"mgbid":0,"authorid":492543,"status":0,"top_class":"502","formats":1,"first_cid":1597375,"first_chapter":"第一个脑子","cover":"http://img-tailor.11222.cn/bcv/big/1130268477934.jpg","desc":"司繁星穿入一本玛丽苏修仙小说，人生艰难。书中佛门圣子爱她姐、道门天才爱她姐、妖界少主爱她姐、魔界大佬爱她姐。所有见到她姐的人和兽都像着了魔地无脑爱她姐！她姐这么能，作为一个炮灰司繁星糟心哭了。然后她发现她一哭，男主们的智商全恢复了！喜大普奔！司繁星拿着特制催泪药和二胡踏上了抢救众人脑子的道路！;男主们送东西的瞬间，脑残恢复了佛门圣子：……抱歉，贫僧刚刚仿佛有些入魔，这师尊给的舍利子不外送的。道门天才：……咳！我刚刚拿错宝剑了，这把不是给你的，我换一把啊。妖界少主：……我失心疯了……"},{"title":"平天策","author":"无罪","category":"古典仙侠","tags":"修士,爽文,小说","hh_hot":8142,"words":3012465,"host":"shuqi.com","base":0,"bid":7170091,"mgbid":0,"authorid":4401,"status":1,"top_class":"502","formats":1,"first_cid":811795,"first_chapter":"第一章新朝旧人","cover":"http://img-tailor.11222.cn/bcv/big/201708081014225174.jpg","desc":"北魏和南朝梁兴盛，却正值整个世界的天地灵气都在逐渐枯竭，正是修行者世界典籍里记载的末法灵竭到来，林意是这个时代里，南朝梁第一批新生的修行者。"},{"title":"仙府种田","author":"司徒明月","category":"古典仙侠","tags":"修士,种田,小说","hh_hot":6758,"words":1583674,"host":"shuqi.com","base":0,"bid":4122242,"mgbid":0,"authorid":41436,"status":1,"top_class":"502","formats":1,"first_cid":816043,"first_chapter":"第1章天降玉佩","cover":"http://img-tailor.11222.cn/bcv/middle/201704161234371995.jpg","desc":"　　叶凌是一名出身贫寒的采药弟子，无意间得到一个蕴藏仙府的玉佩，从此踏上真正的修仙之路。在这座神奇的仙府里，有一间木屋、几亩灵田，和云雾飘渺的幽谷山巅。　　练气、筑基、金丹、元婴、化神．．．．．．一边在修仙界中采药炼丹，一边在仙府里种田，其乐无边"},{"title":"捡的师弟是反派怎么破","author":"令雀","category":"古典仙侠","tags":"女强,女配,穿书,情有独钟,小说","hh_hot":6737,"words":494610,"host":"shuqi.com","base":0,"bid":8354596,"mgbid":0,"authorid":4415215,"status":1,"top_class":"502","formats":1,"first_cid":1458076,"first_chapter":"第 1 章","cover":"http://img-tailor.11222.cn/bcv/big/202102181239318533.jpg","desc":" 沈玉穿成了书中的女配后，最想做的一件事情，就是找到那个把她折磨得神魂俱灭的魔修大反派。  提前找到人，要么做兄弟做基友，要么就是……谈不拢，趁他还不厉害一举除掉。  然而，等她终于找到了反派后，却发现此人跟她想象中的有些不一样，具体不一样也说不出来，只是越来越觉得对方像某个人……  ·  门派内的人都知道，落丹峰的沈大师姐，一直在找一个人。  “季师弟，你就歇歇吧！大师姐又漂亮，资质又好，人好修为高，哪能看得上你啊？” “你看看你这么些年，跟在屁股后面，她理你了吗？没有！” “要我说，大师姐压根就不会喜欢你！”  "},{"title":"六界封神","author":"风萧萧兮","category":"古典仙侠","tags":"修士,逆袭,小说","hh_hot":6571,"words":11842731,"host":"shuqi.com","base":0,"bid":6706570,"mgbid":0,"authorid":70614,"status":0,"top_class":"502","formats":1,"first_cid":686674,"first_chapter":"第一章太极八卦图","cover":"http://img-tailor.11222.cn/bcv/big/201903131631271709.jpg","desc":"上古时期，六界混乱，神界第一至宝封神榜在争夺之中被打碎成了六块，自此，不封神。一个平凡修真少年叶晨，得上古神器太极八卦图，从此改天逆命，一路凯歌，扶摇直上。他于逆境中崛起，凭借着连连际遇，狂踩六界英才，成就狂仙之名！他对敌人铁血无情，为兄弟两肋插刀，为红颜怒发冲冠，令六界闻风丧胆！且看叶晨如何问鼎神界巅峰，手持封神榜，霸道封神！"},{"title":"却道寻常","author":"三两才气","category":"古典仙侠","tags":"热血,仙侠,修炼,小说","hh_hot":6514,"words":2452463,"host":"shuqi.com","base":0,"bid":8265219,"mgbid":0,"authorid":4355583,"status":1,"top_class":"502","formats":1,"first_cid":1463874,"first_chapter":"第一章 青砖，落雪，与马车","cover":"http://img-tailor.11222.cn/bcv/big/202101281059281351.jpg","desc":"走出了倒悬天，登上了十四楼，肩扛着整个人世间，弱冠青衫也敢封天！"},{"title":"大师兄总是那么慵懒","author":"几页书","category":"古典仙侠","tags":"系统,小说","hh_hot":6500,"words":708825,"host":"shuqi.com","base":0,"bid":8392109,"mgbid":0,"authorid":4353933,"status":0,"top_class":"502","formats":1,"first_cid":1575124,"first_chapter":"第1章 :小师妹","cover":"http://img-tailor.11222.cn/bcv/big/1159978392109.jpg","desc":"一个仙玄般的世界，一位觉醒了另一世界记忆的少年，一个关于做梦的外挂，从龙傲天模板化做咸鱼慵懒模式。在这一切的背后，是人性的丧失还是道德的沦丧？"},{"title":"桃花债","author":"大风刮过","category":"幻情小说","tags":"仙侠,神话,神仙,言情,小说","hh_hot":5764,"words":140920,"host":"shuqi.com","base":0,"bid":7512542,"mgbid":0,"authorid":20474,"status":1,"top_class":"503","formats":1,"first_cid":1076625,"first_chapter":"第壹章","cover":"http://img-tailor.11222.cn/bcv/big/201803220914339464.jpg","desc":"　　＂丞相公子宋珧迷恋花魁瑶湘，瑶湘却与一个穷书生情投意合。失魂落魄的宋珧因缘际会误食了仙丹，就此飞升成了神仙。　　天庭的天枢星君和南明帝君犯了错，被玉帝贬下凡界，玉帝钦点宋珧下凡将他二人进行折磨。宋珧的知己好友衡文清君也随其来到人间，却遇上了命中注定的劫数。　　宋珧在下界做了一个藩王世子，把文弱的天枢星君强抢入府……前世纠葛，因果轮回，宋珧在别人的情戏里扮演搭线的桥，自己确是个永世孤鸾的命。＂"},{"title":"师弟求你别修炼了","author":"暮寒","category":"古典仙侠","tags":"天才,爽文,小说","hh_hot":5422,"words":1446250,"host":"shuqi.com","base":0,"bid":8328283,"mgbid":0,"authorid":1065219,"status":0,"top_class":"502","formats":1,"first_cid":1432780,"first_chapter":"第1章 掌心三寸是人间","cover":"http://img-tailor.11222.cn/bcv/big/1153458328283.jpg","desc":"陈明刚刚穿越，被青山道人骗到宗门，他误以为青山宗是隐世宗门，无比强大，于是拼命修仙，师兄师姐吹嘘自己是剑道大能，拿一道破功法让陈明练剑，没想到他领悟了绝世剑意。随便拿出一口大锅，就让他练出绝世丹药，随便练练，修为就已经快接近圣人了……"},{"title":"功德印","author":"青衫烟雨","category":"古典仙侠","tags":"穿越,女强,升级文,小说","hh_hot":4925,"words":1921862,"host":"shuqi.com","base":0,"bid":7446688,"mgbid":0,"authorid":1430301,"status":1,"top_class":"502","formats":1,"first_cid":895092,"first_chapter":"001：前缘","cover":"http://img-tailor.11222.cn/bcv/big/1146837446688.jpg","desc":"千年之后，曾经的女魔头背上功德印，走上引人向善攒功德获新生之路，哪晓得遇到的第一个人，就坏得人神共愤呢，引他向善？算了，我还是再死一回。"},{"title":"道","author":"食堂包子","category":"古典仙侠","tags":"仙侠,小说","hh_hot":4529,"words":5811738,"host":"shuqi.com","base":0,"bid":109673,"mgbid":0,"authorid":59283,"status":1,"top_class":"502","formats":1,"first_cid":386727,"first_chapter":"第1章父受辱，子必还","cover":"http://img-tailor.11222.cn/bcv/big/201604131049034313.jpg","desc":"踏入仙途，风云险恶，几度险死还生，几度魂断欲亡。一路前行伴腥风血雨，求仰不愧天，求俯不怍地。当有一日，迎风直入九霄，挥手拨云雾，俯茫茫苍生，以我之笔，建鼎立道。"},{"title":"奉旨发胖","author":"不是风动","category":"古典架空","tags":"仙侠,修真,宿命情缘,小说","hh_hot":4397,"words":465066,"host":"shuqi.com","base":0,"bid":7856097,"mgbid":0,"authorid":4177085,"status":1,"top_class":"502","formats":1,"first_cid":1171588,"first_chapter":"第 1  章","cover":"http://img-tailor.11222.cn/bcv/big/1107257856097.jpg","desc":"有一天，万众敬仰的浮黎元始帝君一觉醒来，发现头上蹲了一只圆滚滚的小肥鸟。冷酷帝君嘴上说着不养鸟，然而用实际行动打脸啪啪响；小肥鸟卖萌撒娇无所不用其极，只为博君一笑。轻松温馨的搞笑日常中，无家可归的小胖鸟有枝可依，无心无情的帝君渐知人情。操控神仙命运的星盘中，两人的缘分已经在冥冥中注定。"},{"title":"天下男修皆浮云","author":"青衫烟雨","category":"古典仙侠","tags":"女强,升级文,小说","hh_hot":4314,"words":1447633,"host":"shuqi.com","base":0,"bid":5811645,"mgbid":0,"authorid":1430301,"status":1,"top_class":"502","formats":1,"first_cid":381823,"first_chapter":"001：苏醒","cover":"http://img-tailor.11222.cn/bcv/big/1199035811645.jpg","desc":"一朝穿越，时秋成了男修眼中的香饽饽唐僧肉，谁都想啃一口，魔道惦记她，正道眼馋她，就连平素温文尔雅的师兄，看她的眼神也不对了，纵然天生灵韵骨，天下男修皆浮云。"},{"title":"无仙","author":"曳光","category":"古典仙侠","tags":"修士,爽文,小说","hh_hot":4237,"words":4696293,"host":"shuqi.com","base":0,"bid":143847,"mgbid":0,"authorid":162115,"status":1,"top_class":"502","formats":1,"first_cid":324017,"first_chapter":"第一章玄元观","cover":"http://img-tailor.11222.cn/bcv/big/201604111645196227.jpg","desc":"一个小道士的征天历程！让我们开始一个不同的仙侠梦...."},{"title":"楼边人似玉","author":"白鹭未双","category":"古典仙侠","tags":"推理,女强,小说","hh_hot":4221,"words":488806,"host":"shuqi.com","base":0,"bid":7909398,"mgbid":0,"authorid":1406120,"status":1,"top_class":"502","formats":1,"first_cid":1127646,"first_chapter":"第1章 有妖怪","cover":"http://img-tailor.11222.cn/bcv/big/1141307909398.jpg","desc":"掌灯客栈的老板娘真的很讨人厌。刻薄、爱财、狐媚不正经。他修上清之道，斩世间万妖，决计不能被她迷惑了去！"},{"title":"书剑长安","author":"他曾是少年","category":"古典仙侠","tags":"古典,仙侠,江湖,小说","hh_hot":4209,"words":1990171,"host":"shuqi.com","base":0,"bid":6522614,"mgbid":0,"authorid":3419209,"status":1,"top_class":"502","formats":1,"first_cid":657805,"first_chapter":"第一章长安有雨，长门有雪","cover":"http://img-tailor.11222.cn/bcv/big/201607191543098176.jpg","desc":"两年前，莫听雨横刀赴北地。两年后，苏长安负兵往长安。天地太大，众生如介子。江湖太深，处处伤人心。刀，剑，书，友，又是几许春秋。喜，怒，哀，乐，究竟因何缘由。大道二两三钱半，舞剑吟诗话离愁。人生哪能尽如意，对酒当歌几时休？"}],"spend":{"total":0.2998}}')
          .then((value) => ParseFactory.getParser(source.ruleSearch!.bookList)
              .getStringList(value))
          .asStream()
          .expand<String>((element) => element)
          .asyncMap((event) => parseBook(source, event))
          .first;
      String bookUrl = book['bookUrl'];
      if (!bookUrl.startsWith('http')) {
        bookUrl = '${source.bookSourceUrl}$bookUrl';
      }
      print('--------------------------------------------');
      var response = await Dio().post(bookUrl,options:   Options(
        method: 'POST',
        headers: {'content-type':'application/x-www-form-urlencoded;',
          'Accept-Encoding':'gzip, deflate, br',
          'charset':'UTF-8'},
        responseType: ResponseType.plain,
      ));
      if (response.statusCode == 200) {
        print(bookUrl);
        print(response);
      }
      var list = await ParseFactory.getParser(source.ruleToc!.chapterList)
          .getStringList(response.toString());
      for (var item in list) {
        var chapter= await parseChapt(source, item);
        if(item == list[1]){
          var url=chapter['chapterUrl'] as String;
          if(!url.startsWith('http')){
            url =source.bookSourceUrl+url;
          }
          var bookChatperContent=await BookSearch.searchBookChapter(url);
          chapter['content']=await ParseFactory.getParser(source.ruleContent!.content).getString(bookChatperContent);
          print(chapter);
        }
      }
      // .
      //     .then((value) => value.forEach((element) {
      //
      //
      //          var name=await ParseFactory.getOrWorker(source.ruleSearch!.name)
      //               .getString(source.ruleSearch!.name, element);
      //            ParseFactory.getOrWorker(source.ruleSearch!.bookUrl)
      //               .getString(source.ruleSearch!.bookUrl, element)
      //               .then((name) => print(name));
      //
      //         }));
    }
  }
}

testGet() async {

  var uri =
      'http://book.chengxinqinye.com/book/3264/D4558F14824FEA01C583BF967C599826/74DC0016EE25D2973CF1DD0D9CF7A7A2.txt';

   // uri = 'http://www.baidu.com';
  var option=BaseOptions(

        contentType: ContentType.json.value,
        responseType: ResponseType.plain

  );
  // option.headers={'Content-Type':'application/json'};
  var dio=Dio(option);
  // dio.interceptors
  //     .add(InterceptorsWrapper(onResponse:(response,handler){
  //
  // },onError: (error,handler){
  //
  //       print( error.response);
  // }));
  // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
  //   // config the http client
  //   client.findProxy = (uri) {
  //     //proxy all request to localhost:8888
  //     return "PROXY localhost:8888"; //这里将localhost设置为自己电脑的IP，其他不变，注意上线的时候一定记得把代理去掉
  //   };
  //   // you can also create a HttpClient to dio
  //   // return HttpClient();
  // };
  //Content-Type: : APPLICATION/OCTET-STREAM
  //多了个冒号，惊了
  var response = await dio.get(uri);
  if (response.statusCode == 200) {
    // if(response.data is ResponseBody ){
    //   // (response.data as ResponseBody).stream.forEach((element) {print(String.fromCharCodes(element));});
    //   (response.data as ResponseBody).stream.forEach((element) {print(Utf8Decoder().convert(element));});
    // }else {
      print(response);
    // }
  } else {
    print(response);
  }
}

parseBook(BookSource source, String content) async {
  var book = {};
  book['name'] =
      await ParseFactory.getParser(source.ruleSearch!.name).getString(content);
  book['author'] = await ParseFactory.getParser(source.ruleSearch!.author)
      .getString(content);
  book['coverUrl'] = await ParseFactory.getParser(source.ruleSearch!.coverUrl)
      .getString(content);
  book['intro'] =
      await ParseFactory.getParser(source.ruleSearch!.intro).getString(content);
  book['kind'] =
      await ParseFactory.getParser(source.ruleSearch!.kind).getString(content);
  book['lastChapter'] =
      await ParseFactory.getParser(source.ruleSearch!.lastChapter)
          .getString(content);
  book['updateTime'] =
      await ParseFactory.getParser(source.ruleSearch!.updateTime)
          .getString(content);
  book['wordCount'] = await ParseFactory.getParser(source.ruleSearch!.wordCount)
      .getString(content);
  book['bookUrl'] = await ParseFactory.getParser(source.ruleSearch!.bookUrl)
      .getString(content);
  book['bookList'] = await ParseFactory.getParser(source.ruleSearch!.bookList)
      .getString(content);
  return book;
}

parseChapt(BookSource source, String content) async {
  var chapt = {};
  chapt['chapterName'] =
      await ParseFactory.getParser(source.ruleToc!.chapterName)
          .getString(content);
  chapt['chapterUrl'] = await ParseFactory.getParser(source.ruleToc!.chapterUrl)
      .getString(content);
  // chapt['nextTocUrl'] = await ParseFactory.getParser(source.ruleToc!.nextTocUrl)
  //     .getString(content);
  return chapt;
}
