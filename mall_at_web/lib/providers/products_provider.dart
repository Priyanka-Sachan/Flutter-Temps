import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//        id: 'p2',
//        title: 'Trousers',
//        description: 'A nice pair of trousers.',
//        price: 59.99,
//        imageUrl:
//            'https://cdn.shopify.com/s/files/1/2227/7969/products/product-image-828040973_1024x1024.jpg?v=1571711498'),
//    Product(
//        id: 'p3',
//        title: "CHECK PRINT SHIRT",
//        description: "A t-shirt",
//        price: 110,
//        imageUrl:
//            "https://guesseu.scene7.com/is/image/GuessEU/M63H24W7JF0-L302-ALTGHOST?wid=1500&fmt=jpeg&qlt=80&op_sharpen=0&op_usm=1.0,1.0,5,0&iccEmbed=0"),
//    Product(
//        id: 'p4',
//        title: "GLORIA HIGH LOGO SNEAKER",
//        description: "Sneakers for man",
//        price: 91,
//        imageUrl:
//            "https://guesseu.scene7.com/is/image/GuessEU/FLGLO4FAL12-BEIBR?wid=700&amp;fmt=jpeg&amp;qlt=80&amp;op_sharpen=0&amp;op_usm=1.0,1.0,5,0&amp;iccEmbed=0"),
//    Product(
//        id: 'p5',
//        title: "CATE RIGID BAG",
//        description: "Bag u always wanted",
//        price: 94.5,
//        imageUrl:
//            "https://guesseu.scene7.com/is/image/GuessEU/HWVG6216060-TAN?wid=700&amp;fmt=jpeg&amp;qlt=80&amp;op_sharpen=0&amp;op_usm=1.0,1.0,5,0&amp;iccEmbed=0"),
//    Product(
//        id: 'p6',
//        title: "GUESS CONNECT WATCH",
//        description: "Watch for TIME",
//        price: 438.9,
//        imageUrl:
//            "http://guesseu.scene7.com/is/image/GuessEU/WC0001FMSWC-G5?wid=520&fmt=jpeg&qlt=80&op_sharpen=0&op_usm=1.0,1.0,5,0&iccEmbed=0"),
//    Product(
//        id: 'p7',
//        title: "'70s RETRO GLAM KEFIAH",
//        description: "Retro got a new meaning",
//        price: 20,
//        imageUrl:
//            "https://guesseu.scene7.com/is/image/GuessEU/AW6308VIS03-SAP?wid=700&amp;fmt=jpeg&amp;qlt=80&amp;op_sharpen=0&amp;op_usm=1.0,1.0,5,0&amp;iccEmbed=0"),
//    Product(
//        id: 'p8',
//        title: "Ohrensessel Josslyn",
//        description: " ",
//        price: 46.89,
//        imageUrl:
//            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRlShSQPlz98nSQXtjbfQymM4a5mbQlLPgYIg&usqp=CAU"),
//    Product(
//        id: 'p9',
//        title: "Sessel Sofie",
//        description: " ",
//        price: 249.99,
//        imageUrl:
//            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRHXkeKaVKolRYkT10m1dtoq2v1v2xyw9sg7Q&usqp=CAU"),
//    Product(
//        id: 'p10',
//        title: "Schlafsessel Rovigo",
//        description: " ",
//        price: 239.99,
//        imageUrl:
//            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTGA5-TGYlNc1zG2cx986i4t2CqRShfDBbZXg&usqp=CAU"),
//    Product(
//        id: 'p11',
//        title: "Sessel Little",
//        description: " ",
//        price: 119.99,
//        imageUrl:
//            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRlShSQPlz98nSQXtjbfQymM4a5mbQlLPgYIg&usqp=CAU"),
//    Product(
//        id: 'p12',
//        title: "Sessel Peacock",
//        description: " ",
//        price: 599.99,
//        imageUrl:
//            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRHXkeKaVKolRYkT10m1dtoq2v1v2xyw9sg7Q&usqp=CAU"),
//    Product(
//        id: 'p13',
//        title: "Sessel Anna",
//        description: " ",
//        price: 149.99,
//        imageUrl:
//            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRlShSQPlz98nSQXtjbfQymM4a5mbQlLPgYIg&usqp=CAU")
  ];
  List<Product> _myProducts = [];
  String _authToken;
  String _userId;
  Products(this._authToken, this._userId, this._products);

  Future<void> fetchProducts() async {
    final productsUrl =
        'https://fluttertemps.firebaseio.com/products.json?auth=$_authToken';
    final favouritesUrl =
        'https://fluttertemps.firebaseio.com/users/$_userId/favourites.json?auth=$_authToken';
    try {
      final productsResponse = await http.get(productsUrl);
      final productsResponseBody =
          json.decode(productsResponse.body) as Map<String, dynamic>;
      if (productsResponseBody != null) {
        final favouritesResponse = await http.get(favouritesUrl);
        final favouritesResponseBody = json.decode(favouritesResponse.body);
        final List<Product> loadedProducts = [];
        productsResponseBody.forEach((key, value) {
          loadedProducts.insert(
              0,
              Product(
                  id: key,
                  title: value['title'],
                  description: value['description'],
                  price: value['price'],
                  imageUrl: value['imageUrl'],
                  isFavourite: favouritesResponseBody == null
                      ? false
                      : favouritesResponseBody[key] ?? false));
        });
        _products = loadedProducts;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchMyProducts() async {
    final productsUrl =
        'https://fluttertemps.firebaseio.com/products.json?auth=$_authToken&&orderBy="creatorId"&&equalTo="$_userId"';
    try {
      final productsResponse = await http.get(productsUrl);
      final productsResponseBody =
          json.decode(productsResponse.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      productsResponseBody.forEach((key, value) {
        loadedProducts.insert(
            0,
            Product(
                id: key,
                title: value['title'],
                description: value['description'],
                price: value['price'],
                imageUrl: value['imageUrl'],
                isFavourite: false));
      });
      _myProducts = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Product> getProducts() {
    return _products;
  }

  List<Product> getMyProducts() {
    return _myProducts;
  }

  List<Product> getFavouriteProducts() {
    return _products.where((product) => product.isFavourite).toList();
  }

  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://fluttertemps.firebaseio.com/products.json?auth=$_authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId': _userId
          }));
      _products.insert(
          0,
          Product(
              id: json.decode(response.body)['name'],
              title: product.title,
              description: product.description,
              price: product.price,
              imageUrl: product.imageUrl));
      _myProducts.insert(
          0,
          Product(
              id: json.decode(response.body)['name'],
              title: product.title,
              description: product.description,
              price: product.price,
              imageUrl: product.imageUrl));
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    String url =
        'https://fluttertemps.firebaseio.com/products/${product.id}.json?auth=$_authToken';
    try {
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));
      int i = _products.indexWhere((p) => p.id == product.id);
      _products.removeAt(i);
      _products.insert(
          i,
          Product(
              id: product.id,
              title: product.title,
              description: product.description,
              price: product.price,
              imageUrl: product.imageUrl));
      i = _myProducts.indexWhere((p) => p.id == product.id);
      _myProducts.removeAt(i);
      _myProducts.insert(
          i,
          Product(
              id: product.id,
              title: product.title,
              description: product.description,
              price: product.price,
              imageUrl: product.imageUrl));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //Optimistic Update
  Future<void> removeProduct(Product product) async {
    String url =
        'https://fluttertemps.firebaseio.com/products/${product.id}.json?auth=$_authToken';
    int existingProductIndex = _products.indexOf(product);
    int existingMyProductIndex = _myProducts.indexOf(product);
    Product existingProduct = product;
    _products.removeAt(_products.indexWhere((p) => p.id == product.id));
    _myProducts.remove(product);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _products.insert(existingProductIndex, existingProduct);
      _myProducts.insert(existingMyProductIndex, existingProduct);
      notifyListeners();
      throw Exception('Error: ${response.statusCode}');
    }
    existingProduct = null;
  }
}
