import 'package:flutter/material.dart';

class Brandc with ChangeNotifier {
  final int id;
  final String title;
  final String img_url;

  Brandc({
    required this.id,
    required this.title,
    required this.img_url,
  });

  factory Brandc.fromJson(Map<String, dynamic> parsedJson) {
    return Brandc(
      id: parsedJson['id'],
      title: parsedJson['title'],
      img_url: parsedJson['img_url'],
    );
  }
}
