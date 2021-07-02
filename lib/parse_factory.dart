import 'package:BookSource/rule/and_rule.dart';
import 'package:BookSource/rule/error_rule.dart';
import 'package:BookSource/rule/or_rule.dart';
import 'package:BookSource/rule/rule.dart' ;
import 'package:BookSource/rule/single/js_rule.dart';
import 'package:BookSource/rule/single/single_rule.dart';

class ParseFactory {
  static IParser<Rule> getParser(Rule rule) {
    if (rule is AndRule) {
      return AndParser(rule );
    } else if (rule is SingleRule) {
      return SingleParser(rule );
    } else if (rule is OrRule) {
      return OrParser(rule );
    } else if (rule is JsRule) {
      return JsParser(rule );
    }
    return ErrorParser(rule);
  }
}
