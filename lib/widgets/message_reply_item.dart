import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../models/message.dart';
import '../provider/app_theme.dart';
import '../widgets/en_to_ar_number_convertor.dart';

class MessageReplyItem extends StatelessWidget {
  const MessageReplyItem({
    Key key,
    @required this.message,
    @required this.isReply,
  }) : super(key: key);

  final Message message;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: isReply
          ? const EdgeInsets.only(left: 15)
          : const EdgeInsets.only(right: 15),
      child: Container(
//        height: deviceHeight * 0.25,
        width: deviceWidth * 0.8,
        child: Card(
          color: isReply ? AppTheme.white : AppTheme.bg,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        message.comment_author,
                        style: TextStyle(
                          color: AppTheme.h1.withOpacity(0.5),
                          fontFamily: 'Iransans',
                          fontSize: textScaleFactor * 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        EnArConvertor().replaceArNumber('${Jalali.fromDateTime(
                          DateTime.parse(
                            message.comment_date,
                          ),
                        ).year}/${Jalali.fromDateTime(
                          DateTime.parse(
                            message.comment_date,
                          ),
                        ).month}/${Jalali.fromDateTime(
                          DateTime.parse(
                            message.comment_date,
                          ),
                        ).day}'),
                        style: TextStyle(
                          color: AppTheme.grey,
                          fontFamily: 'Iransans',
                          fontSize: textScaleFactor * 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    message.subject,
                    style: TextStyle(
                      color: AppTheme.black,
                      fontFamily: 'Iransans',
                      fontSize: textScaleFactor * 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      message.comment_content,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontFamily: 'Iransans',
                        fontSize: textScaleFactor * 12.0,
                      ),
                      textAlign: TextAlign.right,
                    ),
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
