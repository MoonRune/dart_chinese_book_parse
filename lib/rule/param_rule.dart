import 'package:BookSource/rule/rule.dart';
import 'package:BookSource/rule/single_rule.dart';

class ParamRule extends SingleRule {
  Map param;
  Rule paramRule;

  ParamRule(Mode mode, String ruleContent, this.param,this.paramRule)
      : super(mode, ruleContent);
}
