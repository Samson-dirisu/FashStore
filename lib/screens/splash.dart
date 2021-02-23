import 'package:flutter/material.dart';
import '../components/loading.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Loading(),
      ),
    );
  }
}
