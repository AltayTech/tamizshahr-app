import 'package:flutter/material.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/collect.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/request_address.dart';


class OrderProducts with ChangeNotifier {
  final String total_price;
  final String total_weight;
  final String total_number;
  final String collect_day;
  final String collect_hours;
  final RequestAddress address_data;
  final List<Collect> collect_list;

  OrderProducts({
    required this.total_price,
    required this.total_weight,
    required this.total_number,
    required this.collect_day,
    required this.collect_hours,
    required this.address_data,
    required this.collect_list,
  });

  factory OrderProducts.fromJson(Map<String, dynamic> parsedJson) {
    var collectList = parsedJson['collect_list'] as List;
    List<Collect> collectRaw =
        collectList.map((i) => Collect.fromJson(i)).toList();

    return OrderProducts(
      total_price: parsedJson['total_price'],
      total_weight: parsedJson['total_weight'],
      total_number: parsedJson['total_number'],
      collect_day: parsedJson['collect_day'],
      collect_hours: parsedJson['collect_hours'],
      address_data: RequestAddress.fromJson(parsedJson['address_data']),
      collect_list: collectRaw,
    );
  }

  Map<String, dynamic> toJson() {
    Map? address_data = this.address_data.toJson();

    List<Map>? collect_list = this.collect_list.map((i) => i.toJson()).toList();

    return {
      'total_price': total_price,
      'total_weight': total_weight,
      'total_number': total_number,
      'collect_day': collect_day,
      'collect_hours': collect_hours,
      'address_data': address_data,
      'collect_list': collect_list,
    };
  }
}
