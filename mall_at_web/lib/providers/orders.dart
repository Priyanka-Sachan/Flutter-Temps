import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './cartProduct.dart';
import './order.dart';

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    const url = 'https://fluttertemps.firebaseio.com/orders.json';
    try {
      final response = await http.get(url);
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      List<Order> loadedOrders = [];
      responseBody.forEach((key, order) {
        loadedOrders.insert(
            0,
            Order(
              id: key,
              amount: order['amount'],
              products: (order['products'] as List<dynamic>).map((p) {
                return CartProduct(
                    id: p['id'],
                    title: p['title'],
                    price: p['price'],
                    imageUrl: p['imageUrl'],
                    quantity: p['quantity']);
              }).toList(),
              timeStamp: DateTime.parse(order['timeStamp']),
            ));
      });
      _orders = loadedOrders;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> addOrder(List<CartProduct> products, double amount) async {
    const url = 'https://fluttertemps.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': amount,
            'products': products
                .map((p) => {
                      'id': p.id,
                      'title': p.title,
                      'price': p.price,
                      'imageUrl': p.imageUrl,
                      'quantity': p.quantity
                    })
                .toList(),
            'timeStamp': timeStamp.toIso8601String()
          }));
      _orders.insert(
          0,
          Order(
              id: json.decode(response.body)['name'],
              amount: amount,
              products: products,
              timeStamp: timeStamp));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
