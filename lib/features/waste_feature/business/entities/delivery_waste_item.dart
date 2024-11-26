import 'package:flutter/material.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/collect.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/collect_status.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/pasmand.dart';

import '../../../../models/status.dart';

class DeliveryWasteItem with ChangeNotifier {
  final int id;
  final Status status;
  final CollectStatus total_collects_price;
  final CollectStatus total_collects_weight;
  final CollectStatus total_collects_number;
  final Pasmand store;
  final Pasmand driver;
  final Pasmand operator;

  final String delivery_date;
  final List<Collect> collect_list;

  DeliveryWasteItem({
    this.id = 1,
    required this.status,
    required this.total_collects_price,
    required this.total_collects_weight,
    required this.total_collects_number,
    required this.store,
    required this.driver,
    required this.operator,
    required this.delivery_date,
    required this.collect_list,
  });

  factory DeliveryWasteItem.fromJson(Map<String, dynamic> parsedJson) {
    List<Collect> collectRaw = [];
    if (parsedJson['collect_list'] != null) {
      var collectList = parsedJson['collect_list'] as List;
      collectRaw = collectList.map((i) => Collect.fromJson(i)).toList();
    }
    return DeliveryWasteItem(
      id: parsedJson['id'],
      status: parsedJson['status'] != null
          ? Status.fromJson(parsedJson['status'])
          : Status(term_id: 0, name: '0', slug: '0'),
      total_collects_price: parsedJson['total_collects_price'] != null
          ? CollectStatus.fromJson(parsedJson['total_collects_price'])
          : CollectStatus(estimated: '0', exact: '0'),
      total_collects_weight: parsedJson['total_collects_weight'] != null
          ? CollectStatus.fromJson(parsedJson['total_collects_weight'])
          : CollectStatus(estimated: '0', exact: '0'),
      total_collects_number: parsedJson['total_collects_number'] != null
          ? CollectStatus.fromJson(parsedJson['total_collects_number'])
          : CollectStatus(estimated: '0', exact: '0'),
      store: parsedJson['store'] != null
          ? Pasmand.fromJson(parsedJson['store'])
          : Pasmand(id: 0, post_title: ''),
      driver: parsedJson['driver'] != null
          ? Pasmand.fromJson(parsedJson['driver'])
          : Pasmand(id: 0, post_title: ''),
      operator: parsedJson['operator'] != null
          ? Pasmand.fromJson(parsedJson['operator'])
          : Pasmand(id: 0, post_title: ''),
      delivery_date: parsedJson['delivery_date'] != null
          ? parsedJson['delivery_date']
          : '',
      collect_list: collectRaw,
    );
  }

  Map<String, dynamic> toJson() {
    Map? status = this.status.toJson();
    Map? driver = this.driver.toJson();
    Map? total_price = this.total_collects_price.toJson();
    Map? total_weight = this.total_collects_weight.toJson();
    Map? total_number = this.total_collects_number.toJson();

    List<Map>? collect_list = this.collect_list.map((i) => i.toJson()).toList();

    return {
      'id': id,
      'status': status,
      'total_price': total_price,
      'total_weight': total_weight,
      'total_number': total_number,
      'delivery_date': delivery_date,
      'collect_list': collect_list,
      'driver': driver,
    };
  }
}
