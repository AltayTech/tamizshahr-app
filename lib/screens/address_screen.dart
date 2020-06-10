import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/address.dart';
import 'package:tamizshahr/screens/waste_request_date_screen.dart';
import 'package:tamizshahr/widgets/address_item.dart';

import '../models/customer.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../screens/map_screen.dart';
import '../widgets/custom_dialog_enter.dart';
import '../widgets/custom_dialog_profile.dart';
import '../widgets/main_drawer.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address_screen';

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<Address> addressList = [];
  bool _isInit = true;

  var _isLoading = true;
  Customer customer;
  int totalPrice = 0;
  int totalWeight = 0;

  int totalPricePure;

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

  void _showCompletedialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogProfile(
        title: 'اطلاعات کاربری',
        buttonText: 'صفحه پروفایل ',
        description: 'برای ادامه باید اطلاعات کاربری تکمیل کنید',
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    await getCustomerAddresses();

    super.didChangeDependencies();
  }

  Future<void> getCustomerAddresses() async {
    print(addressList.toString());

    setState(() {
      _isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false).getAddresses();
    addressList = Provider.of<Auth>(context, listen: false).addressItems;
    setState(() {
      _isLoading = false;
    });
  }

  setStateFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();
    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.appBarColor,
        iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
      ),
      body: Builder(builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: AppTheme.bg,
                              border: Border.all(width: 5, color: AppTheme.bg)),
                          height: deviceWidth * 0.4,
                          child: Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: deviceWidth,
                                child: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/images/circle.gif'),
                                  image: AssetImage(
                                      'assets/images/address_page_header.png'),
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: addressList.length != 0
                              ? Container(
                                  child: Consumer<Auth>(
                                    builder: (_, products, ch) =>
                                        ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: products.addressItems.length,
                                      itemBuilder: (ctx, i) => InkWell(
                                        onTap: () async {
                                          await Provider.of<Auth>(context,
                                                  listen: false)
                                              .selectAddress(
                                                  products.addressItems[i]);
                                          setState(() {});
                                        },
                                        child: AddressItem(
                                          addressItem: products.addressItems[i],
                                          isSelected:Provider.of<Auth>(context,
                                              listen: false)
                                              .selectedAddress!=null?
                                              products.addressItems[i].name ==
                                                  Provider.of<Auth>(context,
                                                          listen: false)
                                                      .selectedAddress
                                                      .name:false,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text('محصولی اضافه نشده است'),
                                ),
                        ),
                        SizedBox(
                          height: 50,
                        )
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
                            onTap: () {

                              SnackBar addToCartSnackBar = SnackBar(
                                content: Text(
                                  'سبد خرید خالی می باشد!',
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
                              if (addressList.isEmpty) {
                                Scaffold.of(context)
                                    .showSnackBar(addToCartSnackBar);
                              } else if (!isLogin) {
                                _showLogindialog();
                              } else {
//                                if (customer
//                                    .personalData.personal_data_complete) {
                                  Navigator.of(context)
                                      .pushNamed(WasteRequestDateScreen.routeName);
//                                } else {
//                                  _showCompletedialog();
//                                }
                              }
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
                                color: addressList.isEmpty
                                    ? AppTheme.grey
                                    : AppTheme.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'ادامه',
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
                                      (BuildContext context, int index) {
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: deviceWidth * 0.1 + 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              MapScreen.routeName,
            );
          },
          backgroundColor: AppTheme.primary,
          child: Icon(
            Icons.add,
            color: AppTheme.white,
          ),
        ),
      ),
    );
  }
}
