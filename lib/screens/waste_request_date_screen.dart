import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';

import '../models/customer.dart';
import '../models/region.dart';
import '../models/request/address.dart';
import '../models/request/price_weight.dart';
import '../models/request/wasteCart.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../provider/wastes.dart';
import '../screens/waste_request_send_screen.dart';
import '../widgets/custom_dialog_enter.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';

class WasteRequestDateScreen extends StatefulWidget {
  static const routeName = '/waste_request_date_screen';

  @override
  _WasteRequestDateScreenState createState() => _WasteRequestDateScreenState();
}

class _WasteRequestDateScreenState extends State<WasteRequestDateScreen> {
  List<WasteCart> wasteCartItems = [];
  bool _isInit = true;

  var _isLoading = true;
  late Customer customer;
  late int totalPrice = 0;
  late int totalWeight = 0;

  late int totalPricePure;

  late Address selectedAddress;

  late Region selectedRegion;

  String _selectedHourStart = '';

  late String _selectedHourend;

  List<String> months = [];

  List<String> weekDays = [];

  List<Jalali> dateList = [];

  Jalali _selectedDay = Jalali.now();

  void _showLogindialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogEnter(
        title: 'ورود',
        buttonText: 'صفحه ورود ',
        description: 'برای ادامه لطفا وارد شوید',
        image: Image.asset('assets/images/main_page_request_ic.png'),
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;

      await getRegionDate();

      _isLoading = false;
      setState(() {});
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> getRegionDate() async {
    setState(() {
      _isLoading = true;
    });
    selectedAddress = Provider.of<Auth>(context, listen: false).selectedAddress;

    await Provider.of<Auth>(context, listen: false)
        .retrieveRegion(selectedAddress.region.term_id);

    selectedRegion = Provider.of<Auth>(context, listen: false).regionData;

    getDate(3);
    getMonthAndWeek();

    wasteCartItems = Provider.of<Wastes>(context, listen: false).wasteCartItems;
    totalPrice = 0;
    totalWeight = 0;

    totalPricePure = 0;
    if (wasteCartItems.length > 0) {
      for (int i = 0; i < wasteCartItems.length; i++) {
        print(wasteCartItems[i].featured_image.sizes.medium);
        wasteCartItems[i].prices.length > 0
            ? totalPrice = totalPrice +
                int.parse(getPrice(
                        wasteCartItems[i].prices, wasteCartItems[i].weight)) *
                    wasteCartItems[i].weight
            : totalPrice = totalPrice;
        wasteCartItems[i].prices.length > 0
            ? totalWeight = totalWeight + wasteCartItems[i].weight
            : totalWeight = totalWeight;
      }
    }
    totalPricePure = totalPrice;

    setState(() {
      _isLoading = false;
    });
  }

  String getPrice(List<PriceWeight> prices, int weight) {
    String price = '0';

    for (int i = 0; i < prices.length; i++) {
      if (weight > int.parse(prices[i].weight)) {
        price = prices[i].price;
      } else {
        price = prices[i].price;
        break;
      }
    }
    return price;
  }

  String getHours(String start, String end) {
    String date = '';
    date = start.substring(0, 2) + '-' + end.substring(0, 2);
    return date;
  }

  void getMonthAndWeek() {
    months = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];
    weekDays = [
      'شنبه',
      'یکشنبه',
      'دوشنبه',
      'سه شنبه',
      'چهارشنبه',
      'پنج شنبه',
      'جمعه',
    ];
  }

  Future<void> getDate(int numberFutureDate) async {
    Jalali dateTime = Jalali.now();
    dateList.clear();

    for (int i = 0; i < numberFutureDate; i++) {
      dateList.add(dateTime.addDays(i + 1));
    }
  }

