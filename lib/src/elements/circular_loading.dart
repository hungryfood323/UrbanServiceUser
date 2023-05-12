import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircularLoadingWidget extends StatefulWidget {
  double height;

  CircularLoadingWidget({Key? key, required this.height}) : super(key: key);

  @override
  _CircularLoadingWidgetState createState() => _CircularLoadingWidgetState();
}

class _CircularLoadingWidgetState extends State<CircularLoadingWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation = Tween<double>(begin: widget.height, end: 0).animate(curve)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    Timer(Duration(seconds: 10), () {
      if (mounted) {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
