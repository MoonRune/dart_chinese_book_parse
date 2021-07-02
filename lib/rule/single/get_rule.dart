
import 'dart:convert';

import 'package:BookSource/rule/single/single_rule.dart';
import 'package:flutter_qjs/flutter_qjs.dart';

import '../rule.dart';

class GetParser extends IParser<SingleRule> {
  GetParser(SingleRule rule) : super(rule);

  @override
  Future<String> getString(String content,{Map<String,dynamic>? valueMap}) async {

    return '';
  }

  @override
  Future<List<String>> getStringList(String content,{Map<String,dynamic>? valueMap}) async {
  return [];
  }
}