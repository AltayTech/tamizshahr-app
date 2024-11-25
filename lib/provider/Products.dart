import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';
import '../models/color_code_card.dart';
import '../models/color_code_product_detail.dart';
import '../models/order_send_details.dart';
import '../models/product.dart';
import '../models/product_cart.dart';
import '../models/product_main.dart';
import '../models/search_detail.dart';
import 'urls.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<ProductCart> _cartItems = [];
  List<Category> _categoryItems = [];
  List<String> filterTitle = [];

  String searchEndPoint = '';

  String searchKey = '';
  var _sPage = 1;
  var _sPerPage = 10;
  var _sOrder = 'desc';
  var _sOrderBy = 'date';

  var _sCategory;

  set cartItems(List<ProductCart> value) {
    _cartItems = value;
  }

  bool _isFiltered = false;

  SearchDetail _searchDetails = SearchDetail(max_page: 1, total: 10);

  Future<void> checkFiltered() async {
    if (_sCategory == '') {
      _isFiltered = false;
    } else {
      _isFiltered = true;
    }
  }

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

  static Product _itemZero = Product();
  Product _item = _itemZero;

  late String _token;

  List<Product> get items {
    return _items;
  }

  int get cartItemsCount {
    return _cartItems.length;
  }

  Product get item {
    return _item;
  }

  List<ProductCart> get cartItems {
    return _cartItems;
  }

  get sCategory => _sCategory;

  set sCategory(value) {
    _sCategory = value;
  }

  Future<void> addShopCart(
    Product product,
    ColorCodeProductDetail colorId,
    int quantity,
  ) async {
    debugPrint('addShopCart');
    try {
      _cartItems.add(ProductCart(
          id: product.id,
          title: product.name,
          price: product.price,
          featured_media_url: product.featured_image.sizes.medium,
          productCount: quantity));
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }

  Future<void> updateShopCart(ProductCart product, ColorCodeCard colorId,
      int quantity, bool isLogin) async {
    debugPrint('updateShopCart');
    try {
      _cartItems.firstWhere((prod) => prod.id == product.id).productCount =
          quantity;
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }

  Future<void> removeShopCart(int productId) async {
    debugPrint('removeShopCart');

    try {
      _cartItems.remove(_cartItems.firstWhere((prod) => prod.id == productId));
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }

  Product findById() {
    return _item;
  }

  Future<void> retrieveCategory() async {
    debugPrint('fetchAndSetHomeData');

    final url = Urls.rootUrl + Urls.categoriesEndPoint;
    debugPrint(url);

    try {
      final response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final extractedData = json.decode(response.body) as List<dynamic>;
      debugPrint(extractedData.toString());

      List<Category> categories =
          extractedData.map((i) => Category.fromJson(i)).toList();
      debugPrint(categories[0].name);

      _categoryItems = categories;
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> searchItem() async {
    debugPrint('searchItem');

    final url = Urls.rootUrl + Urls.productsEndPoint + '$searchEndPoint';
    debugPrint(url);

    try {
      final response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        debugPrint(extractedData.toString());

        ProductMain productMain = ProductMain.fromJson(extractedData);
        debugPrint(productMain.productsDetail.max_page.toString());

        _items = productMain.products;
        _searchDetails = productMain.productsDetail;
      } else {
        _items = [];
      }
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      // throw (error);
    }
  }

  Future<void> retrieveItem(int productId) async {
    debugPrint('retrieveItem');

    final url = Urls.rootUrl + Urls.productsEndPoint + "/$productId";
    debugPrint(url);

    try {
      final response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      final extractedData = json.decode(response.body) as dynamic;
      debugPrint(extractedData);

      Product product = Product.fromJson(extractedData);
      debugPrint(product.id.toString());
      debugPrint(product.description.toString());

      _item = product;
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
    notifyListeners();
  }

  set sPerPage(value) {
    _sPerPage = value;
  }

  set sOrder(value) {
    _sOrder = value;
  }

  set sOrderBy(value) {
    _sOrderBy = value;
  }

  set sPage(value) {
    _sPage = value;
  }

  bool get isFiltered => _isFiltered;

  SearchDetail get searchDetails => _searchDetails;

  set item(Product value) {
    _item = value;
  }

  Product get itemZero => _itemZero;

  List<Category> get categoryItems => _categoryItems;

  Future<void> sendRequest(
    OrderSendDetails request,
  ) async {
    debugPrint('sendRequestOrder');
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token')!;
      debugPrint('tooookkkeeennnnnn  $_token');

      final url = Urls.rootUrl + Urls.orderEndPoint;
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
      debugPrint(extractedData);

      debugPrint('qqqqqqqqqqqqqqggggggggq11111111111');

      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      throw (error);
    }
  }
}
