import 'package:FashStore/components/loading.dart';
import 'package:FashStore/components/tag.dart';
import 'package:FashStore/helper/navigator.dart';
import 'package:FashStore/models/product.dart';
import 'package:FashStore/provider/product_provider.dart';
import 'package:FashStore/provider/user_provider.dart';
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
    final provider = Provider.of<ProductProvider>(context);
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          provider.sameProductsByText(category: product.category);
          createPageRoute(
            destination: ProductDetails(product: product),
            context: context,
            offset: Offset(0.0, 1.0),
          );
        },

        // STARTING OF GRIDTILE
        child: Stack(
          children: [
            Positioned.fill(
                child: Align(alignment: Alignment.center, child: Loading())),
            GridTile(
              footer: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Tag(text: product.name),
                    Tag(text: "\$${product.price}", textColor: Colors.green),
                  ],
                ),
              ),
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: product.images[0],
                  fit: BoxFit.cover,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
