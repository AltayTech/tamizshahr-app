import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../provider/app_theme.dart';
import '../../models/customer.dart';
import '../../widgets/main_drawer.dart';
import '../../widgets/profile_view.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  final Customer customer;

  ProfileScreen({this.customer});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
      body: ProfileView(),
    );
  }
}
