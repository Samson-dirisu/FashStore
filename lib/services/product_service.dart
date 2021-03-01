import 'package:FashStore/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  
  // search function
  Future<List<ProductModel>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((snapshot) {
          List<ProductModel> products = [];
          for (DocumentSnapshot result in snapshot.docs) {
            products.add(ProductModel.fromSnapshot(result));
          }
          return products;
        });
  }

  Future<List<ProductModel>> getSimilarProduct(String category) {
   return _firestore
      .collection(collection)
      .where("category", isEqualTo: category)
      .get()
      .then((snapshot) {
        List<ProductModel> products = [];
        for (DocumentSnapshot item in snapshot.docs) {
          products.add(ProductModel.fromSnapshot(item));
        }
        return products;
      });
  }
}
