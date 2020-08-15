import 'package:flutter/material.dart';

import './widgets/notes_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mooray',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue.shade100,
          primaryColorDark: Colors.blueGrey.shade600,
          accentColor: Colors.lightBlueAccent,
      ),
      home: NotesOverviewScreen(),
    );
  }
}
