import 'package:BookSource/rule/single/single_rule.dart';

import '../rule.dart';

class RegexParser extends IParser<SingleRule>{
  late RegExp regExp;
  RegexParser(SingleRule rule) : super(rule) {
    regExp=RegExp(rule.ruleContent);
  }

  @override
  Future<String> getString(String content, {Map<String, dynamic>? valueMap}) async{

    var result = '';
    if(regExp.hasMatch(content)) {
      for (var match in regExp.allMatches(content)) {
        for (var i = 1; i <= match.groupCount; i++) {
          // print(element.group(i));
          // list.add(match.group(i));
          //todo 返回第一个？？
          result='$result${match.group(i)!}';
        }
      }
    }
    return result;
  }

  @override
  Future<List<String>> getStringList(String content, {Map<String, dynamic>? valueMap}) async {
    var list = <String>[];
    if(regExp.hasMatch(content)) {
      for (var match in regExp.allMatches(content)) {
        for (var i = 1; i <= match.groupCount; i++) {
          // print(element.group(i));
          list.add(match.group(i)!);
        }
      }
    }
    return list;
  }

}