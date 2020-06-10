import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../provider/app_theme.dart';
import '../models/product_cart.dart';
import '../provider/Products.dart';
import '../provider/auth.dart';
import '../screens/product_detail_screen.dart';
import 'en_to_ar_number_convertor.dart';

class CardItem extends StatefulWidget {
  final ProductCart shoppItem;
  final Function callFunction;

  CardItem({
    this.shoppItem,
    this.callFunction,
  });

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _isInit = true;

  var _isLoading = true;

  bool isLogin;

  int productCount = 0;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = false;

      productCount = widget.shoppItem.productCount;
      print('productCount' + productCount.toString());
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> removeItem() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Products>(context, listen: false).removeShopCart(
        widget.shoppItem.id, widget.shoppItem.color_selected.id);
    widget.callFunction();


    setState(() {
      _isLoading = false;
      print(_isLoading.toString());
    });
    print(_isLoading.toString());
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();
    isLogin = Provider.of<Auth>(context).isAuth;

    return LayoutBuilder(
      builder: (_, constraints) => Card(
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
          height: deviceWidth * 0.45,
          child: InkWell(
            onTap: () {
              Provider.of<Products>(context).item =
                  Provider.of<Products>(context).itemZero;
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: widget.shoppItem.id,
              );
            },
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: deviceWidth,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: FadeInImage(
                              placeholder: AssetImage('assets/images/logo.jpg'),
                              image: NetworkImage(
                                  widget.shoppItem.featured_media_url != null
                                      ? widget.shoppItem.featured_media_url
                                      : ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: deviceWidth * 0.03,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      widget.shoppItem.title != null
                                          ? widget.shoppItem.title
                                          : 'ندارد',
                                      style: TextStyle(
                                        color: AppTheme.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 12,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(10),
                                          width: 15.0,
                                          height: 15.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.2),
                                            color: Color(
                                              int.parse(
                                                '0xff' +
                                                    widget
                                                        .shoppItem
                                                        .color_selected
                                                        .color_code
                                                        .replaceRange(0, 1, ''),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            widget
                                                .shoppItem.color_selected.title,
                                            style: TextStyle(
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: constraints.maxHeight * 0.23,
                                        width: constraints.maxWidth * 0.23,

                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                                child: InkWell(
                                              onTap: () async {
                                                productCount =
                                                    productCount + 1;

                                                await Provider.of<Products>(
                                                        context,
                                                        listen: false)
                                                    .updateShopCart(
                                                        widget.shoppItem,
                                                        widget.shoppItem
                                                            .color_selected,
                                                        productCount,
                                                        isLogin)
                                                    .then((_) {
                                                  widget.callFunction();
                                                  setState(() {
                                                    _isLoading = false;
                                                    print(_isLoading
                                                        .toString());
                                                  });
                                                });
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: AppTheme.secondary,
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: AppTheme.bg,
                                                  )),
                                            )),
                                            Expanded(
                                              child: Text(
                                                EnArConvertor()
                                                    .replaceArNumber(widget
                                                        .shoppItem
                                                        .productCount
                                                        .toString())
                                                    .toString(),
                                                style: TextStyle(
                                                  color: AppTheme.black,
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 14,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                                child: InkWell(
                                              onTap: () {
                                                productCount =
                                                    productCount - 1;
                                                print('productCount' +
                                                    productCount.toString());

                                                Provider.of<Products>(context,
                                                        listen: false)
                                                    .updateShopCart(
                                                        widget.shoppItem,
                                                        widget.shoppItem
                                                            .color_selected,
                                                        productCount,
                                                        isLogin)
                                                    .then((_) {
                                                  widget.callFunction();

                                                  setState(() {
                                                    _isLoading = false;
                                                    print(_isLoading
                                                        .toString());
                                                  });
                                                });
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: AppTheme.secondary,
                                                  ),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppTheme.bg,
                                                  )),
                                            )),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        height: constraints.maxHeight * 0.2,
                                        width: constraints.maxWidth * 0.330,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              widget.shoppItem.price.isNotEmpty
                                                  ? EnArConvertor()
                                                      .replaceArNumber(
                                                          currencyFormat
                                                              .format(double
                                                                  .parse(widget
                                                                      .shoppItem
                                                                      .price))
                                                              .toString())
                                                  : EnArConvertor()
                                                      .replaceArNumber('0'),
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontFamily: 'Iransans',
                                                fontSize: textScaleFactor * 15,
                                              ),
                                            ),
                                            Text(
                                              '  تومان ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'Iransans',
                                                fontSize: textScaleFactor * 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  left: 2,
                  child: Container(
                    height: deviceWidth * 0.10,
                    width: deviceWidth * 0.1,
                    child: InkWell(
                      onTap: () {
                        return removeItem();
                      },
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ),
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
                            : Container()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
