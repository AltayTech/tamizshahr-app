import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/request/waste.dart';

import '../provider/app_theme.dart';

class WasteItemWastesScreen extends StatelessWidget {
  final Waste waste;
  final bool isSelected;

  WasteItemWastesScreen({this.waste, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected?AppTheme.secondary:AppTheme.bg,
              border: isSelected
                  ? Border.all(width: 2, color: AppTheme.primary)
                  : Border.all(width: 0.3, color: AppTheme.grey),
            ),
            height: constraints.maxHeight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/images/circle.gif'),
                        image: NetworkImage(waste.featured_image.sizes.medium),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        waste.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppTheme.black,
                          fontFamily: 'Iransans',
                          fontSize: textScaleFactor * 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
