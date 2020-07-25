import 'package:flutter/material.dart';
import 'package:tamizshahr/models/driver_data.dart';
import 'package:tamizshahr/models/status.dart';

class Driver with ChangeNotifier {
  final Status status;
  final Status car;
  final Status car_color;
  final String car_number;
  final DriverData driver_data;

  Driver({
    this.status,
    this.car,
    this.car_color,
    this.car_number,
    this.driver_data,
  });

  factory Driver.fromJson(Map<String, dynamic> parsedJson) {
    return Driver(
      status: parsedJson['status'] != null
          ? Status.fromJson(parsedJson['status'])
          : Status(term_id: 0, name: '', slug: ''),
      car: parsedJson['car'] != null
          ? Status.fromJson(parsedJson['car'])
          : Status(term_id: 0, name: '', slug: ''),
      car_color: parsedJson['car_color'] != null
          ? Status.fromJson(parsedJson['car_color'])
          : Status(term_id: 0, name: '', slug: ''),
      car_number:
      parsedJson['car_number'] != null ? parsedJson['car_number'] : '',
      driver_data: parsedJson['driver_data'] != null
          ? DriverData.fromJson(parsedJson['driver_data'])
          : DriverData(),
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
