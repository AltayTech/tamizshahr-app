import 'package:flutter/foundation.dart';

import '../models/personal_data.dart';

class Customer with ChangeNotifier {
  final int id;
  final PersonalData personalData;
  final String money;

  Customer({
    this.id,
    this.personalData,
    this.money,
  });

  factory Customer.fromJson(Map<String, dynamic> parsedJson) {
    return Customer(
      id: parsedJson['id'],
      personalData: PersonalData.fromJson(parsedJson['customer_data']),
      money: parsedJson['money'] != null ? parsedJson['money'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    Map personalData =
        this.personalData != null ? this.personalData.toJson() : null;

    return {
      'customer_data': personalData,
      'id': id,
      'money': money,
    };
  }
}
