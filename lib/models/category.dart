import 'package:flutter/material.dart';

class Category with ChangeNotifier {
  final int term_id;
  final String name;
  final String slug;

  Category({
    required this.term_id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> parsedJson) {
    return Category(
      term_id: parsedJson['term_id'],
      name: parsedJson['name'],
      slug: parsedJson['slug'],
    );
  }
}
