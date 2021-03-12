import 'package:flutter/material.dart';

// function responsible for changing screens

Future<dynamic> createPageRoute(
    {BuildContext context, Widget destination, Offset offset}) {
  return Navigator.push(
    context,
    PageRouteBuilder(
        pageBuilder: (context, animation, secondartAnimation) => destination,
        transitionsBuilder: (context, animation, secondartAnimation, child) {
          var begin = offset;
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 400)),
  );
}

Future<dynamic> changeRouteReplacement(
    {BuildContext context, Widget destination}) {
  return Navigator.pushReplacement(
    context, MaterialPageRoute(builder:(context)  => destination));
}
