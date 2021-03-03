import 'package:FashStore/components/loading.dart';
import 'package:FashStore/components/products.dart';
import 'package:FashStore/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimilarProductScreen extends StatelessWidget {
  final String text;
  final String category;

  const SimilarProductScreen({Key key, this.text, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: text == null ? Text(" ") : Text(text),
        backgroundColor: Colors.pink,
      ),
      body: productProvider.similarCategory.length == 0
      ? Center(child: Text("No product matching this category found"))
      : GridView.builder(
          itemCount: productProvider.similarCategory.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 1),
          itemBuilder: (context, index) {
            return SingleProd(
              product: productProvider.similarCategory[index],
            );
          },
        ),
    );
  }
}
