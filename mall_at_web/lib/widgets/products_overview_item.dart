import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import './product_details_screen.dart';
import '../providers/product.dart';

class ProductsOverviewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context, listen: false);
    Cart cart = Provider.of<Cart>(context, listen: false);
    void navigateToProduct(String id) {
      Navigator.of(context)
          .pushNamed(ProductDetailsScreen.routeName, arguments: id);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: GestureDetector(
          onTap: () => navigateToProduct(product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        header: IconButton(
          icon: Consumer<Product>(
              builder: (ctx, product, childNotToBeUpdated) => Icon(
                  product.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border)),
          onPressed: product.toggleFavourite,
          alignment: Alignment.topLeft,
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            style: TextStyle(color: Colors.white, letterSpacing: 1.5),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              cart.addProductToCart(product);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added to the Cart!'),
                  action: SnackBarAction(
                    textColor: Colors.white,
                    label: 'UNDO',
                    onPressed: () => cart.changeProductQuantity(product.id, -1),
                  ),
                ),
              );
            },
          ),
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
