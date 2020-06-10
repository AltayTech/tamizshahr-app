import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/article.dart';
import 'package:tamizshahr/provider/articles.dart';

import '../provider/app_theme.dart';
import '../widgets/main_drawer.dart';

class ArticleDetailScreen extends StatefulWidget {
  static const routeName = '/articleDetailScreen';

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  var _isLoading;

  bool _isInit = true;

  Article loadedArticle;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await searchItems();
      loadedArticle = Provider.of<Articles>(context, listen: false).item;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> searchItems() async {
    setState(() {
      _isLoading = true;
    });
    final articleId = ModalRoute.of(context).settings.arguments as int;
    await Provider.of<Articles>(context, listen: false).retrieveItem(articleId);

    setState(() {
      _isLoading = false;
    });
    print(_isLoading.toString());
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: TextStyle(
              fontFamily: 'Iransans',
            ),
          ),
          backgroundColor: AppTheme.appBarColor,
          iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
          elevation: 0,
          centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Align(
            alignment: Alignment.center,
            child: _isLoading
                ? SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.isEven ? Colors.grey : Colors.grey,
                        ),
                      );
                    },
                  )
                : SingleChildScrollView(
                  child: Column(

                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: deviceHeight * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: FadeInImage(
                          placeholder:
                              AssetImage('assets/images/circle.gif'),
                          image: NetworkImage(loadedArticle.featured_image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          loadedArticle.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 2,
                            color: AppTheme.black,
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 16.0,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HtmlWidget(
                          loadedArticle.content,
                          onTapUrl: (url) => showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('onTapUrl'),
                              content: Text(url),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            // Set the transparency here
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: MainDrawer(),
        ),
      ),
    );
  }
}
