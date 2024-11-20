import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/charity.dart';
import 'package:tamizshahr/models/customer.dart';
import 'package:tamizshahr/provider/auth.dart';
import 'package:tamizshahr/provider/charities.dart';
import 'package:tamizshahr/provider/customer_info.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';
import 'package:tamizshahr/widgets/currency_input_formatter.dart';
import 'package:tamizshahr/widgets/custom_dialog_send_request.dart';

import '../provider/app_theme.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';
import 'customer_info/login_screen.dart';
import 'navigation_bottom_screen.dart';

class DonationScreen extends StatefulWidget {
  static const routeName = '/DonationScreen';

  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;
  var _isLoading = false;

  late Customer customer;

  final donationController = TextEditingController();

  late Charity loadedCharity;

  String _snackBarMessage = '';

  @override
  void initState() {
    donationController.text = '0';
    super.initState();
  }

  @override
  void dispose() {
    donationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      getCustomerInfo();
      customer = Provider.of<CustomerInfo>(context, listen: false).customer;

      loadedCharity = ModalRoute.of(context)?.settings.arguments as Charity;
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

  late BuildContext buildContex;

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

    ScaffoldMessenger.of(buildContex).showSnackBar(addToCartSnackBar);
    getCustomerInfo();
    setState(() {
      _isLoading = false;
    });
    print(_isLoading.toString());
  }

  String removeSemicolon(String rawString) {
    print(rawString);

    String newvalue = rawString.replaceAll(',', '');
    print(rawString);

    return newvalue;
  }

  void _showSenddialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogSendRequest(
        title: '',
        buttonText: 'خب',
        description: 'کمک شما با موفقیت ثبت شد',
        image: Image.asset('assets/images/main_page_request_ic.png'),
      ),
    );
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
          'کمک به خیریه',
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
        builder: (ctx) {
          buildContex = ctx;

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
                        textDirection: TextDirection.rtl,
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
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'نام موسسه:',
                                          style: TextStyle(
                                            color: AppTheme.grey,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 13.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            loadedCharity.charity_data.name,
                                            style: TextStyle(
                                              color: AppTheme.h1,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 16.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16.0, right: 16, bottom: 6),
                                          child: Text(
                                            'مقدار اهدا (تومان)',
                                            style: TextStyle(
                                              color: AppTheme.h1,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TextFormField(
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: AppTheme.h1,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 16.0,
                                          ),
                                          textAlign: TextAlign.center,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textInputAction: TextInputAction.go,
                                          keyboardType: TextInputType.number,
                                          controller: donationController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
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
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            new CurrencyInputFormatter(),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 0,
                                right: 0,
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

                                    if (double.parse(removeSemicolon(
                                            donationController.text)) >
                                        double.parse(customer.money)) {
                                      SnackBar addToCartSnackBar = SnackBar(
                                        content: Text(
                                          'مقدار درخواستی از امتیاز شما بیشتر است',
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
                                      ScaffoldMessenger.of(ctx)
                                          .showSnackBar(addToCartSnackBar);
                                    } else {
                                      await donateToCharityFromDialogBox(
                                              int.parse(removeSemicolon(
                                                  donationController.text)))
                                          .then((value) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                NavigationBottomScreen
                                                    .routeName,
                                                (Route<dynamic> route) =>
                                                    false);
                                        _showSenddialog();
                                      });
                                    }
                                  },
                                  child: ButtonBottom(
                                    width: deviceWidth * 0.9,
                                    height: deviceWidth * 0.14,
                                    text: 'اهدا',
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
