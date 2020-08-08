import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeDetailsPage extends StatelessWidget {
  static const routeName = '/recipe-details-page';

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context).settings.arguments as Recipe;

    Container ingredientCard(String i) {
      return Container(
        child: Text(
          i,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    ListTile stepsTile(int i, String s) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Text(
            i.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        title: Text(s),
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            recipe.title,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: Image.network(recipe.imageUrl)),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Ingredients',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: recipe.ingredients.map((e) {
                    return ingredientCard(e);
                  }).toList(),
                ),
              ),
              Text(
                'Steps',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 2,
                ),
              ),
              Card(
                borderOnForeground: true,
                shadowColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: recipe.steps.map((e) => stepsTile(1, e)).toList(),
                ),
              )
            ],
          ),
        ));
  }
}
