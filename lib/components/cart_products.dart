import 'package:FashStore/components/constants.dart';
import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productsOnCart = [
    {
      "name": "Male Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": "1800",
      "size": "M",
      "color": "Red",
      "Quantity": 1,
    },
    {
      "name": "Female Blazer",
      "picture": "images/products/blazer2.jpeg",
      "price": "1800",
      "size": "M",
      "color": "Black",
      "Quantity": 1,
    },
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "price": "1800",
      "size": "M",
      "color": "Grey",
      "Quantity": 1,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productsOnCart.length,
      itemBuilder: (context, index) {
        return SingleCartProduct(
          cartProductColor: productsOnCart[index]['color'],
          cartProductName: productsOnCart[index]['name'],
          cartProductPicture: productsOnCart[index]['picture'],
          cartProductPrice: productsOnCart[index]['price'],
          cartProductQuantity: productsOnCart[index]['Quantity'],
          cartProductSize: productsOnCart[index]['size'],
        );
      },
    );
  }
}

class SingleCartProduct extends StatelessWidget {
  final cartProductName;
  final cartProductPicture;
  final cartProductPrice;
  final cartProductSize;
  final cartProductColor;
  final cartProductQuantity;

  // CONSTRUCTOR
  SingleCartProduct(
      {this.cartProductColor,
      this.cartProductName,
      this.cartProductPicture,
      this.cartProductPrice,
      this.cartProductQuantity,
      this.cartProductSize});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,

      // STARTING OF LISTILE
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 0, top: 0),
        // LEADING
        leading: Image.asset(cartProductPicture, width: 80.0, height: 80),
        //TITLE
        title: Text(
          cartProductName,
          style: TextStyle(color: headingColor, fontWeight: FontWeight.w500),
        ),
        // STARTING OF COLUMN
        subtitle: Column(
          children: [
            Row(
              children: [

  //  ====== THIS SECTION IS FOR THE SIZE OF THE PRODUCT =======
                Text("Size:"),
                SizedBox(width: 10),
                Text(
                  cartProductSize,
                  style: TextStyle(
                    color: Colors.pinkAccent,
                  ),
                ),
//    ======= THIS SECTION IS FOR THE COLOR OF THE PRODUCT ======
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 8.0, 10.0, 8.0),
                  child: Text("Color:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    cartProductColor,
                    style: TextStyle(
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ],
            ),
            // sizedbox
            SizedBox(height: 15.0),

  //  =======  THIS SECTION IS FOR THE PRODUCT PRICE ======
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "#$cartProductPrice",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),

//    ========= THIS SECTION IS FOR THE QUANTITY OF THE PRODUCT =======
        trailing: Column(
          children: [
            Expanded(
              child: InkWell(
                child: Icon(Icons.arrow_drop_up),
                onTap: () {},
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text("$cartProductQuantity"),
            )),
            Expanded(
              child: InkWell(
                child: Icon(Icons.arrow_drop_down),
                onTap: (){},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
