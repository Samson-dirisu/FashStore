
import 'package:FashStore/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text("My Orders"),
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        itemCount: userProvider.orders.length,
        itemBuilder: (context, index) {
          return Container(
            height: 80.0,
            child: Card(
              elevation: 5.0,
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(
                    "#${userProvider.orders[index].total}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    "${userProvider.orders[index].description}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                subtitle:
                    Text("${DateTime.fromMillisecondsSinceEpoch(userProvider.orders[index].creatAt)}"),
                trailing: Text("${userProvider.orders[index].status}", style: TextStyle(
                  color: Colors.green
                ),),
              ),
            ),
          );
        },
      ),
    );
  }
}
