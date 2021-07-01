import 'dart:convert';

import 'package:json_path/json_path.dart';

class PatternRule {
  late Mode mode;
  late String rule;
  String replaceRegex = "";
  String replacement = "";
  bool replaceFirst = false;
  Map putMap = {};
  var ruleParam = [];
  var ruleType = [];
  var getRuleType = -2;
  var jsRuleType = -1;
  var defaultRuleType = 0;

  @override
  String toString() {
    return 'PatternRule{mode: $mode, rule: $rule, replaceRegex: $replaceRegex, replacement: $replacement, replaceFirst: $replaceFirst, putMap: $putMap, ruleParam: $ruleParam, ruleType: $ruleType, getRuleType: $getRuleType, jsRuleType: $jsRuleType, defaultRuleType: $defaultRuleType}';
  }

  PatternRule();

  static var JS_PATTERN = RegExp(r'(<js>[\w\W]*?</js>|@js:[\w\W]*$)');

  static List<PatternRule> parse(String ruleStr, {Mode mode = Mode.Default}) {
    var vRuleStr = ruleStr;
    var ruleList = <PatternRule>[];
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
    var start = 0;
    var tmp = "";
    if (JS_PATTERN.hasMatch(vRuleStr)) {
      Iterable<Match> matches = JS_PATTERN.allMatches(vRuleStr);
      for (Match m in matches) {
        if (m.start > start) {
          tmp = vRuleStr.substring(start, m.start).trim();
          if (tmp.isNotEmpty) {
            ruleList.add(PatternRule()
              ..rule = tmp
              ..mode = _mode);
          }
        }
        // ruleList.add(SourceRule(jsMatcher.group(), Mode.Js));
        ruleList.add(PatternRule()
          ..rule = m.group(0) ?? ""
          ..mode = Mode.Js);
        start = m.end;
      }
    }
    if (vRuleStr.length > start) {
      tmp = vRuleStr.substring(start).trim();
      // tmp = vRuleStr.substring(start).trim { it <= ' ' }
      if (tmp.isNotEmpty) {
        ruleList.add(PatternRule()
          ..rule = tmp
          ..mode = _mode);
      }
    }
    return ruleList;
  }

  void makeUpRule(String content) {
    if (ruleParam.isNotEmpty) {
      //TODO
    }
    var ruleStrS = rule.split("##");
    rule = ruleStrS[0].trim();
    if (ruleStrS.length > 1) {
      replaceRegex = ruleStrS[1];
    }
    if (ruleStrS.length > 2) {
      replacement = ruleStrS[2];
    }
    if (ruleStrS.length > 3) {
      replaceFirst = true;
    }
  }

  static String getString(List<PatternRule> rules, String content) {
    if (rules.isEmpty) return '';

    for (var sourceRule in rules) {
      // putRule(sourceRule.putMap)
      sourceRule.makeUpRule(content);
      if (content.isNotEmpty) {
        if (sourceRule.rule.isNotEmpty) {
          switch (sourceRule.mode) {
            case Mode.Js:
              break;
            case Mode.Json:
              return AnalyzeByJSonPath(content).getString(sourceRule.rule);
              break;
            case Mode.XPath:
              break;
            case Mode.Default:
              //jsoup
              return AnalyzeByJSonPath(content).getString(sourceRule.rule);
              break;
          }
        }
      }
    }
    return '';
  }

  static List<String> getStringList(List<PatternRule> rules, String content) {
    if (rules.isEmpty) return [];

    for (var sourceRule in rules) {
      // putRule(sourceRule.putMap)
      sourceRule.makeUpRule(content);
      if (content.isNotEmpty) {
        if (sourceRule.rule.isNotEmpty) {
          switch (sourceRule.mode) {
            case Mode.Js:
              break;
            case Mode.Json:
              return AnalyzeByJSonPath(content).getStringList(sourceRule.rule);
              break;
            case Mode.XPath:
              break;
            case Mode.Default:
              //Jsoup
              return AnalyzeByJSonPath(content).getStringList(sourceRule.rule);
              break;
          }
        }
      }
    }
    return [];
  }
}

