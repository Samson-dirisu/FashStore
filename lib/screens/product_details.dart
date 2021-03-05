import 'package:FashStore/components/constants.dart';
import 'package:FashStore/components/loading.dart';
import 'package:FashStore/components/products.dart';
import 'package:FashStore/provider/app_provider.dart';
import 'package:FashStore/provider/product_provider.dart';
import 'package:FashStore/provider/user_provider.dart';
import 'package:FashStore/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:FashStore/models/product.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;

  // CONSTRUCTOR
  ProductDetails({this.product});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _key = GlobalKey<ScaffoldState>();
  String _size = '';
  @override
  void initState() {
    super.initState();
    _size = widget.product.sizes[0];
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider provider = Provider.of<ProductProvider>(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    provider.sameProducts(category: widget.product);

    return Scaffold(
      key: _key,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // SIZE BUTTON
              Text("Select size"),
              DropdownButton<String>(
                value: _size,
                items: widget.product.sizes
                    .map<DropdownMenuItem<String>>(
                      (value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _size = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 0.0),

//        =========== SECOND SET OF BUTTONS ===========
          Row(
            children: [
              // ADD TO CART NOW BUTTON
              Expanded(
                child: MaterialButton(
                    elevation: 0.4,
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      appProvider.changeLoading();
                      bool success = await userProvider.addToCart(
                          product: widget.product, size: _size);
                      if (success) {
                        _key.currentState.showSnackBar(
                            SnackBar(content: Text("Added to Cart")));
                        userProvider.reloadUserModel();
                        appProvider.changeLoading();
                        return;
                      } else {
                        _key.currentState.showSnackBar(
                            SnackBar(content: Text("Not added to Cart")));
                      }
                      appProvider.changeLoading();
                      return;
                    },
                    color: Colors.pink,
                    textColor: Colors.white,
                    child: appProvider.isLoading
                        ? Loading()
                        : Text("Add to Cart")),
              ),

              // LIKE BUTTON
              IconButton(
                icon:  userProvider.checkWishList(widget.product)
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border, color: Colors.black),
                onPressed: () {
                  if (userProvider.wishListItems.contains(widget.product.id)) {
                    userProvider.removeFromWishList(product: widget.product);
                    userProvider.reloadUserModel();
                  } else {
                    userProvider.addToWishList(product: widget.product);
                    userProvider.reloadUserModel();
                  }
                },
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
