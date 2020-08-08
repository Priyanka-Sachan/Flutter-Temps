import 'package:flutter/material.dart';

import './recipe_card.dart';
import '../dummy_data.dart';
import '../models/category.dart';

class RecipePage extends StatelessWidget {

  static const String routeName='/recipe-page';

  @override
  Widget build(BuildContext context) {

    final recipeCategory=ModalRoute.of(context).settings.arguments as Category;
    final categoryRecipe=DUMMY_RECIPES.where((element) {
      return element.categories.contains(recipeCategory.id);
    }).toList();
    return Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            recipeCategory.title,
            textScaleFactor: 1.8,
            style: TextStyle(letterSpacing: 1.5),
          ),
        ),
        body: ListView.builder(itemBuilder: (context,index){
          return RecipeCard(categoryRecipe[index]);
          },
        itemCount: categoryRecipe.length,)
    );
  }
}
