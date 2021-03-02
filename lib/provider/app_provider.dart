import 'package:flutter/material.dart';

enum SearchBy { PRODUCTS, RESTURANTS }

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  bool showBottomNavBar = true;
  SearchBy search = SearchBy.PRODUCTS;
  String filtered = "Products";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;

  void changeLoading() {
    isLoading = !isLoading;
    showBottomNavBar = !showBottomNavBar;
    notifyListeners();
  }

  addPrice({int newPrice}) {
    priceSum += newPrice;
    notifyListeners();
  }
}
