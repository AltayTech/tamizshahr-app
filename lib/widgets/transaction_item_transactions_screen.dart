import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/transaction.dart';

import '../provider/Products.dart';
import '../provider/app_theme.dart';
import '../screens/product_detail_screen.dart';

class TransactionItemTransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final transaction = Provider.of<Transaction>(context, listen: false);

    return Container(
      height: widthDevice * 0.45,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return InkWell(
            onTap: () {
              Provider.of<Products>(context, listen: false).item =
                  Provider.of<Products>(context, listen: false).itemZero;
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: transaction.id,
              );
            },
            child: Card(
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
//                          Expanded(
//                            child: Padding(
//                              padding: const EdgeInsets.all(4.0),
//                              child: FadeInImage(
//                                placeholder: AssetImage('assets/images/circle.gif'),
//                                image: NetworkImage(collect.featured_image.sizes.medium),
//                                fit: BoxFit.cover,
//                              ),
//                            ),
//                          ),
//                          Container(
//                            height: constraints.maxHeight * 0.08,
//                            alignment: Alignment.centerLeft,
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(3),
//                              color: Colors.white70,
//                            ),
//                            child: Center(
//                              child: Padding(
//                                padding: const EdgeInsets.all(3.0),
//                                child: ListView.builder(
//                                  shrinkWrap: true,
//                                  scrollDirection: Axis.horizontal,
//                                  itemCount: product.color.length,
//                                  itemBuilder:
//                                      (BuildContext context, int index) {
//                                    return Padding(
//                                      padding: const EdgeInsets.all(1.0),
//                                      child: Container(
//                                        width: 10.0,
//                                        height: 10.0,
//                                        decoration: BoxDecoration(
//                                          shape: BoxShape.circle,
//                                          border: Border.all(
//                                              color: Colors.black, width: 0.2),
//                                          color: Color(
//                                            int.parse(
//                                              '0xff' +
//                                                  product
//                                                      .color[index].colorCode
//                                                      .replaceRange(0, 1, ''),
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    );
//                                  },
//                                ),
//                              ),
//                            ),
//                          )
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
                              transaction.user.post_title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppTheme.black,
                                fontFamily: 'Iransans',
//                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 16.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
//                              Padding(
//                                padding: const EdgeInsets.only(
//                                  bottom: 12,
//                                  right: 10,
//                                ),
//                                child:
//
//                                Text(
//                                  product.brand[0].title,
//                                  maxLines: 1,
//                                  overflow: TextOverflow.ellipsis,
//                                  textAlign: TextAlign.right,
//                                  style: TextStyle(
//                                    color: AppTheme.grey,
//                                    fontFamily: 'Iransans',
//                                    fontSize: textScaleFactor * 14.0,
//                                  ),
//                                ),
//
//                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    FittedBox(
                                      child: Text(
                                        transaction.money,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 9.0,
                                        ),
                                      ),
                                    ),
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
