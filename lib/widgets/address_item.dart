import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../models/request/address.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';

class AddressItem extends StatefulWidget {
  final Address addressItem;
  final bool isSelected;

  AddressItem({
    required this.addressItem,
    this.isSelected=false,
  });

  @override
  _AddressItemState createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  bool _isInit = true;

  var _isLoading = true;

  late bool isLogin;

  List<Address> addressList = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = false;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> removeItem() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false).getAddresses();
    addressList = Provider.of<Auth>(context, listen: false).addressItems;

    addressList.remove(
        addressList.firstWhere((prod) => prod.name == widget.addressItem.name));
    await Provider.of<Auth>(context, listen: false).updateAddress(addressList);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: deviceWidth * 0.28,
          width: deviceWidth,
          decoration: BoxDecoration(
            color: widget.isSelected ? AppTheme.primary.withOpacity(0.1) : AppTheme.white,
              border: Border.all(color: AppTheme.white, width: 0.3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: LayoutBuilder(
            builder: (_, constraints) => Stack(
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.only(top:deviceWidth * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.place,
                            color: AppTheme.primary,
                            size: 30,
                          )),
                      Expanded(
                        flex: 6,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    widget.addressItem.name != null
                                        ? widget.addressItem.name
                                        : 'ندارد',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppTheme.black,
                                      fontFamily: 'Iransans',
                                      fontSize: textScaleFactor * 18,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  widget.addressItem.region.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppTheme.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 15,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  widget.addressItem.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppTheme.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 2,
                  left: 2,
                  child: Container(
                    height: deviceWidth * 0.10,
                    width: deviceWidth * 0.1,
                    child: InkWell(
                      onTap: () {
                         removeItem();
                      },
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black54,
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
        ),
      ),
    );
  }
}
