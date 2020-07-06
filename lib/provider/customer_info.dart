import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamizshahr/models/city.dart';
import 'package:tamizshahr/models/province.dart';
import 'package:tamizshahr/models/search_detail.dart';
import 'package:tamizshahr/models/status.dart';
import 'package:tamizshahr/models/transaction.dart';
import 'package:tamizshahr/models/transaction_main.dart';

import '../models/customer.dart';
import '../models/order.dart';
import '../models/order_details.dart';
import '../models/personal_data.dart';
import '../models/shop.dart';
import 'urls.dart';

class CustomerInfo with ChangeNotifier {
  String _payUrl = '';

  int _currentOrderId;

  Shop _shop;

  String get payUrl => _payUrl;
  List<File> chequeImageList = [];

  static Customer _customer_zero = Customer(
    personalData: PersonalData(
      first_name: '',
      last_name: '',
      email: '',
      ostan: '',
      city: '',
//      address: '',
      postcode: '',
      phone: '',
    ),
    money: '0',
  );
  Customer _customer = _customer_zero;
  String _token;

  Customer get customer => _customer;

  List<Order> _orders = [];

  OrderDetails _order;

  List<Order> get orders => _orders;

  Future<void> getCustomer() async {
    print('getCustomer');

    final url = Urls.rootUrl + Urls.customerEndPoint;
    print(url);

    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');

    print(_token);

    Customer customers;
    try {
      final response = await get(url, headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final extractedData = json.decode(response.body);
      print(extractedData);

      customers = Customer.fromJson(extractedData);

      _customer = customers;

      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> sendCustomer(Customer customer) async {
    print('sendCustomer');

    final url = Urls.rootUrl + Urls.customerEndPoint;

    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');
    print(jsonEncode(customer));

    try {
      final response = await post(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(customer),
      );

      final extractedData = json.decode(response.body);
      print(extractedData);
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Order findById(int id) {
    return _orders.firstWhere((prod) => prod.id == id);
  }

  OrderDetails getOrder() {
    return _order;
  }

  Future<void> getOrderDetails(int orderId) async {
    print('getOrderDetails');
    print(orderId.toString());

    _currentOrderId = orderId;

    final url = Urls.rootUrl + Urls.orderInfoEndPoint + '?order_id=$orderId';

    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');

    OrderDetails orderDetails;
    try {
      final response = await get(url, headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final extractedData = json.decode(response.body);

      orderDetails = OrderDetails.fromJson(extractedData);

      _order = orderDetails;
      print(extractedData.toString());

      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> payCashOrder(int orderId) async {
    print('payCashOrder');

    final url = Urls.rootUrl + Urls.payEndPoint + '?order_id=$orderId';

    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');

    try {
      final response = await get(url, headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final extractedData = json.decode(response.body);
      print(extractedData.toString());

      _payUrl = extractedData;
      print(extractedData.toString());

      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> sendNaghdOrder() async {
    print('sendNaghdOrder');

    final url = Urls.rootUrl + Urls.orderInfoEndPoint + '?paytype=naghd';

    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');

    try {
      final response = await post(url, headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final extractedData = json.decode(response.body);
      print(extractedData);

      int orderId = extractedData['order_id'];
      _currentOrderId = orderId;

      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> fetchShopData() async {
    print('fetchShopData');

    final url = Urls.rootUrl + Urls.shopEndPoint;
    print(url);

    try {
      final response = await get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final extractedData = json.decode(response.body) as dynamic;
      print(extractedData);

      Shop shopData = Shop.fromJson(extractedData);

      _shop = shopData;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  int get currentOrderId => _currentOrderId;

  set customer(Customer value) {
    _customer = value;
  }

  set order(OrderDetails value) {
    _order = value;
  }

  Customer get customer_zero => _customer_zero;

  Shop get shop => _shop;

  String searchEndPoint = '';
  String searchKey = '';
  var _sPage = 1;
  var _sPerPage = 10;
  var _sOrder = 'desc';
  var _sOrderBy = 'date';

  List<Transaction> _transactionItems = [];

  SearchDetail _searchDetails;
  Transaction _transactionItem;

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

    print(searchEndPoint);
  }

  Future<void> searchTransactionItems() async {
    print('searchTransactionItems');

    final url = Urls.rootUrl + Urls.transactionsEndPoint + '$searchEndPoint';
    print(url);
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');

    try {
      final response = await get(url, headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        print(extractedData.toString());

        TransactionMain transactionMain =
        TransactionMain.fromJson(extractedData);
        print(transactionMain.searchDetail.max_page.toString());

        _transactionItems = transactionMain.transactions;
        _searchDetails = transactionMain.searchDetail;
      } else {
        _transactionItems = [];
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> retrieveItem(int collectId) async {
    print('retrieveItem');

    final url = Urls.rootUrl + Urls.collectsEndPoint + "/$collectId";
    print(url);

    try {
      final response = await get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      final extractedData = json.decode(response.body) as dynamic;
      print(extractedData);

      Transaction transaction = Transaction.fromJson(extractedData);

      _transactionItem = transaction;
    } catch (error) {
      print(error.toString());
      throw (error);
    }
    notifyListeners();
  }

  Transaction get transactionItem => _transactionItem;

  SearchDetail get searchDetails => _searchDetails;

  List<Transaction> get transactionItems => _transactionItems;

  get sOrderBy => _sOrderBy;

  get sOrder => _sOrder;

  get sPerPage => _sPerPage;

  get sPage => _sPage;

  OrderDetails get order => _order;

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

  Future<void> getProvinces() async {
    print('getProvinces');

    final url = Urls.rootUrl + Urls.provincesEndPoint;
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

        List<Province> wastes =
        extractedData.map((i) => Province.fromJson(i)).toList();

        _provincesItems = wastes;
      } else {
        _provincesItems = [];
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  List<Province> _provincesItems = [];

  List<Province> get provincesItems => _provincesItems;

  Future<void> getCities(int provinceId) async {
    print('getCities');

    final url = Urls.rootUrl + Urls.provincesEndPoint + '$provinceId';
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

        List<City> wastes = extractedData.map((i) => City.fromJson(i)).toList();

        _citiesItems = wastes;
      } else {
        _citiesItems = [];
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  List<City> _citiesItems = [];

  List<City> get citiesItems => _citiesItems;

  Future<void> getTypes() async {
    print('getTypes');

    final url = Urls.rootUrl + Urls.typesEndPoint;
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

        List<Status> wastes =
        extractedData.map((i) => Status.fromJson(i)).toList();

        _typesItems = wastes;
      } else {
        _typesItems = [];
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  List<Status> _typesItems = [];

  List<Status> get typesItems => _typesItems;


  Future<void> sendClearingRequest(String money,String shaba) async {
    print('sendCharityRequest');
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      print('tooookkkeeennnnnn  $_token');

      final url = Urls.rootUrl + Urls.clearingEndPoint;
      print('url  $url');
      print(jsonEncode({
        "money": money,
      }));

      final response = await post(url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({
            "money": money,
            'shaba':shaba
          }));

      final extractedData = json.decode(response.body);
      print(extractedData);

      print('qqqqqqqqqqqqqqggggggggq11111111111');

      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }
}


