import 'package:FashStore/components/constants.dart';
import 'package:FashStore/components/products.dart';
import 'package:FashStore/screens/home_page.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String productDetailName;
  final int productDetailNewPrice;
  final int productDetailOldPrice;
  final String productDetailPicture;

  // CONSTRUCTOR
  ProductDetails(
      {this.productDetailName,
      this.productDetailNewPrice,
      this.productDetailOldPrice,
      this.productDetailPicture});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        elevation: 0.1,
        centerTitle: true,
        title: InkWell(
          child: Text("FashStore"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
          },
        ),
        backgroundColor: Colors.pink,

        // APPBAR BUTTONS
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),

      // BODY
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 10),
        children: [
          Container(
            height: 300,
            color: Colors.black,
            child: Hero(
              tag: Text("Hero 1"),
              child: Material(
                // GRIDTILE STARTS HERE
                child: GridTile(
                  child: Container(
                    color: Colors.white,
                    child: Image.asset(widget.productDetailPicture),
                  ),

                  //FOOTER
                  footer: Container(
                    color: Colors.white38,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0),
                      leading: Container(
                        width: 100.0,
                        alignment: Alignment.center,
                        child: Text(
                          widget.productDetailName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: headingColor,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "#${widget.productDetailOldPrice}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "#${widget.productDetailNewPrice}",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 0.0),

          //      =========== FIRST SET OF BUTTONS ===========
          Row(
            children: [
              // SIZE BUTTON
              Expanded(
                child: MaterialButton(
                  elevation: 0.4,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Size"),
                          content: Text("Choose the size"),
                          actions: [
                            MaterialButton(
                              textColor: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: [
                      Expanded(child: Text("Size")),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),

              // COLOR BUTTON
              Expanded(
                child: MaterialButton(
                  elevation: 0.4,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Color"),
                          content: Text("Choose a  color"),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textColor: Colors.red,
                              child: Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: [
                      Expanded(child: Text("Color")),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),

              // QUANTITY BUTTON
              Expanded(
                child: MaterialButton(
                  elevation: 0.4,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Quantity"),
                          content: Text("Choose the Quantity"),
                          actions: [
                            MaterialButton(
                              child: Text("Close"),
                              textColor: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: [
                      Expanded(child: Text("Qty")),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.0),

//        =========== SECOND SET OF BUTTONS ===========
          Row(
            children: [
              // BUY NOW BUTTON
              Expanded(
                child: MaterialButton(
                    elevation: 0.4,
                    onPressed: () {},
                    color: Colors.pink,
                    textColor: Colors.white,
                    child: Text("Buy now")),
              ),

              // ADD TO SHOPPING CART BUTTON
              IconButton(
                icon: Icon(Icons.add_shopping_cart, color: Colors.red),
                onPressed: () {},
              ),

              // LIKE BUTTON
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () {},
              ),
            ],
          ),

          SizedBox(
            height: 10.0,
          ),

          // PRODUCT DETAILS
          ListTile(
            contentPadding: EdgeInsets.only(left: 0, right: 0),
            title: Text(
              "Product details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: headingColor,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry's standard dummy text ever since the 1500's, when an unknown printer took a gallery of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesettng remaining essentially unchanged. It was popular in the 1960's with the release of Jazz",
                style: TextStyle(
                  letterSpacing: 0.7,
                  color: primaryColor,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),

//      ======== PRODUCT EXTRA DETAILS LIKE NAME, BRAND AND CONDITION ===
          //PRODUCT NAME
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product name: ",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.productDetailName, 
                style: TextStyle(
                  color: primaryColor,
                ),),
              ),
            ],
          ),

          // PRODUCT BRAND
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 5.0, 5.0),
                child: Text(
                  "Product brand: ",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),

              //TODO: Remember to create product brand
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Brand x", style: TextStyle(
                  color: primaryColor,
                ),),
              ),
            ],
          ),

          // PRODUCT CONDITION
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 5.0, 5.0),
                child: Text(
                  "Product condition: ",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("New", style: TextStyle(
                  color: primaryColor,
                ),),
              ),
            ],
          ),

          // SIMILAR PRODUCT SECTION
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Similar Product",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(height: 360.0, child: SimilarProducts())
        ],
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  var productList = [
    {
      "name": "Male Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old price": 2000,
      "price": 1800
    },
    {
      "name": "Female Blazer",
      "picture": "images/products/blazer2.jpeg",
      "old price": 2000,
      "price": 1800
    },
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "old price": 2000,
      "price": 1800
    },
    {
      "name": "Black dress",
      "picture": "images/products/dress2.jpeg",
      "old price": 2000,
      "price": 1800
    },
    {
      "name": " heels",
      "picture": "images/products/hills1.jpeg",
      "old price": 2000,
      "price": 1800
    },
    {
      "name": "Red heels",
      "picture": "images/products/hills2.jpeg",
     "old price": 2000,
      "price": 1800
    },
    {
      "name": "Black Pant",
      "picture": "images/products/pants1.jpg",
      "old price": 2000,
      "price": 1800
    },
    {
      "name": "Grey Pant",
      "picture": "images/products/pants2.jpeg",
      "old price": 2000,
      "price": 1800
    },
    {
      "name": "Shoe",
      "picture": "images/products/shoe1.jpg",
      "old price": 2000,
      "price": 1800
    },
    {
      "name": "Skirt",
      "picture": "images/products/skt1.jpeg",
     "old price": 2000,
      "price": 1800
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

class SimilarSingleProd extends StatelessWidget {
  final productName;
  final productPicture;
  final productOldPrice;
  final productPrice;

  // CONSTRUCTOR
  SimilarSingleProd(
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
