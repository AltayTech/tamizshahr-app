import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tamizshahr/models/charity.dart';

import '../provider/app_theme.dart';
import 'en_to_ar_number_convertor.dart';

class CustomDialogPayCharity extends StatefulWidget {
  final int totalWallet;
  final Charity charity;
  final Function function;

  CustomDialogPayCharity({
    required this.totalWallet,
    required this.charity,
    required this.function,
  });

  @override
  _CustomDialogPayCharityState createState() => _CustomDialogPayCharityState();
}

class _CustomDialogPayCharityState extends State<CustomDialogPayCharity> {
  int moneyToCharity = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();
    return LayoutBuilder(
      builder: (_, constraints) => Padding(
        padding: EdgeInsets.only(
          top: Consts.avatarRadius + Consts.padding,
          bottom: Consts.padding,
          left: Consts.padding,
          right: Consts.padding,
        ),
        child: Container(
          decoration: new BoxDecoration(
            color: AppTheme.bg,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  widget.charity.charity_data.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.black,
                    fontFamily: 'Iransans',
                    height: 2,
                    fontSize: MediaQuery.of(context).textScaleFactor * 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Text(
                      EnArConvertor().replaceArNumber(
                          currencyFormat.format(widget.totalWallet).toString()),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontFamily: 'Iransans',
                        height: 2,
                        fontSize: MediaQuery.of(context).textScaleFactor * 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'امتیاز شما',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontFamily: 'Iransans',
                        height: 2,
                        fontSize: MediaQuery.of(context).textScaleFactor * 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: constraints.maxHeight * 0.20,
                  width: constraints.maxWidth * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'میزان کمک شما',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.grey,
                          fontFamily: 'Iransans',
                          height: 2,
                          fontSize: MediaQuery.of(context).textScaleFactor * 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              if (moneyToCharity > 1) {
                                moneyToCharity = moneyToCharity - 1000;
                                setState(() {});
                              }
                            },
                            child: Container(
                                height: constraints.maxHeight * 0.05,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.accent,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: AppTheme.bg,
                                )),
                          )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                EnArConvertor()
                                    .replaceArNumber(currencyFormat
                                        .format(moneyToCharity)
                                        .toString())
                                    .toString(),
                                style: TextStyle(
                                  color: AppTheme.black,
                                  fontFamily: 'Iransans',
                                  fontSize: textScaleFactor * 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                moneyToCharity = moneyToCharity + 1000;
                                setState(() {});
                              },
                              child: Container(
                                height: constraints.maxHeight * 0.05,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.accent,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: AppTheme.bg,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'تومان',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.grey,
                          fontFamily: 'Iransans',
                          height: 2,
                          fontSize: MediaQuery.of(context).textScaleFactor * 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Builder(
                    builder: (context) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          if (moneyToCharity > 0) {
                            widget.function(moneyToCharity);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: constraints.maxHeight * 0.06,
                          width: constraints.maxWidth * 0.8,
                          decoration: BoxDecoration(
                            color: moneyToCharity > 0
                                ? AppTheme.primary
                                : Colors.grey,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'تایید',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Iransans',
                                  fontSize: textScaleFactor * 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 5.0;
  static const double avatarRadius = 3;
}
