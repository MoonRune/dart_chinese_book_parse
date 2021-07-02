abstract class Rule{
}
abstract class IParser<T extends Rule>{
  T rule;

  IParser(this.rule);


  Future<String>  getString(String content,{Map<String,dynamic>? valueMap}) ;
  Future<List<String>> getStringList(String content,{Map<String,dynamic>? valueMap}) ;
}