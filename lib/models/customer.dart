import 'package:flutter/foundation.dart';

import '../models/personal_data.dart';
import 'order.dart';

class Customer with ChangeNotifier {
  final PersonalData personalData;
//  final List<Order> orders;

  Customer({
    this.personalData,
//    this.orders,
  });

  factory Customer.fromJson(Map<String, dynamic> parsedJson) {
//    var orderList = parsedJson['orders'] as List;
//    List<Order> orderRaw = new List<Order>();
//
//    orderRaw = orderList.map((i) => Order.fromJson(i)).toList();

    return Customer(
      personalData: PersonalData.fromJson(parsedJson['customer_data']),
//      orders: orderRaw,
    );
  }
}
