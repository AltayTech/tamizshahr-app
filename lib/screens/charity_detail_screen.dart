import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/charity.dart';
import 'package:tamizshahr/models/customer.dart';
import 'package:tamizshahr/provider/auth.dart';
import 'package:tamizshahr/provider/charities.dart';
import 'package:tamizshahr/provider/customer_info.dart';
import 'package:tamizshahr/screens/donation_screen.dart';
import 'package:tamizshahr/widgets/custom_dialog_enter.dart';
import 'package:tamizshahr/widgets/custom_dialog_pay_charity.dart';
import 'package:tamizshahr/widgets/en_to_ar_number_convertor.dart';

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
        description: 'برای ادامه لطفا وارد شوید',
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
       Provider.of<CustomerInfo>(context, listen: false).getCustomer();

      setState(() {
        _isLoading = false;
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
    var currencyFormat = intl.NumberFormat.decimalPattern();

    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;
    if (isLogin) {
      customer = Provider.of<CustomerInfo>(context).customer;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          child: _isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.isEven ? Colors.grey : Colors.grey,
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  height: deviceHeight * 0.9,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: deviceHeight * 0.3,
                                child: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/images/circle.gif'),
                                  image: NetworkImage(loadedCharity
                                      .featured_image.sizes.medium),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  loadedCharity.charity_data.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      height: 2,
                                      color: AppTheme.black,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 17.0,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        EnArConvertor().replaceArNumber(
                                            ' کمک در ${loadedCharity.sum_of_helps_months} ماه: '),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 2,
                                            color: AppTheme.grey,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 13.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Text(
                                      EnArConvertor().replaceArNumber(
                                          currencyFormat
                                              .format(double.parse(
                                                  loadedCharity.sum_of_helps))
                                              .toString()),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          height: 2,
                                          color: AppTheme.black,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14.0,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        if (!isLogin) {
                                          _showLogindialog();
                                        } else {
                                          Navigator.of(context).pushNamed(
                                            DonationScreen.routeName,
                                            arguments: loadedCharity,
                                          );
//                                          _showPayCharitydialog(loadedCharity,
//                                              int.parse(customer.money));
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
//                                          boxShadow: [
//                                            BoxShadow(
//                                              color: Colors.grey,
//                                              blurRadius: 1.0,
//                                              // has the effect of softening the shadow
//                                              spreadRadius: 1,
//                                              // has the effect of extending the shadow
//                                              offset: Offset(
//                                                1.0, // horizontal, move right 10
//                                                1.0, // vertical, move down 10
//                                              ),
//                                            )
//                                          ],
                                          color: AppTheme.primary,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'کمک میکنم',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              height: 2,
                                              color: AppTheme.white,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14.0,
                                            ),
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'زمینه های فعالیت: ',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              height: 2,
                                              color: AppTheme.grey,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 13.0,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        alignment: WrapAlignment.start,
                                        children: loadedCharity.activities
                                            .map((e) =>
                                                ChangeNotifierProvider.value(
                                                  value: e,
                                                  child: Text(
                                                    loadedCharity.activities
                                                                .indexOf(e) <
                                                            (loadedCharity
                                                                    .activities
                                                                    .length -
                                                                1)
                                                        ? (e.name + '، ')
                                                        : e.name,
                                                    style: TextStyle(
                                                      fontFamily: 'Iransans',
                                                      color: Colors.black87,
                                                      fontSize:
                                                          textScaleFactor *
                                                              14.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
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
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'شماره تلفن: ',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 2,
                                            color: AppTheme.grey,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 13.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        loadedCharity.charity_data.phone,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 2,
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 14.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'استان:',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 2,
                                            color: AppTheme.grey,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 13.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        loadedCharity.charity_data.ostan,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 2,
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 14.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'شهر:',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 2,
                                            color: AppTheme.grey,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 13.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        loadedCharity.charity_data.city,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 2,
                                            color: AppTheme.black,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 14.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'آدرس:',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 2,
                                            color: AppTheme.grey,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 13.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          loadedCharity.charity_data.address,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              height: 2,
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14.0,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: deviceWidth * 0.1,
                              )
                            ],
                          ),
                        ),
                      ),
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
    );
  }
}
