import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/clearing.dart';

import '../provider/app_theme.dart';
import 'en_to_ar_number_convertor.dart';

class ClearingItemClearScreen extends StatelessWidget {
  String removeSemicolon(String rawString) {
    print(rawString);

    String newvalue = rawString.replaceAll(',', '');

    return newvalue;
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final transaction = Provider.of<Clearing>(context, listen: false);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
      child: Container(
        height: widthDevice * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppTheme.white,
        ),
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return InkWell(
              onTap: () {
//              Provider.of<Products>(context, listen: false).item =
//                  Provider.of<Products>(context, listen: false).itemZero;
//              Navigator.of(context).pushNamed(
//                ProductDetailScreen.routeName,
//                arguments: transaction.id,
//              );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      transaction.status.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.black,
                        fontFamily: 'Iransans',
                        fontSize: textScaleFactor * 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      transaction.paid_date,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.black,
                        fontFamily: 'Iransans',
                        fontSize: textScaleFactor * 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      EnArConvertor().replaceArNumber(currencyFormat
                          .format(
                              double.parse(removeSemicolon(transaction.money)))
                          .toString()),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.black,
                        fontFamily: 'Iransans',
                        fontSize: textScaleFactor * 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
