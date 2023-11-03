import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';

import '../models/request/address.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../screens/map_screen.dart';
import '../screens/waste_request_date_screen.dart';
import '../widgets/address_item.dart';
import '../widgets/custom_dialog_enter.dart';
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

  void _showLogindialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogEnter(
        title: 'ورود',
        buttonText: 'صفحه ورود ',
        description: 'برای ادامه لطفا وارد شوید', image: Image.asset(''),
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
                            color: AppTheme.white,
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

                      addressList.length != 0
                          ? Container(
                              decoration: BoxDecoration(
                                color: AppTheme.bg,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
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
                                        isSelected: Provider.of<Auth>(context,
                                                        listen: false)
                                                    .selectedAddress !=
                                                null
                                            ? products.addressItems[i].name ==
                                                Provider.of<Auth>(context,
                                                        listen: false)
                                                    .selectedAddress
                                                    .name
                                            : false,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: deviceHeight * 0.45,
                              child: Center(
                                child: Text('آدرسی اضافه نشده است'),
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
                  child: InkWell(
                    onTap: () {
                      SnackBar addToCartSnackBar = SnackBar(
                        content: Text(
                          'آدرسی انتخاب نشده است!',
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
                      if (Provider.of<Auth>(context, listen: false)
                              .selectedAddress ==
                          null) {
                        ScaffoldMessenger.of(context).showSnackBar(addToCartSnackBar);
                      } else if (!isLogin) {
                        _showLogindialog();
                      } else {
                        Navigator.of(context)
                            .pushNamed(WasteRequestDateScreen.routeName);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ButtonBottom(
                        width: deviceWidth * 0.75,
                        height: deviceWidth * 0.14,
                        text: 'ادامه',
                        isActive: Provider.of<Auth>(context, listen: false)
                                .selectedAddress !=
                            null,
                      ),
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
                                itemBuilder: (BuildContext context, int index) {
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
      floatingActionButton: FloatingActionButton(
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
    );
  }
}
