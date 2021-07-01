import 'dart:convert';

import 'package:BookSource/bean/parse_rule.dart';
import 'package:json_path/json_path.dart';

import '../parse_factory.dart';

class JsonWorker extends IWorker<SingRule> {
  static var jsonRulePattern = RegExp(r"(?<=\{)\$\..+?(?=\})");
  var jsonCode = JsonCodec();

  @override
  Future<String> getString(SingRule singRule, String json) async {
    if (!singRule.rule.contains(r'{$.')) {
      var pattern = singRule.rule;
      if (pattern.endsWith(r'.[*]')) {
        pattern = pattern.replaceAll(r'.[*]', '[*]');
      }
      final ob = JsonPath(pattern);
      // print(
      //     JsonCodec().decoder.convert(json)["books"])
      var its = ob
          .read(jsonCode.decoder.convert(json))
          .map((match) => '${match.value}');
      if (its.isEmpty) {
        return '';
        // } else if (its.length == 1) {
        //   return its.first;
      } else {
        return its.first;
      }
    } else {
      //https://www.hongshu.com/book/{$.bid}/
      var result = singRule.rule;
      if (jsonRulePattern.hasMatch(singRule.rule)) {
        for (var matcher in jsonRulePattern.allMatches(singRule.rule)) {
          var newRule = SingRule(Mode.Json, matcher.group(0)!);
          var newValue =
              await ParseFactory.getWorker(newRule).getString(newRule, json);
          result=result.replaceAll('{${matcher.group(0)}}', newValue);
        }
      }
      return result;
    }
  }

  @override
  Future<List<String>> getStringList(SingRule rule, String json) async {
    //这个是位jso
    var result = <String>[];

    if (!rule.rule.contains(r'{$.')) {
      var pattern = rule.rule;
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
      var tempRule=rule.rule;
      if (jsonRulePattern.hasMatch(rule.rule)) {
        for (var matcher in jsonRulePattern.allMatches(rule.rule)) {
          var newRule = SingRule(Mode.Json, matcher.group(0)!);
          var newValue =
          await ParseFactory.getWorker(newRule).getString(newRule, json);
          tempRule=tempRule.replaceAll('{${matcher.group(0)}}', newValue);
        }
        result.add(tempRule);
      }
    }
    return result;
  }
}