  Future<void> changeCat(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> sendDate() async {
    String _selectedHours = getHours(_selectedHourStart, _selectedHourend);
    Provider.of<Wastes>(context, listen: false).selectedHours = _selectedHours;
    Provider.of<Wastes>(context, listen: false).selectedDay = _selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();
    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعیین تاریخ جمع آوری',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.white,
            fontFamily: 'Iransans',
            fontSize: textScaleFactor * 15.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.appBarColor,
        iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
      ),
      body: Builder(builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'اطلاعات درخواست',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.h1,
                              fontFamily: 'Iransans',
                              fontWeight: FontWeight.w500,
                              fontSize: textScaleFactor * 16.0,
                            ),
                          ),
                        ),
                        Container(
                          height: deviceHeight * 0.25,
                          decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.grey, width: 0.2)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, bottom: 8.0),
                                        child: Image.asset(
                                          'assets/images/main_page_request_ic.png',
                                          height: deviceWidth * 0.06,
                                          width: deviceWidth * 0.06,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'تعداد ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          EnArConvertor()
                                              .replaceArNumber(wasteCartItems
                                                  .length
                                                  .toString())
                                              .toString(),
                                          style: TextStyle(
                                            color: AppTheme.h1,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, bottom: 2.0),
                                        child: Image.asset(
                                          'assets/images/waste_cart_price_ic.png',
                                          height: deviceWidth * 0.06,
                                          width: deviceWidth * 0.06,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'مبلغ کل',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                      Text(
                                        '(تومان)',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          totalPrice.toString().isNotEmpty
                                              ? EnArConvertor().replaceArNumber(
                                                  currencyFormat
                                                      .format(totalPrice)
                                                      .toString())
                                              : EnArConvertor()
                                                  .replaceArNumber('0'),
                                          style: TextStyle(
                                            color: AppTheme.h1,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, bottom: 2.0),
                                        child: Image.asset(
                                          'assets/images/waste_cart_weight_ic.png',
                                          height: deviceWidth * 0.06,
                                          width: deviceWidth * 0.06,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'وزن کل',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                      Text(
                                        '(کیلوگرم)',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          EnArConvertor()
                                              .replaceArNumber(
                                                  totalWeight.toString())
                                              .toString(),
                                          style: TextStyle(
                                            color: AppTheme.h1,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 18,
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
                        Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                height: deviceHeight * 0.15,
                                child: LayoutBuilder(
                                  builder: (_, constraint) => Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Icon(
                                                Icons.date_range,
                                                color: AppTheme.grey,
                                              ),
                                            ),
                                            Text(
                                              'تاریخ جمع آوری',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize:
                                                    textScaleFactor * 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraint.maxHeight * 0.7,
                                        width: constraint.maxWidth,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: dateList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                _selectedDay = dateList[index];

                                                changeCat(context);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  height: constraint.maxHeight *
                                                      0.55,
                                                  width: constraint.maxWidth *
                                                      0.31,
                                                  decoration: _selectedDay ==
                                                          dateList[index]
                                                      ? BoxDecoration(
                                                          color:
                                                              AppTheme.primary,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                    AppTheme.bg,
                                                                blurRadius: 4,
                                                                spreadRadius: 4)
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            15,
                                                          ),
                                                        )
                                                      : BoxDecoration(
                                                          color: AppTheme.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                    AppTheme.bg,
                                                                blurRadius: 4,
                                                                spreadRadius: 4)
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            15,
                                                          ),
                                                        ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          EnArConvertor().replaceArNumber(
                                                              weekDays[dateList[
                                                                          index]
                                                                      .weekDay -
                                                                  1]),
                                                          style: TextStyle(
                                                            color: _selectedDay ==
                                                                    dateList[
                                                                        index]
                                                                ? AppTheme.white
                                                                : AppTheme.h1,
                                                            fontFamily:
                                                                'Iransans',
                                                            fontSize:
                                                                textScaleFactor *
                                                                    18.0,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          EnArConvertor().replaceArNumber(dateList[
                                                                      index]
                                                                  .day
                                                                  .toString() +
                                                              ' ' +
                                                              months[dateList[
                                                                          index]
                                                                      .month -
                                                                  1]),
                                                          style: TextStyle(
                                                            color: _selectedDay ==
                                                                    dateList[
                                                                        index]
                                                                ? AppTheme.white
                                                                : AppTheme.h1,
                                                            fontFamily:
                                                                'Iransans',
                                                            fontSize:
                                                                textScaleFactor *
                                                                    15.0,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                height: deviceHeight * 0.15,
                                width: deviceWidth,
                                child: LayoutBuilder(
                                  builder: (_, constraint) => Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Icon(
                                                Icons.access_time,
                                                color: AppTheme.grey,
                                              ),
                                            ),
                                            Text(
                                              'ساعت جمع آوری',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize:
                                                    textScaleFactor * 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraint.maxHeight * 0.7,
                                        width: constraint.maxWidth,
                                        child: _isLoading
                                            ? Container()
                                            : Consumer<Auth>(
                                                builder: (_, data, ch) =>
                                                    ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: data.regionData
                                                      .collect_hour.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        _selectedHourStart =
                                                            data
                                                                .regionData
                                                                .collect_hour[
                                                                    index]
                                                                .start;
                                                        _selectedHourend = data
                                                            .regionData
                                                            .collect_hour[index]
                                                            .end;

                                                        changeCat(context);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: constraint
                                                                  .maxHeight *
                                                              0.55,
                                                          width: constraint
                                                                  .maxWidth *
                                                              0.31,
                                                          decoration: _selectedHourStart ==
                                                                  data
                                                                      .regionData
                                                                      .collect_hour[
                                                                          index]
                                                                      .start
                                                              ? BoxDecoration(
                                                                  color: AppTheme
                                                                      .primary,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: AppTheme
                                                                            .bg,
                                                                        blurRadius:
                                                                            4,
                                                                        spreadRadius:
                                                                            4)
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    15,
                                                                  ),
                                                                )
                                                              : BoxDecoration(
                                                                  color: AppTheme
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: AppTheme
                                                                            .bg,
                                                                        blurRadius:
                                                                            4,
                                                                        spreadRadius:
                                                                            4)
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    15,
                                                                  ),
                                                                ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 8.0),
                                                              child: Text(
                                                                getHours(
                                                                    data
                                                                        .regionData
                                                                        .collect_hour[
                                                                            index]
                                                                        .start,
                                                                    data
                                                                        .regionData
                                                                        .collect_hour[
                                                                            index]
                                                                        .end),
                                                                style:
                                                                    TextStyle(
                                                                  color: _selectedHourStart ==
                                                                          data
                                                                              .regionData
                                                                              .collect_hour[
                                                                                  index]
                                                                              .start
                                                                      ? AppTheme
                                                                          .white
                                                                      : AppTheme
                                                                          .h1,
                                                                  fontFamily:
                                                                      'Iransans',
                                                                  fontSize:
                                                                      textScaleFactor *
                                                                          22.0,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ))),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        SnackBar addToCartSnackBar = SnackBar(
                          content: Text(
                            'تاریخ و ساعت جمع آوری انتخاب شود',
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
                        if (_selectedDay == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(addToCartSnackBar);
                        } else if (!isLogin) {
                          _showLogindialog();
                        } else {
                          sendDate();
                          Navigator.of(context)
                              .pushNamed(WasteRequestSendScreen.routeName);
                        }
                      },
                      child: ButtonBottom(
                        width: deviceWidth * 0.9,
                        height: deviceWidth * 0.14,
                        text: 'ادامه',
                        isActive: _selectedDay != null,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: _isLoading
                          ? SpinKitFadingCircle(
                              itemBuilder: (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index.isEven
                                        ? Colors.grey
                                        : Colors.grey,
                                  ),
                                );
                              },
                            )
                          : Container(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: MainDrawer(),
      ),
    );
  }
}
