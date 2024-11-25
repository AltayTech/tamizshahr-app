import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/provider/app_theme.dart';
import 'package:tamizshahr/provider/customer_info.dart';
import 'package:tamizshahr/screens/charity_screen.dart';
import 'package:tamizshahr/screens/messages_screen.dart';

import '../provider/auth.dart';
import '../screens/about_us_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/contact_with_us_screen.dart';
import '../screens/customer_info/login_screen.dart';
import '../screens/customer_info/profile_screen.dart';
import '../screens/guide_screen.dart';
import '../screens/navigation_bottom_screen.dart';
import '../screens/product_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function()? tapHandler) {
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
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  NavigationBottomScreen.routeName,
                                  (Route<dynamic> route) => false);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'فروشگاه',
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
                              'خیریه ها',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Container(
                                height: deviceHeight * 0.03,
                                width: deviceHeight * 0.03,
                                child: Image.asset(
                                  'assets/images/donation_ic.png',
                                  color: AppTheme.grey,
                                )),
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.of(context)
                                  .pushNamed(CharityScreen.routeName);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'آموزشها',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              Icons.description,
                              color: iconColor,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.of(context)
                                  .pushNamed(MessageScreen.routeName);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'پشتیبانی',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              Icons.description,
                              color: iconColor,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.of(context)
                                  .pushNamed(MessageScreen.routeName);
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
                          ListTile(
                            title: Text(
                              'خروج از حساب کاربری',
                              style: TextStyle(
                                fontFamily: "Iransans",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.signOutAlt,
                              color: iconColor,
                            ),
                            onTap: () async {
                              Provider.of<CustomerInfo>(context, listen: false)
                                  .customer = Provider.of<CustomerInfo>(context,
                                      listen: false)
                                  .customer_zero;
                              await Provider.of<Auth>(context, listen: false)
                                  .removeToken();
                              Provider.of<Auth>(context, listen: false)
                                  .isFirstLogout = true;
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  NavigationBottomScreen.routeName,
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
