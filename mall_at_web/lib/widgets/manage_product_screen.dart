import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import './edit_product_screen.dart';
import '../providers/products_provider.dart';
import './manage_product_item.dart';

class ManageProductScreen extends StatelessWidget {
  static final routeName = '/manage-product-screen';

  Future<void> _refreshUserProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchMyProducts();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _refreshUserProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshUserProducts(context),
                    child: Consumer<Products>(
                      builder:(ctx,products,child)=> ListView.builder(
                        itemCount: products.getMyProducts().length,
                        itemBuilder: (ctx, index) =>
                            ManageProductItem(products.getMyProducts()[index]),
                      ),
                    ),
                  ),
      ),
    );
  }
}
