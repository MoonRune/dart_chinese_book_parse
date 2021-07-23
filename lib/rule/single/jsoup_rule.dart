import 'dart:convert';

import 'package:BookSource/rule/rule_factory.dart';
import 'package:BookSource/rule/single/single_rule.dart';
import 'package:flutter_qjs/flutter_qjs.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:json_path/json_path.dart';

import '../../parse_factory.dart';
import '../rule.dart';

class JsoupParser extends IParser<SingleRule> {
  JsoupParser(SingleRule rule) : super(rule);

  @override
  Future<String> getString(String xml, {Map<String, dynamic>? valueMap}) async {
    var element = parse(xml);
    // print(element);
//"class.sResult@tag.li|class.newShow@tag.li

    var jsoup = rule.ruleContent;
    if(jsoup.startsWith(r'$')){
      jsoup=jsoup.substring(1);
    }
    if (jsoup.startsWith('class.')) {
      jsoup = jsoup.substring(5);
    }
    if (jsoup.startsWith('tag.')) {
      jsoup = jsoup.substring(4);
    }
    var list = jsoup.split('@');
    var firstQuery = <Element>[];
    var word;
    if (list[0].contains(' ')) {
      word = list[0].replaceAll(' ',r'.');
    } else {
      word = list[0];
    }
    //deal with space
    //col-md-2 col-sm-4 col-xs-4
    // for (var word in queryWords) {
      var position = -1;
      if (word.contains(r'.')) {
        try {
          position = int.parse(word.split(r'.')[1]);
          word = word.split(r'.')[0];
        } catch (e) {
          print (e.toString());
        }
      }

      // if (firstQuery.isEmpty) {
        var temp = element.querySelectorAll(word);
        if (position == -1) {
          firstQuery.addAll(temp);
        } else {
          firstQuery.add(temp[position]);
        }
      // } else {
      //   var temp = <Element>[];
      //   for (var e in firstQuery) {
      //     temp.addAll(e.querySelectorAll(word));
      //   }
      //   if (position == -1) {
      //     firstQuery.addAll(temp);
      //   } else {
      //     firstQuery.add(temp[position]);
      //   }
      // }
    // }

    //deal with tag
    if (list.length > 1) {
      if (firstQuery.isNotEmpty) {
        for (var tag in list.sublist(1)) {
          if(tag == 'text'){

            return firstQuery.map((e) => e.text).first;
          }
          if(tag == 'href'){


            return firstQuery.map((e) =>  e.attributes['href'].toString()).first;
          }
          var temp = <Element>[];
          for (var e in firstQuery) {
            temp.addAll(e.querySelectorAll(tag));
          }
          firstQuery = temp;
        }
      }
    }

    for (var e in firstQuery) {
      print(e.outerHtml);
    }
    if(firstQuery.isNotEmpty) {
      return (firstQuery.first.outerHtml);
    }else {
      return '';
    }


    var r = rule.ruleContent;
    var attr = '';
    if (r.contains('@')) {
      attr = r.split('@')[1];
      r = r.split('@')[0];
    }
    var item = element.querySelectorAll(r).first;
    if (attr.isEmpty) {
      return item.outerHtml;
    } else {
      return item.attributes[attr]!;
    }
  }

  @override
  Future<List<String>> getStringList(String xml,
      {Map<String, dynamic>? valueMap}) async {
    var element = parse(xml);

//"class.sResult@tag.li|class.newShow@tag.li
    //class.table table-striped table-hover@tbody@tr
    var jsoup = rule.ruleContent;
    if (jsoup.startsWith('class.')) {
      jsoup = jsoup.substring(6);
    }
    if (jsoup.startsWith('tag.')) {
      jsoup = jsoup.substring(4);
    }
    var list = jsoup.split('@');
    var firstQuery = <Element>[];
    var word;
    if (list[0].contains(' ')) {
      word = list[0].replaceAll(' ',',');
    } else {
      word = list[0];
    }
    //deal with space
    // for (var word in queryWords) {
      var position = -1;
      if (word.contains(r'.')) {
        word = word.split(r'.')[0];
        position = int.parse(word.split(r'.')[1]) - 1;
      }

      // if (firstQuery.isEmpty) {
        var temp = element.querySelectorAll(word);
        if (position == -1) {
          firstQuery.addAll(temp);
        } else {
          firstQuery.add(temp[position]);
        }
      // } else {
      //   var temp = <Element>[];
      //   for (var e in firstQuery) {
      //     temp.addAll(e.querySelectorAll(word));
      //   }
      //   if (position == -1) {
      //     firstQuery.addAll(temp);
      //   } else {
      //     firstQuery.add(temp[position]);
      //   }
      // }
    // }

    //deal with tag
    if (list.length > 1) {
      if (firstQuery.isNotEmpty) {
        for (var tag in list.sublist(1)) {
          var temp = <Element>[];
          for (var e in firstQuery) {
            temp.addAll(e.querySelectorAll(tag));
          }
          firstQuery = temp;
        }
      }
    }

    for (var e in firstQuery) {
      print(e.outerHtml);
    }
    return List.from(firstQuery.map((e) => e.outerHtml));

    // print( element.querySelector('.introduce')!.nodes[0].text);
    // print('-----split-----');
    // prin
    // print(element);
//"class.sResult@tag.li|class.newShow@tag.li
    var r = rule.ruleContent;
    var attr = '';
    if (r.contains('@')) {
      attr = r.split('@')[1];
      r = r.split('@')[0];
    }
    if (attr.isEmpty) {
      return element.querySelectorAll(r).map((e) => e.outerHtml).toList();
    } else {
      return element
          .querySelectorAll(r)
          .map((e) => e.attributes[attr]!)
          .toList();
    }
  }
}
