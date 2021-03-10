import 'package:FashStore/components/cart_products.dart';
import 'package:FashStore/components/constants.dart';
import 'package:FashStore/components/loading.dart';
import 'package:FashStore/provider/app_provider.dart';
import 'package:FashStore/provider/order_provider.dart';
import 'package:FashStore/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      key: _key,
      // APPBAR
      appBar: AppBar(
        elevation: 0.1,
        title: Text("Shopping Cart"),
        backgroundColor: Colors.pink,
      ),

      // BODY
      body: userProvider.userModel.cart.isEmpty 
        ? Center(child: Text("Your cart is empty"))
        : CartProducts(keys: _key),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: Visibility(
        visible: appProvider.showBottomNavBar,
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              // TOTAL
              Expanded(
                child: ListTile(
                  title: Text(
                    "Total: ",
                    style: TextStyle(color: headingColor),
                  ),
                  subtitle: Text(
                    "${userProvider.userModel.totalCartPrice}",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // CHECKOUT BUTTON
              Expanded(
                child: MaterialButton(
                  color: Colors.pink,
                  onPressed: () {
                    showAlertDialog(userProvider, orderProvider);
                  },
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
      ),
    );
  }

  void showAlertDialog(UserProvider userProvider, OrderProvider orderProvider) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 150.0,
            decoration: BoxDecoration(
              // color: Colors.black,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                      "You will be charged ${userProvider.userModel.totalCartPrice} upon delivery",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: MaterialButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      bool successful = await orderProvider.createOrder(
                        userId: userProvider.user.uid,
                        totalPrice: userProvider.userModel.totalCartPrice,
                        cart: userProvider.userModel.cart,
                      );
                      if (successful) {
                        _key.currentState.showSnackBar(SnackBar(
                            content: Text("Your order was successful")));
                      } else {
                        _key.currentState.showSnackBar(SnackBar(
                            content: Text("Your order was not successful")));
                      }
                      userProvider.clearCart();
                      userProvider.reloadUserModel();

                      Navigator.pop(context);
                    },
                    child: Text("Accept"),
                  ),
                ),
                MaterialButton(
                  color: Colors.pink,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Reject"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
