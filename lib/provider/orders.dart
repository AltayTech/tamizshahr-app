import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamizshahr/models/order.dart';
import 'package:tamizshahr/models/order_main.dart';
import 'package:tamizshahr/models/search_detail.dart';

import 'urls.dart';

class Orders with ChangeNotifier {
  late String _token;

  String searchEndPoint = '';
  String searchKey = '';
  var _sPage = 1;
  var _sPerPage = 10;
  var _sOrder = 'desc';
  var _sOrderBy = 'date';

  List<Order> _ordersItems = [];

  late SearchDetail _searchDetails;
  late Order _orderItem;

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

    debugPrint(searchEndPoint);
  }

  Future<void> searchOrderItems() async {
    debugPrint('searchOrderItems');

    final url = Urls.rootUrl + Urls.orderEndPoint + '$searchEndPoint';
    debugPrint(url);
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token')!;

    try {
      final response = await get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        debugPrint(extractedData.toString());

        OrdersMain ordersMain = OrdersMain.fromJson(extractedData);
        debugPrint(ordersMain.searchDetail.max_page.toString());

        _ordersItems = ordersMain.transactions;
        _searchDetails = ordersMain.searchDetail;
      } else {
        _ordersItems = [];
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }

  Future<void> retrieveOrderItem(int ordrId) async {
    debugPrint('retrieveOrderItem');

    final url = Urls.rootUrl + Urls.orderEndPoint + "/$ordrId";
    debugPrint(url);

    try {
      final response = await get(url as Uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      final extractedData = json.decode(response.body) as dynamic;
      debugPrint(extractedData);

      Order order = Order.fromJson(extractedData);

      _orderItem = order;
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
    notifyListeners();
  }

  SearchDetail get searchDetails => _searchDetails;

  List<Order> get ordersItems => _ordersItems;

  get sOrderBy => _sOrderBy;

  get sOrder => _sOrder;

  get sPerPage => _sPerPage;

  get sPage => _sPage;

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

  Order get orderItem => _orderItem;
}
