import 'package:BookSource/rule/and_rule.dart';
import 'package:BookSource/rule/or_rule.dart';
import 'package:BookSource/rule/param_rule.dart';
import 'package:BookSource/rule/rule.dart';
import 'package:BookSource/rule/single/js_rule.dart';
import 'package:BookSource/rule/single/put_rule.dart';
import 'single/single_rule.dart';

import 'error_rule.dart';

class RuleFactory {
  static var JS_PATTERN = RegExp(r'(<js>[\w\W]*?</js>|@js:[\w\W]*$)');

  static Rule parse(String? ruleStr, {Mode dMode = Mode.Default}) {
    if(ruleStr == null){
      return ErrorRule();
    }
    //或最优先
    if (ruleStr.contains('||')) {
      var orRules = <Rule>[];
      for (var orRule in ruleStr.split('||')) {
        orRules.add(parse(orRule,dMode: dMode));
      }
      return OrRule(orRules);
    } else if (ruleStr.contains('&&')) {
      var andRules = <Rule>[];
      for (var andRule in ruleStr.split('&&')) {
        andRules.add(parse(andRule,dMode: dMode));
      }
      return AndRule(andRules);
    } else {
      return _parseOther(ruleStr,dMode: dMode);
    }
  }

  static var putPattern = RegExp('@put:(\\{[^}]+?\\})');

  static Rule _parseOther(String ruleStr, {Mode dMode = Mode.Default}) {
    var vRuleStr = ruleStr;
    //
    // if (vRuleStr.isEmpty) return ruleList;
    var _mode = dMode;
    if (vRuleStr.startsWith("@@")) {
      vRuleStr = vRuleStr.substring(2);
    } else if (vRuleStr.toUpperCase().startsWith("@XPath:")) {
      _mode = Mode.XPath;
      vRuleStr = vRuleStr.substring(7);
    } else if (vRuleStr.toUpperCase().startsWith("@JSON:")) {
      _mode = Mode.Json;
      vRuleStr = vRuleStr.substring(6);
    } else if (vRuleStr.startsWith(":")) {
      _mode = Mode.Regex;
      // isRegex = true
      vRuleStr = vRuleStr.substring(1);
    }
    //是否存在|

    var start = 0;
    var tmp = "";
    //只取第一个了
    if (JS_PATTERN.hasMatch(vRuleStr)) {
      Iterable<Match> matches = JS_PATTERN.allMatches(vRuleStr);
      for (Match m in matches) {
        if (m.start > start) {
          tmp = vRuleStr.substring(start, m.start).trim();
        } else {
          tmp = '';
        }
        // ruleList.add(SourceRule(jsMatcher.group(), Mode.Js));
        var group = m.group(0) ?? "";
        var jsResultRule=ruleStr.replaceAll(group, '');
        if (tmp.isNotEmpty) {
          group = group
              .replaceAll("<js>", '')
              .replaceAll("</js>", '')
              .replaceAll("@js:", '');

          // todo put get 标记位独立的rule
          if (tmp.contains('@')) {
            var paramRule = tmp.split('@')[0];
            var other = tmp.replaceFirst(paramRule, '');
            //PUT
            var putMap=<String,Rule>{};
            if (putPattern.hasMatch(other)) {
              for (var match in putPattern.allMatches(other)) {
                var group = match.group(1);
                if (group != null) {
                  group = group.replaceAll('{', '').replaceAll('}', '');
                  var splitedGroup = group.split(':');
                  putMap.addAll({splitedGroup[0]: RuleFactory.parse(splitedGroup[1])});
                }
              }
            }
            var putRule=PutRule(putMap );
            var resultJsRule=JsRule(parse(paramRule,dMode:_mode),  group );
           return  AndRule(<Rule>[putRule,resultJsRule]);
            // return JsRule(parse(jsResultRule,dMode:_mode), group );
          } else {
            return JsRule(parse(jsResultRule,dMode:_mode), group );
          }
          // return JsRule(parse(jsResultRule,dMode:_mode), group );
        }

        start = m.end;
      }
    }
    if (vRuleStr.length > start) {
      tmp = vRuleStr.substring(start).trim();
      // tmp = vRuleStr.substring(start).trim { it <= ' ' }
      if (tmp.isNotEmpty) {
       return SingleRule(_mode, tmp);
      }
    }
    return ErrorRule();
  }
}
