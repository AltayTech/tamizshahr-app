import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Color(0xff77C243);

  static const Color secondary = Color(0xffE5E5E5);
  static const Color bg = Color(0xffF6F6F6);
  static const Color h1 = Color(0xff272727);
  static Color accent = Color(0xffB2C243);
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color grey = Colors.grey;

  // dependent colors
  static Color appBarColor = primary;
  static const Color appBarIconColor = bg;

  // Other colors
  static Color colorOne = Colors.red;
  static Color? colorTwo = Colors.red[300];
  static Color? colorThree = Colors.red[100];
  static BoxDecoration listItemBox = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: AppTheme.white),
    color: AppTheme.white,
  );
}
