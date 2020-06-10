import 'package:flutter/foundation.dart';

class PersonalData with ChangeNotifier {
  final int id;
  final String phone;
  final String first_name;
  final String last_name;
  final String ostan;
  final String city;
//  final String address;
  final String postcode;
  final String email;
  final bool personal_data_complete;

  PersonalData(
      {this.id,
      this.phone,
      this.first_name,
      this.last_name,
      this.email,
      this.ostan,
      this.city,
//      this.address,
      this.postcode,
      this.personal_data_complete});

  factory PersonalData.fromJson(Map<String, dynamic> parsedJson) {
    return PersonalData(
      id: parsedJson['id'],
      phone: parsedJson['phone'],
      first_name: parsedJson['fname'],
      last_name: parsedJson['lname'],
      email: parsedJson['email'],
      ostan: parsedJson['ostan'],
      city: parsedJson['city'],
//      address: parsedJson['address'],
      postcode: parsedJson['postcode'],
      personal_data_complete: parsedJson['customer_data'],
    );
  }
}
