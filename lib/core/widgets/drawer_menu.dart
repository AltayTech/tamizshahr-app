import 'package:flutter/material.dart';
// import 'package:meditest/features/athentication_feature/presentation/pages/auth_page.dart';

// import '../../features/athentication_feature/presentation/providers/authentication_provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.black12,
      backgroundColor: Colors.white60,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Text(''
                'Medical test analyse app'),
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              // Navigator.of(context).pushNamed(AuthPage.routeName);
            },
          ),
          ListTile(
            title: const Text('Guide'),
            onTap: () {
              // Navigator.of(context).popAndPushNamed(HelpScreen.routeName);
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () async {
              // await Provider.of<AuthenticationProvider>(context, listen: false)
              //     .eitherFailureOrLogout();
              // debugPrint(
              //     Provider.of<AuthenticationProvider>(context, listen: false)
              //         .loginSituation
              //         ?.situation);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
