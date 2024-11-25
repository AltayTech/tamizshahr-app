import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tamizshahr/models/article/article_main.dart';

import '../models/article/article.dart';
import '../models/category.dart';
import '../models/search_detail.dart';
import 'urls.dart';

class Articles with ChangeNotifier {
  List<Article> _articleItems = [];
  List<int> _wasteCartItemsId = [];
  SearchDetail _searchDetails = SearchDetail(max_page: 1, total: 10);

  late Article _item;

  String searchEndPoint = '';

  String searchKey = '';
  var _sPage = 1;
  var _sPerPage = 10;

  var _sCategory;

  List<Category> _categoryItems = [];

  void searchBuilder() {
    if (!(searchKey == '')) {
      searchEndPoint = '';

      searchEndPoint = searchEndPoint + '?search=$searchKey';
      searchEndPoint = searchEndPoint + '&page=$_sPage&per_page=$_sPerPage';
    } else {
      searchEndPoint = '';

      searchEndPoint = searchEndPoint + '?page=$_sPage&per_page=$_sPerPage';
    }

    if (!(_sCategory == '' || _sCategory == null)) {
      searchEndPoint = searchEndPoint + '&cat=$_sCategory';
    }
    print(searchEndPoint);
  }

  get sCategory => _sCategory;

  set sCategory(value) {
    _sCategory = value;
  }

  Future<void> searchItem() async {
    print('searchItem');

    final url = Urls.rootUrl + Urls.articlesEndPoint + searchEndPoint;
    print(url);

    try {
      final response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        print(extractedData);
        ArticleMain articleMain = ArticleMain.fromJson(extractedData);

        _articleItems = articleMain.articles;
        _searchDetails = articleMain.articlesDetail;
      } else {
        _articleItems = [];
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      // throw (error);
    }
  }

  Future<void> retrieveCategory() async {
    print('retrieveCategory');

    final url = Urls.rootUrl + Urls.articlesCatEndPoint;
    print(url);

    try {
      final response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final extractedData = json.decode(response.body) as List<dynamic>;
      print(extractedData);

      List<Category> categories =
          extractedData.map((i) => Category.fromJson(i)).toList();

      _categoryItems = categories;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      // throw (error);
    }
  }

  Future<void> retrieveItem(int articleId) async {
    print('retrieveItem');

    final url = Urls.rootUrl + Urls.articlesEndPoint + "/$articleId";
    print(url);

    try {
      final response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      final extractedData = json.decode(response.body) as dynamic;
      print(extractedData);

      Article article = Article.fromJson(extractedData);
      print(article.id.toString());

      _item = article;
    } catch (error) {
      print(error.toString());
      throw (error);
    }
    notifyListeners();
  }

  set sPerPage(value) {
    _sPerPage = value;
  }

  set sPage(value) {
    _sPage = value;
  }

  Article get item => _item;

  SearchDetail get searchDetails => _searchDetails;

  List<Category> get categoryItems => _categoryItems;

  List<int> get wasteCartItemsId => _wasteCartItemsId;

  List<Article> get articleItems => _articleItems;

  get sPage => _sPage;

  get sPerPage => _sPerPage;
}
