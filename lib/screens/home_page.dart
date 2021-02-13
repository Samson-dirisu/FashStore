import 'package:FashStore/components/constants.dart';
import 'package:FashStore/components/products.dart';
import 'package:FashStore/provider/user_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
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
      // APPBAR
      appBar: AppBar(
        elevation: 0.1,
        title: Text("FashStore"),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return CartPage();
                  },
                ),
              );
            },
          ),
        ],
      ),

      // DRAWER
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Samson Dirisu"),
              accountEmail: Text("Samsonauston@gmail.com"),
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
                leading: Icon(Icons.home, color: Colors.red),
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListTile(
                title: Text(
                  "My Account",
                  style: TextStyle(color: headingColor),
                ),
                leading: Icon(Icons.person, color: Colors.red),
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListTile(
                title: Text(
                  "My Orders",
                  style: TextStyle(color: headingColor),
                ),
                leading: Icon(Icons.shopping_basket, color: Colors.red),
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListTile(
                title: Text(
                  "Shopping cart",
                  style: TextStyle(color: headingColor),
                ),
                leading: Icon(Icons.shopping_cart, color: Colors.red),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return CartPage();
                    },
                  ),
                );
              },
            ),
            InkWell(
              child: ListTile(
                title: Text(
                  "Favourites",
                  style: TextStyle(color: headingColor),
                ),
                leading: Icon(Icons.favorite, color: Colors.red),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Log out",
                style: TextStyle(color: headingColor),
              ),
              leading: Icon(Icons.backspace_sharp, color: Colors.red),
              onTap: () {
                user.signOut();
              },
            ),

            Divider(),

            InkWell(
              child: ListTile(
                title: Text(
                  "Settings",
                  style: TextStyle(color: headingColor),
                ),
                leading: Icon(Icons.settings),
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListTile(
                title: Text(
                  "About",
                  style: TextStyle(color: headingColor),
                ),
                leading: Icon(Icons.help),
              ),
              onTap: () {},
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
