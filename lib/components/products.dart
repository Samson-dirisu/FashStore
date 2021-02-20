import 'package:FashStore/models/product/product.dart';
import 'package:FashStore/provider/product_provider.dart';
import 'package:FashStore/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'constants.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 15.0),
      itemCount: productProvider.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 1),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleProd(product: productProvider.products[index]),
        );
      },
    );
  }
}

class SingleProd extends StatelessWidget {
  final ProductModel product;

  const SingleProd({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        child: InkWell(
          // ONTAP FUNCTION
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  // HERE WE ARE PASSING INFO FROM HOMEPAGE TO PRODUCT DETAIL PAGE
                  return ProductDetails(
                    product: product,
                  );
                },
              ),
            );
          },

          // STARTING OF GRIDTILE
          child: GridTile(
            footer: Container(
              color: Colors.white38,
              child: ListTile(
                leading: Container(
                  alignment: Alignment.center,
                  width: 70.0,
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: headingColor,
                    ),
                  ),
                ),
                title: Text(
                  product.price.toString(),
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: product.images[0],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
