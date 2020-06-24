import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/cart_provider.dart';
import 'package:shop_app_v2/providers/product_provider.dart';
import 'package:shop_app_v2/screens/cart_screen.dart';
import 'package:shop_app_v2/widgets/app_drawer.dart';
import 'package:shop_app_v2/widgets/badge.dart';
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
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    // ini hanya di load sekali
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductProvider>(context).fetchAndSetProduct();
    // });
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // ini ngeload beberapa kali
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    // setState(() {
      _isInit=false;
    // });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (_, cartProvider, ch) => Badge(
              child: ch, 
              value: cartProvider.cartCount.toString()
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
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
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ProductsGrid(_isFavorite),
    );
  }
}