import 'package:flutter/material.dart';

class PriceWeight with ChangeNotifier {
  final String weight;
  final String price;

  PriceWeight({
    this.weight = '0',
    this.price = '0',
  });

  factory PriceWeight.fromJson(Map<String, dynamic> parsedJson) {
    return PriceWeight(
      weight: parsedJson['weight'],
      price: parsedJson['price'],
    );
  }
}
