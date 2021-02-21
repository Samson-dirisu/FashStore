import 'package:FashStore/components/constants.dart';
import 'package:FashStore/components/products.dart';
import 'package:FashStore/provider/product_provider.dart';
import 'package:FashStore/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:FashStore/models/product/product.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;

  // CONSTRUCTOR
  ProductDetails({this.product});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final ProductProvider provider = Provider.of<ProductProvider>(context);
    provider.sameProducts(category: widget.product);
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
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.product.images[0]),
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
                      widget.product.name,
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
                          "0900",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "#${widget.product.price}",
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
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
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
                child: Text(
                  "${widget.product.brand}",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
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
                child: Text(
                  "New",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
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
          Container(
              height: 360.0,
              child: SimilarProducts(
                products: provider.similarProducts,
              ))
        ],
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  final List<ProductModel> products;

  const SimilarProducts({Key key, this.products}) : super(key: key);
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 15.0),
      itemCount: widget.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 1),
      itemBuilder: (BuildContext context, int index) {
        if (widget.products != null) {
          return SingleProd(product: widget.products[index]);
        } else
          return Text("no similar category found");
      },
    );
  }
}
