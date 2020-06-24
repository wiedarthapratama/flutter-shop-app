import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/product_provider.dart';
import 'package:shop_app_v2/widgets/app_drawer.dart';
import 'package:shop_app_v2/widgets/user_product_item.dart';
import 'package:shop_app_v2/screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductProvider>(context).fetchAndSetProduct();
  }
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          },),
        ]
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(
              children: <Widget>[
                UserProductItem(
                  productProvider.productList[i].id, 
                  productProvider.productList[i].title, 
                  productProvider.productList[i].imageUrl
                ),
                Divider(),
              ],
            ),
            itemCount: productProvider.productList.length,
          ),
        ),
      ),
    );
  }
}