import 'package:flutter/material.dart';
import './categories_page.dart';
import './favourites_page.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {

  int _selectedPageIndex=0;
  List<Map<String,Object>> _pages=[
    {'title':'Meeals','page':CategoriesPage()},
    {'title':'Favourites','page':FavouritesPage()}
  ];

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
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
          _pages[_selectedPageIndex]['title'],
          textScaleFactor: 1.8,
          style: TextStyle(letterSpacing: 1.5),
        ),
        leading: Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          child: Icon(
            Icons.fastfood,
            size: 50,
          ),
        ),
      ),
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
