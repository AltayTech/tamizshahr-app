import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/article.dart';
import 'package:tamizshahr/provider/articles.dart';
import 'package:tamizshahr/screens/article_detail_screen.dart';

import '../provider/Products.dart';
import '../provider/app_theme.dart';
import '../screens/product_detail_screen.dart';

class ArticleItemArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final article = Provider.of<Article>(context, listen: false);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Container(
      height: widthDevice * 0.45,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return InkWell(
            onTap: () {
//              Provider.of<Articles>(context, listen: false).item =
//                  Provider.of<Articles>(context, listen: false).itemZero;
              Navigator.of(context).pushNamed(
                ArticleDetailScreen.routeName,
                arguments: article.id,
              );
            },
            child: Card(
              child: Container(
                height: constraints.maxHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FadeInImage(
                                placeholder:
                                    AssetImage('assets/images/circle.gif'),
                                image: NetworkImage(
                                    article.featured_image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              article.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppTheme.black,
                                fontFamily: 'Iransans',
//                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 16.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
//                                    FittedBox(child: priceWidget()),
                                    Text(
                                      article.category[0].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppTheme.primary,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor *13.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
