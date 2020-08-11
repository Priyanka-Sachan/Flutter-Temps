import 'package:flutter/material.dart';

import './product.dart';
import './cartProduct.dart';

class Cart with ChangeNotifier {
  Map<String, CartProduct> _cartProducts = {};

  Map<String, CartProduct> get cartProducts {
    return {..._cartProducts};
  }

  int getCartCount() {
    return _cartProducts.length;
  }

  void addProductToCart(Product product) {
    if (_cartProducts.containsKey(product.id)) {
      _cartProducts.update(
          product.id,
          (cartProduct) => CartProduct(
              id: cartProduct.id,
              title: cartProduct.title,
              price: cartProduct.price,
              imageUrl: cartProduct.imageUrl,
              quantity: cartProduct.quantity + 1));
    } else {
      _cartProducts.putIfAbsent(
          product.id,
          () => CartProduct(
              id: product.id,
              title: product.title,
              price: product.price,
              imageUrl: product.imageUrl,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeProductFromCart(String id) {
    _cartProducts.removeWhere((key, cartProduct) => cartProduct.id == id);
    notifyListeners();
  }

  double get totalAmount {
    double amount = 0;
    _cartProducts.forEach((id, cartProduct) {
      amount += cartProduct.price * cartProduct.quantity;
    });
    return amount;
  }

  void changeProductQuantity(String id, int change) {
    _cartProducts.update(
        id,
        (cartProduct) => CartProduct(
            id: cartProduct.id,
            title: cartProduct.title,
            price: cartProduct.price,
            imageUrl: cartProduct.imageUrl,
            quantity: cartProduct.quantity + change));
    _cartProducts.removeWhere((productId, product) => product.id==id&&product.quantity==0);
    notifyListeners();
  }

  void clearCart(){
    _cartProducts={};
    notifyListeners();
  }
}
