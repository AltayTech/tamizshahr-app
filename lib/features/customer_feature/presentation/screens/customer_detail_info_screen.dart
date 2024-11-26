import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../../models/customer.dart';
import '../../../../provider/app_theme.dart';
import '../../../../provider/customer_info.dart';
import 'customer_detail_info_edit_screen.dart';

class CustomerDetailInfoScreen extends StatefulWidget {
  final Customer customer;

  CustomerDetailInfoScreen({required this.customer});

  @override
  _CustomerDetailInfoScreenState createState() =>
      _CustomerDetailInfoScreenState();
}

class _CustomerDetailInfoScreenState extends State<CustomerDetailInfoScreen> {
  late Customer customer;
  var _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      cashOrder();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> cashOrder() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CustomerInfo>(context, listen: false).getCustomer();
    customer = Provider.of<CustomerInfo>(context, listen: false).customer;

    setState(() {
      _isLoading = false;
      print(_isLoading.toString());
    });
    print(_isLoading.toString());
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      color: Colors.transparent,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
        child: _isLoading
            ? Align(
                alignment: Alignment.center,
                child: SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index.isEven ? Colors.grey : Colors.grey,
                      ),
                    );
                  },
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                            ),
                            child: Image.asset(
                              'assets/images/user_Icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            'اطلاعات شخصی',
                            style: TextStyle(
                              color: AppTheme.h1,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 18.0,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'مشخصات',
                              style: TextStyle(
                                color: AppTheme.black,
                                fontFamily: 'Iransans',
                                fontSize: textScaleFactor * 14.0,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            FittedBox(
                              child: TextButton(
                                // color: AppTheme.primary,
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      CustomerDetailInfoEditScreen.routeName);
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Text(
                                      ' ویرایش',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              InfoItem(
                                title: 'نام',
                                text: customer.personalData.first_name,
                                bgColor: Colors.white,
                                iconColor: Color(0xffA67FEC),
                              ),
                              InfoItem(
                                title: 'نام خانوادگی',
                                text: customer.personalData.last_name,
                                bgColor: Colors.white,
                                iconColor: Color(0xffA67FEC),
                              ),
                              InfoItem(
                                title: 'نوع کاربر',
                                text: customer.customer_type.name,
                                bgColor: Colors.white,
                                iconColor: Color(0xffA67FEC),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Container(
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              InfoItem(
                                title: 'ایمیل',
                                text: customer.personalData.email,
                                bgColor: Colors.white,
                                iconColor: Color(0xffA67FEC),
                              ),
                              InfoItem(
                                title: 'استان',
                                text: customer.personalData.ostan != null
                                    ? customer.personalData.ostan
                                    : '',
                                bgColor: Colors.white,
                                iconColor: Color(0xff4392F1),
                              ),
                              InfoItem(
                                title: 'شهر',
                                text: customer.personalData.city != null
                                    ? customer.personalData.city
                                    : '',
                                bgColor: Colors.white,
                                iconColor: Color(0xff4392F1),
                              ),
                              InfoItem(
                                title: 'کدپستی',
                                text: customer.personalData.postcode != null
                                    ? customer.personalData.postcode
                                    : '',
                                bgColor: Colors.white,
                                iconColor: Color(0xff4392F1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({
    required this.title,
    required this.text,
    required this.bgColor,
    required this.iconColor,
  });

  final String title;
  final String text;
  final Color bgColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 6),
            child: Text(
              '$title : ',
              style: TextStyle(
                color: AppTheme.grey,
                fontFamily: 'Iransans',
                fontSize: textScaleFactor * 14.0,
              ),
            ),
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(
                    color: Colors.grey.withOpacity(
                  0.0,
                )),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: AppTheme.black,
                    fontFamily: 'Iransans',
                    fontSize: textScaleFactor * 14.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
