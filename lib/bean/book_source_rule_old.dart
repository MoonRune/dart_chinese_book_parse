import 'dart:convert';

import 'package:BookSource/bean/book_source.dart';
import 'package:BookSource/rule/rule_factory.dart';

class BookSourceOld {
  static const BOOK_SOURCE_TYPE_TEXT_AS_DEFAULT = '';
  static const BOOK_SOURCE_TYPE_AUDIO = 'AUDIO';

  String? bookSourceGroup;
  String? bookSourceName;
  String? bookSourceType;
  String? bookSourceUrl;
  bool? enable;
  String? httpUserAgent;
  String? ruleBookUrlPattern;
  String? ruleChapterList;
  String? ruleChapterName;
  String? ruleChapterUrl;
  String? ruleChapterUrlNext;
  String? ruleContentUrl;
  String? ruleContentUrlNext;
  String? ruleSearchAuthor;
  String? ruleSearchCoverUrl;
  String? ruleSearchIntroduce;
  String? ruleSearchKind;
  String? ruleSearchLastChapter;
  String? ruleSearchList;
  String? ruleSearchName;
  String? ruleSearchNoteUrl;
  String? ruleSearchUrl;
  int? serialNumber;
  int? weight;

  String? ruleFindUrl;
  String? loginUrl;
  String? bookSourceComment;
  String? ruleFindList;
  String? ruleFindName;
  String? ruleFindAuthor;
  String? ruleFindIntroduce;
  String? ruleFindKind;
  String? ruleFindLastChapter;
  String? ruleFindNoteUrl;
  String? ruleFindCoverUrl;

  String? ruleBookContent;
  String? ruleBookContentReplace;

  String? ruleBookInfoInit;
  String? ruleBookName;
  String? ruleBookAuthor;
  String? ruleIntroduce;
  String? ruleBookKind;
  String? ruleBookLastChapter;
  String? ruleCoverUrl;

  @override
  String toString() {
    return 'BookSourceOld{bookSourceGroup: $bookSourceGroup, bookSourceName: $bookSourceName, bookSourceType: $bookSourceType, bookSourceUrl: $bookSourceUrl, enable: $enable, httpUserAgent: $httpUserAgent, ruleBookUrlPattern: $ruleBookUrlPattern, ruleChapterList: $ruleChapterList, ruleChapterName: $ruleChapterName, ruleChapterUrl: $ruleChapterUrl, ruleChapterUrlNext: $ruleChapterUrlNext, ruleContentUrl: $ruleContentUrl, ruleContentUrlNext: $ruleContentUrlNext, ruleSearchAuthor: $ruleSearchAuthor, ruleSearchCoverUrl: $ruleSearchCoverUrl, ruleSearchIntroduce: $ruleSearchIntroduce, ruleSearchKind: $ruleSearchKind, ruleSearchLastChapter: $ruleSearchLastChapter, ruleSearchList: $ruleSearchList, ruleSearchName: $ruleSearchName, ruleSearchNoteUrl: $ruleSearchNoteUrl, ruleSearchUrl: $ruleSearchUrl, serialNumber: $serialNumber, weight: $weight, ruleFindUrl: $ruleFindUrl, loginUrl: $loginUrl, bookSourceComment: $bookSourceComment, ruleFindList: $ruleFindList, ruleFindName: $ruleFindName, ruleFindAuthor: $ruleFindAuthor, ruleFindIntroduce: $ruleFindIntroduce, ruleFindKind: $ruleFindKind, ruleFindLastChapter: $ruleFindLastChapter, ruleFindNoteUrl: $ruleFindNoteUrl, ruleFindCoverUrl: $ruleFindCoverUrl, ruleBookContent: $ruleBookContent, ruleBookContentReplace: $ruleBookContentReplace, ruleBookInfoInit: $ruleBookInfoInit, ruleBookName: $ruleBookName, ruleBookAuthor: $ruleBookAuthor, ruleIntroduce: $ruleIntroduce, ruleBookKind: $ruleBookKind, ruleBookLastChapter: $ruleBookLastChapter, ruleCoverUrl: $ruleCoverUrl}';
  }

