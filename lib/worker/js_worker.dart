import 'dart:convert';

import 'package:BookSource/bean/parse_rule.dart';
import 'package:flutter_qjs/flutter_qjs.dart';
import 'package:json_path/json_path.dart';

import '../parse_factory.dart';

class JsWorker extends IWorker<SingRule> {
  var putPattern = RegExp('@put:(\\{[^}]+?\\})');
  @override
  Future<String> getString(SingRule singRule, String json) async {
    if(putPattern.hasMatch(json)){
      for(var  match in  putPattern.allMatches(json)){
        print(match.input);
        print(match.pattern);
        print(match.group(1));
      }
      json.replaceAll(putPattern, '');
    }

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
    print("engine ready");
    try {
      var resultRule=singRule.singleRule;
      var execute='var  java={}; java.put=function(sign){};';
      if(resultRule!=null){
        var result = await ParseFactory.getWorker(resultRule).getString(resultRule, json);
        execute = execute+' var result=${result};';
      }
      var js = singRule.rule;
      return (await engine.evaluate('${execute} ${js}'));
      //
      // parsejs(value, filename: 'test.js')
      // window.console.debug(value)
      // Parse expression:
      // Expression expression = Expression.parse("cos(x)*cos(x)+sin(x)*sin(x)==1");

      // return (await engine.evaluate(
      //     "Math.trunc(Math.random() * 100).toString();"));
    }
    // catch (e) {
    //   return (e.toString());
    // }
     finally {
      try {
        engine.port.close(); // stop dispatch loop
        engine.close(); // close engine
      } on JSError catch (e) {
        print(e); // catch reference leak exception
      }
    }
  }

  @override
  Future<List<String>> getStringList(SingRule rule, String json) async {
    final engine = FlutterQjs(
      stackSize: 1024 * 1024, // change stack size here.
    );
    engine.dispatch();
    try {
      var js = rule.rule;
      return (await engine.evaluate('var result=7106468; ${js}'));
      //
      // parsejs(value, filename: 'test.js')
      // window.console.debug(value)
      // Parse expression:
      // Expression expression = Expression.parse("cos(x)*cos(x)+sin(x)*sin(x)==1");

      // return (await engine.evaluate(
      //     "Math.trunc(Math.random() * 100).toString();"));
    }
    // catch (e) {
    //   return (e.toString());
    // }
     finally {
      try {
        engine.port.close(); // stop dispatch loop
        engine.close(); // close engine
      } on JSError catch (e) {
        print(e); // catch reference leak exception
      }
    }
  }
}
