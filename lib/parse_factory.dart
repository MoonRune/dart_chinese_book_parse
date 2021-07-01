import 'package:BookSource/worker/js_worker.dart';
import 'package:BookSource/worker/json_worker.dart';
import 'package:BookSource/worker/or_worker.dart';

import 'bean/parse_rule.dart';

class ParseFactory{
  static IWorker<SingRule> getWorker(SingRule rule){
    switch (rule.mode) {
      case Mode.Js:
        return JsWorker();
        break;
      case Mode.Json:
        return JsonWorker();
        break;
      case Mode.XPath:
        break;
      case Mode.Default:
      //jsoup
        return JsonWorker();
        break;
    }

    return JsonWorker();
  }

  static IWorker<ParseRule> getOrWorker(ParseRule rule){
    return OrWorker();
  }

}
abstract class IWorker<T>{
  Future<String>  getString(T rule,String content) ;
  Future<List<String>> getStringList(T rule,String content) ;
}

