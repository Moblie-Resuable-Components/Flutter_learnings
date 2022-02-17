import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {
  String author;
  String title;
  String time;
  String url;
  String urlToImage;
  String date;
  String content;
  String readmoreurl;

  Article(this.author, this.title, this.time, this.url, this.urlToImage,
      this.readmoreurl, this.date, this.content);

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
