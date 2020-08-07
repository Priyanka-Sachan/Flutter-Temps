import 'package:flutter/material.dart';

import 'widgets/add_transaction.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.blueGrey,
            fontFamily: 'Quicksand'),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Transaction> _transactions = [  Transaction('ddyffd', 'New course', 'Buy', 0, DateTime.now()),
    Transaction('hfhjvjvj', 'Chocolate', 'Buy', 46.78, DateTime.now()),
    Transaction('ghhcc', 'Rakhi', 'Buy', 58.00, DateTime.now()),
    Transaction('chhvjvc', 'Groceries', 'Buy', 8.0, DateTime.now()),
    Transaction('fhfff', 'Chappals', 'Buy', 12.0, DateTime.now())];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) =>
        element.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }

  void _addNewTransaction(String title, double amount,DateTime date) {
    Transaction newTransaction = Transaction(
        DateTime.now().toString(), title, 'Buy', amount, date);
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  void inputNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return AddTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade300,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => inputNewTransaction(context),
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Expenso',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions, _deleteTransaction),
          ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => inputNewTransaction(context),
      ),
    );
  }
}
