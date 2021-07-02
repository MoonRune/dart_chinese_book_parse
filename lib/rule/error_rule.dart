import 'package:BookSource/rule/rule.dart';

class ErrorRule extends Rule {}

class ErrorParser extends IParser<Rule> {
  ErrorParser( rule) : super(rule);

  @override
  Future<String> getString(String content,{Map<String,dynamic>? valueMap}) async {
    return '';
  }

  @override
  Future<List<String>> getStringList(String content,{Map<String,dynamic>? valueMap}) async {
    return <String>[];
  }
}