  var headerPattern = RegExp('@Header:\\{.+?\\}');
  var jsPattern = RegExp('\\{\\{.+?\\}\\}');

  String toNewUrl(String? url) {
    var result = '';
    if (url == null || url.isEmpty) {
      return result;
    }
    result = url;
    if (result.toLowerCase().startsWith('<js>')) {
      result = result
          .replaceAll("=searchKey", "={{key}}")
          .replaceAll("=searchPage", "={{page}}");
      return result;
    }
    var map = {};
    if (headerPattern.hasMatch(result)) {
      var header = headerPattern.firstMatch(result)!;
      result = result.replaceFirst(header.group(0)!, '');
      var headers = header.group(0)!.substring(8);
      var regex=RegExp(r"('?\w*'?){1}:");
      var json=(headers.replaceAllMapped(regex,
              (m) => r"'$1':".replaceAllMapped(RegExp(r"\$(\d)"),
                  (m2) => m.group(int.parse(m2.group(1)!))!))).replaceAll(r"'", '"');

        // var jsonHeader = JsonCodec().decoder.convert(json);

      map["headers"]= json;
    }
    var urlList = result.split('|');
    result = urlList[0];

    if (urlList.length > 1) {
      map["charset"] = urlList[1].split("=")[1];
    }
    var jsList = [];
    if (jsPattern.hasMatch(result)) {
      for (var item in jsPattern.allMatches(result)) {
        jsList.add(item.input);
        result = result.replaceAll(item.input, "\$${jsList.length - 1}");
      }
    }
    result = result.replaceAll("{", "<").replaceAll("}", ">");
    result = result.replaceAll("searchKey", "{{key}}");
    result = result
        .replaceAll("<searchPage([-+]1)>", "{{page\$1}}")
        .replaceAll("searchPage([-+]1)", "{{page\$1}}")
        .replaceAll("searchPage", "{{page}}");

    for (var index = 0; index < jsList.length; index++) {
      var item = jsList[index];
      result = result.replaceAll("\$$index",
          item.replaceAll("searchKey", "key").replaceAll("searchPage", "page"));
    }
    urlList = result.split("@");
    result = urlList[0];
    if (urlList.length > 1) {
      map["method"] = "POST";
      map["body"] = urlList[1];
    }
    if (map.length > 0) {
      result += "," + JsonCodec().encoder.convert(map);
    }
    return result;
  }

  BookSource convert2New() {
    // if(bookSourceUrl!=null&& bookSourceUrl!.contains('https://api.zhuishushenqi.com')) {
    //   print(toString());
    // }
    // var content = toNewRule(this.ruleBookContent) ?: ""
    var content = this.ruleBookContent ?? "";
    if (content.startsWith(r'$') && !content.startsWith(r"$.")) {
      content = content.substring(1);
    }
    return BookSource(
        this.bookSourceName ?? "",
        this.bookSourceGroup,
        this.bookSourceUrl ?? "",
        this.bookSourceType ?? "",
        this.ruleBookUrlPattern ?? "",
        this.serialNumber ?? 0,
        this.enable ?? false,
        (ruleFindUrl?.isNotEmpty),
        this.httpUserAgent,
        this.loginUrl,
        this.bookSourceComment,
        0,
        //this.lastUpdateTime
        this.weight,
        toNewUrl(this.ruleFindUrl),
        ExploreRule(
            RuleFactory.parse(this.ruleFindList),
            RuleFactory.parse(this.ruleFindName),
            RuleFactory.parse(this.ruleFindAuthor),
            RuleFactory.parse(this.ruleFindIntroduce),
            RuleFactory.parse(this.ruleFindKind),
            RuleFactory.parse(this.ruleFindLastChapter),
            RuleFactory.parse(""),
            RuleFactory.parse(this.ruleFindNoteUrl),
            RuleFactory.parse(this.ruleFindCoverUrl),
            RuleFactory.parse("")),
        toNewUrl(this.ruleSearchUrl),
        SearchRule(
            RuleFactory.parse(this.ruleSearchList),
            RuleFactory.parse(this.ruleSearchName),
            RuleFactory.parse(this.ruleSearchAuthor),
            RuleFactory.parse(this.ruleSearchIntroduce),
            RuleFactory.parse(this.ruleSearchKind),
            RuleFactory.parse(this.ruleSearchLastChapter),
            RuleFactory.parse(""),
            RuleFactory.parse(this.ruleSearchNoteUrl),
            RuleFactory.parse(this.ruleSearchCoverUrl),
            RuleFactory.parse("")),
        BookInfoRule(
            this.ruleBookInfoInit,
            this.ruleBookName,
            this.ruleBookAuthor,
            this.ruleIntroduce,
            this.ruleBookKind,
            this.ruleBookLastChapter,
            "",
            this.ruleCoverUrl,
            "",
            "",
            ""),
        TocRule(
          RuleFactory.parse(this.ruleChapterList),
          RuleFactory.parse(this.ruleChapterName),
          RuleFactory.parse(this.ruleContentUrl),
          RuleFactory.parse(""),
          RuleFactory.parse(""),
          RuleFactory.parse(this.ruleChapterUrlNext)),
        ContentRule(
          RuleFactory.parse(this.ruleBookContent),
          this.ruleContentUrlNext,
          "", //this.webJs,
          "", //this.sourceRegex,
          this.ruleBookContentReplace,
          "", // this.imageStyle
        ));
  }

