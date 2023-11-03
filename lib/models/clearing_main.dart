import 'package:flutter/foundation.dart';

import '../models/search_detail.dart';
import 'clearing.dart';

class ClearingMain with ChangeNotifier {
  final SearchDetail searchDetail;

  final List<Clearing> clearings;

  ClearingMain({required this.searchDetail, required this.clearings});

  factory ClearingMain.fromJson(Map<String, dynamic> parsedJson) {
    var clearingsList = parsedJson['data'] as List;
    List<Clearing> clearingsRaw = [];

    clearingsRaw = clearingsList.map((i) => Clearing.fromJson(i)).toList();

    return ClearingMain(
      searchDetail: SearchDetail.fromJson(parsedJson['details']),
      clearings: clearingsRaw,
    );
  }
}
