import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/order_provider.dart';
import 'package:shop_app_v2/widgets/app_drawer.dart';
import 'package:shop_app_v2/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders")
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(orderProvider.orderList[i]),
        itemCount: orderProvider.orderList.length,
      ),
    );
  }
}