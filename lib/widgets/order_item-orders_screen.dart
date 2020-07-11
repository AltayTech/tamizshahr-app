import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/order.dart';

import '../provider/app_theme.dart';
import 'en_to_ar_number_convertor.dart';

class OrderItemOrdersScreen extends StatelessWidget {
  Widget getStatusIcon(String statusSlug) {
    Widget icon = Icon(
      Icons.timer,
      color: AppTheme.accent,
//      size: 35,
    );

    if (statusSlug == 'register') {
      icon = Icon(
        Icons.beenhere,
        color: AppTheme.accent,
//        size: 25,
      );
    } else if (statusSlug == 'cancel') {
      icon = Icon(
        Icons.cancel,
        color: AppTheme.grey,
//        size: 35,
      );
    } else if (statusSlug == 'review') {
      icon = Icon(
        Icons.timer,
        color: AppTheme.accent,
//        size: 35,
      );
    } else if (statusSlug == 'sent') {
      icon = Icon(
        Icons.check_circle,
        color: AppTheme.primary,
//        size: 35,
      );
    } else {
      icon = Icon(
        Icons.beenhere,
        color: AppTheme.accent,
//        size: 35,
      );
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final order = Provider.of<Order>(context, listen: false);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Container(
      height: widthDevice * 0.28,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: AppTheme.listItemBox,
              height: constraints.maxHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  color: AppTheme.primary,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Text(
                                    order.send_date,
                                    maxLines: 1,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppTheme.black,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.av_timer,
                                  color: AppTheme.primary,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Text(
                                    order.send_date,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppTheme.black,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: getStatusIcon(order.status.slug)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'تعداد:',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: AppTheme.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 11.0,
                                  ),
                                ),
                                Text(
                                  EnArConvertor()
                                      .replaceArNumber(order.total_number),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  EnArConvertor().replaceArNumber(currencyFormat
                                      .format(double.parse(order.total_price))
                                      .toString()),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 15.0,
                                  ),
                                ),
                                Text(
                                  ' تومان',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: AppTheme.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              order.status.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.black,
                                fontFamily: 'Iransans',
                                fontSize: textScaleFactor * 15.0,
                              ),
                            ),
                          )
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
