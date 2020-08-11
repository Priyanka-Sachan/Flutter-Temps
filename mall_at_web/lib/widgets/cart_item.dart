import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/cartProduct.dart';

class CartItem extends StatelessWidget {
  CartProduct cartProduct;

  CartItem(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Cart cart= Provider.of<Cart>(context, listen: false);

    return Dismissible(
      background: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 32),
          child: Icon(
            Icons.delete,
            size: 40,
            color: Theme.of(context).accentColor,
          ),
          alignment: Alignment.centerRight,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeProductFromCart(cartProduct.id);
      },
      key: ValueKey(cartProduct.id),
      child: Card(
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Card(
          margin: EdgeInsets.all(2),
          color: Colors.pink.shade50,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    child: Image.network(
                      cartProduct.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Text(
                        cartProduct.title,
                        textWidthBasis: TextWidthBasis.parent,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                          'Total: Rs.${(cartProduct.price * cartProduct.quantity).toStringAsFixed(2)}')
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          size: 32,
                        ), onPressed: ()=>cart.changeProductQuantity(cartProduct.id, 1),
                      ),
                      Text(
                        cartProduct.quantity.toString(),
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle,
                          size: 32,
                        ), onPressed: ()=>cart.changeProductQuantity(cartProduct.id, -1),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
