import 'package:FashStore/models/product.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  final Color textColor;
  Tag({this.text, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white24),
      child: Text(text,
          style: TextStyle(
            fontSize: 15.0,
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
