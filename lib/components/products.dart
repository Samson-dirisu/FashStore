import 'package:FashStore/screens/product_details.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Male Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old price": "2000",
      "price": "1800"
    },
    {
      "name": "Female Blazer",
      "picture": "images/products/blazer2.jpeg",
      "old price": "2000",
      "price": "1800"
    },
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "old price": "2000",
      "price": "1800"
    },
    {
      "name": "Black dress",
      "picture": "images/products/dress2.jpeg",
      "old price": "2000",
      "price": "1800"
    },
    {
      "name": " heels",
      "picture": "images/products/hills1.jpeg",
      "old price": "2000",
      "price": "1800"
    },
    {
      "name": "Red heels",
      "picture": "images/products/hills2.jpeg",
      "old price": "2000",
      "price": "1800"
    },
    {
      "name": "Black Pant",
      "picture": "images/products/pants1.jpg",
      "old price": "2000",
      "price": "1800"
    },
    {
      "name": "Grey Pant",
      "picture": "images/products/pants2.jpeg",
      "old price": "2000",
      "price": "1800"
    },
    {
      "name": "Shoe",
      "picture": "images/products/shoe1.jpg",
      "old price": "2000",
      "price": "1800"
    },
    {
      "name": "Skirt",
      "picture": "images/products/skt1.jpeg",
      "old price": "2000",
      "price": "1800"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 15.0),
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 1),
      itemBuilder: (BuildContext context, int index) {
        return SingleProd(
          productName: productList[index]['name'],
          productOldPrice: productList[index]['old price'],
          productPicture: productList[index]['picture'],
          productPrice: productList[index]['price'],
        );
      },
    );
  }
}

class SingleProd extends StatelessWidget {
  final productName;
  final productPicture;
  final productOldPrice;
  final productPrice;

  // CONSTRUCTOR
  SingleProd(
      {this.productName,
      this.productOldPrice,
      this.productPicture,
      this.productPrice});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        child: Hero(
          tag: Text("Hero 1"),
          child: Material(
                      child: InkWell(

              // ONTAP FUNCTION
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {

                      // HERE WE ARE PASSING INFO FROM HOMEPAGE TO PRODUCT DETAIL PAGE
                      return ProductDetails(
                        productDetailName: productName,
                        productDetailNewPrice: productPrice,
                        productDetailOldPrice: productOldPrice,
                        productDetailPicture: productPicture,
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
                        productName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      "\#$productPrice",
                      style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w800),
                    ), 
                  ),
                ),
                child: Image.asset(
                  productPicture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
