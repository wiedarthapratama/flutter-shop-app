import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(this.productId, this.id, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to remove the item from the cart?"),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(ctx).pop(false);
                }, 
                child: Text("No")
              ),
              FlatButton(
                onPressed: (){
                  Navigator.of(ctx).pop(true);
                }, 
                child: Text("Yes")
              ),
            ],
          )
        );
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeCart(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: FittedBox(child: Text('\$ ${price}')),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total: \$ ${(price*quantity)}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}