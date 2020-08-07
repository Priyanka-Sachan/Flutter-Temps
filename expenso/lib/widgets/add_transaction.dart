import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction(this.addTransaction);

  final Function addTransaction;

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitTransaction() {
    String title = _titleController.text;
    double amount = double.parse(_amountController.text);
    if (title.isNotEmpty && amount > 0&&_selectedDate!=null) {
      //widget is an special object to use the fields in the outer class.
      widget.addTransaction(title, amount,_selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _inputDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
            onSubmitted: (_) => _submitTransaction(),
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitTransaction(),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: _inputDate,
              ),
              Text(_selectedDate==null?'No date chosen.':_selectedDate.toString().substring(0,10))
            ],
          ),
          RaisedButton(
            onPressed: () => _submitTransaction(),
            child: Text('Add Transaction'),
          )
        ],
      ),
    );
  }
}
