import 'package:FashStore/components/constants.dart';
import 'package:FashStore/provider/app_provider.dart';
import 'package:FashStore/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatefulWidget {
  final GlobalKey<ScaffoldState> keys;

  const CartProducts({Key key, this.keys}) : super(key: key);
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return ListView.builder(
      itemCount: userProvider.userModel.cart.length,
      itemBuilder: (context, index) {
        return SingleCartProduct(
          keys: widget.keys,
          index: index,
        );
      },
    );
  }
}

class SingleCartProduct extends StatelessWidget {
  final GlobalKey<ScaffoldState> keys;
  final int index;

  // CONSTRUCTOR
  SingleCartProduct({this.keys,  this.index});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Card(
      elevation: 5,

      // STARTING OF LISTILE
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 0, top: 0),
        // LEADING
        leading: Image.network(userProvider.userModel.cart[index].image[0],
            width: 80.0, height: 80),
        //TITLE
        title: Text(
          userProvider.userModel.cart[index].name,
          style: TextStyle(color: headingColor, fontWeight: FontWeight.w500),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Colors.red,
          onPressed: () async {
            appProvider.changeLoading();
            bool success = await userProvider.removeFromCart(
                cartItem: userProvider.userModel.cart[index]);
            if (success) {
              userProvider.reloadUserModel();
             
              keys.currentState
                  .showSnackBar(SnackBar(content: Text("Removed from cart")));
              appProvider.changeLoading();
              return;
            } else {
              appProvider.changeLoading();
            }
          },
        ),
        // STARTING OF COLUMN
        subtitle: Column(
          children: [
            Row(
              children: [
                //  ====== THIS SECTION IS FOR THE SIZE OF THE PRODUCT =======
                Text("Size:"),
                SizedBox(width: 10),
                Text(
                  userProvider.userModel.cart[index].size,
                  style: TextStyle(
                    color: Colors.pinkAccent,
                  ),
                ),
//    ======= THIS SECTION IS FOR THE COLOR OF THE PRODUCT ======
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 8.0, 10.0, 8.0),
                  child: Text("Color:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    "Grey",
                    style: TextStyle(
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ],
            ),
            // sizedbox
            SizedBox(height: 15.0),

            //  =======  THIS SECTION IS FOR THE PRODUCT PRICE ======
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "\$${userProvider.userModel.cart[index].price}",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
