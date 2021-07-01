import 'package:BookSource/rule/and_rule.dart';
import 'package:BookSource/rule/or_rule.dart';
import 'package:BookSource/rule/param_rule.dart';
import 'package:BookSource/rule/rule.dart';
import 'package:BookSource/rule/single_rule.dart';

import 'error_rule.dart';

class RuleFactory {
  static var JS_PATTERN = RegExp(r'(<js>[\w\W]*?</js>|@js:[\w\W]*$)');

  static Rule _parse(String ruleStr, {Mode dMode = Mode.Default}) {
    //或最优先
    if (ruleStr.contains('||')) {
      var orRules = <Rule>[];
      for (var orRule in ruleStr.split('||')) {
        orRules.add(_parse(orRule,dMode: dMode));
      }
      return OrRule(orRules);
    } else if (ruleStr.contains('&&')) {
      var andRules = <Rule>[];
      for (var andRule in ruleStr.split('&&')) {
        andRules.add(_parse(andRule,dMode: dMode));
      }
      return AndRule(andRules);
    } else {}
  }

  static var putPattern = RegExp('@put:(\\{[^}]+?\\})');

  static Rule _parseMode(String ruleStr, {Mode dMode = Mode.Default}) {
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
        if (tmp.isNotEmpty) {
          group = group
              .replaceAll("<js>", '')
              .replaceAll("</js>", '')
              .replaceAll("@js:", '');

          if (tmp.contains('@')) {
            var paramsMap = {};
            var paramRule = tmp.split('@')[0];
            var other = tmp.replaceFirst(paramRule, '');
            if (putPattern.hasMatch(other)) {
              for (var match in putPattern.allMatches(other)) {
                String? group = match.group(1);
                if (group != null) {
                  group = group.replaceAll('{', '').replaceAll('}', '');
                  var splitedGroup = group.split(':');
                  paramsMap.addAll({splitedGroup[0]: splitedGroup[1]});
                }
              }
            }

            return ParamRule(Mode.Js, group, paramsMap, _parse(paramRule,dMode:_mode));
          } else {
            return (SingleRule(Mode.Js, group));
          }
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
