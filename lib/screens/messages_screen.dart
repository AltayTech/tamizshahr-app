import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/message.dart';
import '../provider/auth.dart';
import '../provider/messages.dart';
import '../screens/message_detail_screen.dart';
import '../screens/messages_create_screen.dart';
import '../widgets/message_item.dart';
import 'package:provider/provider.dart';

import '../provider/app_theme.dart';
import '../widgets/main_drawer.dart';

class MessageScreen extends StatefulWidget {
  static const routeName = '/messageScreen';

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  List<Message> messages = [];

  List<String> aboutInfotitle = [];

  List<String> aboutInfoContent = [];

  @override
  void didChangeDependencies() {
    messages = Provider.of<Messages>(context).allMessages;

    if (_isInit) {
      loadMessages();
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> loadMessages() async {
    setState(() {
      _isLoading = true;
    });

    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;

    await Provider.of<Messages>(context, listen: false)
        .getMessages('0', isLogin);

    messages = Provider.of<Messages>(context, listen: false).allMessages;

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
          'پشتیبانی',
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
          child: Container(
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    height: deviceHeight * 0.9,
                    width: deviceWidth,
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MessageDetailScreen.routeName,
                              arguments: messages[index],
                            );
                          },
                          child: MessageItem(
                            message: messages[index],
                            bgColor: AppTheme.bg,
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
                                  color:
                                      index.isEven ? Colors.grey : Colors.grey,
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
                                : Container(),
                          ),
                  ),
                )
              ],
            ),
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
          Icons.add,
          color: AppTheme.bg,
        ),
        onPressed: () {
          Navigator.pushNamed(context, MessageCreateScreen.routeName);
        },
      ),
    );
  }
}
