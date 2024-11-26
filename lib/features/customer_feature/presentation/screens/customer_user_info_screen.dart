import 'package:flutter/material.dart';

import '../../../../models/customer.dart';
import '../../../../provider/app_theme.dart';
import 'customer_detail_info_screen.dart';
import '../../../../widgets/main_drawer.dart';

class CustomerUserInfoScreen extends StatefulWidget {
  static const routeName = '/customer_user_info_screen';
  final Customer customer;

  CustomerUserInfoScreen({
    customer,
  }) : this.customer = Customer();

  @override
  _CustomerUserInfoScreenState createState() => _CustomerUserInfoScreenState();
}

class _CustomerUserInfoScreenState extends State<CustomerUserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.appBarColor,
        iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
      ),

      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: MainDrawer(),
      ), // resizeToAvoidBottomInset: false,
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: CustomerDetailInfoScreen(
            customer: Customer(),
          )),
    );
  }
}
