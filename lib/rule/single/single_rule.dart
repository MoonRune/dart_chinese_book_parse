import 'package:BookSource/rule/rule.dart';
import 'package:BookSource/rule/single/js_rule.dart';
import 'package:BookSource/rule/single/json_rule.dart';

class SingleRule extends Rule {
  Mode mode;
  String ruleContent;

  SingleRule(this.mode, this.ruleContent);
}

enum Mode { XPath, Json, Default,
  // Js,
  Regex }

class SingleParser extends IParser<SingleRule> {
  SingleParser(SingleRule rule) : super(rule);

  @override
  Future<String> getString(String content,{Map<String,dynamic>? valueMap}) async {
    switch (rule.mode) {
      // case Mode.Js:
      //   return JsParser(rule).getString(content);
      //   break;
      case Mode.Json:
        return  JsonParser(rule).getString(content,valueMap: valueMap);
        break;
      case Mode.XPath:
        break;
      case Mode.Default:
        //jsoup
        return  JsonParser(rule).getString(content,valueMap: valueMap);
        break;
    }
    return '';
  }

  @override
  Future<List<String>> getStringList(String content,{Map<String,dynamic>? valueMap}) async {
    switch (rule.mode) {
      // case Mode.Js:
      //   return JsParser(rule).getStringList(content);
      //   break;
      case Mode.Json:
        return await JsonParser(rule).getStringList(content,valueMap: valueMap);
        break;
      case Mode.XPath:
        break;
      case Mode.Default:
        //jsoup
        return await JsonParser(rule).getStringList(content,valueMap: valueMap);
        break;
    }
    return <String>[];
  }
}
