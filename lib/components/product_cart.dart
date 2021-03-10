import 'package:FashStore/helper/navigator.dart';
import 'package:FashStore/models/product.dart';
import 'package:FashStore/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'loading.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          createPageRoute(
            destination: ProductDetails(product: product),
            context: context,
            offset: Offset(1.0, 0.0),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-2, -1),
                  blurRadius: 5,
                )
              ]),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Loading(),
                        ),
                      ),
                      Center(
                        child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: product.images[0],
                            fit: BoxFit.cover,
                            height: 140,
                            width: 120,
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                  text: "${product.name} \n",
                  style: TextStyle(fontSize: 20),
                ),
                TextSpan(
                  text: "by: ${product.brand} \n\n\n",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                TextSpan(
                  text: "\$${product.price} \t",
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                  ),
                ),
                  ],
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
