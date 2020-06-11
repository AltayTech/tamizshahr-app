import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/app_theme.dart';
import '../models/color_code.dart';
import '../models/gallery.dart';
import '../models/order_details.dart';
import '../provider/customer_info.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';
import 'product_detail_screen.dart';

class OrderViewScreen extends StatefulWidget {
  static const routeName = '/order_view_screen';

  @override
  _OrderViewScreenState createState() => _OrderViewScreenState();
}

class _OrderViewScreenState extends State<OrderViewScreen> {
  var _isSelecGallary = false;
  var _isLoading;

  bool _payIsActive;

  bool _uploadIsOk;
  bool _isInit = true;

  int orderId;
  List<Gallery> _imageList = [];

  OrderDetails orderDetails;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      print(('adasd' + url));

      await launch(url);
    } else {
      print(('adasd2' + url));
      throw 'Could not launch $url';
    }
  }

  Future<void> pay(int orderId) async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CustomerInfo>(context, listen: false)
        .payCashOrder(orderId);

    print(_isLoading.toString());
    var payUrl = await Provider.of<CustomerInfo>(context, listen: false).payUrl;
    _launchURL(payUrl);
    setState(() {
      _isLoading = false;
      print(_isLoading.toString());
    });
    print(_isLoading.toString());
  }

  @override
  void initState() {
    _isLoading = false;
    _payIsActive = false;
    _uploadIsOk = false;

    super.initState();
  }

  Future<void> cashOrder() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CustomerInfo>(context, listen: false)
        .getOrderDetails(orderId);

    setState(() {
      _isLoading = false;
      print(_isLoading.toString());
    });
    print(_isLoading.toString());
  }

  void checkStatus(OrderDetails oDt) {
    if (oDt.pay_type_slug == 'naghd') {
      if (oDt.pay_status_slug == 'not_pay') {
        _payIsActive = true;
      } else {
        _payIsActive = false;
      }
    } else {
      if (oDt.pay_status_slug == 'not_pay') {
        _payIsActive = true;
      } else {
        _payIsActive = false;
      }
      if (oDt.order_status_slug == 'cheque_ok') {

      } else {
        _uploadIsOk = false;
      }
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      orderId = ModalRoute.of(context).settings.arguments as int;

      cashOrder();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    orderDetails = Provider.of<CustomerInfo>(context, listen: false).getOrder();
    checkStatus(orderDetails);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.appBarColor,
        iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
      ),
      body: Builder(
        builder: (context) => Container(
          height: deviceHeight * 0.8,
          width: deviceWidth,
          child: Align(
            alignment: Alignment.topCenter,
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
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'وضعیت سفارش: ',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        orderDetails.order_status.toString(),
                                        style: TextStyle(
                                          color: AppTheme.primary,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'شماره سفارش: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            orderDetails.shenaseh.toString(),
                                            style: TextStyle(
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'تاریخ ایجاد سفارش: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            orderDetails.order_register_date
                                                .toString(),
                                            style: TextStyle(
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'قیمت کل: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            EnArConvertor()
                                                    .replaceArNumber(
                                                        currencyFormat.format(
                                                            double.parse(
                                                                orderDetails
                                                                    .total_cost)))
                                                    .toString() +
                                                ' تومان',
                                            style: TextStyle(
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'نوع پرداخت: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            orderDetails.pay_type.toString(),
                                            style: TextStyle(
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'وضعیت پرداخت: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            orderDetails.pay_status.toString(),
                                            style: TextStyle(
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'پیش پرداخت: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            orderDetails.pish == null
                                                ? EnArConvertor()
                                                        .replaceArNumber(
                                                            currencyFormat.format(
                                                                double.parse(
                                                                    orderDetails
                                                                        .pish)))
                                                        .toString() +
                                                    ' تومان'
                                                : '-',
                                            style: TextStyle(
                                              color: AppTheme.black,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'لیست محصولات',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Iransans',
                                fontSize: textScaleFactor * 14,
                              ),
                            ),
                          ),
                          Card(
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: orderDetails.products.length,
                                itemBuilder: (ctx, i) {
                                  return OrderProductItem(
                                    id: orderDetails.products[i].id,
                                    title: orderDetails.products[i].title,
                                    price: orderDetails.products[i].price_low,
                                    color:
                                        orderDetails.products[i].selected_color,
                                    number: orderDetails.number_of_products
                                        .toString(),
                                  );
                                }),
                          ),
                          Consumer<CustomerInfo>(
                            builder: (_, products, ch) => _imageList.isNotEmpty
                                ? Container(
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _imageList.length,
                                        itemBuilder: (ctx, i) {
                                          return Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: deviceHeight * 0.3,
                                                  child: Wrap(
                                                    children: <Widget>[
                                                      Text((i + 1).toString()),
                                                      Image.network(
                                                        _imageList[i].url,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                : Container(),
                          ),
                          InkWell(
                            onTap: () {
                              if (_uploadIsOk) {
                                Provider.of<CustomerInfo>(context)
                                    .addPicture(orderId);
                              } else {
                                SnackBar addToCartSnackBar = SnackBar(
                                  content: Text(
                                    'این مرحله برای شما فعال نگردیده است!',
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
                                Scaffold.of(context)
                                    .showSnackBar(addToCartSnackBar);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: deviceHeight * 0.08,
                                decoration: BoxDecoration(
                                  color: _uploadIsOk
                                      ? AppTheme.primary
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      // has the effect of softening the shadow
                                      spreadRadius: 1.50,
                                      // has the effect of extending the shadow
                                      offset: Offset(
                                        1.0, // horizontal, move right 10
                                        1.0, // vertical, move down 10
                                      ),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Icon(
                                        Icons.credit_card,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, left: 10),
                                        child: Text(
                                          'اپلود تصاویر چک ها',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 16.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_payIsActive) {
                                pay(orderId);
                              } else {
                                SnackBar addToCartSnackBar = SnackBar(
                                  content: Text(
                                    'این مرحله برای شما فعال نگردیده است!',
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
                                Scaffold.of(context)
                                    .showSnackBar(addToCartSnackBar);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: deviceHeight * 0.08,
                                decoration: BoxDecoration(
                                  color: _payIsActive
                                      ? AppTheme.primary
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      // has the effect of softening the shadow
                                      spreadRadius: 1.50,
                                      // has the effect of extending the shadow
                                      offset: Offset(
                                        1.0, // horizontal, move right 10
                                        1.0, // vertical, move down 10
                                      ),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Icon(
                                        Icons.monetization_on,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, left: 10),
                                        child: Text(
                                          'پرداخت',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 16.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({
    Key key,
    @required this.id,
    @required this.number,
    @required this.price,
    @required this.color,
    @required this.title,
  }) : super(key: key);

  final int id;
  final String number;
  final String price;
  final ColorCode color;
  final String title;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: deviceHeight * 0.15,
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: id,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Iransans',
                        fontSize: textScaleFactor * 14.0,
                        color: AppTheme.black),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          'تعداد: ' +
                              EnArConvertor()
                                  .replaceArNumber(number)
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 14.0,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    color.title,
                                    style: TextStyle(
                                      color: AppTheme.black,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(10),
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black, width: 0.2),
                                    color: Color(
                                      int.parse(
                                        '0xff' +
                                            color.color_code
                                                .replaceRange(0, 1, ''),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 4,
                        child: Text(
                          '${price.toString().isNotEmpty ? EnArConvertor().replaceArNumber(currencyFormat.format(double.parse(price))).toString() : '0'}' +
                              ' تومان',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 16.0,
                              color: AppTheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PopupImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Container(
      height: deviceHeight * 0.5,
      width: deviceWidth * 0.5,
      color: Colors.white12,
      child: Center(
        child: Container(
          width: deviceWidth * 0.5,
          height: deviceHeight * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Wrap(
                  children: <Widget>[Icon(Icons.camera), Text('دوربین')],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Wrap(
                  children: <Widget>[Icon(Icons.image), Text('گالری')],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
