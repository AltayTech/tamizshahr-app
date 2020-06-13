import 'package:flutter/material.dart';
import 'package:tamizshahr/models/driver_data.dart';

class Driver with ChangeNotifier {
  final String car;
  final String car_color;
  final String car_number;
  final DriverData driver_data;

  Driver({
    this.car,
    this.car_color,
    this.car_number,
    this.driver_data,
  });

  factory Driver.fromJson(Map<String, dynamic> parsedJson) {
    return Driver(
      car: parsedJson['car'] != null ? parsedJson['car'] : '',
      car_color: parsedJson['car_color'] != null ? parsedJson['car_color'] : '',
      car_number:
          parsedJson['car_number'] != null ? parsedJson['car_number'] : '',
      driver_data: DriverData.fromJson(parsedJson['driver_data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'car': car,
      'car_color': car_color,
      'driver_data': driver_data,
    };
  }
}
