import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/transaction.dart';
import 'package:tamizshahr/provider/app_theme.dart';

import 'en_to_ar_number_convertor.dart';

class TransactionItemTransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final transaction = Provider.of<Transaction>(context, listen: false);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Container(
      height: widthDevice * 0.15,
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
            child: Card(
              child: Container(
                height: constraints.maxHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          transaction.operation,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.black,
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 15.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          transaction.transaction_type.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.black,
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 15.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          EnArConvertor().replaceArNumber(currencyFormat
                              .format(double.parse(transaction.money))
                              .toString()),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.accent,
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 15.0,
                          ),
                        ),
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