  BookSourceOld(
      this.bookSourceGroup,
      this.bookSourceName,
      this.bookSourceType,
      this.bookSourceUrl,
      this.enable,
      this.httpUserAgent,
      this.ruleBookUrlPattern,
      this.ruleChapterList,
      this.ruleChapterName,
      this.ruleChapterUrl,
      this.ruleChapterUrlNext,
      this.ruleContentUrl,
      this.ruleContentUrlNext,
      this.ruleSearchAuthor,
      this.ruleSearchCoverUrl,
      this.ruleSearchIntroduce,
      this.ruleSearchKind,
      this.ruleSearchLastChapter,
      this.ruleSearchList,
      this.ruleSearchName,
      this.ruleSearchNoteUrl,
      this.ruleSearchUrl,
      this.serialNumber,
      this.weight,
      this.ruleFindUrl,
      this.loginUrl,
      this.bookSourceComment,
      this.ruleFindList,
      this.ruleFindName,
      this.ruleFindAuthor,
      this.ruleFindIntroduce,
      this.ruleFindKind,
      this.ruleFindLastChapter,
      this.ruleFindNoteUrl,
      this.ruleFindCoverUrl,
      this.ruleBookContent,
      this.ruleBookContentReplace,
      this.ruleBookInfoInit,
      this.ruleBookName,
      this.ruleBookAuthor,
      this.ruleIntroduce,
      this.ruleBookKind,
      this.ruleBookLastChapter,
      this.ruleCoverUrl);

