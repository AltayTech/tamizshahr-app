import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';
import 'package:tamizshahr/widgets/waste_cart_item_animated_list.dart';

import '../models/request/price_weight.dart';
import '../models/request/wasteCart.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../provider/wastes.dart';
import '../screens/wastes_screen.dart';
import '../widgets/custom_dialog_enter.dart';
import '../widgets/custom_dialog_profile.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';
import 'address_screen.dart';

class WastesScreenAnimatedList extends StatefulWidget {
  static const routeName = '/wastesScreenAnimatedList';

  @override
  _WastesScreenAnimatedListState createState() =>
      _WastesScreenAnimatedListState();
}

class _WastesScreenAnimatedListState extends State<WastesScreenAnimatedList>
    with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<WasteCart> wasteCartItems = [];
  bool _isInit = true;

  var _isLoading = true;
  int totalPrice = 0;
  int totalWeight = 0;
  int totalPricePure = 0;

  var index = 0;

  void _showLogindialog() {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogEnter(
        title: 'ورود',
        buttonText: 'صفحه ورود ',
        description: 'برای ادامه باید وارد شوید',
        image: Image.asset('assets/images/main_page_request_ic.png'),
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
        image: Image.asset('assets/images/main_page_request_ic.png'),
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<Auth>(context, listen: false).checkCompleted();

      await getWasteItems();

      setState(() {});
    }
    _isInit = false;
    await getWasteItems();

    super.didChangeDependencies();
  }

  Future<void> getWasteItems() async {
    setState(() {
      _isLoading = true;
    });
    index = wasteCartItems.length;
    wasteCartItems = Provider.of<Wastes>(context, listen: false).wasteCartItems;

    totalPrice = 0;
    totalWeight = 0;
    totalPricePure = 0;
    if (wasteCartItems.length > 0) {
      for (int i = 0; i < wasteCartItems.length; i++) {
        print(wasteCartItems[i].featured_image.sizes.medium);
        wasteCartItems[i].prices.length > 0
            ? totalPrice = totalPrice +
                int.parse(getPrice(
                        wasteCartItems[i].prices, wasteCartItems[i].weight)) *
                    wasteCartItems[i].weight
            : totalPrice = totalPrice;
        wasteCartItems[i].prices.length > 0
            ? totalWeight = totalWeight + wasteCartItems[i].weight
            : totalWeight = totalWeight;
      }
    }
    changeNumberAnimation(double.parse(totalPrice.toString()));
    totalPricePure = totalPrice;

    setState(() {
      _isLoading = false;
    });
  }

  String getPrice(List<PriceWeight> prices, int weight) {
    String price = '0';

    for (int i = 0; i < prices.length; i++) {
      if (weight > int.parse(prices[i].weight)) {
        price = prices[i].price;
      } else {
        price = prices[i].price;
        break;
      }
    }
    return price;
  }

  late AnimationController _totalPriceController;
  late Animation<double> _totalPriceAnimation;

  @override
  initState() {
    _totalPriceController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _totalPriceAnimation = _totalPriceController;
    super.initState();
  }

  @override
  void dispose() {
    _totalPriceController.dispose();
    super.dispose();
  }

  void changeNumberAnimation(double newValue) {
    setState(() {
      _totalPriceAnimation = new Tween<double>(
        begin: _totalPriceAnimation.value,
        end: newValue,
      ).animate(new CurvedAnimation(
        curve: Curves.ease,
        parent: _totalPriceController,
      ));
    });
    _totalPriceController.forward(from: 0.0);
  }

  void addUser() {
    _listKey.currentState?.insertItem(0, duration: Duration(milliseconds: 500));
  }

  void deleteUser(int index) {
    var user = wasteCartItems.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor:
                CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: _buildItem(user),
          ),
        );
      },
      duration: Duration(milliseconds: 600),
    );
  }

  Widget _buildItem(WasteCart user) {
    return WasteCartItemAnimatedList(
      wasteItem: user,
      function: getWasteItems,
      key: ValueKey<WasteCart>(user),
      onRemove: () {},
    );
  }

  Future<void> removeItem(int itemId) async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Wastes>(context, listen: false).removeWasteCart(
      itemId,
    );

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
    bool isCompleted = Provider.of<Auth>(context, listen: false).isCompleted;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'انتخاب پسماند ',
          style: TextStyle(
            color: AppTheme.white,
            fontFamily: 'Iransans',
//            fontSize: textScaleFactor * 14,
          ),
        ),
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
                          height: deviceHeight * 0.15,
                          decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.grey, width: 0.2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(
                                          Icons.restore_from_trash,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                      Text(
                                        EnArConvertor()
                                            .replaceArNumber(wasteCartItems
                                                .length
                                                .toString())
                                            .toString(),
                                        style: TextStyle(
                                          color: AppTheme.h1,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 18,
                                        ),
                                      ),
                                      Text(
                                        'تعداد ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(
                                          Icons.monetization_on,
                                          color: AppTheme.primary,
                                          size: 40,
                                        ),
                                      ),
                                      AnimatedBuilder(
                                        animation: _totalPriceAnimation,
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return Text(
                                            totalPrice.toString().isNotEmpty
                                                ? EnArConvertor()
                                                    .replaceArNumber(
                                                        currencyFormat
                                                            .format(
                                                                double.parse(
                                                              _totalPriceAnimation
                                                                  .value
                                                                  .toStringAsFixed(
                                                                      0),
                                                            ))
                                                            .toString())
                                                : EnArConvertor()
                                                    .replaceArNumber('0'),
                                            style: TextStyle(
                                              color: AppTheme.h1,
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 18,
                                            ),
                                          );
                                        },
                                      ),
                                      Text(
                                        'تومان ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(
                                          Icons.av_timer,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                      ),
                                      Text(
                                        EnArConvertor()
                                            .replaceArNumber(
                                                totalWeight.toString())
                                            .toString(),
                                        style: TextStyle(
                                          color: AppTheme.h1,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 18,
                                        ),
                                      ),
                                      Text(
                                        'کیلوگرم ',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontFamily: 'Iransans',
                                          fontSize: textScaleFactor * 12,
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
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Consumer<Wastes>(
                            builder: (_, value, ch) =>
                                value.wasteCartItems.length != 0
                                    ? Container(
                                        height: deviceHeight * 0.7,
                                        child: AnimatedList(
                                          key: _listKey,
                                          initialItemCount:
                                              value.wasteCartItems.length,
                                          itemBuilder: (ctx, i, animation) =>
                                              FadeTransition(
                                            opacity: animation,
                                            child: WasteCartItemAnimatedList(
                                              wasteItem:
                                                  value.wasteCartItems[i],
                                              function: getWasteItems,
                                              onRemove: () {},
                                              key: Key(''),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: deviceHeight * 0.6,
                                        child: Center(
                                          child: Text('پسماندی اضافه نشده است'),
                                        ),
                                      ),
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
                    child: InkWell(
                      onTap: () {
                        SnackBar addToCartSnackBar = SnackBar(
                          content: Text(
                            'پسماندی اضافه نشده است!',
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
                        if (wasteCartItems.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(addToCartSnackBar);
                        } else if (!isLogin) {
                          _showLogindialog();
                        } else {
                          if (isCompleted) {
                            Navigator.of(context)
                                .pushNamed(AddressScreen.routeName);
                          } else {
                            _showCompletedialog();
                          }
                        }
                      },
                      child: ButtonBottom(
                        width: deviceWidth * 0.9,
                        height: deviceWidth * 0.14,
                        text: 'ادامه',
                        isActive: wasteCartItems.isNotEmpty,
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
                          : Container(),
                    ),
                  ),
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
        padding: EdgeInsets.only(bottom: deviceWidth * 0.13 + 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              WastesScreen.routeName,
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
