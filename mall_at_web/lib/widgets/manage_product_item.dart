import 'package:flutter/material.dart';
import 'package:mallatweb/providers/products_provider.dart';
import 'package:provider/provider.dart';
import './edit_product_screen.dart';
import '../providers/product.dart';

enum ProductOptions { Edit, Delete }

class ManageProductItem extends StatelessWidget {
  Product product;
  ManageProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final scaffold=Scaffold.of(context);

    Future<void> removeProduct() async {
      try {
        await Provider.of<Products>(context, listen: false)
            .removeProduct(product);
      } catch (error) {
        scaffold.showSnackBar(SnackBar(
          content: Text('Deleting Failed!'),
        ));
      }
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          product.imageUrl,
        ),
      ),
      title: Text(product.title),
      subtitle: Text('Price: Rs.${product.price}'),
      trailing: PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onSelected: (ProductOptions selectedValue) {
          if (selectedValue == ProductOptions.Edit)
            Navigator.of(context)
                .pushNamed(EditProductScreen.routeName, arguments: product);
          else {
            removeProduct();
          }
        },
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).accentColor,
        ),
        itemBuilder: (ctx) => [
          PopupMenuItem(
            child: Icon(Icons.edit),
            value: ProductOptions.Edit,
          ),
          PopupMenuItem(
            child: Icon(Icons.delete_outline),
            value: ProductOptions.Delete,
          ),
        ],
      ),
    );
  }
}
