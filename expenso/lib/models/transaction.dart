import 'package:flutter/material.dart';

class Transaction{
  String id;
  String title;
  String type;
  double amount;
  DateTime date;

    Transaction(this.id,
        this.title,
        this.type,
        this.amount,
        this.date);

    Color checkType(){
      Color color;
      if(type=='buy')
        color= Colors.red;
      else if(type=='get')
        color= Colors.green;
      else if(type=='loan')
        color= Colors.yellow;
      return color;
    }
}
