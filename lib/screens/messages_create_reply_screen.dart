import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';
import '../models/message.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../provider/customer_info.dart';
import '../provider/messages.dart';
import '../widgets/main_drawer.dart';
import '../widgets/message_reply_item.dart';

class MessageCreateReplyScreen extends StatefulWidget {
  static const routeName = '/messageCreateReplyScreen';

  @override
  _MessageCreateReplyScreenState createState() =>
      _MessageCreateReplyScreenState();
}

class _MessageCreateReplyScreenState extends State<MessageCreateReplyScreen> {
  var _isLoading = false;
  var _isInit = true;

  List<Message> messages;

  List<String> aboutInfotitle = [];

  List<String> aboutInfoContent = [];

  final contentTextController = TextEditingController();

  bool isLogin;

  Message message;
  Customer customer;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      contentTextController.text = '';
      message = ModalRoute.of(context).settings.arguments as Message;
      customer = Provider.of<CustomerInfo>(context, listen: false).customer;

      isLogin = Provider.of<Auth>(context, listen: false).isAuth;
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    contentTextController.dispose();

    super.dispose();
  }

  Future<void> createMessageReply() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Messages>(context, listen: false)
        .createMessage(
      message.subject,
      contentTextController.text,
      message.comment_post_ID,
      message.comment_ID,
      isLogin,
    )
        .then((value) async {
      await Provider.of<Messages>(context, listen: false).getMessages(
        message.comment_post_ID,
        isLogin,
      );
      Navigator.of(context).pop();
    });
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
          'جواب',
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
      body: Builder(
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: deviceHeight * 0.9,
            color: AppTheme.primary.withOpacity(0.05),
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              bottom: 8.0,
                            ),
                            child: MessageReplyItem(
                              message: message,
                              isReply: customer.id !=
                                  int.parse(
                                    message.user_id,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: deviceHeight * 0.6,
                              child: TextFormField(
                                maxLines: 10,
                                controller: contentTextController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: AppTheme.bg,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: AppTheme.bg,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Iransans',
                                    fontSize: textScaleFactor * 15.0,
                                  ),
                                  labelText: 'جواب خود را در اینجا بنویسید',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                        ? AppTheme.h1
                                        : AppTheme.h1,
                                  ),
                                );
                              },
                            )
                          : Container()),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          createMessageReply();
        },
        backgroundColor: AppTheme.primary,
        child: Icon(
          Icons.check,
          color: Colors.white,
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
    );
  }
}
