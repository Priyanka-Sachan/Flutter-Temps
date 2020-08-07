import 'package:flutter/material.dart';

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
          accentColor: Colors.pinkAccent,
          fontFamily: 'Quicksand'),
      home: Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Meeeals',
            textScaleFactor: 1.8,
            style: TextStyle(
              letterSpacing: 1.5
            ),
          ),
          leading: Icon(
            Icons.fastfood,
          ),
        ),
        body: CategoriesPage(),
      ),
    );
  }
}

