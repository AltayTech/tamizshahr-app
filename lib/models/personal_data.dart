import 'package:flutter/foundation.dart';

import '../features/waste_feature/business/entities/address.dart';

class PersonalData with ChangeNotifier {
  final String phone;
  final String first_name;
  final String last_name;
  final String ostan;
  final String city;
  final String mobile;
  final List<Address> addresses;
  final String postcode;
  final String email;

  PersonalData({
    this.phone = '',
    this.first_name = '',
    this.last_name = '',
    this.email = '',
    this.ostan = '',
    this.city = '',
    this.mobile = '',
    this.addresses = const [],
    this.postcode = '',
  });

  factory PersonalData.fromJson(Map<String, dynamic> parsedJson) {
    List<Address> addressRaw = [];
    if (parsedJson['address_data'] != null) {
      var addressList = parsedJson['address_data'] as List;
      addressRaw = addressList.map((i) => Address.fromJson(i)).toList();
    } else {
      addressRaw = [];
    }
    return PersonalData(
      phone: parsedJson['phone'] != null ? parsedJson['phone'] : '',
      first_name: parsedJson['fname'] != null ? parsedJson['fname'] : '',
      last_name: parsedJson['lname'] != null ? parsedJson['lname'] : '',
      email: parsedJson['email'] != null ? parsedJson['email'] : '',
      ostan: parsedJson['ostan'] != null ? parsedJson['ostan'] : '',
      city: parsedJson['city'] != null ? parsedJson['city'] : '',
      mobile: parsedJson['mobile'] != null ? parsedJson['mobile'] : '',
      addresses: addressRaw,
      postcode: parsedJson['postcode'] != null ? parsedJson['postcode'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    List<Map>? addresses = this.addresses.map((i) => i.toJson()).toList();

    return {
      'phone': phone,
      'fname': first_name,
      'lname': last_name,
      'email': email,
      'ostan': ostan,
      'city': city,
      'address_data': addresses,
      'postcode': postcode,
    };
  }
}
