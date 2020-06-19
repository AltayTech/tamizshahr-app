import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/screens/collect_list_screen.dart';
import 'package:tamizshahr/screens/orders_screen.dart';

import '../classes/top_bar.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../provider/customer_info.dart';
import '../screens/customer_info/customer_user_info_screen.dart';
import '../screens/customer_info/login_screen.dart';
import '../screens/messages_screen.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var _isLoading = false;
  bool _isInit = true;

  Future<void> cashOrder() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CustomerInfo>(context, listen: false).getCustomer();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      cashOrder();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;

    double deviceSizeWidth = MediaQuery.of(context).size.width;
    double deviceSizeHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    double itemPaddingF = 0.03;
    return !isLogin
        ? Container(
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
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'ورود به اکانت کاربری',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container(
            width: deviceSizeWidth,
            height: deviceSizeHeight,
            child: Align(
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
                  : Container(
                      width: deviceSizeWidth,
                      height: deviceSizeHeight,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              top: deviceSizeHeight * 0,
                              width: deviceSizeWidth,
                              child: TopBar()),

                          Positioned(
                            top: deviceSizeHeight * 0.070,
                            width: deviceSizeWidth * 0.4,
                            right: 20,
                            child: Text(
                              'پروفایل کاربری',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppTheme.bg,
                                  fontFamily: 'Iransans',
                                  fontSize: textScaleFactor * 24.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          Positioned(
                              top: deviceSizeHeight * 0.250,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: deviceSizeHeight * 0.7,
                                width: deviceSizeWidth * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GridView(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              OrdersScreen.routeName);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              deviceSizeWidth * itemPaddingF),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppTheme.primary
                                                        .withOpacity(0.08),

                                                    blurRadius: 10.10,
                                                    // has the effect of softening the shadow
                                                    spreadRadius: 10.510,
                                                    // has the effect of extending the shadow
                                                    offset: Offset(
                                                      0, // horizontal, move right 10
                                                      0, // vertical, move down 10
                                                    ),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/orders_list.png',
                                                  fit: BoxFit.contain,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'سفارش',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppTheme.primary,
                                                      fontFamily: 'Iransans',
                                                      fontSize:
                                                          textScaleFactor *
                                                              18.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              CustomerUserInfoScreen.routeName);
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                deviceSizeWidth * itemPaddingF),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppTheme.primary
                                                          .withOpacity(0.08),

                                                      blurRadius: 10.10,
                                                      // has the effect of softening the shadow
                                                      spreadRadius: 10.510,
                                                      // has the effect of extending the shadow
                                                      offset: Offset(
                                                        0, // horizontal, move right 10
                                                        0, // vertical, move down 10
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/user_Icon.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FittedBox(
                                                      child: Text(
                                                        'اطلاعات شخصی',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              AppTheme.primary,
                                                          fontFamily:
                                                              'Iransans',
                                                          fontSize:
                                                              textScaleFactor *
                                                                  16.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              MessageScreen.routeName);
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                deviceSizeWidth * itemPaddingF),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppTheme.primary
                                                          .withOpacity(0.08),

                                                      blurRadius: 10.10,
                                                      // has the effect of softening the shadow
                                                      spreadRadius: 10.510,
                                                      // has the effect of extending the shadow
                                                      offset: Offset(
                                                        0, // horizontal, move right 10
                                                        0, // vertical, move down 10
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/message_icon.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'پیام ها',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: AppTheme.primary,
                                                        fontFamily: 'Iransans',
                                                        fontSize:
                                                            textScaleFactor *
                                                                18.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              CollectListScreen.routeName);
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                deviceSizeWidth * itemPaddingF),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppTheme.primary
                                                          .withOpacity(0.08),

                                                      blurRadius: 10.10,
                                                      // has the effect of softening the shadow
                                                      spreadRadius: 10.510,
                                                      // has the effect of extending the shadow
                                                      offset: Offset(
                                                        0, // horizontal, move right 10
                                                        0, // vertical, move down 10
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40,
                                                            right: 40,
                                                            bottom: 0,
                                                            top: 5),
                                                    child: Image.asset(
                                                      'assets/images/main_page_request_ic.png',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(

                                                        bottom: 5,
                                                        top: 0),
                                                    child: Text(
                                                      'درخواست ها',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: AppTheme.primary,
                                                        fontFamily: 'Iransans',
                                                        fontSize:
                                                            textScaleFactor *
                                                                18.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2,
                                    ),
                                  ),
                                ),
                              )
//
                              ),
//
                        ],
                      ),
                    ),
            ),
          );
  }
}
