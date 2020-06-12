import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/charity.dart';
import 'package:tamizshahr/provider/auth.dart';
import 'package:tamizshahr/provider/charities.dart';
import 'package:tamizshahr/widgets/custom_dialog_enter.dart';

import '../provider/app_theme.dart';
import '../widgets/main_drawer.dart';

class CharityDetailScreen extends StatefulWidget {
  static const routeName = '/charityDetailScreen';

  @override
  _CharityDetailScreenState createState() => _CharityDetailScreenState();
}

class _CharityDetailScreenState extends State<CharityDetailScreen> {
  var _isLoading;

  bool _isInit = true;

  Charity loadedCharity;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await searchItems();
      loadedCharity = Provider.of<Charities>(context, listen: false).item;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> searchItems() async {
    setState(() {
      _isLoading = true;
    });
    final charityId = ModalRoute.of(context).settings.arguments as int;
    await Provider.of<Charities>(context, listen: false)
        .retrieveCharityItem(charityId);

    setState(() {
      _isLoading = false;
    });
    print(_isLoading.toString());
  }

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

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: TextStyle(
              fontFamily: 'Iransans',
            ),
          ),
          backgroundColor: AppTheme.appBarColor,
          iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
          elevation: 0,
          centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
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
                  : Builder(
                      builder: (_) => Stack(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: deviceHeight * 0.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: FadeInImage(
                                    placeholder:
                                        AssetImage('assets/images/circle.gif'),
                                    image: NetworkImage(loadedCharity
                                        .featured_image.sizes.medium),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    loadedCharity.charity_data.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      height: 2,
                                      color: AppTheme.black,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 16.0,
                                    ),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: HtmlWidget(
                                    loadedCharity.description,
                                    onTapUrl: (url) => showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text('onTapUrl'),
                                        content: Text(url),
                                      ),
                                    ),
                                  ),
                                ),
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
                                    onTap: () async {
                                      if (!isLogin) {
                                        _showLogindialog();
                                      } else {}
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
                                        color: AppTheme.primary,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'میخواهم کمک کنم',
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
                        ],
                      ),
                    )),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            // Set the transparency here
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: MainDrawer(),
        ),
      ),
    );
  }
}
