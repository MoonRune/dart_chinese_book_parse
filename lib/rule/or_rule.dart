import 'package:BookSource/rule/rule.dart';

import '../parse_factory.dart';

class OrRule extends Rule {
  List<Rule> orRules;

  OrRule(this.orRules);
}

class OrParser extends IParser<OrRule> {
  OrParser(OrRule rule) : super(rule);

  //找到第一个有值的
  @override
  Future<String> getString(String content,{Map<String,dynamic>? valueMap}) async {
    var result = '';
    for (var rule in rule.orRules) {
      result = await ParseFactory.getParser(rule).getString(content,valueMap: valueMap);
      if (result.trim().isNotEmpty) {
        return result;
      }
    }
    return '';
  }

  @override
  Future<List<String>> getStringList(String content,{Map<String,dynamic>? valueMap}) async {
    for (var rule in rule.orRules) {
      var result = await ParseFactory.getParser(rule).getStringList(content,valueMap: valueMap);
      if (result.isNotEmpty) {
        return result;
      }
    }
    return <String>[];
  }
}
