import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/screens/collect_detail_screen.dart';

import '../models/request/request_waste_item.dart';
import '../provider/Products.dart';
import '../provider/app_theme.dart';
import 'en_to_ar_number_convertor.dart';

class CollectItemCollectsScreen extends StatelessWidget {
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
        color: Colors.red,
//        size: 35,
      );
    } else if (statusSlug == 'collected') {
      icon = Icon(
        Icons.check_circle,
        color: AppTheme.primary,
//        size: 35,
      );
    } else if (statusSlug == 'not-accessed') {
      icon = Icon(
        Icons.cancel,
        color: AppTheme.grey,
//        size: 35,
      );
    } else {
      icon = Icon(
        Icons.drive_eta,
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
    final collect = Provider.of<RequestWasteItem>(context, listen: false);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: widthDevice * 0.29,
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return InkWell(
              onTap: () {
                Provider.of<Products>(context, listen: false).item =
                    Provider.of<Products>(context, listen: false).itemZero;
                Navigator.of(context).pushNamed(
                  CollectDetailScreen.routeName,
                  arguments: collect.id,
                );
              },
              child: Container(
                decoration: AppTheme.listItemBox,
                height: constraints.maxHeight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    color: AppTheme.primary,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 6, right: 4),
                                      child: Text(
                                        EnArConvertor().replaceArNumber(
                                            collect.collect_date.day),
                                        maxLines: 1,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: AppTheme.black,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12.0,
                                        ),
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
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                   EnArConvertor().replaceArNumber( collect.collect_date.time)  ,
                                      maxLines: 1,
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
                            Expanded(child: getStatusIcon(collect.status.slug)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 25, left: 4),
                                    child: Text(
                                      EnArConvertor().replaceArNumber(collect
                                          .total_collects_weight.estimated),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppTheme.black,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 16.0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'کیلوگرم',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.grey,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 10.0,
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
                                    EnArConvertor().replaceArNumber(
                                        currencyFormat
                                            .format(double.parse(collect
                                                .total_collects_price
                                                .estimated))
                                            .toString()),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppTheme.black,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 14.0,
                                    ),
                                  ),
                                  Text(
                                    ' تومان',
                                    maxLines: 1,
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
                                collect.status.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.black,
                                  fontFamily: 'Iransans',
                                  fontSize: textScaleFactor * 12.0,
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
      ),
    );
  }
}
