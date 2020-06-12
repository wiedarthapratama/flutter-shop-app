import 'package:flutter/foundation.dart';
import 'package:shop_app_v2/models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartList = {};

  Map<String, Cart> get cartList {
    return {..._cartList};
  }

  int get cartCount {
    return _cartList.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartList.forEach((key, cart) { 
      total += cart.price * cart.quantity;
    });
    return total;
  }

  void addCart(String productId, String title, double price) {
    if(_cartList.containsKey(productId)){
      _cartList.update(productId, (existingCart) => Cart(
        id: existingCart.id,
        title: existingCart.title,
        price: existingCart.price,
        quantity: existingCart.quantity + 1,
      ));
    }else{
      _cartList.putIfAbsent(productId, () => Cart(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  void removeCart(String productId){
    _cartList.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartList = {};
    notifyListeners();
  }
}