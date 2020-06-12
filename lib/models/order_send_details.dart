import 'package:flutter/foundation.dart';
import '../models/product_order_send.dart';

class OrderSendDetails with ChangeNotifier {
  final String total_price;
  final String total_number;
  final List<ProductOrderSend> products;

  OrderSendDetails({
    this.total_price,
    this.total_number,
    this.products,
  });

  factory OrderSendDetails.fromJson(Map<String, dynamic> parsedJson) {
    var productList = parsedJson['products'] as List;
    List<ProductOrderSend> productRaw = new List<ProductOrderSend>();

    productRaw = productList.map((i) => ProductOrderSend.fromJson(i)).toList();

    return OrderSendDetails(
      total_price: parsedJson['total_price'],
      total_number: parsedJson['total_number'],
      products: productRaw,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> products = this.products != null
        ? this.products.map((i) => i.toJson()).toList()
        : null;

    return {
      'total_price': total_price,
      'total_number': total_number,
      'products': products,
    };
  }
}
