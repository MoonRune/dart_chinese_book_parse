import 'package:BookSource/rule/rule.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BookSource {
  static const BOOK_TYPE_TEXT = "";
  static const BOOK_TYPE_AUDIO = "1";
  String bookSourceName = ""; // 名称
  String? bookSourceGroup; // 分组
  //@PrimaryKey
  String bookSourceUrl = ""; // 地址，包括 http/https
  String bookSourceType = BOOK_TYPE_TEXT; // 类型，0 文本，1 音频
  String? bookUrlPattern; // 详情页url正则
  int? customOrder = 0; // 手动排序编号
  bool? enabled = true; // 是否启用
  bool? enabledExplore = true; // 启用发现
  String? header; // 请求头
  String? loginUrl; // 登录地址
  String? bookSourceComment; // 注释
  int? lastUpdateTime = 0; // 最后更新时间，用于排序
  int? weight = 0; // 智能排序的权重
  String? exploreUrl; // 发现url
  ExploreRule? ruleExplore; // 发现规则
  String? searchUrl; // 搜索url
  SearchRule? ruleSearch; // 搜索规则
  BookInfoRule? ruleBookInfo; // 书籍信息页规则
  TocRule? ruleToc; // 目录页规则
  ContentRule? ruleContent;

  @override
  String toString() {
    return 'BookSource{bookSourceName: $bookSourceName, bookSourceGroup: $bookSourceGroup, bookSourceUrl: $bookSourceUrl, bookSourceType: $bookSourceType, bookUrlPattern: $bookUrlPattern, customOrder: $customOrder, enabled: $enabled, enabledExplore: $enabledExplore, header: $header, loginUrl: $loginUrl, bookSourceComment: $bookSourceComment, lastUpdateTime: $lastUpdateTime, weight: $weight, exploreUrl: $exploreUrl, ruleExplore: $ruleExplore, searchUrl: $searchUrl, ruleSearch: $ruleSearch, ruleBookInfo: $ruleBookInfo, ruleToc: $ruleToc, ruleContent: $ruleContent}';
  }

  BookSource(
      this.bookSourceName,
      this.bookSourceGroup,
      this.bookSourceUrl,
      this.bookSourceType,
      this.bookUrlPattern,
      this.customOrder,
      this.enabled,
      this.enabledExplore,
      this.header,
      this.loginUrl,
      this.bookSourceComment,
      this.lastUpdateTime,
      this.weight,
      this.exploreUrl,
      this.ruleExplore,
      this.searchUrl,
      this.ruleSearch,
      this.ruleBookInfo,
      this.ruleToc,
      this.ruleContent); // 正文页规则

  @override
  int get hashCode {
    return bookSourceUrl.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (other is BookSource) {
      return other.bookSourceUrl == bookSourceUrl;
    } else {
      return false;
    }
  }
}

@JsonSerializable()
class ExploreRule {
  Rule bookList;
  Rule name;
  Rule author;
  Rule intro;
  Rule kind;
  Rule lastChapter;
  Rule updateTime;
  Rule bookUrl;
  Rule coverUrl;
  Rule wordCount;

  @override
  String toString() {
    return 'ExploreRule{bookList: $bookList, name: $name, author: $author, intro: $intro, kind: $kind, lastChapter: $lastChapter, updateTime: $updateTime, bookUrl: $bookUrl, coverUrl: $coverUrl, wordCount: $wordCount}';
  }

  ExploreRule(
      this.bookList,
      this.name,
      this.author,
      this.intro,
      this.kind,
      this.lastChapter,
      this.updateTime,
      this.bookUrl,
      this.coverUrl,
      this.wordCount);
}

// class BookListRule {
// String?  bookList;
// String?  name;
// String?  author;
// String?  intro;
// String?  kind;
// String?  lastChapter;
// String?  updateTime;
// String?  bookUrl;
// String?  coverUrl;
// String?  wordCount;
// }

@JsonSerializable()
class SearchRule // implements BookListRule
{
  Rule bookList;
  Rule name;
  Rule author;
  Rule intro;
  Rule kind;
  Rule lastChapter;
  Rule updateTime;
  Rule bookUrl;
  Rule coverUrl;
  Rule wordCount;

  SearchRule(
      this.bookList,
      this.name,
      this.author,
      this.intro,
      this.kind,
      this.lastChapter,
      this.updateTime,
      this.bookUrl,
      this.coverUrl,
      this.wordCount);

  @override
  String toString() {
    return 'SearchRule{bookList: $bookList, name: $name, author: $author, intro: $intro, kind: $kind, lastChapter: $lastChapter, updateTime: $updateTime, bookUrl: $bookUrl, coverUrl: $coverUrl, wordCount: $wordCount}';
  }
}

@JsonSerializable()
class BookInfoRule {
  String? init;
  String? name;
  String? author;
  String? intro;
  String? kind;
  String? lastChapter;
  String? updateTime;
  String? coverUrl;
  String? tocUrl;
  String? wordCount;
  String? canReName;

  @override
  String toString() {
    return 'BookInfoRule{init: $init, name: $name, author: $author, intro: $intro, kind: $kind, lastChapter: $lastChapter, updateTime: $updateTime, coverUrl: $coverUrl, tocUrl: $tocUrl, wordCount: $wordCount, canReName: $canReName}';
  }

  BookInfoRule(
      this.init,
      this.name,
      this.author,
      this.intro,
      this.kind,
      this.lastChapter,
      this.updateTime,
      this.coverUrl,
      this.tocUrl,
      this.wordCount,
      this.canReName);
}

@JsonSerializable()
class TocRule {
  Rule chapterList;
  Rule chapterName;
  Rule chapterUrl;
  Rule isVip;
  Rule updateTime;
  Rule nextTocUrl;

  @override
  String toString() {
    return 'TocRule{chapterList: $chapterList, chapterName: $chapterName, chapterUrl: $chapterUrl, isVip: $isVip, updateTime: $updateTime, nextTocUrl: $nextTocUrl}';
  }

  TocRule(this.chapterList, this.chapterName, this.chapterUrl, this.isVip,
      this.updateTime, this.nextTocUrl);
}

@JsonSerializable()
class ContentRule {
  String? content;
  String? nextContentUrl;
  String? webJs;
  String? sourceRegex;
  String? replaceRegex; //替换规则
  String? imageStyle;

  ContentRule(this.content, this.nextContentUrl, this.webJs, this.sourceRegex,
      this.replaceRegex, this.imageStyle); //默认大小居中,FULL最大宽度

  @override
  String toString() {
    return 'ContentRule{content: $content, nextContentUrl: $nextContentUrl, webJs: $webJs, sourceRegex: $sourceRegex, replaceRegex: $replaceRegex, imageStyle: $imageStyle}';
  }
}
