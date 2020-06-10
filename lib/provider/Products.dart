import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamizshahr/models/category.dart';

import '../models/color_code_card.dart';
import '../models/color_code_product_detail.dart';
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
    print(searchEndPoint);
  }

  static Product _itemZero = Product();
  Product _item = _itemZero;

  String _token;

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

  Future<void> addShopCart(Product product, ColorCodeProductDetail colorId,
      int quantity, bool isLogin) async {
    print('addShopCart');
    try {
      if (isLogin) {
        final prefs = await SharedPreferences.getInstance();
        print(product..toString());

        _token = prefs.getString('token');

        final url = Urls.rootUrl +
            Urls.cartEndPoint +
            '?product_id=${product.id}&action=add&color_id=${colorId.id}&how_many=${quantity}';

        final response = await post(
          url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
        );

        final extractedData = json.decode(response.body);

        print(extractedData.toString());

        _cartItems.add(ProductCart(
          id: product.id,
          title: product.name,
          price: colorId.price,
//          brand: Brandc(
//              id: product.brand[0].id,
//              title: product.brand[0].title,
//              img_url: product.brand[0].brand_img_url),
          featured_media_url: product.featured_image.sizes.medium,
          color_selected: ColorCodeCard(
              id: colorId.id,
              color_code: colorId.colorCode,
              title: colorId.title),
          productCount: quantity,
        ));
      } else {
        _cartItems.add(ProductCart(
            id: product.id,
            title: product.name,
            price: colorId.price,
//            brand: Brandc(
//                id: product.brand[0].id,
//                title: product.brand[0].title,
//                img_url: product.brand[0].brand_img_url),
            featured_media_url: product.featured_image.sizes.medium,
            color_selected: ColorCodeCard(
                id: colorId.id,
                color_code: colorId.colorCode,
                title: colorId.title),
            productCount: quantity));
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> updateShopCart(ProductCart product, ColorCodeCard colorId,
      int quantity, bool isLogin) async {
    print('updateShopCart');
    try {
      if (isLogin) {
        final prefs = await SharedPreferences.getInstance();
        print(product..toString());

        _token = prefs.getString('token');

        final url = Urls.rootUrl +
            Urls.cartEndPoint +
            '?product_id=${product.id}&action=update&color_id=${colorId.id}&how_many=${quantity}';

        final response = await post(url, headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });

        final extractedData = json.decode(response.body);

        print(extractedData.toString());

        _cartItems.firstWhere((prod) => prod.id == product.id).productCount =
            quantity;
      } else {
        _cartItems.firstWhere((prod) => prod.id == product.id).productCount =
            quantity;
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> addShopCartAfterLogin(bool isLogin) async {
    print('addShopCartAfterLogin');
    List<ProductCart> _shoppItems = _cartItems;
    try {
      if (isLogin) {
        final prefs = await SharedPreferences.getInstance();
        _token = prefs.getString('token');

        for (int i = 0; i <= _shoppItems.length; i++) {
          final url = Urls.rootUrl +
              Urls.cartEndPoint +
              '?product_id=${_shoppItems[i].id}&action=add&color_id=${_shoppItems[i].color_selected.id}&how_many=${_shoppItems[i].productCount}';

          final response = await post(url, headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          });

          final extractedData = json.decode(response.body);
        }
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> retrieveShopCart() async {
    print('retrieveShopCart');

    final url = Urls.rootUrl + Urls.cartEndPoint;
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');

    try {
      final response = await get(url, headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final extractedData = json.decode(response.body) as List;
      print(extractedData);

      List<ProductCart> cartShop = new List<ProductCart>();

      cartShop = extractedData.map((i) => ProductCart.fromJson(i)).toList();
      print(cartShop.length);

      _cartItems = cartShop;

      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> removeShopCart(int productId, int colorId) async {
    print('removeShopCart');

    final url = Urls.rootUrl +
        Urls.cartEndPoint +
        '?product_id=$productId&action=remove&color_id=$colorId';
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');
    if (_token != '') {
      try {
        final response = await post(url, headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
        final extractedData = json.decode(response.body);

        print(extractedData.toString());
        _cartItems
            .remove(_cartItems.firstWhere((prod) => prod.id == productId));
        notifyListeners();
      } catch (error) {
        print(error.toString());
        throw (error);
      }
    } else {
      _cartItems.remove(_cartItems.firstWhere((prod) => prod.id == productId));
      notifyListeners();
    }
  }

  Product findById() {
    return _item;
  }

  Future<void> retrieveCategory() async {
    print('fetchAndSetHomeData');

    final url = Urls.rootUrl + Urls.categoriesEndPoint;
    print(url);

    try {
      final response = await get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final extractedData = json.decode(response.body) as List<dynamic>;
      print(extractedData);

      List<Category> categories =
          extractedData.map((i) => Category.fromJson(i)).toList();
      print(categories[0].name);

      _categoryItems = categories;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> searchItem() async {
    print('searchItem');

    final url = Urls.rootUrl + Urls.productsEndPoint + '$searchEndPoint';
    print(url);

    try {
      final response = await get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        print(extractedData.toString());

        ProductMain productMain = ProductMain.fromJson(extractedData);
        print(productMain.productsDetail.max_page.toString());

        _items = productMain.products;
        _searchDetails = productMain.productsDetail;
      } else {
        _items = [];
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> retrieveItem(int productId) async {
    print('retrieveItem');

    final url = Urls.rootUrl + Urls.productsEndPoint + "/$productId";
    print(url);

    try {
      final response = await get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      final extractedData = json.decode(response.body) as dynamic;
      print(extractedData);

      Product product = Product.fromJson(extractedData);
      print(product.id.toString());
      print(product.description.toString());

      _item = product;
    } catch (error) {
      print(error.toString());
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
}
