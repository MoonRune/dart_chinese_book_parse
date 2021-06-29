import 'dart:convert';

import 'package:BookSource/bean/book_source.dart';
import 'package:dio/dio.dart';

class BookSearch {
  String ruleUrl;

  String key;

  int page;

  String baseUrl;

  Map headerMapF;
  String book;

  var splitUrlRegex = RegExp(",\\s*(?=\\{)");

  // var pagePattern = Pattern("<(.*?)>")
  late String url;

  BookSearch(this.ruleUrl, this.key, this.page, this.baseUrl, this.headerMapF,
      this.book);

  factory BookSearch.fromRule(BookSource source, String key, int page) =>
      BookSearch(
          source.searchUrl ?? "", key, page, source.bookSourceUrl, Map(), "");

  late String method;

  BookSearch init() {
    var urlArray = ruleUrl.split(splitUrlRegex);
    url = getAbsoluteURL(baseUrl, urlArray[0]);

    if (urlArray.length > 1) {
      JsonCodec json = JsonCodec();
      var option = json.decode(urlArray[1]);
      method = option["method"];
    }
    return this;
  }

  bool isAbsUrl(String it) {
    return it.toLowerCase().startsWith("http://") ||
        it.toLowerCase().startsWith("https://");
  }

  /**
   * 获取绝对地址
   */
  String getAbsoluteURL(String baseURL, String relativePath) {
    if (isAbsUrl(relativePath)) {
      return relativePath;
    }
    if (baseURL.contains(',')) {
      //
      // if (baseURL.isNullOrEmpty()) return relativePath
      // if (relativePath.isAbsUrl()) return relativePath
      var relativeUrl = relativePath;
      var absoluteUrl = Uri.parse(baseURL.substring(0, baseURL.indexOf(",")));
      //
      // val absoluteUrl = URL(baseURL.substringBefore(","))
      // var parseUrl = URL(absoluteUrl, relativePath)
      // print(absoluteUrl.toString()+" "+relativePath+"   "+absoluteUrl.resolve(relativePath).toString());
      relativeUrl = absoluteUrl.resolve(relativePath).toString();
      return relativeUrl;
    }
    // print(baseURL.toString()+" "+relativePath+"   ");
    return baseURL;
  }

  Future<String> searchBooks() async {
    var uri = Uri.parse(baseUrl);
    if (ruleUrl.contains(',')) {
      // uri= uri.replace(path:ruleUrl.split(',')[0]);
      var desc = JsonCodec().decoder.convert(ruleUrl.replaceFirst(ruleUrl.split(',')[0]+',',''));

      uri = uri.replace(path: ruleUrl.split(',')[0]).replace(
          query: desc["body"]
              .replaceAll("{{key}}", key)
              .replaceAll("{{page}", "1"));
    } else {
       uri = Uri.parse((baseUrl + ruleUrl)
          .replaceAll("{{key}}", key)
          .replaceAll("{{page}", "1"));
    }
    try {
      var response = await Dio().getUri(uri);
      if (response.statusCode == 200) {
        print(uri);
        print(response);
        return response.toString();
      }
    } catch (e) {
      // print(url);
      // print(e);
    }
    return '';
  }

  String getSearchUrl() {
    return getAbsoluteURL(baseUrl, ruleUrl);
  }
}
