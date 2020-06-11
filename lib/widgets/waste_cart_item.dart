import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/request/wasteCart.dart';

import '../models/request/price_weight.dart';
import '../provider/app_theme.dart';
import '../provider/wastes.dart';
import 'en_to_ar_number_convertor.dart';

class WasteCartItem extends StatefulWidget {
  final WasteCart wasteItem;
  final Function callFunction;

  WasteCartItem({
    this.wasteItem,
    this.callFunction,
  });

  @override
  _WasteCartItemState createState() => _WasteCartItemState();
}

class _WasteCartItemState extends State<WasteCartItem> {
  bool _isInit = true;

  var _isLoading = true;

  bool isLogin;

  int productWeight = 0;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = false;

      productWeight = widget.wasteItem.weight;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> removeItem() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Wastes>(context, listen: false).removeWasteCart(
      widget.wasteItem.id,
    );
    widget.callFunction();

    setState(() {
      _isLoading = false;
      print(_isLoading.toString());
    });
    print(_isLoading.toString());
  }

  String getPrice(List<PriceWeight> prices, int weight) {
    String price = '0';

    for (int i = 0; i < prices.length; i++) {
      if (weight > int.parse(prices[i].weight)) {
        price = prices[i].price;
      } else {
        price = prices[i].price;
        break;
      }
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Container(
      height: deviceWidth * 0.35,
      width: deviceWidth,
      child: LayoutBuilder(
        builder: (_, constraints) => Card(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: FadeInImage(
                        placeholder: AssetImage('assets/images/logo.jpg'),
                        image: NetworkImage(
                            widget.wasteItem.featured_image != null
                                ? widget.wasteItem.featured_image.sizes.medium
                                : ''),
                        fit: BoxFit.cover,
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
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        widget.wasteItem.name != null
                                            ? widget.wasteItem.name
                                            : 'ندارد',
                                        style: TextStyle(
                                          color: AppTheme.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
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
                                            productWeight = productWeight + 1;

                                            await Provider.of<Wastes>(context,
                                                    listen: false)
                                                .updateWasteCart(
                                              widget.wasteItem,
                                              productWeight,
                                            )
                                                .then((_) {
                                              widget.callFunction();
                                              setState(() {
                                                _isLoading = false;
                                                print(_isLoading.toString());
                                              });
                                            });
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
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
                                                    .wasteItem.weight
                                                    .toString())
                                                .toString(),
                                            style: TextStyle(
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                            child: InkWell(
                                          onTap: () {
                                            if (productWeight > 1) {
                                              productWeight = productWeight - 1;
                                              print('productCount' +
                                                  productWeight.toString());

                                              Provider.of<Wastes>(context,
                                                      listen: false)
                                                  .updateWasteCart(
                                                widget.wasteItem,
                                                productWeight,
                                              )
                                                  .then((_) {
                                                widget.callFunction();

                                                setState(() {
                                                  _isLoading = false;
                                                  print(_isLoading.toString());
                                                });
                                              });
                                            }
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
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
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        widget.wasteItem.prices.length != 0
                                            ? EnArConvertor().replaceArNumber(
                                                currencyFormat
                                                    .format(double.parse(
                                                        getPrice(
                                                            widget.wasteItem
                                                                .prices,
                                                            widget.wasteItem
                                                                .weight)))
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
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        widget.wasteItem.prices.length != 0
                                            ? EnArConvertor().replaceArNumber(
                                                currencyFormat
                                                    .format(double.parse(
                                                            getPrice(
                                                                widget.wasteItem
                                                                    .prices,
                                                                widget.wasteItem
                                                                    .weight)) *
                                                        widget.wasteItem.weight)
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
    );
  }
}
