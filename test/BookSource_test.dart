import 'package:BookSource/bean/parttern_rule.dart';
import 'package:BookSource/book_source_store.dart';
import 'package:test/test.dart';

void main() {

  print(PatternRule.parse(r'@JSon:$.title').toString());

}
