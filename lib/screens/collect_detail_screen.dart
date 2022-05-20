import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/request/request_waste_item.dart';
import 'package:tamizshahr/provider/wastes.dart';
import 'package:tamizshahr/screens/collect_list_screen.dart';
import 'package:tamizshahr/screens/waste_request_send_screen.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';
import 'package:tamizshahr/widgets/collect_details_collects_item.dart';
import 'package:tamizshahr/widgets/en_to_ar_number_convertor.dart';

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
    await Provider.of<Wastes>(context, listen: false).retrieveCollectItem(productId);
    loadedCollect = Provider.of<Wastes>(context, listen: false).requestWasteItem;
    print('ssssssssssssssssssss ' + loadedCollect.collect_list.length.toString());

    setState(() {
      _isLoading = false;
    });
    print(_isLoading.toString());
  }

  Future<void> sendDate() async {
    // String _selectedHours = getHours(_selectedHourStart, _selectedHourend);
    // Provider.of<Wastes>(context, listen: false).selectedHours = _selectedHours;
    // Provider.of<Wastes>(context, listen: false).selectedDay = _selectedDay;

    await Provider.of<Wastes>(context, listen: false).cancelRequest(loadedCollect.id);
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
      body: Builder(builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: <Widget>[
              if (_isLoading)
                Align(
                  alignment: Alignment.center,
                  child: SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.isEven ? Colors.grey : Colors.grey,
                        ),
                      );
                    },
                  ),
                )
              else
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
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
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: AppTheme.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: deviceWidth * 0.15,
                                    height: deviceWidth * 0.155,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                          loadedCollect.driver.driver_data.driver_image != null
                                              ? loadedCollect.driver.driver_data.driver_image.sizes.medium
                                              : '',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            loadedCollect.driver.driver_data.fname +
                                                ' ' +
                                                loadedCollect.driver.driver_data.lname,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              height: 2,
                                              color: AppTheme.black,
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
                                            loadedCollect.driver.car.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              height: 2,
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14.0,
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
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              'پلاک',
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
                                              EnArConvertor().replaceArNumber(loadedCollect.driver.car_number),
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
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              'رنگ',
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
                                              loadedCollect.driver.car_color.name,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: AppTheme.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                      Spacer(),
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
                                            fontSize: textScaleFactor * 15.0,
                                          ),
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'تاریخ درخواست',
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
                                          EnArConvertor().replaceArNumber(
                                            loadedCollect.collect_date.day,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 2,
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 15.0,
                                          ),
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'ساعت درخواست',
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
                                          EnArConvertor().replaceArNumber(
                                            loadedCollect.collect_date.time,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 2,
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 15.0,
                                          ),
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'منطقه درخواست',
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
                                          EnArConvertor().replaceArNumber(
                                            loadedCollect.address_data.region.name,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 2,
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 15.0,
                                          ),
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'تاریخ جمع آوری',
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
                                          loadedCollect.collect_date.collect_done_time != ''
                                              ? EnArConvertor()
                                                  .replaceArNumber(loadedCollect.collect_date.collect_done_time)
                                              : 'جمع آوری نشده است',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 2,
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 15.0,
                                          ),
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppTheme.white),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Text(
                                      'مبلغ کل (تومان):',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: Colors.black54,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 15.0,
                                      ),
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'درخواست:',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                height: 2,
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize: textScaleFactor * 12.0,
                                              ),
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                EnArConvertor().replaceArNumber(currencyFormat
                                                    .format(double.parse(loadedCollect.total_collects_price.estimated))
                                                    .toString()),
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
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'تحویل:',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                height: 2,
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize: textScaleFactor * 12.0,
                                              ),
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                EnArConvertor().replaceArNumber(currencyFormat
                                                    .format(double.parse(loadedCollect.total_collects_price.exact))
                                                    .toString()),
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
                                    ],
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'وزن کل (کیلوگرم):',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: Colors.black54,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 15.0,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'درخواست:',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                height: 2,
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize: textScaleFactor * 12.0,
                                              ),
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                EnArConvertor().replaceArNumber(currencyFormat
                                                    .format(double.parse(loadedCollect.total_collects_weight.estimated))
                                                    .toString()),
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
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'تحویل:',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                height: 2,
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize: textScaleFactor * 12.0,
                                              ),
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                EnArConvertor().replaceArNumber(currencyFormat
                                                    .format(double.parse(loadedCollect.total_collects_weight.exact))
                                                    .toString()),
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
                                    ],
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Text(
                                      'تعداد کل:',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: Colors.black54,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 15.0,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'درخواست:',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                height: 2,
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize: textScaleFactor * 12.0,
                                              ),
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                EnArConvertor().replaceArNumber(currencyFormat
                                                    .format(double.parse(loadedCollect.total_collects_number.estimated))
                                                    .toString()),
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
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                'تحویل:',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: AppTheme.grey,
                                                  fontFamily: 'Iransans',
                                                  fontSize: textScaleFactor * 12.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                EnArConvertor().replaceArNumber(currencyFormat
                                                    .format(double.parse(loadedCollect.total_collects_number.exact))
                                                    .toString()),
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            'لیست پسماندها:',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 2,
                              color: AppTheme.grey,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 15.0,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Consumer<Wastes>(
                            builder: (_, value, ch) => value.requestWasteItem.collect_list.length != 0
                                ? Container(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: value.requestWasteItem.collect_list.length,
                                      itemBuilder: (ctx, i) => CollectDetailsCollectItem(
                                        collectItem: value.requestWasteItem.collect_list[i],
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text('پسماندی اضافه نشده است'),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            onTap: () {
                              if( loadedCollect.status.slug=='cancel') {
                                SnackBar addToCartSnackBar = SnackBar(
                                  content: Text(
                                    'درخواست  لغو شده است',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 14.0,
                                    ),
                                  ),
                                  action: SnackBarAction(
                                    label: 'متوجه شدم',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                // if (_selectedHourStart == null ||
                                //     _selectedDay == null) {
                                Scaffold.of(context).showSnackBar(addToCartSnackBar);
                              }else if( loadedCollect.status.slug=='collected') {
                                SnackBar addToCartSnackBar = SnackBar(
                                  content: Text(
                                    'درخواست جمع آوری شده است',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 14.0,
                                    ),
                                  ),
                                  action: SnackBarAction(
                                    label: 'متوجه شدم',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                // if (_selectedHourStart == null ||
                                //     _selectedDay == null) {
                                Scaffold.of(context).showSnackBar(addToCartSnackBar);
                              }else{
                                SnackBar addToCartSnackBar = SnackBar(
                                  content: Text(
                                    'درخواست جمع آوری لغو شد',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 14.0,
                                    ),
                                  ),
                                  action: SnackBarAction(
                                    label: 'متوجه شدم',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                // if (_selectedHourStart == null ||
                                //     _selectedDay == null) {
                                Scaffold.of(context).showSnackBar(addToCartSnackBar);
                                // }  else {
                                sendDate();
                                Navigator.of(context).pushReplacementNamed(CollectListScreen.routeName);
                                // }
                              }
                            },
                            child: ButtonBottom(
                              width: deviceWidth * 0.9,
                              height: deviceWidth * 0.14,
                              text: 'لغو درخواست',
                              isActive: loadedCollect.status.slug!='cancel'|| loadedCollect.status.slug!='collected',
                            ),
                          ),
                        )
//                        Spacer(),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: MainDrawer(),
      ),
    );
  }
}
