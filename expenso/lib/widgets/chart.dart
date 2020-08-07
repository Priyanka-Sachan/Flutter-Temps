import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './chartBar.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  double totalAmountSum=0.0;
  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7,(index){
     final weekDay=DateTime.now().subtract(Duration(days: index));
     double amountSum=0.0;
     for(int i=0;i<recentTransactions.length;i++)
       if(recentTransactions[i].date.day==weekDay.day&&
       recentTransactions[i].date.month==weekDay.month&&
       recentTransactions[i].date.year==weekDay.year){
         amountSum+=recentTransactions[i].amount;
         totalAmountSum+=recentTransactions[i].amount;
     }
     return {'day':weekDay.toString().substring(8,10),'amount':amountSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: groupedTransactionValues.map((dayTransaction){
          return ChartBar(dayTransaction['day'],dayTransaction['amount'],totalAmountSum);
        }).toList(),
      ),
    );
  }
}



