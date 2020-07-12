import 'package:flutter/material.dart';

class CustomPageTransitionsBuilder extends PageTransitionsBuilder{
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == '/') {
      return child;
    }
    var begin = Offset(1.0, 0.0);
    var end = Offset.zero;
    var curve = Curves.linear;

    var tween = Tween(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: curve,
      )
    );

    return SlideTransition(
      position: tween,
      child: child,
    );
    throw UnimplementedError();
  }
}
