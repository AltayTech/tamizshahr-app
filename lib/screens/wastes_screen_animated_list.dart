import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/request/waste.dart';
import '../models/request/wasteCart.dart';
import '../provider/app_theme.dart';
import '../provider/wastes.dart';
import '../widgets/main_drawer.dart';
import '../widgets/waste_item_wastes_screen.dart';

class WastesScreenAnimatedList extends StatefulWidget {
  static const routeName = '/wastesScreenAnimatedList';

  @override
  _WastesScreenAnimatedListState createState() => _WastesScreenAnimatedListState();
}

class _WastesScreenAnimatedListState extends State<WastesScreenAnimatedList>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;
  var _isLoading;
  Function callBack = () {};

  List<WasteCart> wasteCartItems = [];
  List<int> wasteCartItemsId = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      callBack = ModalRoute.of(context).settings.arguments;

      searchItems();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  List<Waste> loadedWastes = [];

  Future<void> searchItems() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Wastes>(context, listen: false).searchWastesItem();
    loadedWastes.clear();
    loadedWastes = Provider.of<Wastes>(context, listen: false).wasteItems;
    wasteCartItems = Provider.of<Wastes>(context, listen: false).wasteCartItems;
    wasteCartItemsId =
        Provider.of<Wastes>(context, listen: false).wasteCartItemsId;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        appBar: AppBar(
          backgroundColor: AppTheme.appBarColor,
          iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.0, horizontal: deviceWidth * 0.03),
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: deviceHeight * 0.9,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: loadedWastes.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: loadedWastes[i],
                      child: InkWell(
                          onTap: () {
                            wasteCartItems =
                                Provider.of<Wastes>(context, listen: false)
                                    .wasteCartItems;
                            wasteCartItemsId =
                                Provider.of<Wastes>(context, listen: false)
                                    .wasteCartItemsId;

                            if (wasteCartItemsId.contains(loadedWastes[i].id)) {
                              Provider.of<Wastes>(context, listen: false)
                                  .removeWasteCart(loadedWastes[i].id);
                            } else {
                              Provider.of<Wastes>(context, listen: false)
                                  .addWasteCart(loadedWastes[i], 1);
                            }
                            wasteCartItemsId =
                                Provider.of<Wastes>(context, listen: false)
                                    .wasteCartItemsId;

                            setState(() {});
                          },
                          child: WasteItemWastesScreen(
                            waste: loadedWastes[i],
                            isSelected:
                                wasteCartItemsId.contains(loadedWastes[i].id),
                          )),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
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
                                  color:
                                      index.isEven ? Colors.grey : Colors.grey,
                                ),
                              );
                            },
                          )
                        : Container(
                            child: loadedWastes.isEmpty
                                ? Center(
                                    child: Text(
                                    'پسماندی در دسترس نیست',
                                    style: TextStyle(
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 15.0,
                                    ),
                                  ))
                                : Container(),
                          ),
                  ),
                )
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: AppTheme.primary,
          child: Icon(
            Icons.check,
            color: AppTheme.white,
          ),
        ),
      ),
    );
  }
}
