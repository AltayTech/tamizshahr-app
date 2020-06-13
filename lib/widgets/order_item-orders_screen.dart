import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/order.dart';

import '../models/request/request_waste_item.dart';
import '../provider/Products.dart';
import '../provider/app_theme.dart';
import '../screens/product_detail_screen.dart';
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
          return InkWell(
            onTap: () {
//              Provider.of<Products>(context, listen: false).item =
//                  Provider.of<Products>(context, listen: false).itemZero;
//              Navigator.of(context).pushNamed(
//                ProductDetailScreen.routeName,
//                arguments: order.id,
//              );
            },
            child: Card(
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
                                      fontSize: textScaleFactor * 16.0,
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
                                      fontSize: textScaleFactor * 16.0,
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
                                        fontSize: textScaleFactor * 14.0,
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
                                        fontSize: textScaleFactor * 16.0,
                                      ),
                                    ),
                                  ),

                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      EnArConvertor().replaceArNumber(
                                          currencyFormat
                                              .format(double.parse(
                                              order.total_price))
                                              .toString())
                                      ,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppTheme.black,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 18.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'تومان',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: AppTheme.grey,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 14.0,
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
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppTheme.black,
                                fontFamily: 'Iransans',
                                fontSize: textScaleFactor * 16.0,
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
