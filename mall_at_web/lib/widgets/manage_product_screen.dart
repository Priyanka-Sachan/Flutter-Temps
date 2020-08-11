import 'package:flutter/material.dart';
import 'package:mallatweb/providers/product.dart';
import 'package:mallatweb/widgets/edit_product_screen.dart';
import '../providers/products_provider.dart';
import './manage_product_item.dart';
import 'package:provider/provider.dart';

class ManageProductScreen extends StatelessWidget {
  static final routeName = '/manage-product-screen';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = productData.getProducts();
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text(
          'Your Product',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(
            EditProductScreen.routeName,
            arguments: Product(
                id: null,
                title: '',
                description: '',
                price: 0,
                imageUrl: '',
                isFavourite: false)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, index) => ManageProductItem(products[index]),
      ),
    );
  }
}
