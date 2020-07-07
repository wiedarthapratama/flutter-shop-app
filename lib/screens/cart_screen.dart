import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/cart_provider.dart';
import 'package:shop_app_v2/providers/order_provider.dart';
import 'package:shop_app_v2/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Column(children: <Widget>[
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
                      label: Text(
                        '\$ ${cartProvider.totalAmount}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OrderButton(cartProvider: cartProvider)
                  ],
                ))),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (ctx, i) => CartItem(
              cartProvider.cartList.keys.toList()[i],
              cartProvider.cartList.values.toList()[i].id,
              cartProvider.cartList.values.toList()[i].title,
              cartProvider.cartList.values.toList()[i].price,
              cartProvider.cartList.values.toList()[i].quantity),
          itemCount: cartProvider.cartList.length,
        ))
      ]),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartProvider,
  }) : super(key: key);

  final CartProvider cartProvider;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cartProvider.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<OrderProvider>(context, listen: false).addOrder(
                  widget.cartProvider.cartList.values.toList(),
                  widget.cartProvider.totalAmount);
              setState(() {
                _isLoading = false;
              });
              widget.cartProvider.clearCart();
            },
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              "Order Now",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
    );
  }
}
