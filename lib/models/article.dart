import 'package:flutter/material.dart';

import 'article_cat.dart';

class Article with ChangeNotifier {
  final int id;
  final String title;
  final String content;
  final String post_date_gmt;
  final String featured_image;
  final List<ArticleCat> category;

  Article({
    this.id,
    this.title,
    this.content,
    this.post_date_gmt,
    this.category,
    this.featured_image,
  });

  factory Article.fromJson(Map<String, dynamic> parsedJson) {
    var categoryList = parsedJson['category'] as List;
    List<ArticleCat> categoryRaw =
        categoryList.map((i) => ArticleCat.fromJson(i)).toList();

    return Article(
      id: parsedJson['id'],
      title: parsedJson['title'],
      content: parsedJson['content'],
      post_date_gmt: parsedJson['post_date_gmt'],
      featured_image: parsedJson['featured_image'],
      category: categoryRaw,
    );
  }
}
