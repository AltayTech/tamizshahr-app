import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../provider/app_theme.dart';
import '../models/color_code.dart';
import 'en_to_ar_number_convertor.dart';

class CashPaymentProductItem extends StatelessWidget {
  final int id;
  final String title;
  final ColorCode color_selected;
  final String price;
  final String price_low;

  CashPaymentProductItem({
    this.id = 0,
    this.title = '',
    required this.color_selected,
    this.price = '0',
    this.price_low = '0',
  });

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    Widget priceWidget() {
      if (price == price_low) {
        return Text(
          price.isNotEmpty
              ? EnArConvertor().replaceArNumber(
                  currencyFormat.format(double.parse(price)).toString())
              : EnArConvertor().replaceArNumber('0'),
          style: TextStyle(
            fontFamily: 'Iransans',
            color: AppTheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: textScaleFactor * 15.0,
          ),
        );
      } else if (price == '0' || price.isEmpty) {
        return Text(
          price_low.isNotEmpty
              ? EnArConvertor().replaceArNumber(
                  currencyFormat.format(double.parse(price_low)).toString())
              : EnArConvertor().replaceArNumber('0'),
          style: TextStyle(
            fontFamily: 'Iransans',
            color: AppTheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: textScaleFactor * 15.0,
          ),
        );
      } else if (price_low == '0' || price_low.isEmpty) {
        return Text(
          price.isNotEmpty
              ? EnArConvertor().replaceArNumber(
                  currencyFormat.format(double.parse(price)).toString())
              : EnArConvertor().replaceArNumber('0'),
          style: TextStyle(
            fontFamily: 'Iransans',
            color: AppTheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: textScaleFactor * 15.0,
          ),
        );
      } else {
        return Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              price.isNotEmpty
                  ? EnArConvertor().replaceArNumber(
                      currencyFormat.format(double.parse(price)).toString())
                  : EnArConvertor().replaceArNumber('0'),
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontFamily: 'Iransans',
                color: AppTheme.accent,
                fontSize: textScaleFactor * 15.0,
              ),
            ),
            Text(
              price_low.isNotEmpty
                  ? EnArConvertor().replaceArNumber(
                      currencyFormat.format(double.parse(price_low)).toString())
                  : EnArConvertor().replaceArNumber('0'),
              style: TextStyle(
                fontFamily: 'Iransans',
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
                fontSize: textScaleFactor * 15.0,
              ),
            )
          ],
        );
      }
    }

    return Container(
      height: deviceHeight * 0.16,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Iransans',
                  fontSize: textScaleFactor * 12,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      'تعداد: ' + EnArConvertor().replaceArNumber('1'),
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Iransans',
                        fontSize: textScaleFactor * 12,
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            color_selected.title,
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 12,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border:
                                  Border.all(color: Colors.black, width: 0.2),
                              color: Color(
                                int.parse(
                                  '0xff' +
                                      color_selected.color_code
                                          .replaceRange(0, 1, ''),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  priceWidget(),
                  Text(
                    ' تومان ',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontFamily: 'Iransans',
                      fontSize: textScaleFactor * 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
