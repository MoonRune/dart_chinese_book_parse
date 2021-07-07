
import 'dart:convert';

import 'package:BookSource/rule/rule_factory.dart';
import 'package:BookSource/rule/single/single_rule.dart';
import 'package:BookSource/xpath_selector.dart';
import 'package:flutter_qjs/flutter_qjs.dart';
import 'package:json_path/json_path.dart';

import '../../parse_factory.dart';
import '../rule.dart';

class XpathParser extends IParser<SingleRule> {
  XpathParser(SingleRule rule) : super(rule);

  @override
  Future<String> getString(String json,{Map<String,dynamic>? valueMap}) async {

   return XPath(json).query(rule.ruleContent).get();
  }

  @override
  Future<List<String>> getStringList(String json,{Map<String,dynamic>? valueMap}) async {
    return XPath(json).query(rule.ruleContent).list();
  }
}