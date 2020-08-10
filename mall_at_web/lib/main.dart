import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColorLight: Colors.pink.shade50,
          primaryColorDark: Colors.pink.shade200,
          accentColor: Color.fromRGBO(68, 44, 46, 1)),
      home: Scaffold(
        backgroundColor: Colors.pink.shade50,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Mall@Web',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
