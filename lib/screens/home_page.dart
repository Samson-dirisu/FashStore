import 'package:FashStore/components/products.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//MY OWN IMPORTS
import 'package:FashStore/components/horizontal_listview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
      ),
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
              onPressed: () {},
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
                  title: Text("Home Page"),
                  leading: Icon(Icons.home, color: Colors.red),
                ),
                onTap: () {},
              ),
              InkWell(
                child: ListTile(
                  title: Text("My Account"),
                  leading: Icon(Icons.person, color: Colors.red),
                ),
                onTap: () {},
              ),
              InkWell(
                child: ListTile(
                  title: Text("My Orders"),
                  leading: Icon(Icons.shopping_basket, color: Colors.red),
                ),
                onTap: () {},
              ),
              InkWell(
                child: ListTile(
                  title: Text("Categories"),
                  leading: Icon(Icons.dashboard, color: Colors.red),
                ),
                onTap: () {},
              ),
              InkWell(
                child: ListTile(
                  title: Text("Favourites"),
                  leading: Icon(Icons.favorite, color: Colors.red),
                ),
                onTap: () {},
              ),

              Divider(),

              InkWell(
                child: ListTile(
                  title: Text("Settings"),
                  leading: Icon(Icons.settings),
                ),
                onTap: () {},
              ),
              InkWell(
                child: ListTile(
                  title: Text("About"),
                  leading: Icon(Icons.help),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),

        // BODY OF SCAFFOLD
        body: ListView(
          children: [
            // IMAGE CAROUSEL BEGINS HERE
            imageCarousel,

            // STARTING OF PADDING WIDGET
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Categories"),
            ),

            //HORIZONTAL LISTVIEW BEGINS HERE
            HorizontalList(),

            // STARTING OF PADDING WIDGET
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("Recent Products"),
            ),

            // GRID VIEW BEGINS HERE
            Container(height: 320.0, child: Products()),
          ],
        ));
  }
}
