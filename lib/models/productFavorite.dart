import 'package:flutter/foundation.dart';

import '../models/color_code.dart';
import 'price.dart';

class ProductFavorite with ChangeNotifier {
  final int id;
  final String title;
  final Price price;
  final String featured_image;
  final List<ColorCode> colors;

  ProductFavorite({
    this.id,
    this.title,
    this.featured_image,
    this.price,
    this.colors,
  });

  factory ProductFavorite.fromJson(Map<String, dynamic> parsedJson) {
    var colorsFromJson = parsedJson['colors'] as List;
    List<ColorCode> colorRaw =
        colorsFromJson.map((i) => ColorCode.fromJson(i)).toList();

    return ProductFavorite(
      id: parsedJson['id'],
      title: parsedJson['title'],
      featured_image: parsedJson['img_url'],
      price: Price.fromJson(parsedJson['price']),
      colors: colorRaw,
    );
  }
}
