import 'package:flutter/material.dart';

class RequestAddress with ChangeNotifier {
  final String name;
  final String address;
  final String region;
  final String latitude;
  final String longitude;

  RequestAddress({
    this.name = '',
    this.address = '',
    this.region = '',
    this.latitude = '',
    this.longitude = '',
  });

  factory RequestAddress.fromJson(Map<String, dynamic> parsedJson) {
    return RequestAddress(
      name: parsedJson['name'],
      address: parsedJson['address'],
      region: parsedJson['region'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'region': region,
      'latitude': latitude,
      'longitude': longitude
    };
  }
}
