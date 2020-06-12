import 'package:flutter/foundation.dart';

class CharityData with ChangeNotifier {
  final String name;
  final String excerpt;
  final String ostan;
  final String city;
  final String phone;
  final String mobile;
  final String address;
  final String postcode;
  final String email;

  CharityData({
    this.name,
    this.excerpt,
    this.ostan,
    this.city,
    this.phone,
    this.mobile,
    this.address,
    this.postcode,
    this.email,
  });

  factory CharityData.fromJson(Map<String, dynamic> parsedJson) {
    return CharityData(
      name: parsedJson['name'],
      excerpt: parsedJson['excerpt'],
      ostan: parsedJson['ostan'],
      city: parsedJson['city'],
      phone: parsedJson['phone'],
      mobile: parsedJson['mobile'],
      address: parsedJson['address'],
      postcode: parsedJson['postcode'],
      email: parsedJson['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'excerpt': excerpt,
      'ostan': ostan,
      'city': city,
      'phone': phone,
      'mobile': mobile,
      'address': address,
      'postcode': postcode,
      'email': email,
    };
  }
}
