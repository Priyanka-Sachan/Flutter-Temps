import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './orders_screen.dart';
import '../providers/orders.dart';
import '../providers/cart.dart';
import './cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Theme.of(context).accentColor
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.airport_shuttle,
              color: Theme.of(context).accentColor,
              size: 32,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(OrdersScreen.routeName),
          )
        ],
        title: Text(
          'My Cart',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: cart.cartProducts.length==0?Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                  size:300
                ),
                Text('Your cart is empty!',
                style: Theme.of(context).textTheme.headline4,)
              ],
            ):ListView.builder(
              itemBuilder: (ctx, index) =>
                  CartItem(cart.cartProducts.values.toList()[index]),
              itemCount: cart.getCartCount(),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'Total:  ',
                style: Theme.of(context).textTheme.headline6,
              ),
              Chip(
                label: Text('Rs.${cart.totalAmount.toStringAsFixed(2)}'),
              ),
              Expanded(child: SizedBox()),
              FlatButton(
                child: Text(
                  'ORDER NOW',
                  style: Theme.of(context).textTheme.headline6,
                ),
                onPressed: () {
                  if (cart.cartProducts.length > 0) {
                    Provider.of<Orders>(context, listen: false).addOrder(
                        cart.cartProducts.values.toList(), cart.totalAmount);
                    cart.clearCart();
                    Navigator.of(context).pushNamed(OrdersScreen.routeName);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
