import 'package:flutter/material.dart';
import 'package:meeeal/dummy_data.dart';
import '../models/category.dart';
import './category_card.dart';

class CategoriesPage extends StatelessWidget {
  List<Category> dummyData = DUMMY_CATEGORIES;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: (context, index) {
          return CategoryCard(dummyData[index].id, dummyData[index].title,
              dummyData[index].icon);
        },
    itemCount: dummyData.length,);
  }
}
