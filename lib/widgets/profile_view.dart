import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/screens/collect_list_screen.dart';
import 'package:tamizshahr/screens/orders_screen.dart';

import '../classes/top_bar.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../provider/customer_info.dart';
import '../features/customer_feature/presentation/screens/customer_user_info_screen.dart';
import '../features/customer_feature/presentation/screens/login_screen.dart';
import '../screens/messages_screen.dart';
import 'main_item_button.dart';

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
                            right: 20,
                            left: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
//                                InkWell(
//                                  onTap: () async {
//                                    Provider.of<CustomerInfo>(context,
//                                            listen: false)
//                                        .customer = Provider.of<CustomerInfo>(
//                                            context,
//                                            listen: false)
//                                        .customer_zero;
//                                    await Provider.of<Auth>(context,
//                                            listen: false)
//                                        .removeToken();
//                                    Provider.of<Auth>(context, listen: false)
//                                        .isFirstLogout = true;
//                                    Navigator.of(context).pop();
//                                    Navigator.of(context)
//                                        .pushNamedAndRemoveUntil(
//                                            NavigationBottomScreen.routeName,
//                                            (Route<dynamic> route) => false);
//                                  },
//                                  child: Row(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.center,
//                                    children: <Widget>[
////                                Padding(
////                                  padding: const EdgeInsets.all(8),
////                                  child: Icon(FontAwesomeIcons.signOutAlt,color: AppTheme.white,),
////                                ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(top: 4),
//                                        child: Text(
//                                          'خروج از حساب کاربری',
//                                          textAlign: TextAlign.left,
//                                          style: TextStyle(
//                                              color: AppTheme.bg,
//                                              fontFamily: 'Iransans',
//                                              fontSize: textScaleFactor * 14,
//                                              fontWeight: FontWeight.w600),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
                                Spacer(),
                                Text(
                                  'پروفایل کاربری',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: AppTheme.bg,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 24.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
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
                                  padding: const EdgeInsets.all(5.0),
                                  child: GridView(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              OrdersScreen.routeName);
                                        },
                                        child: MainItemButton(
                                          title: 'سفارش',
                                          itemPaddingF: itemPaddingF,
                                          imageUrl:
                                              'assets/images/orders_list.png',
                                          isMonoColor: false,
                                          imageSizeFactor: 0.25,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              CustomerUserInfoScreen.routeName);
                                        },
                                        child: MainItemButton(
                                          title: 'اطلاعات شخصی',
                                          itemPaddingF: itemPaddingF,
                                          imageUrl:
                                              'assets/images/user_Icon.png',
                                          isMonoColor: false,
                                          imageSizeFactor: 0.30,
                                        ),

//
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              MessageScreen.routeName);
                                        },
                                        child: MainItemButton(
                                          title: 'پیام ها',
                                          itemPaddingF: itemPaddingF,
                                          imageUrl:
                                              'assets/images/message_icon.png',
                                          isMonoColor: false,
                                          imageSizeFactor: 0.25,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              CollectListScreen.routeName);
                                        },
                                        child: MainItemButton(
                                          title: 'درخواست ها',
                                          itemPaddingF: itemPaddingF,
                                          imageUrl:
                                              'assets/images/main_page_request_ic.png',
                                          isMonoColor: false,
                                          imageSizeFactor: 0.35,
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
