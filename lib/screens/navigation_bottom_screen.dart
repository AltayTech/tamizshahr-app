import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/strings.dart';
import '../provider/app_theme.dart';
import '../widgets/main_drawer.dart';
import '../widgets/profile_view.dart';
import 'home_screen.dart';

class NavigationBottomScreen extends StatefulWidget {
  static const routeName = '/NBS';

  @override
  _NavigationBottomScreenState createState() => _NavigationBottomScreenState();
}

class _NavigationBottomScreenState extends State<NavigationBottomScreen>
    with SingleTickerProviderStateMixin {
  bool isLogin;
  int _selectedPageIndex = 0;

  void selectBNBItem(int index) {
    setState(
      () {
        _selectedPageIndex = index;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
      'title': Strings.navHome,
    },
    {
      'page': HomeScreen(),
      'title': Strings.navQest,
    },
    {
      'page': HomeScreen(),
      'title': Strings.naveFavorite,
    },
    {
      'page': ProfileView(),
      'title': Strings.navProfile,
    }
  ];

  void _selectBNBItem(int index) {
    setState(
      () {
        _selectedPageIndex = index;
      },
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            contentTextStyle: TextStyle(
                color: AppTheme.bg,
                fontFamily: 'Iransans',
                fontSize: MediaQuery.of(context).textScaleFactor * 15.0),
            title: Text('خروج از اپلیکیشن'),
            content: Text('آیا میخواهید از اپلیکیشن خارج شوید؟'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("نه"),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
//                  Navigator.of(context).popUntil(ModalRoute.withName(LoginScreen.routeName));
                  Navigator.of(context).pop(true);
                },
                child: Text("بلی"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              child: Container(),
              preferredSize: Size.fromHeight(15),
            ),
            title: Text(
              'تمیز شهر',
              style: TextStyle(
                fontFamily: 'Iransans',
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.vertical(
                  bottom: new Radius.elliptical(
                      MediaQuery.of(context).size.width * 9, 200.0)),
            ),
            backgroundColor: AppTheme.appBarColor,
            iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
            centerTitle: true,
          ),
          drawer: Theme(
            data: Theme.of(context).copyWith(
              // Set the transparency here
              canvasColor: Colors
                  .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
            ),
            child: MainDrawer(),
          ),
          body: Stack(
            children: <Widget>[
              _pages[_selectedPageIndex]['page'],
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 8,
            selectedLabelStyle: TextStyle(
                color: AppTheme.secondary,
                fontFamily: 'Iransans',
                fontSize: MediaQuery.of(context).textScaleFactor * 10.0),
            onTap: _selectBNBItem,
            backgroundColor: AppTheme.bg,
            unselectedItemColor: Colors.grey,
            selectedItemColor: AppTheme.primary,
            currentIndex: _selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: AppTheme.white,
                icon: Icon(Icons.home),
                title: Text(
                  Strings.navHome,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: AppTheme.white,
                icon: Icon(Icons.directions_car),
                title: Text(
                  Strings.navQest,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: AppTheme.white,
                icon: Icon(Icons.add_shopping_cart),
                title: Text(
                  Strings.naveFavorite,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: AppTheme.white,
                icon: Icon(Icons.account_circle),
                title: Text(
                  Strings.navProfile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
