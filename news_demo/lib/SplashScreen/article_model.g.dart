// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['author'] as String,
    json['title'] as String,
    json['time'] as String,
    json['url'] as String,
    json['urlToImage'] as String,
    json['readmoreurl'] as String,
    json['date'] as String,
    json['content'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'time': instance.time,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'date': instance.date,
      'content': instance.content,
      'readmoreurl': instance.readmoreurl,
    };
