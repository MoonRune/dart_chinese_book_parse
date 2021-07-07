import 'package:BookSource/parse_factory.dart';
import 'package:BookSource/rule/rule.dart';

class AndRule extends Rule {
  List<Rule> andRules;

  AndRule(this.andRules);
}

class AndParser extends IParser<AndRule>{
  AndParser(AndRule rule) : super(rule);

  //todo 拼接方式??
  @override
  Future<String> getString(String content,{Map<String,dynamic>? valueMap}) async{
    var result = '';
    for(var rule in rule.andRules){
      var append = await ParseFactory.getParser(rule).getString(content,valueMap: valueMap);
      result= '$result$append\\n';
    }
    return result;
  }

  @override
  Future<List<String>> getStringList(String content,{Map<String,dynamic>? valueMap}) async {
    var result = <String>[];
    for(var rule in rule.andRules){
      var append = await ParseFactory.getParser(rule).getStringList(content,valueMap: valueMap);
      result.addAll(append);
    }
    return result;
  }

}