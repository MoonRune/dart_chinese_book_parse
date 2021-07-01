import 'package:BookSource/rule/rule.dart';

class AndRule extends Rule {
  List<Rule> andRules;

  AndRule(this.andRules);
}
