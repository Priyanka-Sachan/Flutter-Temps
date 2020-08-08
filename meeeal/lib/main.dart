import 'package:flutter/material.dart';

import './widgets/tab_bar_page.dart';
import './widgets/recipe_details_page.dart';
import './widgets/recipe_page.dart';
import './widgets/categories_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.grey.shade500,
          accentColor: Colors.tealAccent,
          fontFamily: 'Quicksand'),
      routes: {
        '/': (ctx) => TabBarPage(),
        RecipePage.routeName: (ctx) => RecipePage(),
        RecipeDetailsPage.routeName: (ctx) => RecipeDetailsPage()
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesPage());
      },
    );
  }
}
