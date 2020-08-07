import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  String label;
  double amountSum;
  double totalAmountSum;

  ChartBar(this.label, this.amountSum, this.totalAmountSum);

  @override
  Widget build(BuildContext context) {
    print('Cahrtbar made..');
    return Column(
      children: <Widget>[
        Text(amountSum.toString()),
        Container(
          height: 100.0,
          width: 10.0,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              FractionallySizedBox(
                heightFactor: totalAmountSum==0?0.0:(amountSum / totalAmountSum),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              )
            ],
          ),
        ),
        Text(label)
      ],
    );
  }
}
