import 'package:FashStore/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text("My Orders"),
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) {
          print("xxxxxxxxxx ${orderProvider.orders.length}");
          return Card(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.red,
                  backgroundImage: NetworkImage(
                      "${orderProvider.orders[index].cart[index]["images"][0]}"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
