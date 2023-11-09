import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/article/article.dart';
import '../models/category.dart';
import '../models/search_detail.dart';
import '../provider/app_theme.dart';
import '../provider/articles.dart';
import '../widgets/article_item_article_screen.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';

class ArticlesScreen extends StatefulWidget {
  static const routeName = '/articlesScreen';

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;

  ScrollController _scrollController = new ScrollController();

  var _isLoading;

  int page = 1;

   SearchDetail productsDetail=SearchDetail();

  List<int> _selectedCategoryIndexes = [];
  int _selectedCategoryId = 0;
  List<String> _selectedCategoryTitle = [];

  List<Category> categoryList = [];

  @override
  void initState() {
    Provider.of<Articles>(context, listen: false).sPage = 1;

    Provider.of<Articles>(context, listen: false).searchBuilder();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (page < productsDetail.max_page) {
          page = page + 1;
          Provider.of<Articles>(context, listen: false).sPage = page;
          searchItems();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      Provider.of<Articles>(context, listen: false).retrieveCategory();
      categoryList =
          Provider.of<Articles>(context, listen: false).categoryItems;

      Provider.of<Articles>(context, listen: false).searchBuilder();

      searchItems();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  List<Article> loadedProducts = [];
  List<Article> loadedProductstolist = [];

  Future<void> _submit() async {
    loadedProducts.clear();
    loadedProducts =
        await Provider.of<Articles>(context, listen: false).articleItems;
    loadedProductstolist.addAll(loadedProducts);
  }

  Future<void> filterItems() async {
    loadedProductstolist.clear();
    await searchItems();
  }

  Future<void> searchItems() async {
    setState(() {
      _isLoading = true;
    });
    print(_isLoading.toString());

    await Provider.of<Articles>(context, listen: false).searchItem();
    productsDetail =
        Provider.of<Articles>(context, listen: false).searchDetails;
    _submit();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> changeCat(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Articles>(context, listen: false).sPage = 1;
    Provider.of<Articles>(context, listen: false).searchBuilder();

    String categoriesEndpoint =
        _selectedCategoryId != 0 ? '$_selectedCategoryId' : '';
    Provider.of<Articles>(context, listen: false).sCategory =
        categoriesEndpoint;

    Provider.of<Articles>(context, listen: false).searchBuilder();
    loadedProductstolist.clear();

    await searchItems();

    setState(() {
      _isLoading = false;
    });
  }

  String endPointBuilder(List<dynamic> input) {
    String outPutString = '';
    for (int i = 0; i < input.length; i++) {
      i == 0
          ? outPutString = input[i].toString()
          : outPutString = outPutString + ',' + input[i].toString();
    }
    return outPutString;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'مقالات',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.0, horizontal: deviceWidth * 0.03),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Container(
                        color: AppTheme.white,
                        height: deviceHeight * 0.05,
                        width: deviceWidth,
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                _selectedCategoryIndexes.clear();
                                _selectedCategoryTitle.clear();

                                _selectedCategoryIndexes.add(-1);
                                _selectedCategoryId = 0;
                                _selectedCategoryTitle.add('همه');

                                changeCat(context);
                              },
                              child: Container(
                                decoration: _selectedCategoryId == 0
                                    ? BoxDecoration(
                                        color: AppTheme.bg,
                                        border: Border(
                                          bottom: BorderSide(
                                              color: AppTheme.primary,
                                              width: 3),
                                        ),
                                      )
                                    : BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'همه',
                                      style: TextStyle(
                                        color: _selectedCategoryId == 0
                                            ? AppTheme.primary
                                            : AppTheme.h1,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 14.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Consumer<Articles>(
                              builder: (_, data, ch) => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.categoryItems.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: InkWell(
                                      onTap: () {
                                        _selectedCategoryIndexes.clear();
                                        _selectedCategoryTitle.clear();

                                        _selectedCategoryIndexes.add(index);
                                        _selectedCategoryId =
                                            data.categoryItems[index].term_id;
                                        _selectedCategoryTitle.add(
                                            data.categoryItems[index].name);

                                        changeCat(context);
                                      },
                                      child: Container(
                                        decoration: _selectedCategoryIndexes
                                                .contains(index)
                                            ? BoxDecoration(
                                                color: AppTheme.bg,
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: AppTheme.primary,
                                                      width: 3),
                                                ),
                                              )
                                            : BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              data.categoryItems[index].name !=
                                                      null
                                                  ? data
                                                      .categoryItems[index].name
                                                  : 'n',
                                              style: TextStyle(
                                                color: data.categoryItems[index]
                                                            .term_id ==
                                                        _selectedCategoryId
                                                    ? AppTheme.primary
                                                    : AppTheme.h1,
                                                fontFamily: 'Iransans',
                                                fontSize:
                                                    textScaleFactor * 14.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Spacer(),
                        Consumer<Articles>(builder: (_, Articles, ch) {
                          return Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.0, horizontal: 3),
                              child: Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 5),
                                      child: Text(
                                        'تعداد:',
                                        style: TextStyle(
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4.0, left: 6),
                                      child: Text(
                                        productsDetail.total != -1
                                            ? EnArConvertor().replaceArNumber(
                                                productsDetail.total.toString())
                                            : EnArConvertor()
                                                .replaceArNumber('0'),
                                        style: TextStyle(
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 13.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 5),
                                      child: Text(
                                        'از',
                                        style: TextStyle(
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4.0, left: 6),
                                      child: Text(
                                        productsDetail.total != -1
                                            ? EnArConvertor().replaceArNumber(
                                                productsDetail.total.toString())
                                            : EnArConvertor()
                                                .replaceArNumber('0'),
                                        style: TextStyle(
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 13.0,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        }),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: deviceHeight * 0.75,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: loadedProductstolist.length,
                        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                          value: loadedProductstolist[i],
                          child: ArticleItemArticlesScreen(),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                        alignment: Alignment.center,
                        child: _isLoading
                            ? SpinKitFadingCircle(
                                itemBuilder: (BuildContext context, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index.isEven
                                          ? Colors.grey
                                          : Colors.grey,
                                    ),
                                  );
                                },
                              )
                            : Container(
                                child: loadedProductstolist.isEmpty
                                    ? Center(
                                        child: Text(
                                        'محصولی وجود ندارد',
                                        style: TextStyle(
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 15.0,
                                        ),
                                      ))
                                    : Container())))
              ],
            ),
          ),
        ),
      ),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: MainDrawer(),
      ),
    );
  }
}
