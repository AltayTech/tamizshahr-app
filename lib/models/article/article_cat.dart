import 'package:flutter/material.dart';

class ArticleCat with ChangeNotifier {
  final int term_id;
  final String name;
  final String slug;

  ArticleCat({
    required this.term_id,
    required this.name,
    required this.slug,
  });

  factory ArticleCat.fromJson(Map<String, dynamic> parsedJson) {
    return ArticleCat(
      term_id: parsedJson['term_id'],
      name: parsedJson['name'],
      slug: parsedJson['slug'],
    );
  }
}
