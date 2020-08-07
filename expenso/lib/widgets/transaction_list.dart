import 'package:expenso/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {

  List<Transaction> transactions=[];
  Function deleteTransaction;

  TransactionList(this.transactions,this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 512.0,
      child: transactions.length==0?Column(
        children: <Widget>[
          Image.asset('assets/images/waiting.png',
          height: 300,),
          Text('No transaction added yet!',
          style: Theme.of(context).textTheme.headline3),
        ],
      ):
      ListView.builder(
        itemCount: transactions.length,
          itemBuilder: (context,index){
            return Card(
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      child: Text(transactions[index].amount.toString()),
                      backgroundColor: transactions[index].checkType(),
                      radius: 24.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(transactions[index].title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(transactions[index].date.toIso8601String(),
                          style: TextStyle(
                              color: Colors.grey),
                        )
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.delete,
                              color: Colors.red),
                      onPressed: ()=>deleteTransaction(index),
                    )
                  ],
                ),
              ),
            );
          })
    );
  }
}

