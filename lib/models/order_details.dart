import 'package:flutter/foundation.dart';

import 'orderItem.dart';

class OrderDetails with ChangeNotifier {
  final int id;
  final String total_cost;
  final String order_register_date;
  final String shenaseh;
  final int number_of_products;
  final List<OrderItem> products;
  final String order_status;
  final String order_status_slug;
  final String pay_type;
  final String pay_type_slug;
  final String pish;
  final String pay_status;
  final String pay_status_slug;

  OrderDetails({
    required this.id,
    required this.total_cost,
    required this.shenaseh,
    required this.order_register_date,
    required this.number_of_products,
    required this.products,
    required this.order_status,
    required this.order_status_slug,
    required this.pay_type,
    required this.pay_type_slug,
    required this.pish,
    required this.pay_status,
    required this.pay_status_slug,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> parsedJson) {
    var productList = parsedJson['products'] as List;
    List<OrderItem> productRaw = [];

    productRaw = productList.map((i) => OrderItem.fromJson(i)).toList();

    return OrderDetails(
      id: parsedJson['id'],
      total_cost: parsedJson['total_cost'],
      shenaseh: parsedJson['shenaseh'],
      order_register_date: parsedJson['order_register_date'],
      number_of_products: parsedJson['number_of_products'],
      products: productRaw,
      order_status: parsedJson['order_status'],
      order_status_slug: parsedJson['order_status_slug'],
      pay_type: parsedJson['pay_type'],
      pay_type_slug: parsedJson['pay_type_slug'],
      pish: parsedJson['pish'],
      pay_status: parsedJson['pay_status'],
      pay_status_slug: parsedJson['pay_status_slug'],
    );
  }
}
