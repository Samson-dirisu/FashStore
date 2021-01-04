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
      "name": "Purple heels",
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
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
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
        child: Hero(
          tag: productName,
          child: Material(
            child: InkWell(
              onTap: () {},
              child: GridTile(
                footer: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Text(
                      productName,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
