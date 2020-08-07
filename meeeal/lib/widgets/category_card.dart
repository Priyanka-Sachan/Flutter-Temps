import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String id;
  final String title;
  final IconData icon;

  CategoryCard(this.id, this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey.shade600,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    textScaleFactor: 1.5,
                  )),
              Icon(
                icon,
                size: 80,
              )
            ],
          ),
        ));
  }
}
