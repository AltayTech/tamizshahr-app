import 'package:flutter/material.dart';

import 'pasmand.dart';

class Collect with ChangeNotifier {
  final Pasmand pasmand;
  final String estimated_weight;
  final String exact_weight;
  final String estimated_price;
  final String exact_price;

  Collect({
    required this.pasmand,
    required this.estimated_weight,
    required this.exact_weight,
    required this.estimated_price,
    required this.exact_price,
  });

  factory Collect.fromJson(Map<String, dynamic> parsedJson) {
    return Collect(
      estimated_weight: parsedJson['estimated_weight'] != null &&
              parsedJson['estimated_weight'] != ''
          ? parsedJson['estimated_weight']
          : '0',
      exact_weight:
          parsedJson['exact_weight'] != null && parsedJson['exact_weight'] != ''
              ? parsedJson['exact_weight']
              : '0',
      estimated_price: parsedJson['estimated_price'] != null &&
              parsedJson['estimated_price'] != ''
          ? parsedJson['estimated_price']
          : '0',
      exact_price:
          parsedJson['exact_price'] != null && parsedJson['exact_price'] != ''
              ? parsedJson['exact_price']
              : '0',
      pasmand: Pasmand.fromJson(parsedJson['pasmand']),
    );
  }

  Map<String, dynamic> toJson() {
    Map? pasmand = this.pasmand != null ? this.pasmand.toJson() : null;

    return {
      'pasmand': pasmand,
      'estimated_weight': estimated_weight,
      'exact_weight': exact_weight,
      'estimated_price': estimated_price,
      'exact_price': exact_price,
    };
  }
}
