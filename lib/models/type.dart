import 'package:flutter/material.dart';

class TypePost with ChangeNotifier {
  final int term_id;
  final String name;
  final String slug;

  TypePost({
    this.term_id = 0,
    this.name = '',
    this.slug = '',
  });

  factory TypePost.fromJson(Map<String, dynamic> parsedJson) {
    return TypePost(
      term_id: parsedJson['term_id'],
      name: parsedJson['name'],
      slug: parsedJson['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'term_id': term_id,
      'name': name,
      'slug': slug,
    };
  }
}
