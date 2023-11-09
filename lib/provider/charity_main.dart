import 'package:flutter/foundation.dart';

import '../models/charity.dart';
import '../models/search_detail.dart';

class CharityMain with ChangeNotifier {
  final SearchDetail charitiesDetail;

  final List<Charity> charities;

  CharityMain({
    required this.charitiesDetail,
    required this.charities,
  });

  factory CharityMain.fromJson(Map<String, dynamic> parsedJson) {
    var charitiesList = parsedJson['data'] as List;
    List<Charity> charitiesRaw = [];

    charitiesRaw = charitiesList.map((i) => Charity.fromJson(i)).toList();

    return CharityMain(
      charitiesDetail: SearchDetail.fromJson(parsedJson['details']),
      charities: charitiesRaw,
    );
  }
}
