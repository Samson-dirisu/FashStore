import 'package:FashStore/models/product/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "product";

  Future<List<ProductModel>> getProducts() =>
      _firestore.collection(collection).get().then((snapshot) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in snapshot.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });
}
