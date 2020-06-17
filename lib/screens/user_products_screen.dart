import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/product_provider.dart';
import 'package:shop_app_v2/widgets/app_drawer.dart';
import 'package:shop_app_v2/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){},),
        ]
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: <Widget>[
              UserProductItem(productProvider.productList[i].title, productProvider.productList[i].imageUrl),
              Divider(),
            ],
          ),
          itemCount: productProvider.productList.length,
        ),
      ),
    );
  }
}