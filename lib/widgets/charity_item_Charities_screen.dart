import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/charity.dart';
import 'package:tamizshahr/screens/charity_detail_screen.dart';

import '../provider/app_theme.dart';

class CharityItemCahritiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final charity = Provider.of<Charity>(context, listen: false);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Container(
      height: widthDevice * 0.45,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return InkWell(
            onTap: () {
//              Provider.of<Articles>(context, listen: false).item =
//                  Provider.of<Articles>(context, listen: false).itemZero;
              Navigator.of(context).pushNamed(
                CharityDetailScreen.routeName,
                arguments: charity.id,
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FadeInImage(
                                placeholder:
                                    AssetImage('assets/images/circle.gif'),
                                image: NetworkImage(
                                    charity.featured_image.sizes.medium),
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
                              charity.charity_data.name,
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
