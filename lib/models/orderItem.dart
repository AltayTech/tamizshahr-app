import 'package:flutter/foundation.dart';

import '../models/color_code.dart';

class OrderItem with ChangeNotifier {
  final int id;
  final String title;
  final String price_low;
  final ColorCode selected_color;

  OrderItem({
    this.id,
    this.title,
    this.price_low,
    this.selected_color,
  });

  factory OrderItem.fromJson(Map<String, dynamic> parsedJson) {
    return OrderItem(
      id: parsedJson['id'],
      title: parsedJson['title'],
      price_low: parsedJson['price_low'],
      selected_color: ColorCode.fromJson(parsedJson['selected_color']),
    );
  }
}
