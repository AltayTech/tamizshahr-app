import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tamizshahr/features/waste_feature/business/entities/collect.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/price_weight.dart';

import '../provider/app_theme.dart';
import 'en_to_ar_number_convertor.dart';

class CollectDetailsCollectItem extends StatefulWidget {
  final Collect collectItem;

  CollectDetailsCollectItem({
    required this.collectItem,
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
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: deviceWidth * 0.5,
        width: deviceWidth,
        decoration: AppTheme.listItemBox,
        child: LayoutBuilder(
          builder: (_, constraints) => Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
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
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'وزن کل (کیلوگرم): ',
                            style: TextStyle(
                              color: AppTheme.black.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 14,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'درخواست: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 12,
                                  ),
                                ),
                                Text(
                                  EnArConvertor()
                                      .replaceArNumber(widget
                                          .collectItem.estimated_weight
                                          .toString())
                                      .toString(),
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'تحویل: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 12,
                                  ),
                                ),
                                Text(
                                  EnArConvertor()
                                      .replaceArNumber(widget
                                          .collectItem.exact_weight
                                          .toString())
                                      .toString(),
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'قیمت کل (تومان): ',
                            style: TextStyle(
                              color: AppTheme.black.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 14,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'درخواست: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 12,
                                  ),
                                ),
                                Text(
                                  widget.collectItem.estimated_price != null
                                      ? EnArConvertor().replaceArNumber(
                                          currencyFormat.format(double.parse(
                                              widget.collectItem
                                                  .estimated_price)))
                                      : EnArConvertor().replaceArNumber('0'),
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'تحویل: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 12,
                                  ),
                                ),
                                Text(
                                  widget.collectItem.exact_price != null
                                      ? EnArConvertor().replaceArNumber(
                                          currencyFormat.format(double.parse(
                                              widget.collectItem.exact_price)))
                                      : EnArConvertor().replaceArNumber('0'),
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 18,
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
