import 'package:hive/hive.dart';

part 'news_article_model.g.dart';

@HiveType(typeId: 0)
class NewsArticle {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? urlToImage;

  @HiveField(2)
  final String sourceName;

  @HiveField(3)
  final DateTime publishedAt;

  @HiveField(4)
  final String url;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final String? content;

  @HiveField(7)
  final String? author;

  @HiveField(8)
  final String? category;

  NewsArticle({
    required this.title,
    required this.urlToImage,
    required this.sourceName,
    required this.publishedAt,
    required this.url,
    required this.description,
    required this.content,
    required this.author,
    required this.category,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      urlToImage: json['urlToImage'],
      sourceName: json['source']['name'] ?? 'Unknown',
      publishedAt: DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
      url: json['url'] ?? '',
      author: json['author'] ?? '',
    );
  }
}
