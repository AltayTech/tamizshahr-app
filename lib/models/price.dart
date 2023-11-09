import 'package:flutter/material.dart';

class Price with ChangeNotifier {
  final String price;
  final String price_without_discount;

  Price({
    required this.price,
    required this.price_without_discount,
  });

  factory Price.fromJson(Map<String, dynamic> parsedJson) {
    return Price(
      price: parsedJson['price'],
      price_without_discount: parsedJson['price_without_discount'],
    );
  }
}
