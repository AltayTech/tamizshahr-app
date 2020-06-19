import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../models/message.dart';
import '../provider/app_theme.dart';
import '../widgets/en_to_ar_number_convertor.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key key,
    @required this.message,
    @required this.bgColor,
  }) : super(key: key);

  final Message message;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        child: Container(
          height: deviceHeight * 0.25,
          color:AppTheme.white,
          child: LayoutBuilder(
            builder: (ctx, constraints) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.20,
                  width: double.infinity,
                  color: AppTheme.bg,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      EnArConvertor().replaceArNumber('${Jalali.fromDateTime(
                        DateTime.parse(message.comment_date),
                      ).year}/${Jalali.fromDateTime(
                        DateTime.parse(message.comment_date),
                      ).month}/${Jalali.fromDateTime(
                        DateTime.parse(message.comment_date),
                      ).day}'),
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontFamily: 'Iransans',
                        fontSize: textScaleFactor * 15.0,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 4),
                        child: Container(
                          height: constraints.maxHeight * 0.17,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              message.subject,
                              maxLines: 2,
                              overflow:TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppTheme.black,
                                fontFamily: 'Iransans',
                                fontSize: textScaleFactor * 17.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: constraints.maxHeight * 0.40,
                          width: constraints.maxWidth * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              message.comment_content,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: AppTheme.grey,
                                fontFamily: 'Iransans',
                                fontSize: textScaleFactor * 13.0,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
