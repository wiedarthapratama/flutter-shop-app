import 'package:flutter/material.dart';
import 'package:shop_app_v2/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if(selectedValue == FilterOptions.Favorites){
                  _isFavorite = true;
                }else{
                  _isFavorite = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
            ]
          )
        ],
      ),
      body: ProductsGrid(_isFavorite),
    );
  }
}