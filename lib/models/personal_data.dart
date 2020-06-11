import 'package:flutter/foundation.dart';

import 'request/address.dart';

class PersonalData with ChangeNotifier {
  final String phone;
  final String first_name;
  final String last_name;
  final String ostan;
  final String city;
  final List<Address> addresses;
  final String postcode;
  final String email;

  PersonalData({
    this.phone,
    this.first_name,
    this.last_name,
    this.email,
    this.ostan,
    this.city,
    this.addresses,
    this.postcode,
  });

  factory PersonalData.fromJson(Map<String, dynamic> parsedJson) {
    var addressList = parsedJson['address_data'] as List;
    List<Address> addressRaw =
        addressList.map((i) => Address.fromJson(i)).toList();

    return PersonalData(
      phone: parsedJson['phone'],
      first_name: parsedJson['fname'],
      last_name: parsedJson['lname'],
      email: parsedJson['email'],
      ostan: parsedJson['ostan'],
      city: parsedJson['city'],
      addresses: addressRaw,
      postcode: parsedJson['postcode'],
    );
  }

  Map<String, dynamic> toJson() {

    List<Map> addresses = this.addresses != null
        ? this.addresses.map((i) => i.toJson()).toList()
        : null;

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
