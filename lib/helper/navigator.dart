import 'package:flutter/material.dart';

Future<dynamic> createPageRoute({BuildContext context, Widget destination, Offset offset}) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondartAnimation) => destination,
      transitionsBuilder: (context, animation, secondartAnimation, child) {
        var begin = offset;
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve:curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}
