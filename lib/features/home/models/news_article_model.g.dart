// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsArticleAdapter extends TypeAdapter<NewsArticle> {
  @override
  final int typeId = 0;

  @override
  NewsArticle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsArticle(
      title: fields[0] as String,
      urlToImage: fields[1] as String,
      sourceName: fields[2] as String,
      publishedAt: fields[3] as DateTime,
      url: fields[4] as String,
      description:  fields[5] as String?,
      content:  fields[6] as String?,
      author:  fields[7] as String?,
      category:  fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NewsArticle obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.urlToImage)
      ..writeByte(2)
      ..write(obj.sourceName)
      ..writeByte(3)
      ..write(obj.publishedAt)
      ..writeByte(4)
      ..write(obj.url)
    ..writeByte(5)
    ..write(obj.description)
      ..writeByte(6)
      ..write(obj.content)
      ..writeByte(7)
      ..write(obj.author)
    ..writeByte(8)
    ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
