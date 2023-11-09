import 'package:flutter/foundation.dart';

import 'article.dart';
import '../search_detail.dart';

class ArticleMain with ChangeNotifier {
  final SearchDetail articlesDetail;

  final List<Article> articles;

  ArticleMain({
    required this.articlesDetail,
    required this.articles,
  });

  factory ArticleMain.fromJson(Map<String, dynamic> parsedJson) {
    var articlesList = parsedJson['data'] as List;
    List<Article> articlesRaw = [];

    articlesRaw = articlesList.map((i) => Article.fromJson(i)).toList();

    return ArticleMain(
      articlesDetail: SearchDetail.fromJson(parsedJson['details']),
      articles: articlesRaw,
    );
  }
}
