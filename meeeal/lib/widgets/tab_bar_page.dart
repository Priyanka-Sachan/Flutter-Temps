import 'package:flutter/material.dart';

import './main_drawer.dart';
import './categories_page.dart';
import './favourites_page.dart';
import '../models/recipe.dart';

class TabBarPage extends StatefulWidget {

  List<Recipe> _favouriteRecipe;

  TabBarPage(this._favouriteRecipe);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {

  int _selectedPageIndex=0;
  List<Map<String,Object>> _pages;

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });
  }

  @override
  void initState() {
    _pages=[
      {'title':'Meeals','page':CategoriesPage()},
      {'title':'Favourites','page':FavouritesPage(widget._favouriteRecipe)}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          _pages[_selectedPageIndex]['title'],
          textScaleFactor: 1.8,
          style: TextStyle(letterSpacing: 1.5),
        ),

      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        unselectedItemColor:Colors.white,
        selectedItemColor:Colors.tealAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favorites')
          )
        ],
      ),
    );
  }
}
