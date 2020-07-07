import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shop_app_v2/models/order.dart';
import 'package:shop_app_v2/models/cart.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<Order> _orderList = [];

  List<Order> get orderList {
    return [..._orderList];
  }

  Future<void> addOrder(List<Cart> cartProducts, double total) async {
    const url = "https://flutter-shop-app-281d3.firebaseio.com/orders.json";
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList(),
        }));
    _orderList.insert(
        0,
        Order(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timestamp,
            products: cartProducts));
    notifyListeners();
  }
}
