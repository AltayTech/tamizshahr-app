import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/screens/wallet_screen.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';

import '../provider/Products.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../screens/article_screen.dart';
import '../screens/collect_list_screen.dart';
import '../screens/waste_cart_screen.dart';
import '../widgets/custom_dialog.dart';
import 'product_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isInit = false;
      Provider.of<Products>(context, listen: false).retrieveCategory();

      Provider.of<Auth>(context, listen: false).getToken();

      bool _isFirstLogin =
          Provider.of<Auth>(context, listen: false).isFirstLogin;
      if (_isFirstLogin) {
        _showLoginDialog(context);
      }
      bool _isFirstLogout =
          Provider.of<Auth>(context, listen: false).isFirstLogout;
      if (_isFirstLogout) {
        _showLoginDialogExit(context);
      }

      Provider.of<Auth>(context, listen: false).isFirstLogin = false;
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  void _showLoginDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (ctx) => CustomDialog(
          title: 'خوش آمدید',
          buttonText: 'تایید',
          description:
              'برای دریافت اطلاعات کاربری به قسمت پروفایل مراجعه فرمایید',
        ),
      );
    });
  }

  void _showLoginDialogExit(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (ctx) => CustomDialog(
          title: 'کاربر گرامی',
          buttonText: 'تایید',
          description: 'شما با موفقیت از اکانت کاربری خارج شدید',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    double itemPaddingF = 0.025;

    return SingleChildScrollView(
      child: Container(
        color: AppTheme.bg,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.bg,
                    border: Border.all(width: 5, color: AppTheme.bg)),
                height: deviceWidth * 0.4,
                child: Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: deviceWidth,
                      child: FadeInImage(
                        placeholder: AssetImage('assets/images/circle.gif'),
                        image: AssetImage('assets/images/main_page_header.png'),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  WasteCartScreen.routeName,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 2, left: 20, right: 20),
                child: ButtonBottom(
                  width: deviceWidth * 0.9,
                  height: deviceWidth * 0.14,
                  text: 'درخواست جمع آوری',
                  isActive: true,
                ),
              ),
            ),
            Container(
              height: deviceHeight * 0.6,
              width: deviceWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  primary: false,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(CollectListScreen.routeName);
                      },
                      child: LayoutBuilder(
                        builder: (_, constraint) => Padding(
                          padding: EdgeInsets.all(deviceWidth * itemPaddingF),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withOpacity(0.08),

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
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        bottom: 10,
                                        top: 16),
                                    child: Container(
                                      height: constraint.maxHeight * 0.7,
                                      child: Image.asset(
                                        'assets/images/main_page_request_ic.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'درخواست ها',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.h1,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 18.0,
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
                        Navigator.of(context).pushNamed(WalletScreen.routeName);
                      },
                      child: LayoutBuilder(
                        builder: (_, constraint) => Padding(
                          padding: EdgeInsets.all(deviceWidth * itemPaddingF),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withOpacity(0.08),
                                    blurRadius: 10.10,
                                    spreadRadius: 10.510,
                                    offset: Offset(
                                      0, // horizontal, move right 10
                                      0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, bottom: 10, top: 16),
                                  child: Container(
                                    height: constraint.maxHeight * 0.30,
                                    child: Image.asset(
                                        'assets/images/main_page_wallet_ic.png',
                                        fit: BoxFit.contain,
                                        color: AppTheme.primary),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'کیف پول',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.h1,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 18.0,
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
                        Navigator.of(context)
                            .pushNamed(ArticlesScreen.routeName);
                      },
                      child: LayoutBuilder(
                        builder: (_, constraint) => Padding(
                          padding: EdgeInsets.all(deviceWidth * itemPaddingF),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withOpacity(0.08),
                                    blurRadius: 10.10,
                                    spreadRadius: 10.510,
                                    offset: Offset(
                                      0,
                                      0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, bottom: 10, top: 16),
                                  child: Container(
                                    height: constraint.maxHeight * 0.30,
                                    child: Image.asset(
                                      'assets/images/main_page_article_ic.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'مقالات آموزشی',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.h1,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 18.0,
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
                        Navigator.of(context)
                            .pushNamed(ProductsScreen.routeName);
                      },
                      child: LayoutBuilder(
                        builder: (_, constraint) => Padding(
                          padding: EdgeInsets.all(deviceWidth * itemPaddingF),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withOpacity(0.08),
                                    blurRadius: 10.10,
                                    spreadRadius: 10.510,
                                    offset: Offset(
                                      0,
                                      0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: constraint.maxHeight * 0.30,
                                    child: Image.asset(
                                      'assets/images/main_page_shop_ic.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'فروشگاه',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.h1,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 18.0,
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
