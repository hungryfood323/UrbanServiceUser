import 'dart:async';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/layout/welcome.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed(App_Screen);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 200,
      width: 100,
      color: appColorWhite,
      child: Center(
        child: Image.asset(
          'assets/images/Logo2.png',
          height: 50,
          //fit: BoxFit.contain,
          // width: SizeConfig.blockSizeHorizontal * 50,
        ),
      ),
    );
  }
}
