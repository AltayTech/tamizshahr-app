import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/customer.dart';
import 'package:tamizshahr/models/order.dart';
import 'package:tamizshahr/provider/auth.dart';
import 'package:tamizshahr/provider/customer_info.dart';
import 'package:tamizshahr/provider/orders.dart';
import 'package:tamizshahr/screens/charity_screen.dart';
import 'package:tamizshahr/screens/product_screen.dart';
import 'package:tamizshahr/widgets/order_item-orders_screen.dart';
import 'package:tamizshahr/widgets/transaction_item_transactions_screen.dart';

import '../models/search_detail.dart';
import '../provider/app_theme.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';
import 'customer_info/login_screen.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/ordersScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;
  ScrollController _scrollController = new ScrollController();
  var _isLoading;
  int page = 1;
  SearchDetail productsDetail;

  Customer customer;

  @override
  void initState() {
    Provider.of<Orders>(context, listen: false).sPage = 1;

    Provider.of<Orders>(context, listen: false).searchBuilder();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page = page + 1;
        Provider.of<Orders>(context, listen: false).sPage = page;

        searchItems();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
//      await getCustomerInfo();
      getCustomerInfo();
      searchItems();
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

  List<Order> loadedProducts = [];
  List<Order> loadedProductstolist = [];

  Future<void> searchItems() async {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Orders>(context, listen: false).searchBuilder();
    await Provider.of<Orders>(context, listen: false).searchOrderItems();
    productsDetail = Provider.of<Orders>(context, listen: false).searchDetails;

    loadedProducts.clear();
    loadedProducts =
        await Provider.of<Orders>(context, listen: false).ordersItems;
    loadedProductstolist.addAll(loadedProducts);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    bool isLogin = Provider.of<Auth>(context).isAuth;

    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        appBar: AppBar(
          title: Text(
            'سفارش ها',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.0, horizontal: deviceWidth * 0.03),
            child: !isLogin
                ? Container(
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
                                  'ورود به اکانت کاربری',
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
                : Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[


                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/orders_list.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'سفارش ها',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 14.0,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),

                                Spacer(),
                                Consumer<CustomerInfo>(
                                    builder: (_, Wastes, ch) {
                                  return Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: deviceHeight * 0.0,
                                          horizontal: 3),
                                      child: Wrap(
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          direction: Axis.horizontal,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3,
                                                      vertical: 5),
                                              child: Text(
                                                'تعداد:',
                                                style: TextStyle(
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 12.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0, left: 6),
                                              child: Text(
                                                productsDetail != null
                                                    ? EnArConvertor()
                                                        .replaceArNumber(
                                                            productsDetail.total
                                                                .toString())
                                                    : EnArConvertor()
                                                        .replaceArNumber('0'),
                                                style: TextStyle(
                                                  fontFamily: 'Iransans',
                                                  fontSize:
                                                      textScaleFactor * 13.0,
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Divider(thickness: 1, color: AppTheme.h1),

                          Container(
                            width: double.infinity,
                            height: deviceHeight * 0.75,
                            child: ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              itemCount: loadedProductstolist.length,
                              itemBuilder: (ctx, i) =>
                                  ChangeNotifierProvider.value(
                                value: loadedProductstolist[i],
                                child: OrderItemOrdersScreen(),
                              ),
                            ),
                          ),
                        ],
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
                                  : Container(
                                      child: loadedProductstolist.isEmpty
                                          ? Center(
                                              child: Text(
                                              'محصولی وجود ندارد',
                                              style: TextStyle(
                                                fontFamily: 'Iransans',
                                                fontSize:
                                                    textScaleFactor * 15.0,
                                              ),
                                            ))
                                          : Container())))
                    ],
                  ),
          ),
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
