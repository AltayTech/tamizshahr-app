import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:tamizshahr/models/request/collect_time.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';

import '../models/customer.dart';
import '../models/region.dart';
import '../models/request/address.dart';
import '../models/request/collect.dart';
import '../models/request/pasmand.dart';
import '../models/request/price_weight.dart';
import '../models/request/request_address.dart';
import '../models/request/request_waste.dart';
import '../models/request/wasteCart.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../provider/wastes.dart';
import '../widgets/custom_dialog_enter.dart';
import '../widgets/custom_dialog_profile.dart';
import '../widgets/custom_dialog_send_request.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';
import 'navigation_bottom_screen.dart';

class WasteRequestSendScreen extends StatefulWidget {
  static const routeName = '/waste_request_send_screen';

  @override
  _WasteRequestSendScreenState createState() => _WasteRequestSendScreenState();
}

class _WasteRequestSendScreenState extends State<WasteRequestSendScreen> {
  List<WasteCart> wasteCartItems = [];
  bool _isInit = true;

  var _isLoading = true;
  Customer customer;
  int totalPrice = 0;
  int totalWeight = 0;

  int totalPricePure;

  Address selectedAddress;

  Region selectedRegion;

  String _selectedHourStart;

  String _selectedHourend;

  List<String> months = [];

  List<String> weekDays = [];

  List<Jalali> dateList = [];

  Jalali _selectedDay;

  String selectedHours;

  Jalali selectedDay;

  RequestWaste requestWaste;

  void _showLogindialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogEnter(
        title: 'ورود',
        buttonText: 'صفحه ورود ',
        description: 'برای ادامه لطفا وارد شوید',
      ),
    );
  }

  void _showCompletedialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogProfile(
        title: 'اطلاعات کاربری',
        buttonText: 'صفحه پروفایل ',
        description: 'برای ادامه باید اطلاعات کاربری تکمیل کنید',
      ),
    );
  }

  void _showSenddialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogSendRequest(
        title: '',
        buttonText: 'خب',
        description: 'درخواست شما با موفقیت ثبت شد',
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

    getDate(3);
    getMonthAndWeek();
    selectedRegion = Provider.of<Auth>(context, listen: false).regionData;
    selectedHours = Provider.of<Wastes>(context, listen: false).selectedHours;
    selectedDay = Provider.of<Wastes>(context, listen: false).selectedDay;

    selectedAddress = Provider.of<Auth>(context, listen: false).selectedAddress;

    await Provider.of<Auth>(context, listen: false)
        .retrieveRegion(selectedAddress.region.term_id);
    await Provider.of<Auth>(context, listen: false).checkCompleted();

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

  Future<void> getDate(int numberFutureDate) {
    Jalali dateTime = Jalali.now();
    dateList.clear();

    for (int i = 0; i < numberFutureDate; i++) {
      dateList.add(dateTime.addDays(i));
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

  Future<void> createRequest(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    List<Collect> collectList = [];
    for (int i = 0; i < wasteCartItems.length; i++) {
      collectList.add(
        Collect(
          estimated_weight: wasteCartItems[i].weight.toString(),
          estimated_price:
              getPrice(wasteCartItems[i].prices, wasteCartItems[i].weight),
          pasmand: Pasmand(
              id: wasteCartItems[i].id, post_title: wasteCartItems[i].name),
        ),
      );
    }

    requestWaste = RequestWaste(
        collect_date: CollectTime(
            time: selectedHours,
            day:
                '${weekDays[selectedDay.weekDay - 1]}  ${selectedDay.day} ${months[selectedDay.month]}'),
        address_data: RequestAddress(
          name: selectedAddress.name,
          address: selectedAddress.address,
          region: selectedAddress.region.term_id.toString(),
          latitude: selectedAddress.latitude,
          longitude: selectedAddress.longitude,
        ),
        collect_list: collectList);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> sendRequest(BuildContext context, bool isLogin) async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Wastes>(context, listen: false)
        .sendRequest(requestWaste, isLogin);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();
    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;
    bool isCompleted = Provider.of<Auth>(context, listen: false).isCompleted;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ثبت نهایی درخواست',
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
                              fontSize: textScaleFactor * 17.0,
                            ),
                          ),
                        ),
                        Container(
                          height: deviceHeight * 0.25,
                          width: deviceWidth * 0.9,
                          decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.grey, width: 0.2)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                        Container(
                          width: deviceWidth * 0.9,
                          decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.grey, width: 0.2)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.date_range,
                                          color: AppTheme.grey,
                                          size: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'تاریخ جمع آوری',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: AppTheme.grey,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 15.0,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          weekDays[selectedDay.weekDay - 1],
                                          style: TextStyle(
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 18.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Text(
                                        EnArConvertor().replaceArNumber(
                                            selectedDay.day.toString() +
                                                ' ' +
                                                months[selectedDay.month - 1]),
                                        style: TextStyle(
                                          color: AppTheme.black,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 18.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.access_time,
                                          color: AppTheme.grey,
                                          size: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'ساعت جمع آوری',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppTheme.grey,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 15.0,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Center(
                                        child: Text(
                                          selectedHours,
                                          style: TextStyle(
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 18.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.location_on,
                                          color: AppTheme.grey,
                                          size: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'منطقه:',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppTheme.grey,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 15.0,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Center(
                                        child: Text(
                                          selectedRegion.name,
                                          style: TextStyle(
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 18.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                      onTap: () async {
                        SnackBar addToCartSnackBar = SnackBar(
                          content: Text(
                            'سبد خرید خالی می باشد!',
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
                        if (wasteCartItems.isEmpty) {
                          Scaffold.of(context).showSnackBar(addToCartSnackBar);
                        } else if (!isLogin) {
                          _showLogindialog();
                        } else {
                          if (isCompleted) {
                            await createRequest(context);

                            await sendRequest(context, isLogin).then((value) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  NavigationBottomScreen.routeName,
                                  (Route<dynamic> route) => false);
                              _showSenddialog();
                            });
                          } else {
                            _showCompletedialog();
                          }
                        }
                      },
                      child: ButtonBottom(
                        width: deviceWidth * 0.9,
                        height: deviceWidth * 0.14,
                        text: 'تایید نهایی',
                        isActive: wasteCartItems.isNotEmpty,
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