  BookSourceOld.fromJson(dynamic json) {
    bookSourceGroup = json["bookSourceGroup"];
    bookSourceName = json["bookSourceName"];
    bookSourceType = json["bookSourceType"];
    bookSourceUrl = json["bookSourceUrl"];
    enable = json["enable"];
    httpUserAgent = json["httpUserAgent"];
    ruleBookUrlPattern = json["ruleBookUrlPattern"];
    ruleChapterList = json["ruleChapterList"];
    ruleChapterName = json["ruleChapterName"];
    ruleChapterUrl = json["ruleChapterUrl"];
    ruleChapterUrlNext = json["ruleChapterUrlNext"];
    ruleContentUrl = json["ruleContentUrl"];
    ruleContentUrlNext = json["ruleContentUrlNext"];
    ruleSearchAuthor = json["ruleSearchAuthor"];
    ruleSearchCoverUrl = json["ruleSearchCoverUrl"];
    ruleSearchIntroduce = json["ruleSearchIntroduce"];
    ruleSearchKind = json["ruleSearchKind"];
    ruleSearchLastChapter = json["ruleSearchLastChapter"];
    ruleSearchList = json["ruleSearchList"];
    ruleSearchName = json["ruleSearchName"];
    ruleSearchNoteUrl = json["ruleSearchNoteUrl"];
    ruleSearchUrl = json["ruleSearchUrl"];
    serialNumber = json["serialNumber"];
    weight = json["weight"];

    ruleFindUrl = json["ruleFindUrl"];
    loginUrl = json["loginUrl"];
    bookSourceComment = json["bookSourceComment"];
    ruleFindList = json["ruleFindList"];
    ruleFindName = json["ruleFindName"];
    ruleFindAuthor = json["ruleFindAuthor"];
    ruleFindKind = json["ruleFindKind"];
    ruleFindLastChapter = json["ruleFindLastChapter"];
    ruleFindNoteUrl = json["ruleFindNoteUrl"];
    ruleFindCoverUrl = json["ruleFindCoverUrl"];

    ruleBookContent = json["ruleBookContent"];
    ruleBookContentReplace = json["ruleBookContentReplace"];

    ruleBookInfoInit = json["ruleBookInfoInit"];
    ruleBookName = json["ruleBookName"];
    ruleBookAuthor = json["ruleBookAuthor"];
    ruleIntroduce = json["ruleIntroduce"];
    ruleBookKind = json["ruleBookKind"];
    ruleBookLastChapter = json["ruleBookLastChapter"];
    ruleCoverUrl = json["ruleCoverUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["bookSourceGroup"] = bookSourceGroup;
    map["bookSourceName"] = bookSourceName;
    map["bookSourceType"] = bookSourceType;
    map["bookSourceUrl"] = bookSourceUrl;
    map["enable"] = enable;
    map["httpUserAgent"] = httpUserAgent;
    map["ruleBookUrlPattern"] = ruleBookUrlPattern;
    map["ruleChapterList"] = ruleChapterList;
    map["ruleChapterName"] = ruleChapterName;
    map["ruleChapterUrl"] = ruleChapterUrl;
    map["ruleChapterUrlNext"] = ruleChapterUrlNext;
    map["ruleContentUrl"] = ruleContentUrl;
    map["ruleContentUrlNext"] = ruleContentUrlNext;
    map["ruleSearchAuthor"] = ruleSearchAuthor;
    map["ruleSearchCoverUrl"] = ruleSearchCoverUrl;
    map["ruleSearchIntroduce"] = ruleSearchIntroduce;
    map["ruleSearchKind"] = ruleSearchKind;
    map["ruleSearchLastChapter"] = ruleSearchLastChapter;
    map["ruleSearchList"] = ruleSearchList;
    map["ruleSearchName"] = ruleSearchName;
    map["ruleSearchNoteUrl"] = ruleSearchNoteUrl;
    map["ruleSearchUrl"] = ruleSearchUrl;
    map["serialNumber"] = serialNumber;
    map["weight"] = weight;

    map["ruleFindUrl"] = ruleFindUrl;
    map["loginUrl"] = loginUrl;
    map["bookSourceComment"] = bookSourceComment;
    map["ruleFindList"] = ruleFindList;
    map["ruleFindName"] = ruleFindName;
    map["ruleFindAuthor"] = ruleFindAuthor;
    map["ruleFindKind"] = ruleFindKind;
    map["ruleFindLastChapter"] = ruleFindLastChapter;
    map["ruleFindNoteUrl"] = ruleFindNoteUrl;
    map["ruleFindCoverUrl"] = ruleFindCoverUrl;

    map["ruleBookContent"] = ruleBookContent;
    map["ruleBookContentReplace"] = ruleBookContentReplace;

    map["ruleBookInfoInit"] = ruleBookInfoInit;
    map["ruleBookName"] = ruleBookName;
    map["ruleBookAuthor"] = ruleBookAuthor;
    map["ruleIntroduce"] = ruleIntroduce;
    map["ruleBookKind"] = ruleBookKind;
    map["ruleBookLastChapter"] = ruleBookLastChapter;
    map["ruleCoverUrl"] = ruleCoverUrl;

    return map;
  }
}
