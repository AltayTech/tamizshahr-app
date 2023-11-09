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
    required this.name,
    required this.excerpt,
    required this.ostan,
    required this.city,
    required this.phone,
    required this.mobile,
    required this.address,
    required this.postcode,
    required this.email,
  });

  factory CharityData.fromJson(Map<String, dynamic> parsedJson) {
    return CharityData(
      name: parsedJson['name'] != null ? parsedJson['name'] : '',
      excerpt: parsedJson['excerpt'] != null ? parsedJson['excerpt'] : '',
      ostan: parsedJson['ostan'] != null ? parsedJson['ostan'] : '',
      city: parsedJson['city'] != null ? parsedJson['city'] : '',
      phone: parsedJson['phone'] != null ? parsedJson['phone'] : '',
      mobile: parsedJson['mobile'] != null ? parsedJson['mobile'] : '',
      address: parsedJson['address'] != null ? parsedJson['address'] : '',
      postcode: parsedJson['postcode'] != null ? parsedJson['postcode'] : '',
      email: parsedJson['email'] != null ? parsedJson['email'] : '',
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
