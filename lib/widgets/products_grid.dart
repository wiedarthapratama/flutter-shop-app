import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/product_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  bool _isFavs;

  ProductsGrid(this._isFavs);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final productList = _isFavs ? productProvider.favoriteProductList : productProvider.productList;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        childAspectRatio: 3/2, 
        crossAxisSpacing: 10, 
        mainAxisSpacing: 10
      ), 
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: productList[i],
        child: ProductItem(
          // productList[i].id, 
          // productList[i].title, 
          // productList[i].imageUrl
        )
      ),
      itemCount: productList.length,
    );
  }
}