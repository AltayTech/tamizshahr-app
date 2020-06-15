import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/charity.dart';
import 'package:tamizshahr/models/customer.dart';
import 'package:tamizshahr/provider/auth.dart';
import 'package:tamizshahr/provider/charities.dart';
import 'package:tamizshahr/provider/customer_info.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';
import 'package:tamizshahr/widgets/custom_dialog_enter.dart';
import 'package:tamizshahr/widgets/custom_dialog_pay_charity.dart';

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

  Customer customer;

  String _snackBarMessage = '';

  BuildContext buildContex;

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
    await Provider.of<Charities>(context, listen: false).retrieveCharityItem(
      charityId,
    );

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

  void _showPayCharitydialog(Charity charity, int totalPrice) {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogPayCharity(
        charity: charity,
        totalWallet: totalPrice,
        function: donateToCharityFromDialogBox,
      ),
    );
  }

  Future<void> donateToCharityFromDialogBox(
    int totalDonation,
  ) async {
    setState(() {
      _isLoading = true;
    });

    _snackBarMessage = 'کمک شما با موفقیت اهدا شد';

    setState(() {
      _isLoading = true;
    });

    Provider.of<Charities>(context, listen: false)
        .sendCharityRequest(loadedCharity.id, totalDonation.toString())
        .then((_) {
      setState(() {
        _isLoading = false;
        print(_isLoading.toString());
      });
    });
    SnackBar addToCartSnackBar = SnackBar(
      content: Text(
        _snackBarMessage,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Iransans',
          fontSize: MediaQuery.of(context).textScaleFactor * 14.0,
        ),
      ),
      action: SnackBarAction(
        label: 'متوجه شدم',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    Scaffold.of(buildContex).showSnackBar(addToCartSnackBar);
    getCustomerInfo();
    setState(() {
      _isLoading = false;
    });
    print(_isLoading.toString());
  }

  Future<void> getCustomerInfo() async {
    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;
    if (isLogin) {
      await Provider.of<CustomerInfo>(context, listen: false).getCustomer();
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;
    if (isLogin) {
      customer = Provider.of<CustomerInfo>(context).customer;
    }
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
        body: Builder(builder: (ctx) {
          buildContex = ctx;
          return Directionality(
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
                    : Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: deviceHeight * 0.3,

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: FadeInImage(
                                      placeholder: AssetImage(
                                          'assets/images/circle.gif'),
                                      image: NetworkImage(loadedCharity
                                          .featured_image.sizes.medium),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                                      fontSize: textScaleFactor * 17.0,
                                      fontWeight: FontWeight.w700
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
                              SizedBox(height: deviceWidth * 0.1,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () async {
                          if (!isLogin) {
                            _showLogindialog();
                          } else {
                            _showPayCharitydialog(loadedCharity,
                                int.parse(customer.money));
                          }
                        },
                        child:
                        ButtonBottom(
                          width: deviceWidth * 0.9,
                          height: deviceWidth * 0.14,
                          text: 'میخواهم کمک کنم',
                          isActive:true,
                        ),

                      ),
                    ),
                  ],
                )),
          );
        }),
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
