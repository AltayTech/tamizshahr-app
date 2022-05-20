import 'package:flutter/material.dart';

import 'request/collect_hour.dart';

class Region with ChangeNotifier {
  final int term_id;
  final String name;
  final List<CollectHour> collect_hour;
  final String day_num_forward;

  Region({
    this.term_id,
    this.name,
    this.collect_hour,
    this.day_num_forward,
  });

  factory Region.fromJson(Map<String, dynamic> parsedJson) {
    List<CollectHour> hourRaw=[];
    if (parsedJson['collect_hour'] != null) {
      var hourList = parsedJson['collect_hour'] as List;
     hourRaw =
          hourList.map((i) => CollectHour.fromJson(i)).toList();
    };
    return Region(
      term_id: parsedJson['term_id'],
      name: parsedJson['name'],
      collect_hour: hourRaw,
      day_num_forward: parsedJson['day_num_forward']!=null?parsedJson['day_num_forward']:'3',
    );
  }
  Map<String, dynamic> toJson() {

    List<Map> collect_hour =
    this.collect_hour != null ? this.collect_hour.map((i) => i.toJson()).toList() : null;

    return {
      'term_id' : term_id,
      'name' : name,
      'collect_hour':collect_hour,
      'day_num_forward':day_num_forward,
   };
  }
}
