import 'package:FashStore/models/cart_item.dart';
import 'package:FashStore/models/orders.dart';
import 'package:FashStore/models/user.dart';
import 'package:FashStore/provider/user_provider.dart';
import 'package:FashStore/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:FashStore/models/user.dart';

class OrderProvider with ChangeNotifier {
  OrderService _orderService = OrderService();
  UserProvider provider = UserProvider.initialize();

  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  OrderProvider.initialize() {
    userOrder();
  }

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
      print("The error is $e");
      return false;
    }
  }

  Future<void> userOrder() async {
    _orders = await _orderService.getUserOrders(userId: );
    notifyListeners();
  }
}
