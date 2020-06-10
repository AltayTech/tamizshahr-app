import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../models/customer.dart';
import '../models/price_weight.dart';
import '../models/wasteCart.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../provider/wastes.dart';
import '../screens/wastes_screen.dart';
import '../widgets/custom_dialog_enter.dart';
import '../widgets/custom_dialog_profile.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';
import '../widgets/waste_cart_item.dart';
import 'address_screen.dart';

class WasteCartScreen extends StatefulWidget {
  static const routeName = '/waste_cart_screen';

  @override
  _WasteCartScreenState createState() => _WasteCartScreenState();
}

class _WasteCartScreenState extends State<WasteCartScreen> {
  List<WasteCart> wasteCartItems = [];
  bool _isInit = true;

  var _isLoading = true;
  Customer customer;
  int totalPrice = 0;
  int totalWeight = 0;

  int totalPricePure;

  void _showLogindialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogEnter(
        title: 'ورود',
        buttonText: 'صفحه ورود ',
        description: 'برای ادامه باید وارد شوید',
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

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;

      await getWasteItems();

      _isLoading = false;
      setState(() {});
    }
    _isInit = false;
    await getWasteItems();

    super.didChangeDependencies();
  }

  Future<void> getWasteItems() async {
    print(wasteCartItems.toString());

    setState(() {
      _isLoading = true;
    });
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

  void setStateFun() {
    getWasteItems();
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
                        Container(
                          height: deviceHeight * 0.13,
                          decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.grey, width: 0.2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(
                                          Icons.restore_from_trash,
                                          color: AppTheme.primary,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
                                        EnArConvertor()
                                            .replaceArNumber(wasteCartItems
                                                .length
                                                .toString())
                                            .toString(),
                                        style: TextStyle(
                                          color: AppTheme.h1,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 15,
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
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(
                                          Icons.monetization_on,
                                          color: AppTheme.primary,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
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
                                          fontSize: textScaleFactor * 15,
                                        ),
                                      ),
                                      Text(
                                        'تومان ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(
                                          Icons.signal_wifi_4_bar_lock,
                                          color: AppTheme.primary,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
                                        EnArConvertor()
                                            .replaceArNumber(
                                                totalWeight.toString())
                                            .toString(),
                                        style: TextStyle(
                                          color: AppTheme.h1,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 15,
                                        ),
                                      ),
                                      Text(
                                        'کیلوگرم ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12,
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
                          child: Consumer<Wastes>(
                            builder: (_, value, ch) => value
                                        .wasteCartItems.length !=
                                    0
                                ? Container(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: value.wasteCartItems.length,
                                      itemBuilder: (ctx, i) => WasteCartItem(
                                        wasteItem: value.wasteCartItems[i],
                                        callFunction: setStateFun,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text('محصولی اضافه نشده است'),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {
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
                                Scaffold.of(context)
                                    .showSnackBar(addToCartSnackBar);
                              } else if (!isLogin) {
                                _showLogindialog();
                              } else {
//                                if (customer
//                                    .personalData.personal_data_complete) {
                                Navigator.of(context)
                                    .pushNamed(AddressScreen.routeName);
//                                } else {
//                                  _showCompletedialog();
//                                }
                              }
                            },
                            child: Container(
                              width: deviceWidth * 0.8,
                              height: deviceWidth * 0.1,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.0,
                                    // has the effect of softening the shadow
                                    spreadRadius: 0,
                                    // has the effect of extending the shadow
                                    offset: Offset(
                                      1.0, // horizontal, move right 10
                                      1.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                color: wasteCartItems.isEmpty
                                    ? AppTheme.grey
                                    : AppTheme.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'ادامه',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 13.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                              : Container()))
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: deviceWidth * 0.1 + 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              WastesScreen.routeName,
            );
          },
          backgroundColor: AppTheme.primary,
          child: Icon(
            Icons.add,
            color: AppTheme.white,
          ),
        ),
      ),
    );
  }
}
