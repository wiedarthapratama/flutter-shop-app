import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/models/product.dart';
import 'package:shop_app_v2/providers/cart_provider.dart';
import 'package:shop_app_v2/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // menggunakan cara ini agar data product tidak berubah tapi untuk object favorite berubah karna menggunakan consumer

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ), 
              onPressed: () {
                product.toogleFavoriteStatus();
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ), 
            onPressed: (){
              cartProvider.addCart(product.id, product.title, product.price);
            },
          ),
        ),
      ),
    );
  }
}