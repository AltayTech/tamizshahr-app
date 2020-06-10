import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customer_info.dart';
import '../provider/auth.dart';
import '../screens/about_us_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/contact_with_us_screen.dart';
import '../screens/customer_info/login_screen.dart';
import '../screens/customer_info/profile_screen.dart';
import '../screens/guide_screen.dart';
import '../screens/navigation_bottom_screen.dart';
import '../screens/product_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    Color textColor = Colors.white;
    Color iconColor = Colors.white38;
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
              ),

              Wrap(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: deviceHeight * 0.25,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/main_page_header.png',
                          fit: BoxFit.cover,
                        ),
                      ),
//                      Container(
//                        width: double.infinity,
//                        height: deviceHeight * 0.25,
//                        padding: EdgeInsets.all(20),
//                        alignment: Alignment.center,
//                        color: Colors.purpleAccent.withOpacity(0.1),
//                        child: Padding(
//                          padding: const EdgeInsets.only(top: 20.0),
//                          child: Text(
//                            'نسخه آزمایشی فروشگاه \n همراه ساتل',
//                            style: TextStyle(
//                                fontWeight: FontWeight.w400,
//                                fontSize: 24,
//                                height: 2,
//                                fontFamily: 'BFarnaz',
//                                color: AppTheme.bg),
//                            textAlign: TextAlign.center,
//                          ),
//                        ),
//                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<Auth>(
                    builder: (_, auth, ch) => ListTile(
                      title: Text(
                        auth.isAuth ? 'پروفایل' : 'ورود',
                        style: TextStyle(
                          fontFamily: "Iransans",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: textColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      trailing: Icon(
                        Icons.account_circle,
                        color: iconColor,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        auth.isAuth
                            ? Navigator.of(context)
                                .pushNamed(ProfileScreen.routeName)
                            : Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                      },
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    height: deviceHeight * 0.63,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'خانه',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              Icons.home,
                              color: iconColor,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.of(context)
                                  .pushNamed(NavigationBottomScreen.routeName);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'محصولات',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              Icons.phonelink,
                              color: iconColor,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.of(context).pushNamed(
                                  ProductsScreen.routeName,
                                  arguments: 0);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'سبد خرید',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              Icons.shopping_cart,
                              color: iconColor,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.of(context)
                                  .pushNamed(CartScreen.routeName);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'راهنما',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              Icons.help,
                              color: iconColor,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.of(context)
                                  .pushNamed(GuideScreen.routeName);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'تماس با ما',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              Icons.contact_phone,
                              color: iconColor,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.of(context)
                                  .pushNamed(ContactWithUs.routeName);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'درباره ما',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              Icons.account_balance,
                              color: iconColor,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.of(context)
                                  .pushNamed(AboutUsScreen.routeName);
                            },
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey.withOpacity(0.6),
                          ),
                          ListTile(
                            title: Text(
                              'خروج',
                              style: TextStyle(
                                fontFamily: 'Iransans',
                                fontSize: textScaleFactor * 13.0,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              Icons.power_settings_new,
                              color: Colors.red,
                            ),
                            onTap: () async {
                              Provider.of<CustomerInfo>(context, listen: false).customer =
                                  Provider.of<CustomerInfo>(context, listen: false)
                                      .customer_zero;
                              await Provider.of<Auth>(context, listen: false).removeToken();
                              Provider.of<Auth>(context, listen: false)
                                  .isFirstLogout = true;
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(NavigationBottomScreen.routeName);
                            },
                          ),
                          Container(
                            height: 20,
                            color: Colors.black54,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'تبریزاپس',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Iransans',
                                    color: Colors.green,
                                    fontSize: textScaleFactor * 11.0,
                                  ),
                                ),
                                Text(
                                  'طراحی شده توسط',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Iransans',
                                    color: textColor,
                                    fontSize: textScaleFactor * 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
//        ),
            ],
          ),
        ),
      ),
    );
  }
}
