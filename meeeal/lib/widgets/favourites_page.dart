import 'package:flutter/material.dart';

import '../models/recipe.dart';
import './recipe_card.dart';

class FavouritesPage extends StatefulWidget {
  List<Recipe> _favouriteRecipe = [];

  FavouritesPage(this._favouriteRecipe);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  void removeItem(String recipeId) {
    setState(() {
      widget._favouriteRecipe.removeWhere((recipe) {
        if (recipe.id == recipeId)
          return true;
        else
          return false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget._favouriteRecipe.length == 0
          ? Center(
              child: Text(
              'You have no favourite recipes now - Start adding some..',
              style: Theme.of(context).textTheme.headline4,
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                return RecipeCard(widget._favouriteRecipe[index], removeItem);
              },
              itemCount: widget._favouriteRecipe.length,
            ),
    );
  }
}
