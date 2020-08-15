import 'package:flutter/material.dart';
import '../providers/auth.dart';
import './auth_screen.dart';
import 'package:provider/provider.dart';

import './manage_product_screen.dart';
import './cart_screen.dart';
import '../providers/cart.dart';
import './badge.dart';
import '../providers/products_provider.dart';
import './products_overview_item.dart';

enum menuOptions { Favourites, All, Add ,LogOut}

class ProductsOverviewScreen extends StatefulWidget {

  static const routeName='/products-overview-screen';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavourites = false;
  bool _init = false;
  bool _isLoading = false;

  @override
  void initState() {
    _init = true;
    //Other ways to use context in init..
//    Future.delayed(Duration.zero)
//        .then((value) => Provider.of<Products>(context).fetchProducts());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      _init = false;
    }
    super.didChangeDependencies();
  }

  void navigateToCart() {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
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
          Consumer<Cart>(builder: (ctx, cart, ch) {
            return Badge(
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: navigateToCart,
              ),
              value: cart.getCartCount().toString(),
            );
          }),
          PopupMenuButton(
            padding: EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onSelected: (menuOptions selectedValue) {
              setState(() {
                if (selectedValue == menuOptions.Favourites)
                  _showFavourites = true;
                else if (selectedValue == menuOptions.All)
                  _showFavourites = false;
                else if(selectedValue==menuOptions.Add) {
                  Navigator.of(context)
                      .pushNamed(ManageProductScreen.routeName);
                }
                else{
                  Provider.of<Auth>(context,listen: false).logOut();
                  //Navigator.of(context).pushNamed(AuthScreen.routeName);
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).accentColor,
            ),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: menuOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: menuOptions.All,
              ),
              PopupMenuItem(
                child: Text('Your Products'),
                value: menuOptions.Add,
              ),
              PopupMenuItem(
                child: Text('Log Out'),
                value: menuOptions.LogOut,
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
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
