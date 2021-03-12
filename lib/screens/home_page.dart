import 'package:FashStore/components/constants.dart';
import 'package:FashStore/components/products.dart';
import 'package:FashStore/helper/navigator.dart';
import 'package:FashStore/provider/product_provider.dart';
import 'package:FashStore/provider/user_provider.dart';
import 'package:FashStore/screens/login.dart';
import 'package:FashStore/screens/order_page.dart';
import 'package:FashStore/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//MY OWN IMPORTS
import 'package:FashStore/components/horizontal_listview.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showField = false;
  var _key = GlobalKey<ScaffoldState>();
  String value = '';
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    Widget imageCarousel = Container(
      height: 200,
      child: Carousel(
          boxFit: BoxFit.cover,
          //CAROUSEL IMAGES
          images: [
            AssetImage("images/m1.jpeg"),
            AssetImage("images/c1.jpg"),
            AssetImage("images/m2.jpg"),
            AssetImage("images/w1.jpeg"),
            AssetImage("images/w3.jpeg"),
            AssetImage("images/w4.jpeg"),
          ],
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          dotSize: 4.0,
          indicatorBgPadding: 10.0,
          dotBgColor: Colors.transparent),
    );

    return Scaffold(
      key: _key,
      // APPBAR
      appBar: AppBar(
        elevation: 0.1,
        title:
            Visibility(visible: showField == false, child: Text("FashStore")),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          showField
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7.0, right: 8.0),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      autofocus: true,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Icon(Icons.search, color: Colors.white),
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          showField = !showField;
                          value = value;
                        });
                        productProvider.search(productName: value);
                         createPageRoute(
                  destination: SearchScreen(),
                  context: context,
                  offset: Offset(1.0, 0.0),
                );
                      },
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      showField = !showField;
                    });
                  },
                ),
          Visibility(
            visible: showField == false,
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                createPageRoute(
                  destination: CartPage(),
                  context: context,
                  offset: Offset(1.0, 0.0),
                );
              },
            ),
          ),
        ],
      ),

      // DRAWER
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${userProvider.userModel.name}"),
              accountEmail: Text("${userProvider.userModel.email}"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.pink),
            ),

            // BODY OF DRAWER
            InkWell(
              child: ListTile(
                title: Text(
                  "Home Page",
                  style: TextStyle(color: headingColor),
                ),
                leading: Icon(Icons.home, color: Colors.pink),
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListTile(
                title: Text(
                  "My Orders",
                  style: TextStyle(color: headingColor),
                ),
                leading: Icon(Icons.shopping_basket, color: Colors.pink),
              ),
              onTap: () async {
                await userProvider.getUserOrder();
                createPageRoute(
                  destination: OrderPage(),
                  context: context,
                  offset: Offset(1.0, 0.0),
                );
              },
            ),
            InkWell(
              child: ListTile(
                title: Text(
                  "Shopping cart",
                  style: TextStyle(color: headingColor),
                ),
                leading: Icon(Icons.shopping_cart, color: Colors.pink),
              ),
              onTap: () {
                createPageRoute(
                  destination: CartPage(),
                  context: context,
                  offset: Offset(1.0, 0.0),
                );
              },
            ),
            ListTile(
              title: Text(
                "Log out",
                style: TextStyle(color: headingColor),
              ),
              leading: Icon(Icons.backspace_sharp, color: Colors.pink),
              onTap: () {
                userProvider.signOut();
                changeRouteReplacement(
                                    context: context,
                                    destination: Login(),
                                  );
              },
            ),
          ],
        ),
      ),

      // BODY OF SCAFFOLD
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE CAROUSEL BEGINS HERE
          imageCarousel,

          // STARTING OF PADDING WIDGET
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style:
                  TextStyle(color: headingColor, fontWeight: FontWeight.bold),
            ),
          ),

          //HORIZONTAL LISTVIEW BEGINS HERE
          HorizontalList(),

          // STARTING OF PADDING WIDGET
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10, left: 8.0),
            child: Text(
              "Recent Products",
              style:
                  TextStyle(color: headingColor, fontWeight: FontWeight.bold),
            ),
          ),

          // GRID VIEW BEGINS HERE
          Flexible(child: Products()),
        ],
      ),
    );
  }
}
