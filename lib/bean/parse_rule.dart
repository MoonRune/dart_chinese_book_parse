import 'dart:convert';
class ParseRule {
  List<SingRule> rules;

  ParseRule(this.rules);

  factory ParseRule.parse(String? rule) {
    if (rule == null) {
      return ParseRule([]);
    }
    return ParseRule(_parse(rule));
  }

  static var JS_PATTERN = RegExp(r'(<js>[\w\W]*?</js>|@js:[\w\W]*$)');

  static List<SingRule> _parse(String ruleStr, {Mode mode = Mode.Default}) {
    var vRuleStr = ruleStr;
    var ruleList = <SingRule>[];
    if (vRuleStr.isEmpty) return ruleList;
    var _mode = mode;
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
    //todo 处理&& 需要并联操作
    //$.classname&&.shouquanname
    if (vRuleStr.contains('&&')) {
      vRuleStr = vRuleStr.split('&&')[0];
      // rules = rule.split('&&');
      // elementsType = r'&';
    } else if  (vRuleStr.contains('||')){
      vRuleStr = vRuleStr.split('||')[0];
      // rules = rule.split('||');
      // elementsType = r'|';
    }
    var start = 0;
    var tmp = "";
    if (JS_PATTERN.hasMatch(vRuleStr)) {
      Iterable<Match> matches = JS_PATTERN.allMatches(vRuleStr);
      for (Match m in matches) {
        SingRule? tempRule;
        if (m.start > start) {
          tmp = vRuleStr.substring(start, m.start).trim();
          if (tmp.isNotEmpty) {
            tempRule = SingRule(_mode, tmp);
          }
        }
        // ruleList.add(SourceRule(jsMatcher.group(), Mode.Js));
        var group=m.group(0)??"";
        group=group.replaceAll("<js>", '').replaceAll("</js>", '').replaceAll("@js:", '');
        ruleList.add(SingRule(Mode.Js,group, singleRule: tempRule));
        start = m.end;
      }
    }
    if (vRuleStr.length > start) {
      tmp = vRuleStr.substring(start).trim();
      // tmp = vRuleStr.substring(start).trim { it <= ' ' }
      if (tmp.isNotEmpty) {
        ruleList.add(SingRule(_mode, tmp));
      }
    }
    return ruleList;
  }
}

class SingRule {
  Mode mode;
  late String rule;
  SingRule? singleRule;
  var paramsMap = {};

  var putPattern = RegExp('@put:(\\{[^}]+?\\})');

  SingRule(this.mode, String originRule, {this.singleRule}) {



    if (this.mode!=Mode.Js && originRule.contains('@')) {
      this.rule = originRule.split('@')[0];
      var other = originRule.replaceFirst(this.rule, '');
      if (putPattern.hasMatch(other)) {
        for (var match in putPattern.allMatches(other)) {
          String? group = match.group(1);
          if(group!=null) {
            group=group.replaceAll('{', '').replaceAll('}', '');
           var splitedGroup= group.split(':');
            paramsMap.addAll({splitedGroup[0]:splitedGroup[1]});
          }
        }
      }
    } else {
      this.rule = originRule;
    }
  }

  factory SingRule.parse(String? rule) {
    return SingRule(Mode.Default, "");
  }
}

enum Mode { XPath, Json, Default, Js, Regex }

//rule abstract rule  getString getStringList
//orRule any get nonull return
//andRule execute all and return combiane
//paramRule  exp: js  rule executed after params executed
//singleRule common
