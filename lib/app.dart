import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/layout/newTabbar.dart';
import 'package:demo_project/src/screens/layout/splashscreen.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:demo_project/src/share_preference/preferencesKey.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppScreen extends StatelessWidget {
  final SharedPreferences prefs;
  AppScreen(this.prefs);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Product Sans',
        // primaryColor: appColorBlack,
      ),
      debugShowCheckedModeBanner: false,
      home: _handleCurrentScreen(prefs),
    );
  }

  Widget _handleCurrentScreen(SharedPreferences prefs) {
    String? data = prefs.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    preferences = prefs;
    if (data == null) {
      if (preferences!.containsKey("guest user")) {
        print('0');
        return LoginContainerView();
      } else {
        print('1');
        return SplashScreen();
      }
    } else {
      print('2');
      return TabbarScreen();
    }
  }
}
