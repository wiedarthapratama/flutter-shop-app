import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/auth_provider.dart';
import 'package:shop_app_v2/providers/cart_provider.dart';
import 'package:shop_app_v2/providers/order_provider.dart';
import 'package:shop_app_v2/providers/product_provider.dart';
import 'package:shop_app_v2/screens/auth_screen.dart';
import 'package:shop_app_v2/screens/cart_screen.dart';
import 'package:shop_app_v2/screens/edit_product_screen.dart';
import 'package:shop_app_v2/screens/orders_screen.dart';
import 'package:shop_app_v2/screens/product_detail_screen.dart';
import 'package:shop_app_v2/screens/products_overview_screen.dart';
import 'package:shop_app_v2/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OrderProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.red,
              fontFamily: 'Lato'),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen()
          },
        ),
      ),
    );
  }
}
