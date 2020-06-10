import 'package:flutter/material.dart';
import 'package:tamizshahr/provider/app_theme.dart';

class InfoEditItem extends StatelessWidget {
  const InfoEditItem(
      {Key key,
      @required this.title,
      @required this.controller,
      @required this.keybordType,
      @required this.bgColor,
      @required this.iconColor,
      this.maxLine = 1,
      @required this.fieldHeight})
      : super(key: key);

  final String title;
  final TextEditingController controller;
  final TextInputType keybordType;
  final int maxLine;
  final Color bgColor;
  final Color iconColor;
  final double fieldHeight;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: deviceWidth * 0.8,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title : ',
                style: TextStyle(
                  color: AppTheme.h1,
                  fontFamily: 'Iransans',
                  fontSize: textScaleFactor * 14.0,
                ),
              ),
              Container(
                color: Colors.white,
                height: fieldHeight,
                child: Form(
                  child: TextFormField(
                    maxLines: maxLine,
                    keyboardType: keybordType,
                    onEditingComplete: () {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لطفا مقداری را وارد نمایید';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.none,
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 0,
                          color: Colors.white,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Iransans',
                        fontSize: textScaleFactor * 10.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
