import 'package:flutter/material.dart';

import 'region.dart';

class Address with ChangeNotifier {
  final String name;
  final String address;
  final Region region;
  final String latitude;
  final String longitude;

  Address({this.name, this.address,this.region, this.latitude, this.longitude});

  factory Address.fromJson(Map<String, dynamic> parsedJson) {
    return Address(
      name: parsedJson['name'],
      address: parsedJson['address'],
      region: Region.fromJson(parsedJson['region']),
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
    );
  }


  Map<String, dynamic> toJson() {
    Map region =
    this.region != null ? this.region.toJson() : null;

    return {
      'name' : name,
      'address' : address,
      'region':region,
      'latitude' : latitude,
      'longitude' : longitude    };
  }
}
