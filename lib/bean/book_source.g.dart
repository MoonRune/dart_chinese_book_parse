// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookSource _$BookSourceFromJson(Map<String, dynamic> json) {
  return BookSource(
    json['bookSourceName'] as String,
    json['bookSourceGroup'] as String?,
    json['bookSourceUrl'] as String,
    json['bookSourceType'] as String,
    json['bookUrlPattern'] as String?,
    json['customOrder'] as int?,
    json['enabled'] as bool,
    json['enabledExplore'] as bool,
    json['header'] as String?,
    json['loginUrl'] as String?,
    json['bookSourceComment'] as String?,
    json['lastUpdateTime'] as int,
    json['weight'] as int,
    json['exploreUrl'] as String?,
    json['ruleExplore'] == null
        ? null
        : ExploreRule.fromJson(json['ruleExplore'] as Map<String, dynamic>),
    json['searchUrl'] as String?,
    json['ruleSearch'] == null
        ? null
        : SearchRule.fromJson(json['ruleSearch'] as Map<String, dynamic>),
    json['ruleBookInfo'] == null
        ? null
        : BookInfoRule.fromJson(json['ruleBookInfo'] as Map<String, dynamic>),
    json['ruleToc'] == null
        ? null
        : TocRule.fromJson(json['ruleToc'] as Map<String, dynamic>),
    json['ruleContent'] == null
        ? null
        : ContentRule.fromJson(json['ruleContent'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookSourceToJson(BookSource instance) =>
    <String, dynamic>{
      'bookSourceName': instance.bookSourceName,
      'bookSourceGroup': instance.bookSourceGroup,
      'bookSourceUrl': instance.bookSourceUrl,
      'bookSourceType': instance.bookSourceType,
      'bookUrlPattern': instance.bookUrlPattern,
      'customOrder': instance.customOrder,
      'enabled': instance.enabled,
      'enabledExplore': instance.enabledExplore,
      'header': instance.header,
      'loginUrl': instance.loginUrl,
      'bookSourceComment': instance.bookSourceComment,
      'lastUpdateTime': instance.lastUpdateTime,
      'weight': instance.weight,
      'exploreUrl': instance.exploreUrl,
      'ruleExplore': instance.ruleExplore,
      'searchUrl': instance.searchUrl,
      'ruleSearch': instance.ruleSearch,
      'ruleBookInfo': instance.ruleBookInfo,
      'ruleToc': instance.ruleToc,
      'ruleContent': instance.ruleContent,
    };

ExploreRule _$ExploreRuleFromJson(Map<String, dynamic> json) {
  return ExploreRule(
    json['bookList'] as String?,
    json['name'] as String?,
    json['author'] as String?,
    json['intro'] as String?,
    json['kind'] as String?,
    json['lastChapter'] as String?,
    json['updateTime'] as String?,
    json['bookUrl'] as String?,
    json['coverUrl'] as String?,
    json['wordCount'] as String?,
  );
}

Map<String, dynamic> _$ExploreRuleToJson(ExploreRule instance) =>
    <String, dynamic>{
      'bookList': instance.bookList,
      'name': instance.name,
      'author': instance.author,
      'intro': instance.intro,
      'kind': instance.kind,
      'lastChapter': instance.lastChapter,
      'updateTime': instance.updateTime,
      'bookUrl': instance.bookUrl,
      'coverUrl': instance.coverUrl,
      'wordCount': instance.wordCount,
    };

SearchRule _$SearchRuleFromJson(Map<String, dynamic> json) {
  return SearchRule(
    json['bookList'] as String?,
    json['name'] as String?,
    json['author'] as String?,
    json['intro'] as String?,
    json['kind'] as String?,
    json['lastChapter'] as String?,
    json['updateTime'] as String?,
    json['bookUrl'] as String?,
    json['coverUrl'] as String?,
    json['wordCount'] as String?,
  );
}

Map<String, dynamic> _$SearchRuleToJson(SearchRule instance) =>
    <String, dynamic>{
      'bookList': instance.bookList,
      'name': instance.name,
      'author': instance.author,
      'intro': instance.intro,
      'kind': instance.kind,
      'lastChapter': instance.lastChapter,
      'updateTime': instance.updateTime,
      'bookUrl': instance.bookUrl,
      'coverUrl': instance.coverUrl,
      'wordCount': instance.wordCount,
    };

BookInfoRule _$BookInfoRuleFromJson(Map<String, dynamic> json) {
  return BookInfoRule(
    json['init'] as String?,
    json['name'] as String?,
    json['author'] as String?,
    json['intro'] as String?,
    json['kind'] as String?,
    json['lastChapter'] as String?,
    json['updateTime'] as String?,
    json['coverUrl'] as String?,
    json['tocUrl'] as String?,
    json['wordCount'] as String?,
    json['canReName'] as String?,
  );
}

Map<String, dynamic> _$BookInfoRuleToJson(BookInfoRule instance) =>
    <String, dynamic>{
      'init': instance.init,
      'name': instance.name,
      'author': instance.author,
      'intro': instance.intro,
      'kind': instance.kind,
      'lastChapter': instance.lastChapter,
      'updateTime': instance.updateTime,
      'coverUrl': instance.coverUrl,
      'tocUrl': instance.tocUrl,
      'wordCount': instance.wordCount,
      'canReName': instance.canReName,
    };

TocRule _$TocRuleFromJson(Map<String, dynamic> json) {
  return TocRule()
    ..chapterList = json['chapterList'] as String?
    ..chapterName = json['chapterName'] as String?
    ..chapterUrl = json['chapterUrl'] as String?
    ..isVip = json['isVip'] as String?
    ..updateTime = json['updateTime'] as String?
    ..nextTocUrl = json['nextTocUrl'] as String?;
}

Map<String, dynamic> _$TocRuleToJson(TocRule instance) => <String, dynamic>{
  'chapterList': instance.chapterList,
  'chapterName': instance.chapterName,
  'chapterUrl': instance.chapterUrl,
  'isVip': instance.isVip,
  'updateTime': instance.updateTime,
  'nextTocUrl': instance.nextTocUrl,
};

ContentRule _$ContentRuleFromJson(Map<String, dynamic> json) {
  return ContentRule(
    json['content'] as String?,
    json['nextContentUrl'] as String?,
    json['webJs'] as String?,
    json['sourceRegex'] as String?,
    json['replaceRegex'] as String?,
    json['imageStyle'] as String?,
  );
}

Map<String, dynamic> _$ContentRuleToJson(ContentRule instance) =>
    <String, dynamic>{
      'content': instance.content,
      'nextContentUrl': instance.nextContentUrl,
      'webJs': instance.webJs,
      'sourceRegex': instance.sourceRegex,
      'replaceRegex': instance.replaceRegex,
      'imageStyle': instance.imageStyle,
    };
