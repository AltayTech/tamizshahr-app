import 'package:flutter/material.dart';

class Feature with ChangeNotifier {
  final String feature;

  Feature({
    required this.feature,
  });

  factory Feature.fromJson(Map<String, dynamic> parsedJson) {
    return Feature(
      feature: parsedJson['feature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feature': feature,
    };
  }
}
