import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamizshahr/models/charity.dart';
import 'package:tamizshahr/provider/charity_main.dart';

import '../models/search_detail.dart';
import 'urls.dart';

class Charities with ChangeNotifier {
  List<Charity> _charitiesItems = [];
  SearchDetail _searchDetails = SearchDetail(max_page: 1, total: 10);

  late Charity _item;

  String searchEndPoint = '';

  String searchKey = '';
  var _sPage = 1;
  var _sPerPage = 10;

  String _token = '';

  void searchBuilder() {
    if (!(searchKey == '')) {
      searchEndPoint = '';

      searchEndPoint = searchEndPoint + '?search=$searchKey';
      searchEndPoint = searchEndPoint + '&page=$_sPage&per_page=$_sPerPage';
    } else {
      searchEndPoint = '';

      searchEndPoint = searchEndPoint + '?page=$_sPage&per_page=$_sPerPage';
    }

    debugPrint(searchEndPoint);
  }

  Future<void> searchCharitiesItem() async {
    debugPrint('searchCharityItem');

    final url = Urls.rootUrl + Urls.charitiesEndPoint + searchEndPoint;
    debugPrint(url);

    try {
      final response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        debugPrint(extractedData);
        CharityMain charityMain = CharityMain.fromJson(extractedData);

        _charitiesItems = charityMain.charities;
        _searchDetails = charityMain.charitiesDetail;
      } else {
        _charitiesItems = [];
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }

  Future<void> retrieveCharityItem(int charityId) async {
    debugPrint('retrieveCharityItemvvvvv');

    final url = Urls.rootUrl + Urls.charitiesEndPoint + "/$charityId";
    debugPrint(url);

    try {
      final response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      final extractedData = json.decode(response.body) as dynamic;
      debugPrint(extractedData);

      Charity charity = Charity.fromJson(extractedData);
      debugPrint(charity.id.toString());

      _item = charity;
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
    notifyListeners();
  }

  List<Charity> get charitiesItems => _charitiesItems;

  set sPerPage(value) {
    _sPerPage = value;
  }

  set sPage(value) {
    _sPage = value;
  }

  SearchDetail get searchDetails => _searchDetails;

  get sPage => _sPage;

  get sPerPage => _sPerPage;

  Charity get item => _item;

  Future<void> sendCharityRequest(int charityId, String totalPrice) async {
    debugPrint('sendCharityRequest');
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token')!;
      debugPrint('tooookkkeeennnnnn  $_token');

      final url = Urls.rootUrl + Urls.charitiesEndPoint;
      debugPrint('url  $url');
      debugPrint(jsonEncode({
        "charity_id": charityId,
        "total_price": totalPrice,
      }));

      final response = await post(Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({
            "charity_id": charityId,
            "total_price": totalPrice,
          }));

      final extractedData = json.decode(response.body);
      debugPrint(extractedData);

      debugPrint('qqqqqqqqqqqqqqggggggggq11111111111');

      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }
}
