import 'package:FashStore/provider/app_provider.dart';
import 'package:FashStore/provider/order_provider.dart';
import 'package:FashStore/provider/product_provider.dart';
import 'package:FashStore/provider/user_provider.dart';
import 'package:FashStore/screens/home_page.dart';
import 'package:FashStore/screens/login.dart';
import 'package:FashStore/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ChangeNotifierProvider.value(value: OrderProvider.initialize()),
      ChangeNotifierProvider.value(value: AppProvider())
    ],
    child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink.shade400),
        home: ScreenController()),
  ));
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default:
        return Login();
    }
  }
}

// start 3.48
