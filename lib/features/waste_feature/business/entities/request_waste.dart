import 'package:flutter/material.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/collect.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/collect_time.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/request_address.dart';


class RequestWaste with ChangeNotifier {
  final CollectTime collect_date;
  final RequestAddress address_data;
  final List<Collect> collect_list;

  RequestWaste({
    required this.collect_date,
    required this.address_data,
    required this.collect_list,
  });

  factory RequestWaste.fromJson(Map<String, dynamic> parsedJson) {
    var collectList = parsedJson['collect_list'] as List;
    List<Collect> collectRaw =
        collectList.map((i) => Collect.fromJson(i)).toList();

    return RequestWaste(
      collect_date: CollectTime.fromJson(parsedJson['collect_date']),
      address_data: RequestAddress.fromJson(parsedJson['address_data']),
      collect_list: collectRaw,
    );
  }

  Map<String, dynamic> toJson() {
    Map? collect_date =
        this.collect_date != null ? this.collect_date.toJson() : null;
    Map? address_data =
        this.address_data != null ? this.address_data.toJson() : null;

    List<Map>? collect_list = this.collect_list != null
        ? this.collect_list.map((i) => i.toJson()).toList()
        : null;

    return {
      'collect_date': collect_date,
      'address_data': address_data,
      'collect_list': collect_list,
    };
  }
}
