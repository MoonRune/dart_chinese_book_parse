import 'package:BookSource/parse_factory.dart';
import 'package:BookSource/rule/rule.dart';
import 'single/single_rule.dart';

//目前只有json
@Deprecated('被jsRule')
class ParamRule extends SingleRule {
  // Map param;
  Rule paramRule;

  ParamRule(Mode mode, String ruleContent, this.paramRule)
      : super(mode, ruleContent);
}

class ParamParser extends SingleParser{
  ParamParser(ParamRule rule) : super(rule);

  @override
  Future<String> getString(String content,{Map<String,dynamic>? valueMap}) async {
    var paramRule = rule as ParamRule;
    content=await ParseFactory.getParser(paramRule.paramRule).getString(content,valueMap: valueMap);
    return  super.getString(content);
  }

  @override
  Future<List<String>> getStringList(String content,{Map<String,dynamic>? valueMap}) async {
    var paramRule = rule as ParamRule;
    content=await ParseFactory.getParser(paramRule.paramRule).getString(content,valueMap: valueMap);
    return  super.getStringList(content);
  }


}
