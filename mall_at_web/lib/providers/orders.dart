import 'package:flutter/material.dart';
import './cartProduct.dart';
import './order.dart';

class Orders with ChangeNotifier{
  List<Order> _orders=[];

  List<Order> get orders{
    return [..._orders];
  }

  void addOrder(List<CartProduct> products,double amount){
    _orders.insert(0, Order(
      id:DateTime.now().toString() ,
      amount: amount,
      products: products,
      timeStamp: DateTime.now()
    )
    );
    notifyListeners();
  }
}