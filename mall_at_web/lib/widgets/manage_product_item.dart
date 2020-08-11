import 'package:flutter/material.dart';
import 'package:mallatweb/widgets/edit_product_screen.dart';
import '../providers/product.dart';

class ManageProductItem extends StatelessWidget {
  Product product;
  ManageProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          product.imageUrl,
        ),
      ),
      title: Text(product.title),
      subtitle: Text('Price: Rs.${product.price}'),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () =>
            Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: product),
      ),
    );
  }
}
