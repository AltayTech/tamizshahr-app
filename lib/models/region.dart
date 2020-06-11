import 'package:flutter/material.dart';
import 'file:///C:/AndroidStudioProjects/pasmand/tamiz_shahr/lib/models/request/collect_hour.dart';

class Region with ChangeNotifier {
  final int term_id;
  final String name;
  final List<CollectHour> collect_hour;

  Region({
    this.term_id,
    this.name,
    this.collect_hour,
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
    );
  }
  Map<String, dynamic> toJson() {

    List<Map> collect_hour =
    this.collect_hour != null ? this.collect_hour.map((i) => i.toJson()).toList() : null;

    return {
      'term_id' : term_id,
      'name' : name,
      'collect_hour':collect_hour,
   };
  }
}
