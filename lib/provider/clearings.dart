import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamizshahr/models/clearing.dart';
import 'package:tamizshahr/models/clearing_main.dart';

import '../models/search_detail.dart';
import 'urls.dart';

class Clearings with ChangeNotifier {
  String _token;

  List<Clearing> _deliveriesItems = [];

  SearchDetail _searchDetails;

  String _selectedHours;
  Jalali _selectedDay;

  String get selectedHours => _selectedHours;

  set selectedHours(String value) {
    _selectedHours = value;
  }

  Jalali get selectedDay => _selectedDay;

  set selectedDay(Jalali value) {
    _selectedDay = value;
  }

  String searchEndPoint = '';
  String searchKey = '';
  var _sPage = 1;
  var _sPerPage = 10;
  var _sOrder = 'desc';
  var _sOrderBy = 'date';
  var _sCategory;

  void searchBuilder() {
    if (!(searchKey == '')) {
      searchEndPoint = '';

      searchEndPoint = searchEndPoint + '?search=$searchKey';
      searchEndPoint = searchEndPoint + '&page=$_sPage&per_page=$_sPerPage';
    } else {
      searchEndPoint = '';

      searchEndPoint = searchEndPoint + '?page=$_sPage&per_page=$_sPerPage';
    }
    if (!(_sOrder == '')) {
      searchEndPoint = searchEndPoint + '&order=$_sOrder';
    }
    if (!(_sOrderBy == '')) {
      searchEndPoint = searchEndPoint + '&orderby=$_sOrderBy';
    }

    if (!(_sCategory == '' || _sCategory == null)) {
      searchEndPoint = searchEndPoint + '&category=$_sCategory';
    }
    print(searchEndPoint);
  }

  Future<void> searchCleaingsItems() async {
    print('searchCleaingsItems');

    final url = Urls.rootUrl + Urls.clearingEndPoint + '$searchEndPoint';
    print(url);

    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      print('tooookkkeeennnnnn  $_token');

      final response = await get(url, headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        print(extractedData.toString());

        ClearingMain deliveryMain = ClearingMain.fromJson(extractedData);
        print(deliveryMain.searchDetail.max_page.toString());

        _deliveriesItems = deliveryMain.clearings;
        _searchDetails = deliveryMain.searchDetail;
      } else {
        _deliveriesItems = [];
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  set sCategory(value) {
    _sCategory = value;
  }

  set sOrderBy(value) {
    _sOrderBy = value;
  }

  set sOrder(value) {
    _sOrder = value;
  }

  set sPerPage(value) {
    _sPerPage = value;
  }

  set sPage(value) {
    _sPage = value;
  }

  List<Clearing> get deliveriesItems => _deliveriesItems;

  SearchDetail get searchDetails => _searchDetails;
}
