import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/customer.dart';
import 'package:tamizshahr/provider/auth.dart';
import 'package:tamizshahr/provider/customer_info.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';
import 'package:tamizshahr/widgets/currency_input_formatter.dart';
import 'package:tamizshahr/widgets/custom_dialog_send_request.dart';

import '../models/search_detail.dart';
import '../provider/app_theme.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';
import 'customer_info/login_screen.dart';
import 'navigation_bottom_screen.dart';

class ClearScreen extends StatefulWidget {
  static const routeName = '/ClearScreen';

  @override
  _ClearScreenState createState() => _ClearScreenState();
}

class _ClearScreenState extends State<ClearScreen>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;
  var _isLoading = false;
  int page = 1;
  SearchDetail productsDetail;

  Customer customer;

  final shabaController = TextEditingController();
  final donationController = TextEditingController();

  @override
  void initState() {
    Provider.of<CustomerInfo>(context, listen: false).sPage = 1;

    Provider.of<CustomerInfo>(context, listen: false).searchBuilder();

    shabaController.text = 'IR';
    donationController.text = '0';
    super.initState();
  }

  @override
  void dispose() {
    shabaController.dispose();
    donationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      getCustomerInfo();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> getCustomerInfo() async {
    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;
    if (isLogin) {
      await Provider.of<CustomerInfo>(context, listen: false).getCustomer();
    }
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

  Future<void> sendClearingRequest(String money, String shaba) async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<CustomerInfo>(context, listen: false)
        .sendClearingRequest(money.toString(), shaba);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    bool isLogin = Provider.of<Auth>(context).isAuth;

    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'درخواست تسویه',
          style: TextStyle(
            fontFamily: 'Iransans',
          ),
        ),
        backgroundColor: AppTheme.appBarColor,
        iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Builder(
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: deviceHeight * 0.0,
                    horizontal: deviceWidth * 0.03),
                child: !isLogin
                    ? Container(
                        height: deviceHeight * 0.8,
                        child: Center(
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('شما وارد نشده اید'),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(LoginScreen.routeName);
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'ورود به حساب کاربری',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppTheme.primary,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          color: AppTheme.white,
                          height: deviceHeight * 0.9,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          border: Border.all(
                                            width: 5,
                                            color: AppTheme.white,
                                          )),
                                      height: deviceWidth * 0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              height: deviceWidth * 0.9,
                                              width: deviceWidth,
                                              color: AppTheme.white,
                                              child: FadeInImage(
                                                placeholder: AssetImage(
                                                    'assets/images/circle.gif'),
                                                image: AssetImage(
                                                    'assets/images/wallet_money_bg.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'امتیاز',
                                                    style: TextStyle(
                                                      color: AppTheme.grey,
                                                      fontFamily: 'Iransans',
                                                      fontSize:
                                                          textScaleFactor *
                                                              13.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Consumer<CustomerInfo>(
                                                    builder: (_, data, ch) =>
                                                        Text(
                                                      data.customer != null
                                                          ? EnArConvertor().replaceArNumber(
                                                              currencyFormat
                                                                  .format(double
                                                                      .parse(data
                                                                          .customer
                                                                          .money))
                                                                  .toString())
                                                          : EnArConvertor()
                                                              .replaceArNumber(
                                                                  currencyFormat
                                                                      .format(double
                                                                          .parse(
                                                                              '0'))),
                                                      style: TextStyle(
                                                        color: AppTheme.black,
                                                        fontFamily: 'Iransans',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize:
                                                            textScaleFactor *
                                                                18.0,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Text(
                                                    'تومان',
                                                    style: TextStyle(
                                                      color: AppTheme.grey,
                                                      fontFamily: 'Iransans',
                                                      fontSize:
                                                          textScaleFactor *
                                                              13.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: Text(
                                        'شماره شبا',
                                        style: TextStyle(
                                          color: AppTheme.h1,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14.0,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: AppTheme.h1,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 16.0,
                                      ),
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      textInputAction: TextInputAction.go,
                                      keyboardType: TextInputType.number,
                                      controller: shabaController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        border: OutlineInputBorder(
                                          gapPadding: 10,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 10.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, left: 8, right: 8),
                                      child: Text(
                                        'مقدار درخواستی(تومان)',
                                        style: TextStyle(
                                          color: AppTheme.h1,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14.0,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: AppTheme.h1,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 16.0,
                                      ),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      textInputAction: TextInputAction.go,
                                      controller: donationController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 0,
                                            bottom: 10),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 10.0,
                                        ),
                                      ),
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly,
                                        new CurrencyInputFormatter(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: () async {
                                    SnackBar addToCartSnackBar = SnackBar(
                                      content: Text(
                                        'شماره شبا را وارد نمایید',
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
                                    if (shabaController.text == null ||
                                        shabaController.text == 'IR') {
                                      Scaffold.of(context)
                                          .showSnackBar(addToCartSnackBar);
                                    } else {
                                      await sendClearingRequest(
                                              donationController.text,
                                              shabaController.text)
                                          .then((value) => Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  NavigationBottomScreen
                                                      .routeName,
                                                  (Route<dynamic> route) =>
                                                      false));
                                      _showSenddialog();
                                    }
                                  },
                                  child: ButtonBottom(
                                    width: deviceWidth * 0.9,
                                    height: deviceWidth * 0.14,
                                    text: 'تسویه',
                                    isActive: true,
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
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
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
              ),
            ),
          );
        },
      ),
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
