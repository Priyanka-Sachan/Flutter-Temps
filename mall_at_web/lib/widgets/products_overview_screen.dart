import 'package:flutter/material.dart';
import 'package:mallatweb/widgets/cart_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import './badge.dart';
import '../providers/products_provider.dart';
import './products_overview_item.dart';

enum filterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavourites = false;

  void navigateToCart(){
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    // final cart = Provider.of<Cart>(context, listen: false).cartProducts;
    final products = _showFavourites
        ? productsData.getFavouriteProducts()
        : productsData.getProducts();

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.camera,
          color: Theme.of(context).accentColor,
          size: 40,
        ),
        title: Text(
          'Mall@Web',
          style: Theme.of(context).textTheme.headline4,
        ),
        titleSpacing: 2,
        actions: <Widget>[
          Consumer<Cart>(
            builder: (ctx, cart, ch)  {
              return Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: navigateToCart,
              ),
              value: cart.getCartCount().toString(),
            );
            }
          ),
          PopupMenuButton(
            padding: EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onSelected: (filterOptions selectedValue) {
              setState(() {
                if (selectedValue == filterOptions.Favourites)
                  _showFavourites = true;
                else
                  _showFavourites = false;
              });
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).accentColor,
            ),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: filterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: filterOptions.All,
              ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            value: products[index], child: ProductsOverviewItem()),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
      ),
    );
  }
}
