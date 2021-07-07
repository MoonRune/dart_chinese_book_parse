import 'dart:convert';

import 'package:BookSource/rule/single/single_rule.dart';
import 'package:dio/dio.dart';
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
    final setToGlobalObject = await engine.evaluate(" (key, val) => { this[key] = val; }");
    await setToGlobalObject.invoke([
      "put",
      IsolateFunction((String key,String value) {
        if(valueMap!=null){
          valueMap[key]=value;
        }
      }),
    ]);
    await setToGlobalObject.invoke([
      "ajax",
      IsolateFunction((String url)  async {
        url=url.replaceAll('@', '?');
        var data=  await Dio().get(url);
        return data.toString();
      }),
    ]);
    try {
      var resultRule = rule.resultRule;
      //todo java 就是put和get的map来源
      var execute = '';

      if (resultRule != null) {
        var result =
            await ParseFactory.getParser(resultRule).getString(content,valueMap: valueMap);
        execute =  'var result="$result";';
      }
      var js = rule.js.replaceAll('java.ajax(', 'await ajax(');
      var js = rule.js.replaceAll('java.put(', 'put(');
      js='$execute$js';

      js = ' async function dothis(){$js}; dothis()';
      var jsResult= (await engine.evaluate(js));
      return jsResult;
    } finally {
      try {
        setToGlobalObject.free();
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
      stackSize: 1024 * 1024, // ch
    );

     engine.dispatch();
    final setToGlobalObject = await engine.evaluate(" (key, val) => { this[key] = val; }");
    await setToGlobalObject.invoke([
      "put",
      IsolateFunction((String url) {
        print(url);
      }),
    ]);
    await setToGlobalObject.invoke([
      "ajax",
      IsolateFunction((String url) {
        return Dio().get(url.replaceAll('@', '?')).then((response) => response.data);
      }),
    ]);
    try {
      var resultRule = rule.resultRule;
      var execute = '';
      if (resultRule != null) {
        var result =
            await ParseFactory.getParser(resultRule).getString(content,valueMap: valueMap);
        execute = execute + ' var result="$result";';
      }

      var js = rule.js.replaceAll('java.', '');
      
      return (await engine.evaluate('$execute$js'));
    } finally {
      try {
        setToGlobalObject.free();
        engine.port.close(); // stop dispatch loop
        engine.close(); // close engine
      } on JSError catch (e) {
        print(e); // catch reference leak exception
      }
    }
  }
}
