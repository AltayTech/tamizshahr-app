import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../models/message.dart';
import '../provider/app_theme.dart';
import '../widgets/en_to_ar_number_convertor.dart';

class MessageReplyItem extends StatelessWidget {
  const MessageReplyItem({
    required this.message,
    required this.isReply,
  });

  final Message message;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: isReply
          ? const EdgeInsets.only(left: 0, top: 8)
          : const EdgeInsets.only(right: 20, top: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: Container(
//        height: deviceHeight * 0.25,
//        width: deviceWidth * 0.8,
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
                    width: 4,
                    color: isReply ? AppTheme.primary : AppTheme.grey)),
            color: AppTheme.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        message.comment_author,
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Iransans',
                          fontSize: textScaleFactor * 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          EnArConvertor().replaceArNumber(
                            '${(DateTime.parse(message.comment_date)).hour}:${(DateTime.parse(message.comment_date)).minute}',
                          ),
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 14.0,
                          ),
                          textAlign: TextAlign.right,
                        ),
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
                          fontSize: textScaleFactor * 14.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
