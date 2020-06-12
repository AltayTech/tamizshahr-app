import 'package:flutter/foundation.dart';
import '../models/article.dart';

import '../models/product.dart';
import '../models/search_detail.dart';

class ArticleMain with ChangeNotifier {
  final SearchDetail articlesDetail;

  final List<Article> articles;

  ArticleMain({this.articlesDetail, this.articles});

  factory ArticleMain.fromJson(Map<String, dynamic> parsedJson) {
    var articlesList = parsedJson['data'] as List;
    List<Article> articlesRaw = new List<Article>();

    articlesRaw = articlesList.map((i) => Article.fromJson(i)).toList();

    return ArticleMain(
      articlesDetail: SearchDetail.fromJson(parsedJson['details']),
      articles: articlesRaw,
    );
  }
}
