import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final PageController pageController;

  BottomNav({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    // TextTheme textTheme = Theme.of(context).textTheme;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: primaryColor.withOpacity(0.3),
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              onPressed: () {
                pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.home),
            ),
            const SizedBox(),
            IconButton(
              onPressed: () {
                pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.bookmark),
            ),
            const SizedBox(),
            IconButton(
              onPressed: () {
                pageController.animateToPage(2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.bar_chart),
            ),
          ],
        ),
      ),
    );
  }
}
