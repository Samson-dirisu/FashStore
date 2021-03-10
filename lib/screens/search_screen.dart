import 'package:FashStore/components/product_cart.dart';
import 'package:FashStore/helper/navigator.dart';
import 'package:FashStore/provider/product_provider.dart';
import 'package:FashStore/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text("Searched Products"),
        backgroundColor: Colors.pink,
      ),
      body: productProvider.productsSearched.length == 0
          ? Center(child: Text("oops!!! No product matching your search"))
          : ListView.builder(
              itemCount: productProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // createPageRoute(
                    //   destination: ProductDetails(),
                    //   context: context,
                    //   offset: Offset(1.0, 0.0),
                    // );
                  },
                  child: ProductCard(product: productProvider.productsSearched[index]),
                );
              },
            ),
    );
  }
}
