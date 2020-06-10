import 'package:flutter/material.dart';

import 'pasmand.dart';

class Collect with ChangeNotifier {
  final Pasmand pasmand;
  final String weight;
  final String price;

  Collect({
    this.pasmand,
    this.weight,
    this.price,
  });

  factory Collect.fromJson(Map<String, dynamic> parsedJson) {
    return Collect(
      weight: parsedJson['weight'],
      price: parsedJson['price'],
      pasmand: Pasmand.fromJson(parsedJson['pasmand']),
    );
  }

  Map<String, dynamic> toJson() {
    Map pasmand = this.pasmand != null ? this.pasmand.toJson() : null;

    return {
      'pasmand': pasmand,
      'weight': weight,
      'price': price,
    };
  }
}
