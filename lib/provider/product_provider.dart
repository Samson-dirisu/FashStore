import 'package:FashStore/components/services/product_service.dart';
import 'package:FashStore/models/product/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  ProductService _productService = ProductService();
  List<ProductModel> products = [];
  List<ProductModel> productsSearched = [];
  List<ProductModel> similarProducts = [];

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productService.getProducts();
    notifyListeners();
  }

  Future search({String productName}) async {
    productsSearched =
        await _productService.searchProducts(productName: productName);
    notifyListeners();
  }

  Future sameProducts({ProductModel category}) async {
    similarProducts = await _productService.getSimilarProduct(category.category);
    notifyListeners();
  }
}
