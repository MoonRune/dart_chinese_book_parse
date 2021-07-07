
import 'dart:convert';

import 'package:BookSource/rule/rule_factory.dart';
import 'package:BookSource/rule/single/single_rule.dart';
import 'package:flutter_qjs/flutter_qjs.dart';
import 'package:html/parser.dart';
import 'package:json_path/json_path.dart';

import '../../parse_factory.dart';
import '../rule.dart';

class JsoupParser extends IParser<SingleRule> {
  JsoupParser(SingleRule rule) : super(rule);

  @override
  Future<String> getString(String xml,{Map<String,dynamic>? valueMap}) async {
    var element=parse(xml);
    print(element);
//"class.sResult@tag.li|class.newShow@tag.li
    var r= rule.ruleContent;
    var attr= '';
    if(r.contains('@')){
      attr = r.split('@')[1];
      r = r.split('@')[0];
    }
    var item=element.querySelectorAll(r).first;
    if(attr.isEmpty){
      return item.outerHtml;
    }else {
      return item.attributes[attr]!;
    }
  }

  @override
  Future<List<String>> getStringList(String xml,{Map<String,dynamic>? valueMap}) async {
    var element=parse(xml);
    print(element);
//"class.sResult@tag.li|class.newShow@tag.li
    var r= rule.ruleContent;
    var attr= '';
    if(r.contains('@')){
      attr = r.split('@')[1];
      r = r.split('@')[0];
    }
    if(attr.isEmpty){
      return
      element.querySelectorAll(r).map((e) => e.outerHtml).toList();
    }else {
      return
        element.querySelectorAll(r).map((e) => e.attributes[attr]!).toList();
    }
  }
}