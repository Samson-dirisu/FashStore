import 'package:FashStore/components/constants.dart';
import 'package:FashStore/helper/navigator.dart';
import 'package:FashStore/provider/product_provider.dart';
import 'package:FashStore/screens/similar_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Category(
            imageLocation: "images/cate_image/tshirt.png",
            imageCaption: "shirt",
            onTap: (){
              
    productProvider.sameProductsByText(category: "shirt");
              createPageRoute(
                destination: SimilarProductScreen(
                  text: "Shirt Category",
                  category: "shirt",
                ),
                context: context,
                offset: Offset(0.0, 1.0),
              );
            },
          ),
          Category(
            imageLocation: "images/cate_image/jeans.png",
            imageCaption: "jeans",
            onTap: (){
              productProvider.sameProductsByText(category: "jeans");
              createPageRoute(
                destination: SimilarProductScreen(
                  text: "Jeans Category",
                  category: "jeans",
                ),
                context: context,
                offset: Offset(0.0, 1.0),
              );
            },
          ),
          Category(
            imageLocation: "images/cate_image/informal.png",
            imageCaption: "informal",
            onTap: (){
              productProvider.sameProductsByText(category: "informal");
              createPageRoute(
                destination: SimilarProductScreen(
                  text: "Informal Category",
                  category: "informal",
                ),
                context: context,
                offset: Offset(0.0, 1.0),
              );
            },
          ),
          Category(
            imageLocation: "images/cate_image/accessories.png",
            imageCaption: "accessories",
            onTap: (){
              productProvider.sameProductsByText(category: "accessories");
              createPageRoute(
                destination: SimilarProductScreen(
                  text: "Accessories Category",
                  category: "accessories",
                ),
                context: context,
                offset: Offset(0.0, 1.0),
              );
            },
          ),
          Category(
            imageLocation: "images/cate_image/dress.png",
            imageCaption: "dress",
            onTap: (){
              productProvider.sameProductsByText(category: "dress");
              createPageRoute(
                destination: SimilarProductScreen(
                  text: "Dress Category",
                  category: "dress",
                ),
                context: context,
                offset: Offset(0.0, 1.0),
              );
            },
          ),
          Category(
            imageLocation: "images/cate_image/formal.png",
            imageCaption: "formal",
            onTap: (){
              productProvider.sameProductsByText(category: "formal");
              createPageRoute(
                destination: SimilarProductScreen(
                  text: "Formal Category",
                  category: "formal",
                ),
                context: context,
                offset: Offset(0.0, 1.0),
              );
            },
          ),
          Category(
            imageLocation: "images/cate_image/shoe.png",
            imageCaption: "shoe",
            onTap: (){
              productProvider.sameProductsByText(category: "shoe");
              createPageRoute(
                destination: SimilarProductScreen(
                  text: "Shoe Category",
                  category: "shoe",
                ),
                context: context,
                offset: Offset(0.0, 1.0),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;
  final Function onTap;

  // CONSTRUCTOR
  Category({this.imageCaption, this.imageLocation, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        child: Container(
          width: 100.0,
          child: ListTile(
              title: Image.asset(
                imageLocation,
                width: 40,
                height: 40,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    imageCaption,
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              )),
        ),
        onTap: onTap,
      ),
    );
  }
}
