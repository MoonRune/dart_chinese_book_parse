import 'dart:convert';

import 'package:BookSource/rule/single/single_rule.dart';
import 'package:flutter_qjs/flutter_qjs.dart';

import '../../parse_factory.dart';
import '../rule.dart';

class JsRule extends Rule {
  Rule? resultRule;
  String js;

  JsRule(this.resultRule, this.js);
}

class JsParser extends IParser<JsRule> {
  JsParser(JsRule rule) : super(rule);

  @override
  Future<String> getString(String content,{Map<String,dynamic>? valueMap}) async {
    final engine = FlutterQjs(
      stackSize: 1024 * 1024, // change stack size here.
    );
    // val bindings = SimpleBindings()
    // bindings["java"] = this
    // bindings["cookie"] = CookieStore
    // bindings["cache"] = CacheManager
    // bindings["book"] = book
    // bindings["result"] = result
    // bindings["baseUrl"] = baseUrl
    // bindings["chapter"] = chapter
    // bindings["title"] = chapter?.title
    // bindings["src"] = content
    // bindings["nextChapterUrl"] = nextChapterUrl

     engine.dispatch();
    try {
      var resultRule = rule.resultRule;
      //todo java 就是put和get的map来源
      var execute = 'var  java={}; java.put=function(sign){};';

      if (resultRule != null) {
        var result =
            await ParseFactory.getParser(resultRule).getString(content,valueMap: valueMap);
        execute = execute + ' var result="$result";';
      }
      var js = rule.js;
      return (await engine.evaluate('$execute$js'));
    } finally {
      try {
        engine.port.close(); // stop dispatch loop
        engine.close(); // close engine
      } on JSError catch (e) {
        print(e); // catch reference leak exception
      }
    }
  }

  @override
  Future<List<String>> getStringList(String content,{Map<String,dynamic>? valueMap}) async {
    final engine = FlutterQjs(
      stackSize: 1024 * 1024, // change stack size here.
    );
     engine.dispatch();
    try {
      var resultRule = rule.resultRule;
      var execute = 'var  java={}; java.put=function(sign){};';
      if (resultRule != null) {
        var result =
            await ParseFactory.getParser(resultRule).getString(content,valueMap: valueMap);
        execute = execute + ' var result="$result";';
      }
      var js = rule.js;
      return (await engine.evaluate('$execute$js'));
    } finally {
      try {
        engine.port.close(); // stop dispatch loop
        engine.close(); // close engine
      } on JSError catch (e) {
        print(e); // catch reference leak exception
      }
    }
  }
}
