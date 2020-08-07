import 'package:flutter/material.dart';

class Category{
  @required final String id;
  @required final String title;
  final IconData icon;

  Category({this.id,this.title,this.icon=Icons.fastfood});
}