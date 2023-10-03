import 'package:flutter_hive_state_master/util/utils/utils.dart';

class FeedModel {
  final String? id;
  final String? name;
  final String? title;
  final String? description;
  final String? author;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  FeedModel(
      {this.id,
      this.name,
      this.title,
      this.description,
      this.author,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
        id: json['source']['id'],
        name: json['source']['name'],
        title: json['title'],
        description: json['description'],
        author: json['author'],
        urlToImage: json['urlToImage'],
        publishedAt: DateTime.parse(json['publishedAt'])
            .toLocal()
            .dateTimeAgo(numericDates: true),
        content: json['content']);
  }
}
