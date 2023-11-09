import 'package:flutter/material.dart';

class Status with ChangeNotifier {
  final int term_id;
  final String name;
  final String slug;

  Status({
    this.term_id = 0,
    this.name = '',
    this.slug = '',
  });

  factory Status.fromJson(Map<String, dynamic> parsedJson) {
    return Status(
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
