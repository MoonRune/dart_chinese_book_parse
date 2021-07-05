import 'package:BookSource/rule/single/single_rule.dart';

import '../rule.dart';

class RegexChildParser extends IParser<SingleRule>{
  static var regex=RegExp(r'\$(\d)');
  var index=0;
  RegexChildParser(SingleRule rule) : super(rule) {
    index=regex.firstMatch(rule.ruleContent)!.group(0)! as int ;
  }

  @override
  Future<String> getString(String content, {Map<String, dynamic>? valueMap}) async{

    var result = content.split(';')[index];
    return result;
  }

  @override
  Future<List<String>> getStringList(String content, {Map<String, dynamic>? valueMap}) async {
    var list = <String>[];

    var result = content.split(';')[index];
    list.add(result);
    return list;
  }

}