import 'package:flutter/material.dart';
import './categories_page.dart';
import './favourites_page.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Meeeals',
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
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Category',
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Favourites',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[CategoriesPage(), FavouritesPage()],
        ),
      ),
    );
  }
}
