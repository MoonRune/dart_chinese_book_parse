
import 'dart:convert';

import 'package:BookSource/rule/rule_factory.dart';
import 'package:BookSource/rule/single/single_rule.dart';
import 'package:flutter_qjs/flutter_qjs.dart';
import 'package:json_path/json_path.dart';

import '../../parse_factory.dart';
import '../rule.dart';

class JsonParser extends IParser<SingleRule> {
  JsonParser(SingleRule rule) : super(rule);
  static var jsonRulePattern = RegExp(r'(?<=\{)\$\..+?(?=\})');
  var jsonCode = JsonCodec();

  @override
  Future<String> getString(String json,{Map<String,dynamic>? valueMap}) async {

    if (!rule.ruleContent.contains(r'{$.')) {
      var pattern =rule.ruleContent;
      if (pattern.endsWith(r'.[*]')) {
        pattern = pattern.replaceAll(r'.[*]', '[*]');
      }
      final ob = JsonPath(pattern);
      var its = ob
          .read(jsonCode.decoder.convert(json))
          .map((match) => '${match.value}');
      if (its.isEmpty) {
        return '';
      } else {
        return its.first;
      }
    } else {
      //https://www.hongshu.com/book/{$.bid}/
      var result = rule.ruleContent;
      if (jsonRulePattern.hasMatch(rule.ruleContent)) {
        for (var matcher in jsonRulePattern.allMatches(rule.ruleContent)) {
          var newRule = RuleFactory.parse(matcher.group(0)!,dMode: Mode.Json);
          var newValue =
          await ParseFactory.getParser(newRule).getString(json,valueMap: valueMap);
          result=result.replaceAll('{${matcher.group(0)}}', newValue);
        }
      }
      return result;
    }
  }

  @override
  Future<List<String>> getStringList(String json,{Map<String,dynamic>? valueMap}) async {
    //这个是位jso
    var result = <String>[];

    if (!rule.ruleContent.contains(r'{$.')) {
      var pattern = rule.ruleContent;
      if (pattern.endsWith(r'.[*]')) {
        pattern = pattern.replaceAll(r'.[*]', '[*]');
      }

      final ob = JsonPath(pattern);
      // print(
      //     JsonCodec().decoder.convert(json)["books"])

      var ps = ob.read(JsonCodec().decoder.convert(json));

      for (var p in ps) {
        ////兼容不支持[*]而做的处理
        if (p.value is List) {
          for (var item in p.value) {
            result.add(JsonCodec().encoder.convert(item));
          }
        } else {
          result.add(JsonCodec().encoder.convert(p.value));
        }
      }
    }else {
      var tempRule=rule.ruleContent;
      if (jsonRulePattern.hasMatch(rule.ruleContent)) {
        for (var matcher in jsonRulePattern.allMatches(rule.ruleContent)) {
          var newRule = RuleFactory.parse(matcher.group(0)!,dMode: Mode.Json);
          //todo  json list？？？
          var newValue =
          await ParseFactory.getParser(newRule).getString(json,valueMap: valueMap);
          tempRule=tempRule.replaceAll('{${matcher.group(0)}}', newValue);
        }
        result.add(tempRule);
      }
    }
    return result;
  }
}