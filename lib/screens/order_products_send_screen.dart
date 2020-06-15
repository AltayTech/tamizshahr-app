import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';
import 'package:tamizshahr/widgets/custom_dialog_send_request.dart';

import '../models/customer.dart';
import '../models/order_send_details.dart';
import '../models/product_cart.dart';
import '../models/product_order_send.dart';
import '../provider/Products.dart';
import '../provider/app_theme.dart';
import '../provider/customer_info.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';

class OrderProductsSendScreen extends StatefulWidget {
  static const routeName = '/orderProductsSendScreen';

  @override
  _OrderProductsSendScreenState createState() =>
      _OrderProductsSendScreenState();
}

class _OrderProductsSendScreenState extends State<OrderProductsSendScreen> {
  var _isLoading = false;
  var _isInit = true;

  OrderSendDetails orderRequest;

  List<ProductCart> shoppItems;

  int totalNumber = 0;

  int totalPrice = 0;

  List<ProductOrderSend> productsList = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await getRegionDate();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> getRegionDate() async {
    setState(() {
      _isLoading = true;
    });

    shoppItems = Provider.of<Products>(context, listen: false).cartItems;
    totalNumber = 0;
    totalPrice = 0;

    if (shoppItems.length > 0) {
      totalNumber = shoppItems.length;

      for (int i = 0; i < shoppItems.length; i++) {
        shoppItems[i].price.isNotEmpty
            ? totalPrice = totalPrice +
                int.parse(shoppItems[i].price) * shoppItems[i].productCount
            : totalPrice = totalPrice;
        productsList.add(ProductOrderSend(
          product: shoppItems[i].id,
          number: shoppItems[i].productCount.toString(),
          total_price:
              (shoppItems[i].productCount * int.parse(shoppItems[i].price))
                  .toString(),
          price: shoppItems[i].price,
        ));
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> createRequest(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    orderRequest = OrderSendDetails(
        total_number: totalNumber.toString(),
        total_price: totalPrice.toString(),
        products: productsList);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> sendRequest(
    BuildContext context,
  ) async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Products>(context, listen: false)
        .sendRequest(orderRequest);

    setState(() {
      _isLoading = false;
    });
  }

  void _showSendOrderdialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogSendRequest(
        title: '',
        buttonText: 'خب',
        description: 'سفارش شما با موفقیت ثبت شد',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    Customer customer =
        Provider.of<CustomerInfo>(context, listen: false).customer;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.appBarColor,
        iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
      ),
      body: Builder(
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                height: deviceHeight * 0.35,
                child: Image.asset(
                  'assets/images/cash_pay_header.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: deviceHeight * 0.1,
                left: deviceWidth * 0.1,
                child: Text(
                  'پرداخت ',
                  style: TextStyle(
                      color: AppTheme.bg,
                      fontFamily: 'Iransans',
                      fontSize: textScaleFactor * 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: deviceHeight * 0.22,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: deviceHeight * 0.5,
                    width: deviceWidth * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              color: AppTheme.primary),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15.0),
                              child: Text(
                                'اطلاعات ارسال محصول',
                                style: TextStyle(
                                  color: AppTheme.bg,
                                  fontFamily: 'Iransans',
                                  fontSize: textScaleFactor * 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppTheme.h1, width: 0.3),
                              color: AppTheme.bg),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        'نام و نام خانوادگی:    ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                      Text(
                                        customer.personalData.first_name +
                                            ' ' +
                                            customer.personalData.last_name,
                                        style: TextStyle(
                                          color: AppTheme.black,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        'استان:    ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                      Text(
                                        customer.personalData.ostan,
                                        style: TextStyle(
                                          color: AppTheme.black,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        'شهر:   ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                      Text(
                                        customer.personalData.city,
                                        style: TextStyle(
                                          color: AppTheme.black,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        'کدپستی:    ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                      Text(
                                        customer.personalData.postcode,
                                        style: TextStyle(
                                          color: AppTheme.black,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        'همراه:    ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                      Text(
                                        EnArConvertor().replaceArNumber(
                                            (customer.personalData.mobile
                                                    .toString())
                                                .toString()),
                                        style: TextStyle(
                                          color: AppTheme.black,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'مبلغ قابل پرداخت (تومان): ',
                                style: TextStyle(
                                  color: AppTheme.grey,
                                  fontFamily: 'Iransans',
                                  fontSize: textScaleFactor * 14,
                                ),
                              ),
                              Text(
                                EnArConvertor().replaceArNumber(currencyFormat
                                    .format(totalPrice)
                                    .toString()),
                                style: TextStyle(
                                  color: AppTheme.primary,
                                  fontFamily: 'Iransans',
                                  fontSize: textScaleFactor * 20,
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () async {
                    if (totalPrice == 0) {
                      var _snackBarMessage = 'محصولی وجود ندارد!';
                      final addToCartSnackBar = SnackBar(
                        content: Text(
                          _snackBarMessage,
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
                      Scaffold.of(context).showSnackBar(addToCartSnackBar);
                    } else {
                      await createRequest(context).then((value) =>
                          sendRequest(context)
                              .then((value) => _showSendOrderdialog()));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ButtonBottom(
                      width: deviceWidth * 0.9,
                      height: deviceWidth * 0.14,
                      text: 'انجام خرید',
                      isActive: true,
                    ),
                  ),
                ),
              ),
              Positioned(
                height: deviceHeight * 0.8,
                width: deviceWidth,
                child: Align(
                    alignment: Alignment.center,
                    child: _isLoading
                        ? SpinKitFadingCircle(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      index.isEven ? Colors.grey : Colors.grey,
                                ),
                              );
                            },
                          )
                        : Container()),
              ),
            ],
          ),
        ),
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
