import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tamizshahr/models/charity.dart';
import 'package:tamizshahr/models/charity_main.dart';

import '../models/search_detail.dart';
import 'urls.dart';

class Charities with ChangeNotifier {
  List<Charity> _charitiesItems = [];
  SearchDetail _searchDetails = SearchDetail(max_page: 1, total: 10);

  Charity _item;

  String searchEndPoint = '';

  String searchKey = '';
  var _sPage = 1;
  var _sPerPage = 10;

  void searchBuilder() {
    if (!(searchKey == '')) {
      searchEndPoint = '';

      searchEndPoint = searchEndPoint + '?search=$searchKey';
      searchEndPoint = searchEndPoint + '&page=$_sPage&per_page=$_sPerPage';
    } else {
      searchEndPoint = '';

      searchEndPoint = searchEndPoint + '?page=$_sPage&per_page=$_sPerPage';
    }

    print(searchEndPoint);
  }

  Future<void> searchCharitiesItem() async {
    print('searchCharityItem');

    final url = Urls.rootUrl + Urls.charitiesEndPoint + searchEndPoint;
    print(url);

    try {
      final response = await get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        print(extractedData);
        CharityMain charityMain = CharityMain.fromJson(extractedData);

        _charitiesItems = charityMain.charities;
        _searchDetails = charityMain.charitiesDetail;
      } else {
        _charitiesItems = [];
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> retrieveCharityItem(int charityId) async {
    print('retrieveCharityItemvvvvv');

    final url = Urls.rootUrl + Urls.charitiesEndPoint + "/$charityId";
    print(url);

    try {
      final response = await get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      final extractedData = json.decode(response.body) as dynamic;
      print(extractedData);

      Charity charity = Charity.fromJson(extractedData);
      print(charity.id.toString());

      _item = charity;
    } catch (error) {
      print(error.toString());
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
}
