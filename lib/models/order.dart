import 'package:flutter/foundation.dart';

class Order with ChangeNotifier {
  final int id;
  final String shenaseh;
  final String total_cost;
  final String order_register_date;
  final int total_num;
  final String order_status;
  final String pay_type;
  final String pish;
  final String pay_status;

  Order(
      {this.id,
      this.shenaseh,
      this.total_cost,
      this.order_register_date,
      this.total_num,
      this.order_status,
      this.pay_type,
      this.pish,
      this.pay_status});

  factory Order.fromJson(Map<String, dynamic> parsedJson) {
    return Order(
      id: parsedJson['id'],
      shenaseh: parsedJson['shenaseh'],
      total_cost: parsedJson['total_cost'],
      order_register_date: parsedJson['order_register_date'],
      total_num: parsedJson['total_num'],
      order_status: parsedJson['order_status'],
      pay_type: parsedJson['pay_type'],
      pish: parsedJson['pish'],
      pay_status: parsedJson['pay_status'],
    );
  }
}
