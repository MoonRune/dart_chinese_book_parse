import 'dart:convert';
import 'dart:ffi';

import 'bean/book_source.dart';
import 'bean/book_source_rule_old.dart';

class BookSourcesReader {
  static List<BookSource> read(String text) {
    var jsonCodec = JsonCodec();
    List list = jsonCodec.decoder.convert(text);
    return list.map((e) => BookSourceOld.fromJson(e).convert2New()).toList();
  }
}
