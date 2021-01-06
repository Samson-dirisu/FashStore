import 'package:FashStore/components/cart_products.dart';
import 'package:FashStore/components/constants.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        elevation: 0.1,
        title: Text("Shopping Cart"),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),

      // BODY
      body: CartProducts(),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            // TOTAL
            Expanded(
              child: ListTile(
                title: Text("Total: ", style: TextStyle(
                  color: headingColor
                ),),
                subtitle: Text("#2000", style: TextStyle(
                  color: Colors.green,
                  fontSize: 15
                ),),
              ),
            ),

            // CHECKOUT BUTTON
            Expanded(
              child: MaterialButton(
                color: Colors.pink,
                onPressed: () {},
                child: Text(
                  "Check out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
