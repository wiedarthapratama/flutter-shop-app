import 'package:flutter/material.dart';
import 'package:shop_app_v2/models/product.dart';
import 'package:shop_app_v2/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop')
      ),
      body: ProductsGrid(),
    );
  }
}