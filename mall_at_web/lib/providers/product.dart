import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.isFavourite = false});

  Future<void> toggleFavourite(String authToken, String userId) async {
    String url =
        'https://fluttertemps.firebaseio.com/users/$userId/favourites/$id.json?auth=$authToken';
    isFavourite = !isFavourite;
    notifyListeners();
    final response = await http.put(url, body: json.encode(isFavourite));
    if (response.statusCode >= 400) {
      isFavourite = !isFavourite;
      notifyListeners();
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
