import 'package:flutter/material.dart';
import 'package:meeeal/dummy_data.dart';
import 'package:meeeal/models/recipe.dart';

import './widgets/filters_page.dart';
import './widgets/tab_bar_page.dart';
import './widgets/recipe_details_page.dart';
import './widgets/recipe_page.dart';
import './widgets/categories_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Recipe> _availableRecipe;
  List<Recipe> _favouriteRecipe=[];
  Map<String, bool> _filters = {
    'glutten-free': false,
    'lactose-free': false,
    'vegan': false,
    'vegetarian': false
  };

  void _setFilters(Map<String,bool> updatedFilters){
    setState(() {
      _filters=updatedFilters;
      _availableRecipe=DUMMY_RECIPES.where((recipe) {
        if(_filters['glutten-free']&&!recipe.isGlutenFree)
          return false;
        if(_filters['lactose-free']&&!recipe.isLactoseFree)
          return false;
        if(_filters['vegan']&&!recipe.isVegan)
          return false;
        if(_filters['vegetarian']&&!recipe.isVegetarian)
          return false;
        return true;
      });
    });
  }

  void _toggleFavourite(String recipeId){
    final existingIndex=_favouriteRecipe.indexWhere((recipe)=> (recipe.id==recipeId));
    if(existingIndex>=0)
      setState(() {
        _favouriteRecipe.removeAt(existingIndex);
      });
    else
      setState(() {
        _favouriteRecipe.add(DUMMY_RECIPES.firstWhere((recipe) => recipe.id==recipeId ));
      });
  }

  bool _isFavourite(String recipeId){
    if(_favouriteRecipe.indexWhere((recipe)=> (recipe.id==recipeId))>=0)
        return true;
    else
      return false;
  }

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
        '/': (ctx) => TabBarPage(_favouriteRecipe),
        RecipePage.routeName: (ctx) => RecipePage(_availableRecipe),
        RecipeDetailsPage.routeName: (ctx) => RecipeDetailsPage(_isFavourite,_toggleFavourite),
        FiltersPage.routeName: (ctx) => FiltersPage(_filters,_setFilters)
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesPage());
      },
    );
  }
}
