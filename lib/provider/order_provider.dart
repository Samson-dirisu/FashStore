import 'package:FashStore/models/cart_item.dart';
import 'package:FashStore/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class OrderProvider with ChangeNotifier {
  OrderService _orderService = OrderService();
  
  Future<bool> createOrder(
      {String userId, int totalPrice, List<CartItemModel> cart}) async {
    try {
      var uuid = Uuid();
      var id = uuid.v4();
      _orderService.createOrder(
          userId: userId,
          description: "some random description",
          status: "complete",
          id: id,
          totalPrice: totalPrice,
          cart: cart);
      return true;
    } catch (e) {
      return false;
    }
  }

  
}