enum Mode { XPath, Json, Default, Js, Regex }

class AnalyzeByJSonPath {
  String json = "";

  AnalyzeByJSonPath(this.json);

  var jsonRulePattern = RegExp(r"(?<=\{)\$\..+?(?=\})");

  String getString(String rule) {
    if (rule.isEmpty) {
      return '';
    }
    var result = '';
    var rules = [];
    var elementsType = '';
    if (rule.contains('&&')) {
      rules = rule.split('&&');
      elementsType = r'&';
    } else {
      rules = rule.split('||');
      elementsType = r'|';
    }

    if (rules.length == 1) {
      if (!rule.contains(r'{$.')) {
        final ob = JsonPath(rules[0]);
        // print(
        //     JsonCodec().decoder.convert(json)["books"])
        var its = ob
            .read(JsonCodec().decoder.convert(json))
            .map((match) => '${match.value}');
        if (its.isEmpty) {
          return '';
          // } else if (its.length == 1) {
          //   return its.first;
        } else {
          return its.first;
        }
      } else {
        result = rule;
        if (jsonRulePattern.hasMatch(rule)) {
          for (var matcher in jsonRulePattern.allMatches(rule)) {
            result = result.replaceAll(
                '{${matcher.group(0)}}', getString(matcher.group(0)!));
          }
          return result;
        }
      }
    } else {
      var textList = <String>[];
      for (var rl in rules) {
        var temp = getString(rl);
        if (temp.isNotEmpty) {
          textList.add(temp);
          if (elementsType == "|") {
            break;
          }
        }
      }
      return textList.join("\n").toString();
    }
    return "";
  }

  List<String> getStringList(String rule) {
    var result = <String>[];
    if (rule.isEmpty) {
      return result;
    }
    var rules = <String>[];
    var elementsType = '';
    if (rule.contains('&&')) {
      rules = rule.split('&&');
      elementsType = r'&';
    } else {
      rules = rule.split('||');
      elementsType = r'|';
    }

    if (rules.length == 1) {
      if (!rule.contains(r'{$.')) {
        //new ??
        var pattern = rules[0];
        var forceList = false;
        if (pattern.endsWith(r'.[*]')) {
          forceList = true;
          pattern = pattern.replaceAll(r'.[*]', '[*]');
        }

        final ob = JsonPath(pattern);
        // print(
        //     JsonCodec().decoder.convert(json)["books"])

        var ps = ob.read(JsonCodec().decoder.convert(json));

        for (var p in ps) {
          ////兼容不支持[*]而做的处理
          // if (p.value is List) {
          //   for (var item in p.value) {
          //     result.add(JsonCodec().encoder.convert(item));
          //   }
          // } else {
            result.add(JsonCodec().encoder.convert(p.value));
          // }
        }
        return result;
      } else {
        if (jsonRulePattern.hasMatch(rule)) {
          for (var matcher in jsonRulePattern.allMatches(rule)) {
            var stringList = getStringList(matcher.group(0)!);
            for (var s in stringList) {
              result.add(rule.replaceAll('{${matcher.group(0)}}', s));
            }
          }
          return result;
        }
      }
    } else {
      var results = <List<String>>[];
      for (var rl in rules) {
        var temp = getStringList(rl);
        if (temp.isNotEmpty) {
          results.add(temp);
          if (elementsType == '|') {
            break;
          }
        }
      }
      if (results.isNotEmpty) {
        //这是什么？？
        if ('%' == elementsType) {
          for (var i = 0; i < results[0].length; i++) {
            for (var temp in results) {
              if (i < temp.length) {
                result.add(temp[i]);
              }
            }
          }
        } else {
          for (var temp in results) {
            result.addAll(temp);
          }
        }
      }
    }
    return result;
  }
}
