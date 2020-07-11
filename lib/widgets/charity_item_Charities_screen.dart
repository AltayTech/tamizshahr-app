import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/charity.dart';
import 'package:tamizshahr/screens/charity_detail_screen.dart';

import '../provider/app_theme.dart';

class CharityItemCharitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final charity = Provider.of<Charity>(context, listen: false);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Container(
      height: widthDevice * 0.32,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return InkWell(
            onTap: () {
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
                      child: Container(
                        height: constraints.maxHeight,
                        child: FadeInImage(
                          placeholder: AssetImage('assets/images/circle.gif'),
                          image:
                              NetworkImage(charity.featured_image.sizes.medium),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
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
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.start,
                                children: charity.activities
                                    .map((e) => ChangeNotifierProvider.value(
                                          value: e,
                                          child: Text(
                                            charity.activities.indexOf(e) <
                                                    (charity.activities.length -
                                                        1)
                                                ? (e.name + '، ')
                                                : e.name,
                                            style: TextStyle(
                                              fontFamily: 'Iransans',
                                              color: Colors.grey,
                                              fontSize: textScaleFactor * 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            )
                          ],
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
