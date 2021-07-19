import 'dart:convert';

import 'package:BookSource/bean/book_source.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class BookSearch {
  BookSource source;

  String key;

  int page;

  String baseUrl;

  Map headerMapF;
  String book;

  var splitUrlRegex = RegExp(",\\s*(?=\\{)");

  // var pagePattern = Pattern("<(.*?)>")
  late String url;

  BookSearch(this.source, this.key, this.page, this.baseUrl, this.headerMapF,
      this.book);

  factory BookSearch.fromRule(BookSource source, String key, int page) =>
      BookSearch(source, key, page, source.bookSourceUrl, Map(), "").init();

  late String method;

  BookSearch init() {
    var ruleUrl = source.bookSourceUrl;
    var urlArray = ruleUrl.split(splitUrlRegex);
    url = getAbsoluteURL(baseUrl, urlArray[0]);

    if (urlArray.length > 1) {
      var json = JsonCodec();
      var option = json.decode(urlArray[1]);
      if (option["method"] != null) {
        method = option["method"];
      }
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
    var option = BaseOptions();
    option.headers={'content-type':'application/x-www-form-urlencoded;',
    'Accept-Encoding':'gzip, deflate, br',
    'charset':'UTF-8'};
    var uri = Uri.parse(
      baseUrl,
    );

    var ruleUrl = source.searchUrl ?? '';
    var method = 'GET';
    late var data;
    data='';
    if (ruleUrl.contains(',')) {
      // uri= uri.replace(path:ruleUrl.split(',')[0]);
      var desc = JsonCodec()
          .decoder
          .convert(ruleUrl.replaceFirst(ruleUrl.split(',')[0] + ',', ''));

      var convertedPath = ruleUrl
          .split(',')[0]
          .replaceAll('{{key}}', key)
          .replaceAll('{{page}}', '1');
      if (convertedPath.contains('?')) {
        var query = convertedPath.split('?')[1];
        convertedPath = convertedPath.split('?')[0];
        uri = uri.replace(path: convertedPath);
        uri = uri.replace(query: query);
      } else {
        uri = uri.replace(path: convertedPath);
      }
      // uri = uri.replace(query: newPath);
      if (desc['method'] != null && desc['method'] == 'POST') {
        method = 'POST';
      }
      if (desc['body'] != null) {
        var body = desc["body"]
            .replaceAll("{{key}}", key)
            .replaceAll("{{page}}", "1");
        if (method == 'POST') {
          data = body;
        } else {
          uri = uri.replace(
              query: body);
        }
      }
      if (desc['headers'] != null) {
        String headers = desc['headers'];

        option.headers = JsonCodec().decoder.convert(headers);
      }
    } else {
      uri = Uri.parse((baseUrl + ruleUrl)
          .replaceAll("{{key}}", key)
          .replaceAll("{{page}}", "1"));
    }
    try {
      var dio = new Dio(option);
      // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      //   // config the http client
      //   client.findProxy = (uri) {
      //     //proxy all request to localhost:8888
      //     return "PROXY localhost:8888"; //这里将localhost设置为自己电脑的IP，其他不变，注意上线的时候一定记得把代理去掉
      //   };
      //   // you can also create a HttpClient to dio
      //   // return HttpClient();
      // };
      late var response;
      if (method == 'POST') {
        response = await dio.postUri(uri, data: data);
      } else {
        response = await dio.getUri(uri);
      }
      if (response.statusCode == 200) {
        print(uri);
        print(response);
        return response.toString();
      }
    } catch (e) {
      print(url);
      print(e);
    }
    return '';
  }

  static Future<String> searchBookChapter(String url) async {
    var option = BaseOptions();
    var uri = Uri.parse(url.replaceAll('@', '?'));

    try {
      var dio = new Dio(option);
      // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      //   // config the http client
      //   client.findProxy = (uri) {
      //     //proxy all request to localhost:8888
      //     return "PROXY localhost:8888"; //这里将localhost设置为自己电脑的IP，其他不变，注意上线的时候一定记得把代理去掉
      //   };
      //   // you can also create a HttpClient to dio
      //   // return HttpClient();
      // };
      var response = await dio.getUri(uri);
      if (response.statusCode == 200) {
        // print(uri);
        // print(response);
        return response.toString();
      }
    } catch (e) {
      print(url);
      print(e);
    }
    return '';
  }

  String getSearchUrl() {
    return getAbsoluteURL(baseUrl, source.bookSourceUrl);
  }
}
