import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamizshahr/models/request_waste.dart';

import '../models/waste.dart';
import '../models/wasteCart.dart';
import 'urls.dart';

class Wastes with ChangeNotifier {
  List<Waste> _wasteItems = [];
  List<WasteCart> _wasteCartItems = [];
  List<int> _wasteCartItemsId = [];
  String _token;

  Future<void> searchItem() async {
    print('searchItem');

    final url = Urls.rootUrl + Urls.pasmandsEndPoint;
    print(url);

    try {
      final response = await get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        print(extractedData);

        List<Waste> wastes =
            extractedData.map((i) => Waste.fromJson(i)).toList();

        _wasteItems = wastes;
      } else {
        _wasteItems = [];
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> addWasteCart(Waste waste, int weight) async {
    print('addWasteCart');
    try {
      _wasteCartItems.add(WasteCart(
          id: waste.id,
          name: waste.name,
          excerpt: waste.excerpt,
          prices: waste.prices,
          featured_image: waste.featured_image,
          status: waste.status,
          weight: weight));
      _wasteCartItemsId.add(waste.id);
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> updateWasteCart(WasteCart waste, int quantity) async {
    print('updateShopCart');
    try {
      _wasteCartItems.firstWhere((prod) => prod.id == waste.id).weight =
          quantity;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> removeWasteCart(int wasteId) async {
    print('removeShopCart');

    _wasteCartItems
        .remove(_wasteCartItems.firstWhere((prod) => prod.id == wasteId));
    _wasteCartItemsId
        .remove(_wasteCartItemsId.firstWhere((prod) => prod == wasteId));

    notifyListeners();
  }

  String get token => _token;

  List<WasteCart> get wasteCartItems => _wasteCartItems;

  List<Waste> get wasteItems => _wasteItems;

  List<int> get wasteCartItemsId => _wasteCartItemsId;

  Future<void> sendRequest(RequestWaste request, bool isLogin) async {
    print('sendRequest');
    try {
      if (isLogin) {
        final prefs = await SharedPreferences.getInstance();
        _token = prefs.getString('token');
        print('tooookkkeeennnnnn  $_token');

        final url = Urls.rootUrl + Urls.collectsEndPoint;
        print('url  $url');
        print(jsonEncode(request));

        final response = await post(url,
            headers: {
              'Authorization': 'Bearer $_token',
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            body: jsonEncode(request));

        final extractedData = json.decode(response.body);
        print('qqqqqqqqqqqqqqggggggggq11111111111');
      } else {
        print('qqqqqqqqqqqqqqggggggggq');
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

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
}
