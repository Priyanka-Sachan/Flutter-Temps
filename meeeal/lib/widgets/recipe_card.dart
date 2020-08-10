import 'package:flutter/material.dart';

import './recipe_details_page.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final Function removeItem;

  RecipeCard(this.recipe, this.removeItem);

  String seenRecipeId;

  void selectRecipe(BuildContext context, Recipe recipe) {
    Navigator.of(context)
        .pushNamed(RecipeDetailsPage.routeName, arguments: recipe)
        .then((value) {
      seenRecipeId = value;
      if (seenRecipeId != null) removeItem(seenRecipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectRecipe(context, recipe),
      splashColor: Theme.of(context).accentColor,
      child: Card(
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    recipe.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  color: Colors.black54,
                  child: Text(
                    recipe.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.access_time),
                        Text(recipe.duration.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.work),
                        Text('Complexity'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        Text('Affordability'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
