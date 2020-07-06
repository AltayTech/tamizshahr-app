import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tamizshahr/models/request/collect.dart';

import '../models/request/price_weight.dart';
import '../provider/app_theme.dart';
import 'en_to_ar_number_convertor.dart';

class CollectDetailsCollectItem extends StatefulWidget {
  final Collect collectItem;

  CollectDetailsCollectItem({
    this.collectItem,
  });

  @override
  _CollectDetailsCollectItemState createState() =>
      _CollectDetailsCollectItemState();
}

class _CollectDetailsCollectItemState extends State<CollectDetailsCollectItem> {
  bool _isInit = true;

  var _isLoading = true;

  int productWeight = 0;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = false;

      productWeight = int.parse(widget.collectItem.estimated_weight);
    }
    _isInit = false;
    super.didChangeDependencies();
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: deviceWidth * 0.30,
        width: deviceWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppTheme.white,
            border: Border.all(color: AppTheme.grey, width: 0.3)),
        child: LayoutBuilder(
          builder: (_, constraints) => Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.collectItem.pasmand.post_title != null
                                ? widget.collectItem.pasmand.post_title
                                : 'ندارد',
                            style: TextStyle(
                              color: AppTheme.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 16,
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'وزن کل: ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Iransans',
                                  fontSize: textScaleFactor * 12,
                                ),
                              ),
                              Text(
                                EnArConvertor()
                                    .replaceArNumber(
                                        widget.collectItem.estimated_weight.toString())
                                    .toString(),
                                style: TextStyle(
                                  color: AppTheme.black,
                                  fontFamily: 'Iransans',
                                  fontSize: textScaleFactor * 16,
                                ),
                              ),
                              Text(
                                '  کیلوگرم ',
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
                    Expanded(
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'هر کیلو: ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 12,
                            ),
                          ),
                          Text(
                            widget.collectItem.estimated_price.length != null
                                ? EnArConvertor().replaceArNumber(currencyFormat
                                    .format(
                                        double.parse(widget.collectItem.estimated_price))
                                    .toString())
                                : EnArConvertor().replaceArNumber('0'),
                            style: TextStyle(
                              color: AppTheme.black,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 16,
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
                          Spacer(),
                          Text(
                            'قیمت کل: ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 12,
                            ),
                          ),
                          Text(
                            widget.collectItem.estimated_price != null
                                ? EnArConvertor().replaceArNumber(
                                    currencyFormat.format(
                                        double.parse(widget.collectItem.estimated_price)))
                                : EnArConvertor().replaceArNumber('0'),
                            style: TextStyle(
                              color: AppTheme.black,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 18,
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
