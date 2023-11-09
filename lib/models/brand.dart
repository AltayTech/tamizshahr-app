import 'package:flutter/material.dart';

class Brand with ChangeNotifier {
  final int id;
  final String title;
  final String brand_img_url;

  Brand({
    required this.id,
    required this.title,
    required this.brand_img_url,
  });

  factory Brand.fromJson(Map<String, dynamic> parsedJson) {
    return Brand(
      id: parsedJson['id'],
      title: parsedJson['title'],
      brand_img_url: parsedJson['brand_img_url'],
    );
  }
}
