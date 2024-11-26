import 'package:flutter/foundation.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/request_waste_item.dart';

import '../../../../models/search_detail.dart';

class CollectMain with ChangeNotifier {
  final SearchDetail searchDetail;

  final List<RequestWasteItem> requestWasteItem;

  CollectMain({
    required this.searchDetail,
    required this.requestWasteItem,
  });

  factory CollectMain.fromJson(Map<String, dynamic> parsedJson) {
    var productsList = parsedJson['data'] as List;
    List<RequestWasteItem> collectRaw = [];

    collectRaw = productsList.map((i) => RequestWasteItem.fromJson(i)).toList();

    return CollectMain(
      searchDetail: SearchDetail.fromJson(parsedJson['details']),
      requestWasteItem: collectRaw,
    );
  }
}
