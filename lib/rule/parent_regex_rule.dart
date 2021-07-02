import 'package:BookSource/rule/rule.dart';
import 'package:BookSource/rule/single/single_rule.dart';


class ParentRegexRule extends Rule{
  String parentRegex;
  String currentRegex;

  ParentRegexRule(this.parentRegex, this.currentRegex);
}

class ParentRegexParser extends IParser<ParentRegexRule>{
  ParentRegexParser(ParentRegexRule rule) : super(rule) ;

  @override
  Future<String> getString(String content, {Map<String, dynamic>? valueMap}) async{
    var reg = RegExp(rule.parentRegex);
    var replace= content.replaceAllMapped(reg, (m) =>
        rule.currentRegex.replaceAllMapped(RegExp(r'\$(\d)'),
                (m2) => m.group(int.parse(m2.group(1)!))!
        ));
    return replace;
  }

  @override
  Future<List<String>> getStringList(String content, {Map<String, dynamic>? valueMap}) async {
    var reg = RegExp(rule.parentRegex);
    var replace= content.replaceAllMapped(reg, (m) =>
        rule.currentRegex.replaceAllMapped(RegExp(r'\$(\d)'),
                (m2) => m.group(int.parse(m2.group(1)!))!
        ));
    return [replace];
  }

}