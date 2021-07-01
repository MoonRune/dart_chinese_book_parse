import 'dart:convert';

import 'package:BookSource/bean/parse_rule.dart';
import 'package:json_path/json_path.dart';

import '../parse_factory.dart';

class OrWorker extends IWorker<ParseRule>{

  @override
  Future<String> getString(ParseRule parseRule, String content) async {

    for(var rule in parseRule.rules){

      var result = await ParseFactory.getWorker(rule).getString(rule, content);
      if(result.isNotEmpty){
        return result;
      }
    }
    return '';
  }

  @override
  Future<List<String>> getStringList(ParseRule parseRule, String content) async {

    for(var rule in parseRule.rules){

      var result = await ParseFactory.getWorker(rule).getStringList(rule, content);
      if(result.isNotEmpty){
        return result;
      }
    }
    return [];
  }

}