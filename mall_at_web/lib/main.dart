import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/product.dart';
import './widgets/edit_product_screen.dart';
import './widgets/manage_product_screen.dart';
import './providers/orders.dart';
import './widgets/orders_screen.dart';
import './widgets/cart_screen.dart';
import './widgets/product_details_screen.dart';
import './widgets/products_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Color.fromRGBO(68, 44, 46, 1),
              primaryColorLight: Colors.pink.shade50,
              primaryColorDark: Colors.pink.shade200,
              accentColor: Color.fromRGBO(68, 44, 46, 1),
              fontFamily: 'Quicksand',
              iconTheme: IconThemeData(color: Color.fromRGBO(68, 44, 46, 1))),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            ManageProductScreen.routeName: (ctx) => ManageProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(Product()),
          }),
    );
  }
}
