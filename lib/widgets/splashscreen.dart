import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final double photoSize;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;
  final Text loadingText;
  final ImageProvider imageBackground;
  final Gradient gradientBackground;

  SplashScreen(
      {this.loaderColor = Colors.grey,
      required this.seconds,
      this.photoSize = 100,
      this.onClick,
      this.navigateAfterSeconds,
      this.title = const Text(''),
      this.backgroundColor = Colors.white,
      this.styleTextUnderTheLoader = const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      required this.image,
      this.loadingText = const Text(""),
      this.imageBackground =
          const AssetImage('assets/images/main_page_request_ic.png'),
      this.gradientBackground =
          const LinearGradient(colors: [Colors.white, Colors.grey])});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.seconds), () {
      if (widget.navigateAfterSeconds is String) {
        Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
      } else if (widget.navigateAfterSeconds is Widget) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => widget.navigateAfterSeconds));
      } else {
        throw new ArgumentError(
            'widget.navigateAfterSeconds must either be a String or Widget');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new InkWell(
        onTap: widget.onClick,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: widget.imageBackground,
                ),
                gradient: widget.gradientBackground,
                color: widget.backgroundColor,
              ),
            ),
            new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  child: new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          height: MediaQuery.of(context).size.width * 0.8,
                          child: widget.image),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      widget.title
                    ],
                  )),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.04,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitThreeBounce(
                        size: 25,
                        duration: Duration(milliseconds: 2000),
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index.isEven
                                  ? Color(0xff06623B)
                                  : Color(0xff06623B),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      widget.loadingText
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
