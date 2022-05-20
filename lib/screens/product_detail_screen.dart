import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamizshahr/widgets/buton_bottom.dart';

import '../models/product.dart';
import '../provider/Products.dart';
import '../provider/app_theme.dart';
import '../widgets/badge.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/main_drawer.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/productDetailScreen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _current = 0;
  var _isLoading;

  bool _isInit = true;

  Product loadedProduct;
  String _snackBarMessage = '';

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await searchItems();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> searchItems() async {
    setState(() {
      _isLoading = true;
    });
    final productId = ModalRoute.of(context).settings.arguments as int;
    await Provider.of<Products>(context, listen: false).retrieveItem(productId);
    loadedProduct = Provider.of<Products>(context, listen: false).findById();

    setState(() {
      _isLoading = false;
    });
    print(_isLoading.toString());
  }

  Future<void> addToShoppingCart(
      Product loadedProduct, var _selectedColor) async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Products>(context, listen: false)
        .addShopCart(loadedProduct, _selectedColor, 1);

    setState(() {
      _isLoading = false;
    });
    print(_isLoading.toString());
  }

  Future<bool> isExistInCart(
    Product loadedProduct,
  ) async {
    bool isExist = false;
    setState(() {
      _isLoading = true;
    });
    isExist = Provider.of<Products>(context, listen: false)
        .cartItems
        .any((prod) => prod.id == loadedProduct.id);

    print(isExist.toString());

    setState(() {
      _isLoading = false;
    });
    return isExist;
  }

  Widget priceWidget(BuildContext context) {
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    if (loadedProduct != null) {
      if (loadedProduct.price_without_discount == loadedProduct.price) {
        return Text(
          loadedProduct.price_without_discount.isNotEmpty
              ? EnArConvertor().replaceArNumber(currencyFormat
                  .format(double.parse(loadedProduct.price_without_discount))
                  .toString())
              : EnArConvertor().replaceArNumber('0'),
          style: TextStyle(
            color: AppTheme.black,
            fontFamily: 'Iransans',
            fontWeight: FontWeight.bold,
            fontSize: textScaleFactor * 20,
          ),
          textAlign: TextAlign.center,
        );
      } else if (loadedProduct.price_without_discount == '0' ||
          loadedProduct.price_without_discount.isEmpty) {
        return Text(
          loadedProduct.price.isNotEmpty
              ? EnArConvertor().replaceArNumber(currencyFormat
                  .format(double.parse(loadedProduct.price))
                  .toString())
              : EnArConvertor().replaceArNumber('0'),
          style: TextStyle(
            color: AppTheme.black,
            fontFamily: 'Iransans',
            fontWeight: FontWeight.bold,
            fontSize: textScaleFactor * 20,
          ),
        );
      } else if (loadedProduct.price == '0' || loadedProduct.price.isEmpty) {
        return Text(
          loadedProduct.price_without_discount.isNotEmpty
              ? EnArConvertor().replaceArNumber(currencyFormat
                  .format(double.parse(loadedProduct.price_without_discount))
                  .toString())
              : EnArConvertor().replaceArNumber('0'),
          style: TextStyle(
            color: AppTheme.black,
            fontFamily: 'Iransans',
            fontWeight: FontWeight.bold,
            fontSize: textScaleFactor * 20,
          ),
        );
      } else {
        return Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              loadedProduct.price_without_discount.isNotEmpty
                  ? EnArConvertor().replaceArNumber(currencyFormat
                      .format(
                          double.parse(loadedProduct.price_without_discount))
                      .toString())
                  : EnArConvertor().replaceArNumber('0'),
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2,
                color: AppTheme.grey,
                fontFamily: 'Iransans',
                fontSize: textScaleFactor * 16,
              ),
            ),
            Text(
              loadedProduct.price.isNotEmpty
                  ? EnArConvertor().replaceArNumber(currencyFormat
                      .format(double.parse(loadedProduct.price))
                      .toString())
                  : EnArConvertor().replaceArNumber('0'),
              style: TextStyle(
                color: AppTheme.black,
                fontFamily: 'Iransans',
                fontWeight: FontWeight.bold,
                fontSize: textScaleFactor * 20,
              ),
            ),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.white,
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
          actions: <Widget>[
            Consumer<Products>(
              builder: (_, products, ch) => products.cartItemsCount != 0
                  ? Badge(
                      color: Color(0xff06623B),
                      value: products.cartItemsCount.toString(),
                      child: ch,
                    )
                  : ch,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                color: AppTheme.bg,
                icon: Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.ltr,
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: deviceHeight * 0.4,
                            decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    aspectRatio: 1,
                                    viewportFraction: 1.0,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    autoPlay: false,
                                    height: deviceHeight * 0.7,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (index, _) {
                                      _current = index;
                                      setState(() {});
                                    },
                                  ),
                                  items: loadedProduct.gallery.map((gallery) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: Container(
                                              width: deviceWidth,
                                              height: deviceHeight * 0.7,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              child: FadeInImage(
                                                placeholder: AssetImage(
                                                    'assets/images/circle.gif'),
                                                image: NetworkImage(
                                                    gallery.sizes.medium),
                                                fit: BoxFit.contain,
                                              )),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: loadedProduct.gallery.map<Widget>(
                                      (index) {
                                        return Container(
                                          width: 10.0,
                                          height: 10.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: AppTheme.h1,
                                                  width: 0.4),
                                              color: _current ==
                                                      loadedProduct.gallery
                                                          .indexOf(index)
                                                  ? AppTheme.secondary
                                                  : AppTheme.bg),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            color: AppTheme.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      loadedProduct.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 2,
                                        color: AppTheme.black,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 18,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[

                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: textScaleFactor * 15.0),
                                          child: Text(
                                            'تومان',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Iransans',
                                              fontSize:
                                                  textScaleFactor * 15.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: priceWidget(context),
                                        ),
Spacer(),
                                        loadedProduct.status.slug=='not-available'? Padding(
                                          padding: EdgeInsets.only(
                                              bottom: textScaleFactor * 15.0),
                                          child: Text(
                                            'ناموجود',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'Iransans',
                                              fontSize:
                                              textScaleFactor * 15.0,
                                            ),
                                          ),
                                        ):Container(),
                                      ],
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: HtmlWidget(
                                      loadedProduct.description,
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
                          ),
                          Spacer(),
                        ],
                      ),
              ),
            ),
            Positioned(
                bottom: 15,
                left: 15,
                right: 15,
                child: Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () async {
                        bool isExist = await isExistInCart(loadedProduct);
                        setState(() {});
                        if (loadedProduct.price.isEmpty) {
                          _snackBarMessage = 'قیمت محصول صفر میباشد';
                          SnackBar addToCartSnackBar = SnackBar(
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
                        } else if (loadedProduct.status.slug=='not-available') {
                          _snackBarMessage = 'محصول موجود نمیباشد';
                          SnackBar addToCartSnackBar = SnackBar(
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
                        }else if (isExist) {
                          _snackBarMessage = 'محصول در سبد خرید موجود میباشد';
                          SnackBar addToCartSnackBar = SnackBar(
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
                          await addToShoppingCart(loadedProduct, null);

                          _snackBarMessage =
                              'محصول با موفقیت به سبد اضافه گردید!';
                          SnackBar addToCartSnackBar = SnackBar(
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
                        }
                      },
                      child: ButtonBottom(
                        width: deviceWidth * 0.9,
                        height: deviceWidth * 0.14,
                        text: 'اضافه به سبد خرید',
                        isActive: true,
                      ),
                    );
                  },
                )),
          ],
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: MainDrawer(),
        ),
      ),
    );
  }
}
