import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/request/collect_main.dart';
import '../models/request/request_waste.dart';
import '../models/request/request_waste_item.dart';
import '../models/request/waste.dart';
import '../models/request/wasteCart.dart';
import '../models/search_detail.dart';
import 'urls.dart';

class Wastes with ChangeNotifier {
  List<Waste> _wasteItems = [];
  List<WasteCart> _wasteCartItems = [];
  List<int> _wasteCartItemsId = [];
  late String _token;

  List<RequestWasteItem> _collectItems = [];

  late SearchDetail _searchDetails;

  late RequestWasteItem _requestWasteItem;

  Future<void> searchWastesItem() async {
    debugPrint('searchItem');

    final url = Urls.rootUrl + Urls.pasmandsEndPoint;
    debugPrint(url);

    try {
      final response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        debugPrint(extractedData.toString());

        List<Waste> wastes =
            extractedData.map((i) => Waste.fromJson(i)).toList();

        _wasteItems = wastes;
      } else {
        _wasteItems = [];
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }

  Future<void> addWasteCart(Waste waste, int weight) async {
    debugPrint('addWasteCart');
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
      debugPrint(error.toString());
      throw (error);
    }
  }

  Future<void> updateWasteCart(WasteCart waste, int quantity) async {
    debugPrint('updateShopCart');
    try {
      _wasteCartItems.firstWhere((prod) => prod.id == waste.id).weight =
          quantity;
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }

  Future<void> removeWasteCart(int wasteId) async {
    debugPrint('removeShopCart');

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
    debugPrint('sendRequest');
    try {
      if (isLogin) {
        final prefs = await SharedPreferences.getInstance();
        _token = prefs.getString('token')!;
        debugPrint('tooookkkeeennnnnn  $_token');

        final url = Urls.rootUrl + Urls.collectsEndPoint;
        debugPrint('url  $url');
        debugPrint(jsonEncode(request));

        final response = await post(Uri.parse(url),
            headers: {
              'Authorization': 'Bearer $_token',
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            body: jsonEncode(request));

        final extractedData = json.decode(response.body);
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }

  late String _selectedHours;
  late Jalali _selectedDay;

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
    debugPrint(searchEndPoint);
  }

  Future<void> searchCollectItems() async {
    debugPrint('searchCollectItems');

    final url = Urls.rootUrl + Urls.collectsEndPoint + '$searchEndPoint';
    debugPrint(url);

    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token')!;
      debugPrint('tooookkkeeennnnnn  $_token');

      final response = await get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        debugPrint(extractedData.toString());

        CollectMain collectMain = CollectMain.fromJson(extractedData);
        debugPrint(collectMain.searchDetail.max_page.toString());

        _collectItems = collectMain.requestWasteItem;
        _searchDetails = collectMain.searchDetail;
      } else {
        _collectItems = [];
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }

  Future<void> retrieveCollectItem(int collectId) async {
    debugPrint('retrieveCollectItem');

    final url = Urls.rootUrl + Urls.collectsEndPoint + "/$collectId";
    debugPrint(url);

    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token')!;
      debugPrint('tooookkkeeennnnnn  $_token');

      final response = await get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      final extractedData = json.decode(response.body) as dynamic;
      debugPrint(extractedData);

      RequestWasteItem requestWasteItem =
          RequestWasteItem.fromJson(extractedData);
      debugPrint(requestWasteItem.id.toString());

      _requestWasteItem = requestWasteItem;
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
    notifyListeners();
  }

  get sCategory => _sCategory;

  get sOrderBy => _sOrderBy;

  get sOrder => _sOrder;

  get sPerPage => _sPerPage;

  get sPage => _sPage;

  RequestWasteItem get requestWasteItem => _requestWasteItem;

  SearchDetail get searchDetails => _searchDetails;

  List<RequestWasteItem> get CollectItems => _collectItems;

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
}
