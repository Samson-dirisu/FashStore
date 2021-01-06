import 'package:FashStore/components/constants.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Category(
            imageLocation: "images/cate_image/tshirt.png",
            imageCaption: "shirt",
          ),
          Category(
            imageLocation: "images/cate_image/jeans.png",
            imageCaption: "jeans",
          ),
          Category(
            imageLocation: "images/cate_image/informal.png",
            imageCaption: "informal",
          ),
          Category(
            imageLocation: "images/cate_image/accessories.png",
            imageCaption: "accessories",
          ),
          Category(
            imageLocation: "images/cate_image/dress.png",
            imageCaption: "dress",
          ),
          Category(
            imageLocation: "images/cate_image/formal.png",
            imageCaption: "formal",
          ),
          Category(
            imageLocation: "images/cate_image/shoe.png",
            imageCaption: "shoe",
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {

  final String imageLocation;
  final String imageCaption;

  // CONSTRUCTOR
  Category({this.imageCaption, this.imageLocation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(imageLocation),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(imageCaption,style: TextStyle(
                    color: primaryColor,
                  ),),
              ),
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
 