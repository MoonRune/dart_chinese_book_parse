import 'package:BookSource/rule/rule.dart';

class SingleRule extends Rule {
  Mode mode;
  String ruleContent;

  SingleRule(this.mode, this.ruleContent);
}

enum Mode { XPath, Json, Default, Js, Regex }