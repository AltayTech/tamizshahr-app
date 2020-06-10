import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/customer.dart';
import '../models/message.dart';
import '../provider/auth.dart';
import '../customer_info.dart';
import '../provider/messages.dart';
import '../widgets/message_reply_item.dart';
import 'package:provider/provider.dart';

import '../provider/app_theme.dart';
import '../widgets/main_drawer.dart';
import 'messages_create_reply_screen.dart';

class MessageDetailScreen extends StatefulWidget {
  static const routeName = '/messageDetailScreen';

  @override
  _MessageDetailScreenState createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  List<Message> messages = [];

  Message message;

  Customer customer;

  @override
  void didChangeDependencies() async {
    messages = Provider.of<Messages>(context, listen: false).allMessagesDetail;

    if (_isInit) {
      message = ModalRoute.of(context).settings.arguments as Message;
      customer = Provider.of<CustomerInfo>(context, listen: false).customer;

      loadMessages();
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> loadMessages() async {
    setState(() {
      _isLoading = true;
    });

    bool isLogin = Provider.of<Auth>(context).isAuth;

    await Provider.of<Messages>(context, listen: false)
        .getMessages(message.comment_post_ID, isLogin);
    messages = Provider.of<Messages>(context, listen: false).allMessagesDetail;
    setState(() {
      _isLoading = false;
      print(_isLoading.toString());
    });
    print(_isLoading.toString());
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'جوابها',
          style: TextStyle(
            color: AppTheme.bg,
            fontFamily: 'Iransans',
            fontSize: textScaleFactor * 18.0,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.appBarColor,
        iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  height: deviceHeight * 0.8,
                  width: deviceWidth,
                  child: ListView.builder(

                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MessageReplyItem(
                        message: messages[index],
                        isReply: customer.personalData.id !=
                            int.parse(
                              messages[index].user_id,
                            ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                      alignment: Alignment.center,
                      child: _isLoading
                          ? SpinKitFadingCircle(
                              itemBuilder: (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index.isEven
                                        ? Colors.grey
                                        : Colors.grey,
                                  ),
                                );
                              },
                            )
                          : Container(
                              child: messages.isEmpty
                                  ? Center(
                                      child: Text(
                                      'سوالی وجود ندارد',
                                      style: TextStyle(
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 15.0,
                                      ),
                                    ))
                                  : Container())))
            ],
          ),
        ),
      ),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: MainDrawer(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.h1,
        child: Icon(
          Icons.reply,
          color: AppTheme.bg,
        ),
        onPressed: () {
          Navigator.pushNamed(context, MessageCreateReplyScreen.routeName,
              arguments: messages.last);
        },
      ),
    );
  }
}
