import 'package:flutter/material.dart';
import 'package:tamizshahr/provider/app_theme.dart';

class MainItemButton extends StatelessWidget {
  const MainItemButton({
    required this.title,
     this.itemPaddingF=10,
    this.imageSizeFactor = 0.35,
     this.imageUrl='',
    this.isMonoColor = true,
  }) ;

  final String title;
  final String imageUrl;
  final double itemPaddingF;
  final double imageSizeFactor;
  final bool isMonoColor;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return LayoutBuilder(
      builder: (_, constraint) => Padding(
        padding: EdgeInsets.all(deviceWidth * itemPaddingF),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.08),
                  blurRadius: 10.10,
                  spreadRadius: 10.510,
                  offset: Offset(
                    0,
                    0,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: constraint.maxHeight * imageSizeFactor,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.contain,
                        color: isMonoColor ? AppTheme.primary : null,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.h1,
                          fontFamily: 'Iransans',
                          fontSize: textScaleFactor * 18.0,
                        ),
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
