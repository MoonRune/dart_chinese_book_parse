import 'package:BookSource/rule/single/regex_child_rule.dart';
import 'package:BookSource/rule/single/single_rule.dart';

import '../rule.dart';

class RegexParser extends IParser<SingleRule>{
  static var regex=RegExp(r'\$(\d)');
  late RegExp regExp;
  var index=-1;
  RegexParser(SingleRule rule) : super(rule) {


    if(RegexChildParser.regex.hasMatch(rule.ruleContent)){
      index=int.parse(regex.firstMatch(rule.ruleContent)!.group(1)!)-1 ;
    }else {
      regExp = RegExp(rule.ruleContent);
    }
  }

  @override
  Future<String> getString(String content, {Map<String, dynamic>? valueMap}) async{

    if(index>=0){

      var replace= content.split(';')[index];
      return rule.ruleContent.replaceAll(regex.firstMatch(rule.ruleContent)!.group(0)!, replace);
    }
    var result = '';
    if(regExp.hasMatch(content)) {
      for (var match in regExp.allMatches(content)) {
        for (var i = 1; i <= match.groupCount; i++) {
          // print(element.group(i));
          // list.add(match.group(i));
          //todo 返回第一个？？
          result='$result;${match.group(i)!}';
        }
      }
    }
    return result;
  }

  @override
  Future<List<String>> getStringList(String content, {Map<String, dynamic>? valueMap}) async {
    if(index>=0){
      //todo
    return content.split(';;')[index].split(';');
    }
    var tmp = '';
    var list = <String>[];
    if(regExp.hasMatch(content)) {
      for (var match in regExp.allMatches(content)) {
        tmp = '';
        for (var i = 1; i <= match.groupCount; i++) {
          // print(element.group(i));
          if(tmp.isEmpty) {
            tmp = '${match.group(i)!}';
          }else {
            tmp = '$tmp;${match.group(i)!}';
          }
        }

        list.add(tmp);
      }
    }
    return list;
  }

}