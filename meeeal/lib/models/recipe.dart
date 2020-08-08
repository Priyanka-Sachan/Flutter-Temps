import 'package:flutter/foundation.dart';

enum Complexity { Simple, Challenging, Hard }
enum Affordability { Affordable, Pricey, Luxurious }

class Recipe {
  String id;
  String title;
  List<String> categories;
  String imageUrl;
  List<String> steps;
  List<String> ingredients;
  int duration;
  Complexity complexity;
  Affordability affordability;
  bool isGlutenFree;
  bool isLactoseFree;
  bool isVegan;
  bool isVegetarian;

  Recipe(
      {this.id,
      this.title,
      this.categories,
      this.imageUrl,
      this.steps,
      this.ingredients,
      this.duration,
      this.complexity,
      this.affordability,
      this.isGlutenFree,
      this.isLactoseFree,
      this.isVegan,
      this.isVegetarian});
}
