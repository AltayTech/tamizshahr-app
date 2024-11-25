import 'package:flutter/material.dart';

// import '../../features/home_screen/presentation/pages/home_screen.dart';
import 'app_background.dart';
import 'bottom_nav.dart';
import 'drawer_menu.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({Key? key}) : super(key: key);
  static const routeName = '/MainWrapper';

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      // const HomeScreen(),
      // const HomeScreen(),
      // const HomeScreen(),
    ];
    // var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNav(pageController: pageController),
        appBar: AppBar(),
        drawer: DrawerMenu(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AppBackground.getBackGroundImage(),
              fit: BoxFit.cover,
            ),
          ),

          // height: height,
          child: PageView(
            controller: pageController,
            children: pageViewWidget,
          ),
        ),
      ),
    );
  }
}
