import 'package:flutter/material.dart';
import '../models/featured_image.dart';
import '../models/sizes.dart';

class Category with ChangeNotifier {
  final int term_id;
  final String name;
  final String slug;

  Category({
    this.term_id,
    this.name,
    this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> parsedJson) {
    return Category(
      term_id: parsedJson['term_id'],
      name: parsedJson['name'],
      slug: parsedJson['slug'],

    );
  }
}
