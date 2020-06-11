import 'package:flutter/material.dart';

import '../status.dart';
import 'address.dart';
import 'collect.dart';

class RequestWasteItem with ChangeNotifier {
  final int id;
  final Status status;
  final String total_price;
  final String total_weight;
  final String total_number;
  final String collect_day;
  final String collect_hours;
  final String collect_hour_exact;
  final Address address;
  final List<Collect> collect_list;

  RequestWasteItem({
    this.id,
    this.status,
    this.total_price,
    this.total_weight,
    this.total_number,
    this.collect_day,
    this.collect_hours,
    this.collect_hour_exact,
    this.address,
    this.collect_list,
  });

  factory RequestWasteItem.fromJson(Map<String, dynamic> parsedJson) {
    var collectList = parsedJson['collect_list'] as List;
    List<Collect> collectRaw =
        collectList.map((i) => Collect.fromJson(i)).toList();

    return RequestWasteItem(
      id: parsedJson['id'],
      status: Status.fromJson(parsedJson['status']),
      total_price: parsedJson['total_price'],
      total_weight: parsedJson['total_weight'],
      total_number: parsedJson['total_number'],
      collect_day: parsedJson['collect_day'],
      collect_hours: parsedJson['collect_hours'],
      collect_hour_exact: parsedJson['collect_hour_exact']!=null?parsedJson['collect_hour_exact']:'',
      address: Address.fromJson(parsedJson['address']),
      collect_list: collectRaw,
    );
  }

  Map<String, dynamic> toJson() {
    Map address = this.address != null ? this.address.toJson() : null;
    Map status = this.status != null ? this.status.toJson() : null;

    List<Map> collect_list = this.collect_list != null
        ? this.collect_list.map((i) => i.toJson()).toList()
        : null;

    return {
      'id': id,
      'status': status,
      'total_price': total_price,
      'total_weight': total_weight,
      'total_number': total_number,
      'collect_day': collect_day,
      'collect_hours': collect_hours,
      'collect_hour_exact': collect_hour_exact,
      'address_data': address,
      'collect_list': collect_list,
    };
  }
}
