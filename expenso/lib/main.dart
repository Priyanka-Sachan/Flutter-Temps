import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal.shade300,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text('Expenso',
          style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: Container(
          child: Text('Personal expenses'),
        ),
        ),
    );
  }
}

