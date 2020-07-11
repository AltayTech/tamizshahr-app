import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../provider/Products.dart';
import '../provider/app_theme.dart';
import '../screens/product_detail_screen.dart';
import 'en_to_ar_number_convertor.dart';

class ProductItemProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final product = Provider.of<Product>(context, listen: false);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    Widget priceWidget() {
      if (product.price == product.price) {
        return Text(
          product.price.isNotEmpty
              ? EnArConvertor().replaceArNumber(
                  currencyFormat.format(double.parse(product.price)).toString())
              : EnArConvertor().replaceArNumber('0'),
          style: TextStyle(
            fontFamily: 'Iransans',
            color: AppTheme.black,
            fontWeight: FontWeight.w500,
            fontSize: textScaleFactor * 17.0,
          ),
        );
      } else if (product.price == '0' || product.price.isEmpty) {
        return Text(
          product.price.isNotEmpty
              ? EnArConvertor().replaceArNumber(
                  currencyFormat.format(double.parse(product.price)).toString())
              : EnArConvertor().replaceArNumber('0'),
          style: TextStyle(
            fontFamily: 'Iransans',
            color: AppTheme.black,
            fontWeight: FontWeight.w500,
            fontSize: textScaleFactor * 17.0,
          ),
        );
      } else if (product.price == '0' || product.price.isEmpty) {
        return Text(
          product.price.isNotEmpty
              ? EnArConvertor().replaceArNumber(
                  currencyFormat.format(double.parse(product.price)).toString())
              : EnArConvertor().replaceArNumber('0'),
          style: TextStyle(
            fontFamily: 'Iransans',
            color: AppTheme.black,
            fontWeight: FontWeight.w500,
            fontSize: textScaleFactor * 17.0,
          ),
        );
      } else {
        return Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              product.price.isNotEmpty
                  ? EnArConvertor().replaceArNumber(currencyFormat
                      .format(double.parse(product.price))
                      .toString())
                  : EnArConvertor().replaceArNumber('0'),
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontFamily: 'Iransans',
                color: AppTheme.grey,
                fontSize: textScaleFactor * 15.0,
              ),
            ),
            Text(
              product.price.isNotEmpty
                  ? EnArConvertor().replaceArNumber(currencyFormat
                      .format(double.parse(product.price))
                      .toString())
                  : EnArConvertor().replaceArNumber('0'),
              style: TextStyle(
                fontFamily: 'Iransans',
                fontWeight: FontWeight.w500,
                color: AppTheme.black,
                fontSize: textScaleFactor * 17.0,
              ),
            )
          ],
        );
      }
    }

    return Container(
      height: widthDevice * 0.4,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return InkWell(
            onTap: () {
              Provider.of<Products>(context, listen: false).item =
                  Provider.of<Products>(context, listen: false).itemZero;
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Card(
              elevation: 0.0,
              child: Container(
                height: constraints.maxHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FadeInImage(
                                placeholder:
                                    AssetImage('assets/images/circle.gif'),
                                image: NetworkImage(
                                    product.featured_image.sizes.medium),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppTheme.black,
                                fontFamily: 'Iransans',
//                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 15.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    FittedBox(child: priceWidget()),
                                    Text(
                                      'تومان',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppTheme.grey,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 9.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
