import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/order.dart';

import '../provider/app_theme.dart';
import 'en_to_ar_number_convertor.dart';

class OrderItemOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final order = Provider.of<Order>(context, listen: false);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Container(
      height: widthDevice * 0.35,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Card(
            child: Container(
              height: constraints.maxHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Icon(
                                  Icons.date_range,
                                  color: AppTheme.grey,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  order.send_date,
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 14.0,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: Icon(
                                  Icons.av_timer,
                                  color: AppTheme.grey,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  order.send_date,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
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
                                ),
                                Expanded(
                                  child: Text(
                                    order.total_number,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppTheme.black,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 14.0,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    EnArConvertor().replaceArNumber(
                                        currencyFormat
                                            .format(double.parse(
                                                order.total_price))
                                            .toString()),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppTheme.black,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 14.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.timer,
                            size: 50,
                            color: AppTheme.primary,
                          ),
                        )),
                        Spacer(),
                        Expanded(
                          child: Text(
                            order.status.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppTheme.black,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 14.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
