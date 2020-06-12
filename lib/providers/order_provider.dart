import 'package:flutter/foundation.dart';
import 'package:shop_app_v2/models/order.dart';
import 'package:shop_app_v2/models/cart.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orderList = [];

  List<Order> get orderList {
    return [..._orderList];
  }

  void addOrder(List<Cart> cartProducts, double total) {
    _orderList.insert(
      0, 
      Order(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts
      )
    );
    notifyListeners();
  }
}