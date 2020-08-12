import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static final routeName = '/edit-product-screen';

  final Product product;
  EditProductScreen(this.product);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _init = false;
  bool _isLoading = false;
  Product editedProduct;

  @override
  void initState() {
    _init = true;
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      editedProduct = ModalRoute.of(context).settings.arguments as Product;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageUrlFocusNode.hasFocus) setState(() {});
  }

  void _saveProduct() {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (editedProduct.id == null)
        Provider.of<Products>(context, listen: false)
            .addProduct(editedProduct)
            .catchError((error) {
          return showDialog<Null>(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('An Error Occurred.'),
                    content: Text('Something went wrong.'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OKAY'),
                        onPressed: () => Navigator.of(ctx).pop(),
                      )
                    ],
                  ));
        }).then((_) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        });
      else
        Provider.of<Products>(context, listen: false)
            .updateProduct(editedProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit product',
          style: Theme.of(context).textTheme.headline4,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _imageUrlController.text.isEmpty
                            ? Icon(
                                Icons.image,
                                size: 128,
                              )
                            : Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: editedProduct.title,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) => editedProduct = Product(
                            id: editedProduct.id,
                            title: value,
                            description: editedProduct.description,
                            price: editedProduct.price,
                            imageUrl: editedProduct.imageUrl,
                            isFavourite: editedProduct.isFavourite),
                        validator: (value) {
                          if (value.isEmpty) return 'Title cannot be empty.';
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: editedProduct.price.toString(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) => editedProduct = Product(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: editedProduct.description,
                            price: double.parse(value),
                            imageUrl: editedProduct.imageUrl,
                            isFavourite: editedProduct.isFavourite),
                        validator: (value) {
                          if (value.isEmpty) return 'Enter a price';
                          if (double.parse(value) <= 0)
                            return 'Price should be greater than 0';
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: editedProduct.description,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) => editedProduct = Product(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: value,
                            price: editedProduct.price,
                            imageUrl: editedProduct.imageUrl,
                            isFavourite: editedProduct.isFavourite),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Description cannot be empty.';
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image Url',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onSaved: (value) => editedProduct = Product(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: editedProduct.description,
                            price: editedProduct.price,
                            imageUrl: value,
                            isFavourite: editedProduct.isFavourite),
                        validator: (value) {
                          if (value.isEmpty) return 'Enter correct image url.';
                          return null;
                        },
                      ),
                    ),
                    RaisedButton(
                      child: Text('SUBMIT PRODUCT'),
                      onPressed: _saveProduct,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
