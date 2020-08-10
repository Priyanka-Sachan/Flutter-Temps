import 'package:flutter/material.dart';

import '../models/recipe.dart';
import './recipe_card.dart';
import '../models/category.dart';

class RecipePage extends StatefulWidget {

  static const String routeName = '/recipe-page';
  final List<Recipe> availableRecipe;

  RecipePage(this.availableRecipe);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool _loadedInitData = false;
  Category _category;
  List<Recipe> _categoryRecipe;

  @override
  void didChangeDependencies() {
    //Would have worked in init if not for context
    if (!_loadedInitData) {
      _category = ModalRoute.of(context).settings.arguments as Category;
      _categoryRecipe = widget.availableRecipe.where((element) {
        return element.categories.contains(_category.id);
      }).toList();
    }
    _loadedInitData = true;
    super.didChangeDependencies();
  }

  void _removeItem(String id) {
    setState(() {
      print('recipe page remove item');
      _categoryRecipe.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            _category.title,
            textScaleFactor: 1.8,
            style: TextStyle(letterSpacing: 1.5),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return RecipeCard(_categoryRecipe[index], _removeItem);
          },
          itemCount: _categoryRecipe.length,
        )
    );
  }
}
