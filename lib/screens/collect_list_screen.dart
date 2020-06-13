import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../models/request/request_waste_item.dart';
import '../models/search_detail.dart';
import '../provider/app_theme.dart';
import '../provider/wastes.dart';
import '../widgets/collect_item_collect_screen.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';

class CollectListScreen extends StatefulWidget {
  static const routeName = '/collectListScreen';

  @override
  _CollectListScreenState createState() => _CollectListScreenState();
}

class _CollectListScreenState extends State<CollectListScreen>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;

  ScrollController _scrollController = new ScrollController();

  var _isLoading;

  var scaffoldKey;
  int page = 1;

  SearchDetail productsDetail;

  var sortValue = 'جدیدترین';
  List<String> sortValueList = ['جدیدترین', 'گرانترین', 'ارزانترین'];

  @override
  void initState() {
    Provider
        .of<Wastes>(context, listen: false)
        .sPage = 1;

    Provider.of<Wastes>(context, listen: false).searchBuilder();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page = page + 1;
        Provider
            .of<Wastes>(context, listen: false)
            .sPage = page;

        searchItems();
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
      searchItems();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  List<RequestWasteItem> loadedProducts = [];
  List<RequestWasteItem> loadedProductstolist = [];

  Future<void> _submit() async {
    loadedProducts.clear();
    loadedProducts =
    await Provider
        .of<Wastes>(context, listen: false)
        .CollectItems;
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

    Provider.of<Wastes>(context, listen: false).searchBuilder();
    await Provider.of<Wastes>(context, listen: false).searchCollectItems();
    productsDetail = Provider
        .of<Wastes>(context, listen: false)
        .searchDetails;
    _submit();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> changeCat(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    print(_isLoading.toString());

    Provider
        .of<Wastes>(context, listen: false)
        .sPage = 1;

    Provider.of<Wastes>(context, listen: false).searchBuilder();

    loadedProductstolist.clear();

    await searchItems();

    setState(() {
      _isLoading = false;
      print(_isLoading.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    var textScaleFactor = MediaQuery
        .of(context)
        .textScaleFactor;

    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xffF9F9F9),
        appBar: AppBar(
          title: Text(
            'لیست درخواست ها',
            style: TextStyle(
              fontFamily: 'Iransans',
            ),
          ),
          backgroundColor: AppTheme.appBarColor,
          iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.0, horizontal: deviceWidth * 0.03),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: deviceWidth * 0.2,
                        child: Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: deviceWidth,
                                child: FadeInImage(
                                  placeholder:
                                  AssetImage('assets/images/circle.gif'),
                                  image: AssetImage(
                                      'assets/images/collect_list_header.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                      color: AppTheme.white,
                                      border: Border.all(
                                          color: AppTheme.h1, width: 0.2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8, top: 6),
                                    child: DropdownButton<String>(
                                      value: sortValue,
                                      icon: Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: AppTheme.black,
                                          size: 20,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: AppTheme.black,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 13.0,
                                      ),
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          sortValue = newValue;

                                          if (sortValue == 'گرانترین') {
                                            Provider
                                                .of<Wastes>(context,
                                                listen: false)
                                                .sOrder = 'desc';
                                            Provider
                                                .of<Wastes>(context,
                                                listen: false)
                                                .sOrderBy = 'price';
                                            page = 1;
                                            Provider
                                                .of<Wastes>(context,
                                                listen: false)
                                                .sPage = page;
                                            loadedProductstolist.clear();

                                            searchItems();
                                          } else if (sortValue == 'ارزانترین') {
                                            Provider
                                                .of<Wastes>(context,
                                                listen: false)
                                                .sOrder = 'asc';
                                            Provider
                                                .of<Wastes>(context,
                                                listen: false)
                                                .sOrderBy = 'price';

                                            page = 1;
                                            Provider
                                                .of<Wastes>(context,
                                                listen: false)
                                                .sPage = page;
                                            loadedProductstolist.clear();

                                            searchItems();
                                          } else {
                                            Provider
                                                .of<Wastes>(context,
                                                listen: false)
                                                .sOrder = 'desc';
                                            Provider
                                                .of<Wastes>(context,
                                                listen: false)
                                                .sOrderBy = 'date';
                                            page = 1;
                                            Provider
                                                .of<Wastes>(context,
                                                listen: false)
                                                .sPage = page;
                                            loadedProductstolist.clear();

                                            searchItems();
                                          }
                                        });
                                      },
                                      items: sortValueList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 3.0),
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                    color: AppTheme.black,
                                                    fontFamily: 'Iransans',
                                                    fontSize:
                                                    textScaleFactor * 13.0,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Consumer<Wastes>(builder: (_, Wastes, ch) {
                              return Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.0,
                                      horizontal: 3),
                                  child: Wrap(
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                      WrapCrossAlignment.center,
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
                                            productsDetail != null
                                                ? EnArConvertor()
                                                .replaceArNumber(
                                                productsDetail.total
                                                    .toString())
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
                        Divider(thickness: 1, color: AppTheme.h1),
                        Container(
                          width: double.infinity,
                          height: deviceHeight * 0.68,
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            itemCount: loadedProductstolist.length,
                            itemBuilder: (ctx, i) =>
                                ChangeNotifierProvider.value(
                                  value: loadedProductstolist[i],
                                  child: CollectItemCollectsScreen(),
                                ),
                          ),
                        ),
                      ],
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
