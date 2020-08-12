import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://cdn.shopify.com/s/files/1/2227/7969/products/product-image-828040973_1024x1024.jpg?v=1571711498'),
    Product(
        id: 'p3',
        title: "CHECK PRINT SHIRT",
        description: "A t-shirt",
        price: 110,
        imageUrl:
            "https://guesseu.scene7.com/is/image/GuessEU/M63H24W7JF0-L302-ALTGHOST?wid=1500&fmt=jpeg&qlt=80&op_sharpen=0&op_usm=1.0,1.0,5,0&iccEmbed=0"),
    Product(
        id: 'p4',
        title: "GLORIA HIGH LOGO SNEAKER",
        description: "Sneakers for man",
        price: 91,
        imageUrl:
            "https://guesseu.scene7.com/is/image/GuessEU/FLGLO4FAL12-BEIBR?wid=700&amp;fmt=jpeg&amp;qlt=80&amp;op_sharpen=0&amp;op_usm=1.0,1.0,5,0&amp;iccEmbed=0"),
    Product(
        id: 'p5',
        title: "CATE RIGID BAG",
        description: "Bag u always wanted",
        price: 94.5,
        imageUrl:
            "https://guesseu.scene7.com/is/image/GuessEU/HWVG6216060-TAN?wid=700&amp;fmt=jpeg&amp;qlt=80&amp;op_sharpen=0&amp;op_usm=1.0,1.0,5,0&amp;iccEmbed=0"),
    Product(
        id: 'p6',
        title: "GUESS CONNECT WATCH",
        description: "Watch for TIME",
        price: 438.9,
        imageUrl:
            "http://guesseu.scene7.com/is/image/GuessEU/WC0001FMSWC-G5?wid=520&fmt=jpeg&qlt=80&op_sharpen=0&op_usm=1.0,1.0,5,0&iccEmbed=0"),
    Product(
        id: 'p7',
        title: "'70s RETRO GLAM KEFIAH",
        description: "Retro got a new meaning",
        price: 20,
        imageUrl:
            "https://guesseu.scene7.com/is/image/GuessEU/AW6308VIS03-SAP?wid=700&amp;fmt=jpeg&amp;qlt=80&amp;op_sharpen=0&amp;op_usm=1.0,1.0,5,0&amp;iccEmbed=0"),
    Product(
        id: 'p8',
        title: "Ohrensessel Josslyn",
        description: " ",
        price: 46.89,
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRlShSQPlz98nSQXtjbfQymM4a5mbQlLPgYIg&usqp=CAU"),
    Product(
        id: 'p9',
        title: "Sessel Sofie",
        description: " ",
        price: 249.99,
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRHXkeKaVKolRYkT10m1dtoq2v1v2xyw9sg7Q&usqp=CAU"),
    Product(
        id: 'p10',
        title: "Schlafsessel Rovigo",
        description: " ",
        price: 239.99,
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTGA5-TGYlNc1zG2cx986i4t2CqRShfDBbZXg&usqp=CAU"),
    Product(
        id: 'p11',
        title: "Sessel Little",
        description: " ",
        price: 119.99,
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRlShSQPlz98nSQXtjbfQymM4a5mbQlLPgYIg&usqp=CAU"),
    Product(
        id: 'p12',
        title: "Sessel Peacock",
        description: " ",
        price: 599.99,
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRHXkeKaVKolRYkT10m1dtoq2v1v2xyw9sg7Q&usqp=CAU"),
    Product(
        id: 'p13',
        title: "Sessel Anna",
        description: " ",
        price: 149.99,
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRlShSQPlz98nSQXtjbfQymM4a5mbQlLPgYIg&usqp=CAU")
  ];

  List<Product> getProducts() {
    return _products;
  }

  List<Product> getFavouriteProducts() {
    return _products.where((product) => product.isFavourite).toList();
  }

  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<void> addProduct(Product product) {
    const url = 'https://fluttertemps.firebaseio.com/products.json';
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'isFavourite': product.isFavourite
            }))
        .then((response) {
      _products.insert(
          0,
          Product(
              id: json.decode(response.body)['name'],
              title: product.title,
              description: product.description,
              price: product.price,
              imageUrl: product.imageUrl,
              isFavourite: product.isFavourite));
      notifyListeners();
    }).catchError((error){
      //Even if we don't catch and throw error here ..we will still get it .
      print(error.toString());
      throw error;
    });
  }

  void updateProduct(Product product) {
    _products.insert(
        _products.indexWhere((p) => p.id == product.id),
        Product(
            id: product.id,
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl,
            isFavourite: product.isFavourite));
    notifyListeners();
  }
}
