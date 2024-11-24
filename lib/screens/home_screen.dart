import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/screens/wallet_screen.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';
import 'package:tamizshahr/widgets/main_item_button.dart';

import '../provider/Products.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../screens/article_screen.dart';
import '../screens/collect_list_screen.dart';
import '../screens/waste_cart_screen.dart';
import '../widgets/custom_dialog.dart';
import 'product_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        Provider.of<Auth>(context, listen: false).isFirstLogout = false;
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
          title: AppLocalizations.of(context)!.welcome,
          buttonText: AppLocalizations.of(context)!.accept,
          description: AppLocalizations.of(context)!.forarticles,
          image: Image.asset('assets/images/main_page_request_ic.png'),
        ),
      );
    });
  }

  void _showLoginDialogExit(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (ctx) => CustomDialog(
          title: AppLocalizations.of(context)!.dearuser,
          buttonText: AppLocalizations.of(context)!.accept,
          description: AppLocalizations.of(context)!.logoutsuccess,
          image: Image.asset('assets/images/main_page_request_ic.png'),
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
                  text: AppLocalizations.of(context)!.collectrequest,
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
                      child: MainItemButton(
                        title: AppLocalizations.of(context)!.request,
                        itemPaddingF: itemPaddingF,
                        imageUrl: 'assets/images/main_page_request_ic.png',
                        isMonoColor: false,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(WalletScreen.routeName);
                      },
                      child: MainItemButton(
                          title: AppLocalizations.of(context)!.wallet,
                          itemPaddingF: itemPaddingF,
                          imageUrl: 'assets/images/main_page_wallet_ic.png'),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ArticlesScreen.routeName);
                        },
                        child: MainItemButton(
                            title: AppLocalizations.of(context)!.articles,
                            itemPaddingF: itemPaddingF,
                            imageSizeFactor: 0.33,
                            isMonoColor: true,
                            imageUrl: 'assets/images/main_page_paper_ic.png')),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ProductsScreen.routeName);
                      },
                      child: MainItemButton(
                          title: AppLocalizations.of(context)!.store,
                          itemPaddingF: itemPaddingF,
                          imageUrl: 'assets/images/main_page_shop_ic.png'),
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
