import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart")
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$ ${cartProvider.totalAmount}', style: TextStyle(color: Colors.white),),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(onPressed: null, child: Text("Order Now", style: TextStyle(color: Theme.of(context).primaryColor),),)
                ],
              )
            )
          )
        ]
      ),
    );
  }
}