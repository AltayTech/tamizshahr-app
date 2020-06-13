import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/request/request_waste_item.dart';
import 'package:tamizshahr/provider/wastes.dart';
import 'package:tamizshahr/widgets/collect_details_collects_item.dart';

import '../provider/app_theme.dart';
import '../widgets/main_drawer.dart';

class CollectDetailScreen extends StatefulWidget {
  static const routeName = '/collectDetailScreen';

  @override
  _CollectDetailScreenState createState() => _CollectDetailScreenState();
}

class _CollectDetailScreenState extends State<CollectDetailScreen> {
  int _current = 0;
  var _isLoading;

  bool _isInit = true;

  RequestWasteItem loadedCollect;
  String _snackBarMessage = '';

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await searchItems();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> searchItems() async {
    setState(() {
      _isLoading = true;
    });
    final productId = ModalRoute.of(context).settings.arguments as int;
    await Provider.of<Wastes>(context, listen: false)
        .retrieveCollectItem(productId);
    loadedCollect =
        Provider.of<Wastes>(context, listen: false).requestWasteItem;
    print(
        'ssssssssssssssssssss ' + loadedCollect.collect_list.length.toString());

    setState(() {
      _isLoading = false;
    });
    print(_isLoading.toString());
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: TextStyle(
              fontFamily: 'Iransans',
            ),
          ),
          backgroundColor: AppTheme.appBarColor,
          iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
          elevation: 0,
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: _isLoading
                  ? SpinKitFadingCircle(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index.isEven ? Colors.grey : Colors.grey,
                          ),
                        );
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'مشخصات راننده',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    height: 2,
                                    color: AppTheme.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 14.0,
                                  ),
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'نظرسنجی راننده',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    height: 2,
                                    color: AppTheme.primary,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 18.0,
                                  ),
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: deviceWidth * 0.15,
                                    height: deviceWidth * 0.155,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                          loadedCollect
                                              .driver.driver_data.driver_image,
                                        ),
                                      ),
                                    ),
//                                  child: FadeInImage(
//                                    placeholder:
//                                        AssetImage('assets/images/circle.gif'),
//                                    image: NetworkImage(loadedCollect
//                                        .driver.driver_data.driver_image),
//                                    fit: BoxFit.contain,
//                                  ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              loadedCollect.driver.driver_data
                                                      .fname +
                                                  ' ' +
                                                  loadedCollect
                                                      .driver.driver_data.lname,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                height: 2,
                                                color: AppTheme.black,
                                                fontFamily: 'Iransans',
                                                fontSize:
                                                    textScaleFactor * 14.0,
                                              ),
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              loadedCollect.driver.car,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                height: 2,
                                                color: AppTheme.black,
                                                fontFamily: 'Iransans',
                                                fontSize:
                                                    textScaleFactor * 14.0,
                                              ),
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'پلاک',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: AppTheme.grey,
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 14.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                loadedCollect.driver.car_number,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: AppTheme.black,
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 16.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'رنگ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: AppTheme.grey,
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 14.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                loadedCollect.driver.car_color,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: AppTheme.black,
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 16.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'وضعیت',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              height: 2,
                                              color: AppTheme.grey,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14.0,
                                            ),
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            loadedCollect.status.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              height: 2,
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 16.0,
                                            ),
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'تاریخ جمع آوری',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: AppTheme.grey,
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 14.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                loadedCollect.collect_day,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: AppTheme.black,
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 16.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'تاریخ درخواست',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: AppTheme.grey,
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 14.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                loadedCollect
                                                    .collect_hour_exact,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: AppTheme.black,
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 16.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'مبلغ کل(تومان)',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: AppTheme.grey,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 14.0,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      loadedCollect.total_price,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: AppTheme.black,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 16.0,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'وزن(کیلوگرم)',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: AppTheme.grey,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 14.0,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      loadedCollect.total_weight,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: AppTheme.black,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 16.0,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'تعداد ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: AppTheme.grey,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 14.0,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      loadedCollect.total_number,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: AppTheme.black,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 16.0,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'لیست پسماندها:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 15,
                                  ),
                                ),
                              ),
                              Consumer<Wastes>(
                                builder: (_, value, ch) => value
                                            .requestWasteItem
                                            .collect_list
                                            .length !=
                                        0
                                    ? Container(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: value.requestWasteItem
                                              .collect_list.length,
                                          itemBuilder: (ctx, i) =>
                                              CollectDetailsCollectItem(
                                            collectItem: value.requestWasteItem
                                                .collect_list[i],
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Text('پسماندی اضافه نشده است'),
                                      ),
                              ),
                            ],
                          ),
                        ),
//                        Spacer(),
                      ],
                    ),
            ),
          ],
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: MainDrawer(),
        ),
      ),
    );
  }
}
