import 'package:flutter/material.dart';

import '../../../../models/customer.dart';
import '../../../../provider/app_theme.dart';
import 'customer_detail_order_screen.dart';
import '../../../../widgets/main_drawer.dart';

class CustomerOrdersScreen extends StatefulWidget {
  static const routeName = '/customer_order_screen';
  final Customer customer;

  CustomerOrdersScreen({
    customer,
  }) : this.customer = Customer();

  @override
  _CustomerOrdersScreenState createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
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
      body: CustomerDetailOrderScreen(
        customer: Customer(),
      ),
    );
  }
}
