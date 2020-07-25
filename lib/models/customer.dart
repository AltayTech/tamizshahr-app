import 'package:flutter/foundation.dart';

import '../models/personal_data.dart';
import 'status.dart';

class Customer with ChangeNotifier {
  final int id;
  final Status status;
  final Status customer_type;
  final PersonalData personalData;
  final String money;

  Customer({
    this.id,
    this.status,
    this.customer_type,
    this.personalData,
    this.money,
  });

  factory Customer.fromJson(Map<String, dynamic> parsedJson) {
    return Customer(
      id: parsedJson['id']!=null?parsedJson['id']:0,
      status: parsedJson['status']!=null?Status.fromJson(parsedJson['status']):Status(term_id: 0,name:'',slug: ''),
      customer_type: parsedJson['customer_type']!=null?Status.fromJson(parsedJson['customer_type']):Status(term_id: 0,name:'',slug: ''),
      personalData: PersonalData.fromJson(parsedJson['customer_data']),
      money: parsedJson['money'] != null &&parsedJson['money'] != ''? parsedJson['money'] : '0.0',
    );
  }

  Map<String, dynamic> toJson() {
    Map personalData =
        this.personalData != null ? this.personalData.toJson() : null;
    Map customer_type = this.customer_type != null ? this.customer_type.toJson() : null;

    return {
      'customer_data': personalData,
      'customer_type': customer_type,
      'id': id,
      'money': money,
    };
  }
}
