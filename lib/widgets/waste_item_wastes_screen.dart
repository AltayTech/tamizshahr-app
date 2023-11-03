import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/request/waste.dart';
import '../provider/app_theme.dart';

class WasteItemWastesScreen extends StatelessWidget {
  final Waste waste;
  final bool isSelected;

  WasteItemWastesScreen({
    required this.waste,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: isSelected ? AppTheme.white : AppTheme.white,
            border: isSelected
                ? Border.all(width: 3, color: AppTheme.primary)
                : Border.all(width: 0.3, color: AppTheme.grey),
          ),
          height: constraints.maxHeight,
          child: Padding(
            padding: EdgeInsets.all(constraints.maxWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: constraints.maxWidth * 0.06),
                  child: Container(
                    width: constraints.maxWidth * 0.55,
                    height: constraints.maxHeight * 0.50,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/circle.gif'),
                      image: NetworkImage(waste.featured_image.sizes.medium),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    waste.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppTheme.black,
                      fontFamily: 'Iransans',
                      fontSize: textScaleFactor * 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
