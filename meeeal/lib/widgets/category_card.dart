import 'package:flutter/material.dart';

import './recipe_page.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard(this.category);

  void navigateToRecipePage(BuildContext c,Category category){
    Navigator.of(c).pushNamed(RecipePage.routeName,arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateToRecipePage(context,category),
      splashColor: Theme.of(context).accentColor,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 0,horizontal: 8),
          color: Colors.teal.shade50,
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
                      category.title,
                      textScaleFactor: 2,
                    )),
                Icon(
                  category.icon,
                  size: 80,
                )
              ],
            ),
          )),
    );
  }
}
