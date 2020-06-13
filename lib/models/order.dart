import 'package:flutter/foundation.dart';
import 'package:tamizshahr/models/product_order_receive.dart';
import 'package:tamizshahr/models/status.dart';

class Order with ChangeNotifier {
  final int id;
  final Status status;
  final String pay_status;
  final String pay_date;
  final String pay_transaction;
  final String send_date;
  final String total_price;
  final String total_number;
  final List<ProductOrderReceive> products;

  Order({
    this.id,
    this.status,
    this.pay_status,
    this.pay_date,
    this.pay_transaction,
    this.send_date,
    this.total_price,
    this.total_number,
    this.products,
  });

  factory Order.fromJson(Map<String, dynamic> parsedJson) {
    var productList = parsedJson['products'] as List;
    List<ProductOrderReceive> productRaw =
        productList.map((i) => ProductOrderReceive.fromJson(i)).toList();

    return Order(
      id: parsedJson['id'],
      status: Status.fromJson(parsedJson['status']),
      pay_status: parsedJson['pay_status']!=null?parsedJson['pay_status']:'',
      pay_date: parsedJson['pay_date']!=null?parsedJson['pay_date']:'',
      pay_transaction: parsedJson['pay_transaction']!=null?parsedJson['pay_transaction']:'',
      send_date: parsedJson['send_date']!=null?parsedJson['send_date']:'',
      total_price: parsedJson['total_price'],
      total_number: parsedJson['total_number'],
      products: productRaw,
    );
  }
}
