import 'package:flutter/material.dart';

import '../../../../models/region.dart';

class Address with ChangeNotifier {
  final String name;
  final String address;
  final Region region;
  final String latitude;
  final String longitude;

  Address({
     this.name='',
     this.address='',
    required this.region,
     this.latitude='0.0',
     this.longitude='0.0',
  });

  factory Address.fromJson(Map<String, dynamic> parsedJson) {
    return Address(
      name: parsedJson['name'],
      address: parsedJson['address'],
      region: parsedJson['region'] != null
          ? Region.fromJson(parsedJson['region'])
          : Region(term_id: 0, name: '', collect_hour: []),
      latitude: parsedJson['latitude'] != null ? parsedJson['latitude'] : 0.0,
      longitude:
          parsedJson['longitude'] != null ? parsedJson['longitude'] : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>? region = this.region != null ? this.region.toJson() : null;

    return {
      'name': name,
      'address': address,
      'region': region,
      'latitude': latitude,
      'longitude': longitude
    };
  }
}
