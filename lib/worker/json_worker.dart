import 'dart:convert';

import 'package:BookSource/bean/parse_rule.dart';
import 'package:json_path/json_path.dart';

import '../parse_factory.dart';

class JsonWorker extends IWorker<SingRule> {
  static var jsonRulePattern = RegExp(r"(?<=\{)\$\..+?(?=\})");
  var jsonCode = JsonCodec();

  @override
  Future<String> getString(SingRule singRule, String json) async {
    final ob = JsonPath(singRule.rule);
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
  }

  @override
  Future<List<String>> getStringList(SingRule rule, String json) async {
    //这个是位jso
    var result = <String>[];
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
    return result;
  }
}
