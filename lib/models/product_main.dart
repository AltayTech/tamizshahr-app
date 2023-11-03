import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../models/search_detail.dart';

class ProductMain with ChangeNotifier {
  final SearchDetail productsDetail;

  final List<Product> products;

  ProductMain({required this.productsDetail, this.products=const []});

  factory ProductMain.fromJson(Map<String, dynamic> parsedJson) {
    var productsList = parsedJson['data'] as List;
    List<Product> productsRaw = [];

    productsRaw = productsList.map((i) => Product.fromJson(i)).toList();

    return ProductMain(
      productsDetail: SearchDetail.fromJson(parsedJson['details']),
      products: productsRaw,
    );
  }
}
