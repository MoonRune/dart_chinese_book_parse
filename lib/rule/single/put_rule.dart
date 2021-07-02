import 'dart:convert';

import 'package:BookSource/parse_factory.dart';
import 'package:BookSource/rule/single/single_rule.dart';
import 'package:flutter_qjs/flutter_qjs.dart';

import '../rule.dart';

class PutRule extends Rule {
  Map<String, Rule> ruleMap;

  PutRule( this.ruleMap);
}

class PutParser extends IParser<PutRule> {
  PutParser(PutRule rule) : super(rule);

  @override
  Future<String> getString(String content,{Map<String,dynamic>? valueMap}) async {
    if (valueMap != null) {
      for (var entry in rule.ruleMap.entries) {
        valueMap.putIfAbsent(entry.key,
            () => ParseFactory.getParser(entry.value).getString(content,valueMap: valueMap));
      }
    }
    return '';
  }

  @override
  Future<List<String>> getStringList(String content,{Map<String,dynamic>? valueMap}) async {
    if (valueMap != null) {
      for (var entry in rule.ruleMap.entries) {
        valueMap.putIfAbsent(entry.key,
                () => ParseFactory.getParser(entry.value).getString(content,valueMap: valueMap));
      }
    }
    return [];
  }
}
