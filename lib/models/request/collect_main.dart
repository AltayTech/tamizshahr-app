import 'package:flutter/foundation.dart';
import '../../models/request/request_waste_item.dart';

import '../search_detail.dart';

class CollectMain with ChangeNotifier {
  final SearchDetail searchDetail;

  final List<RequestWasteItem> requestWasteItem;

  CollectMain({this.searchDetail, this.requestWasteItem});

  factory CollectMain.fromJson(Map<String, dynamic> parsedJson) {
    var productsList = parsedJson['data'] as List;
    List<RequestWasteItem> collectRaw = new List<RequestWasteItem>();

    collectRaw =
        productsList.map((i) => RequestWasteItem.fromJson(i)).toList();

    return CollectMain(
      searchDetail: SearchDetail.fromJson(parsedJson['details']),
      requestWasteItem: collectRaw,
    );
  }
}
